import ceylon.ast.core {
    Node,
    WideningTransformer
}

import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type,
    ScopeModel=Scope,
    ElementModel=Element
}
import com.vasileff.ceylon.dart.model {
    DartTypeModel
}

abstract
class BaseTransformer<Result>
        (CompilationContext ctx)
        satisfies WideningTransformer<Result> {

    shared
    ClassMemberTransformer classMemberTransformer
        =>  ctx.classMemberTransformer;

    shared
    ExpressionTransformer expressionTransformer
        =>  ctx.expressionTransformer;

    shared
    MiscTransformer miscTransformer
        =>  ctx.miscTransformer;

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
    DartExpression withCasting(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            DartExpression dartExpression) {

        assert (exists lhsType = ctx.lhsTypeTop);
        return withCastingLhsRhs(scope,
                lhsType, rhsType, dartExpression);
    }

    DartExpression withCastingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            TypeModel|NoType lhsType,
            TypeModel rhsType,
            DartExpression dartExpression,
            "Set to `true` on the rare occasion that a `Boolean`,
             `Integer`, `Float`, or `String` as the expected
             [[lhsType]] indicates an unerased Ceylon object
             rather than a native type. Likely, this will only
             be for narrowing operations where the lhs is the
             argument to an unboxing function."
            Boolean disableErasure = false) {

        DartTypeModel castType;

        if (is NoType lhsType) {
            return dartExpression;
        }
        else if (lhsType.isSubtypeOf(rhsType)) {
            // they're either the same, or this is the result
            // of a narrowing operation
            castType = ctx.dartTypes.dartTypeModel(lhsType, disableErasure);
        }
        else if (ctx.dartTypes.erasedToObject(rhsType)) {
            // the result of a call to a generic function, or
            // something like a Ceylon intersection type. Either
            // may result in a Dart narrowing.
            castType = ctx.dartTypes.dartTypeModel(lhsType, disableErasure);
        }
        else {
            // rhs is neither a supertype of lhs nor erased,
            // so don't bother
            return dartExpression;
        }

        // the rhs may still have the same dart type
        // (this is actually the normal case)
        // `disableErasure` here is used for qualified expressions
        // where we are forcing an unerased type (for now)
        if (castType == ctx.dartTypes.dartTypeModel(rhsType, disableErasure)) {
            return dartExpression;
        }

        // cast away
        return
        DartAsExpression {
            dartExpression;
            ctx.dartTypes.dartTypeName(scope, castType);
        };
    }

    "Returns the non-erased result of [[fun]] with proper casting
     to [[lhsType]]."
    shared
    DartExpression withLhsTypeNoErasure(
            Node|ElementModel|ScopeModel scope,
            TypeModel lhsType, TypeModel rhsType, DartExpression fun())
        // This is a small hack, but at least isolated.
        // We are counting on the `dartExpression` not being wrapped
        // in an `as` cast since we are claiming we want an `Anything`.
        // And then, we'll cast to `lhsType`.
        =>  ctx.withLhsType(ctx.ceylonTypes.anythingType, ()
            =>  let (dartExpression = fun())
                withCastingLhsRhs {
                    scope = scope;
                    lhsType = lhsType;
                    rhsType = rhsType;
                    dartExpression = dartExpression;
                    disableErasure = true;
                });

    shared
    DartExpression withBoxing(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            DartExpression dartExpression) {

        assert (exists lhsType = ctx.lhsTypeTop);
        return withBoxingLhsRhs(scope,
                lhsType, rhsType, dartExpression);
    }

    DartExpression withBoxingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            TypeModel|NoType lhsType,
            TypeModel rhsType,
            DartExpression dartExpression)
        =>  let (conversion =
                    switch (lhsType)
                    case (is NoType) null
                    case (is TypeModel) ctx.ceylonTypes
                        .boxingConversionFor(lhsType, rhsType))
            if (exists conversion)
            then withBoxingConversion(scope, rhsType, dartExpression, conversion)
            else withCastingLhsRhs(scope, lhsType, rhsType, dartExpression);

    DartExpression withBoxingConversion(
            Node|ElementModel|ScopeModel scope,
            "The `actual` type of the expression. Whether the expression produces
             erased or boxed values will be inferred from [[conversion]], so the
             [[rhsActual]] type does not necessarily indicate the Dart static type
             of the [[expression]]."
            TypeModel rhsActual,
            "The expression that produces values that can be used as inputs to
             [[conversion]]."
            DartExpression expression,
            "The conversion to apply to the result of [[expression]]."
            BoxingConversion conversion) {

        value [boxingFunction, lhsActual] =
            switch (conversion)
            case (ceylonBooleanToNative)
                [DartSimpleIdentifier("dart$ceylonBooleanToNative"),
                 ctx.ceylonTypes.booleanType]
            case (ceylonFloatToNative)
                [DartSimpleIdentifier("dart$ceylonFloatToNative"),
                 ctx.ceylonTypes.floatType]
            case (ceylonIntegerToNative)
                [DartSimpleIdentifier("dart$ceylonIntegerToNative"),
                 ctx.ceylonTypes.integerType]
            case (ceylonStringToNative)
                [DartSimpleIdentifier("dart$ceylonStringToNative"),
                 ctx.ceylonTypes.stringType]
            case (nativeToCeylonBoolean)
                [DartSimpleIdentifier("dart$nativeToCeylonBoolean"),
                 ctx.dartTypes.dartBoolModel]
            case (nativeToCeylonFloat)
                [DartSimpleIdentifier("dart$nativeToCeylonFloat"),
                 ctx.dartTypes.dartDoubleModel]
            case (nativeToCeylonInteger)
                [DartSimpleIdentifier("dart$nativeToCeylonInteger"),
                 ctx.dartTypes.dartIntModel]
            case (nativeToCeylonString)
                [DartSimpleIdentifier("dart$nativeToCeylonString"),
                 ctx.dartTypes.dartStringModel];

        value castedExpression =
                switch (lhsActual)
                // for native to ceylon, we'll never need an 'as' cast
                case (is DartTypeModel) expression
                // for ceylon to native, we may need to cast the arg
                case (is TypeModel) withCastingLhsRhs(
                        // disable erasure; we *know* that the result
                        // of the expression is not erased
                        scope, lhsActual, rhsActual, expression, true);

        return
        DartFunctionExpressionInvocation {
            DartPrefixedIdentifier {
                // TODO qualify programatically so we can compile lang module
                DartSimpleIdentifier("$ceylon$language");
                boxingFunction;
            };
            DartArgumentList {
                [castedExpression];
            };
        };
    }
}
