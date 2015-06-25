import ceylon.ast.core {
    Node,
    WideningTransformer
}

import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type
}

abstract
class BaseTransformer<Result>
        (CompilationContext ctx)
        satisfies WideningTransformer<Result> {

    shared
    ExpressionTransformer expressionTransformer
        =>  ctx.expressionTransformer;

    shared
    DartTransformer dartTransformer
        =>  ctx.dartTransformer;

    shared
    StatementTransformer statementTransformer
        =>  ctx.statementTransformer;

    shared
    TopLevelTransformer topLevelTransformer
        =>  ctx.topLevelTransformer;

    shared actual default
    Result transformNode(Node that) {
        throw CompilerBug(that, "Unhandled node '``className(that)``'");
    }

    shared
    void unimplementedError(Node that, String? message=null)
        =>  error(that,
                "compiler bug: unhandled node \
                 '``className(that)``'" +
                (if (exists message)
                then ": " + message
                else ""));

    shared
    void error(Node that, Anything message)
        =>  process.writeErrorLine(
                message?.string else "<null>");

    shared
    DartExpression|Absent withBoxing<Absent=Nothing>
            (TypeModel rhsType, DartExpression|Absent expression)
            given Absent satisfies Null {

        assert (exists lhsType = ctx.lhsTypeTop);

        if (exists expression) {
            value conversion =
                switch (lhsType)
                case (is NoType) null
                case (is TypeModel) ctx.typeFactory
                        .boxingConversionFor(lhsType, rhsType);

            if (exists conversion) {
                return withBoxingConversion(expression, conversion);
            }
            else {
                return expression;
            }
        }
        else {
            assert (is Absent null);
            return null;
        }
    }
}

DartExpression withBoxingConversion(
        DartExpression expression,
        BoxingConversion conversion) {

    DartSimpleIdentifier boxingFunction =
        switch (conversion)
        case (ceylonBooleanToNative)
            DartSimpleIdentifier("dart$ceylonBooleanToNative")
        case (ceylonFloatToNative)
            DartSimpleIdentifier("dart$ceylonFloatToNative")
        case (ceylonIntegerToNative)
            DartSimpleIdentifier("dart$ceylonIntegerToNative")
        case (ceylonStringToNative)
            DartSimpleIdentifier("dart$ceylonStringToNative")
        case (nativeToCeylonBoolean)
            DartSimpleIdentifier("dart$nativeToCeylonBoolean")
        case (nativeToCeylonFloat)
            DartSimpleIdentifier("dart$nativeToCeylonFloat")
        case (nativeToCeylonInteger)
            DartSimpleIdentifier("dart$nativeToCeylonInteger")
        case (nativeToCeylonString)
            DartSimpleIdentifier("dart$nativeToCeylonString");

    return DartFunctionExpressionInvocation {
        func = DartPrefixedIdentifier(
                    DartSimpleIdentifier("$ceylon$language"),
                    boxingFunction);
        argumentList = DartArgumentList([expression]);
    };
}
