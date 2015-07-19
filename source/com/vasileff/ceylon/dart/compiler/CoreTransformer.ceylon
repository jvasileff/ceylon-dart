import ceylon.ast.core {
    Node,
    WideningTransformer
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionModel=Function,
    TypeModel=Type,
    ScopeModel=Scope,
    ElementModel=Element,
    FunctionOrValueModel=FunctionOrValue,
    ClassOrInterfaceModel=ClassOrInterface
}
import com.vasileff.ceylon.dart.model {
    DartTypeModel
}

"""Provides:

   - Convenience attributes for concrete transformers
   - Fallback and error handling methods
   - Boxing, casting, and other type utility methods

   Shared code generation methods should be placed in [[BaseTransformer]].
"""
abstract
class CoreTransformer<Result>(CompilationContext ctx)
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

    shared
    void error(Node that, Anything message)
        =>  process.writeErrorLine(
                message?.string else "<null>");

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
    DartExpression withBoxing(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            "The declaration that produces the value.

             For `Function`s, the declaration is used for its return type.

             If a declaration is not provided, boxing will erase to native if possible,
             and casting will *not* assume erased to Object (except for non-denotable
             [[rhsType]]s, as always.)"
            FunctionOrValueModel? rhsDeclaration,
            DartExpression dartExpression)
        =>  withBoxingForType {
                scope;
                rhsType;
                if (exists rhsDeclaration)
                    then ctx.dartTypes.erasedToNative(rhsDeclaration)
                    else ctx.dartTypes.native(rhsType);
                if (exists rhsDeclaration)
                    then ctx.dartTypes.erasedToObject(rhsDeclaration)
                    else false;
                dartExpression;
            };

    DartExpression withBoxingConversion(
            Node|ElementModel|ScopeModel scope,
            "The type of [[expression]]."
            TypeModel rhsType,
            "If the [[expression]]'s static type is not denotable, is a defaulted
             parameter, or is otherwise erased to `core.Object`."
            Boolean erasedToObject,
            "The expression that produces values that can be used as inputs to
             [[conversion]]."
            DartExpression expression,
            "The conversion to apply to the result of [[expression]]."
            BoxingConversion conversion)
        =>  let ([boxTypeDeclaration, toNative] =
                switch (conversion)
                case (ceylonBooleanToNative) [ctx.ceylonTypes.booleanDeclaration, true]
                case (ceylonFloatToNative)   [ctx.ceylonTypes.floatDeclaration, true]
                case (ceylonIntegerToNative) [ctx.ceylonTypes.integerDeclaration, true]
                case (ceylonStringToNative)  [ctx.ceylonTypes.stringDeclaration, true]
                case (nativeToCeylonBoolean) [ctx.ceylonTypes.booleanDeclaration, false]
                case (nativeToCeylonFloat)   [ctx.ceylonTypes.floatDeclaration, false]
                case (nativeToCeylonInteger) [ctx.ceylonTypes.integerDeclaration, false]
                case (nativeToCeylonString)  [ctx.ceylonTypes.stringDeclaration, false])
            DartFunctionExpressionInvocation {
                DartPropertyAccess {
                    ctx.dartTypes.dartIdentifierForClassOrInterface {
                        scope;
                        boxTypeDeclaration;
                    };
                    DartSimpleIdentifier {
                        if (toNative)
                        then "nativeValue"
                        else "instance";
                    };
                };
                DartArgumentList {
                    // For ceylon to native, we may need to narrow the non-native
                    // argument.
                    //
                    // For native to ceylon, we may need to narrow the native argument
                    // in the unusual case that `rhsActual` is `Anything` despite being
                    // native, which happens for defaulted parameters.
                    [withCastingLhsRhs {
                        scope;
                        lhsType = boxTypeDeclaration.type;
                        lhsErasedToObject = false;
                        rhsType = rhsType;
                        rhsErasedToObject = erasedToObject;
                        erasedToNative = !toNative;
                        expression;
                    }];
                };
            };

    shared
    DartExpression withBoxingCustom(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  withBoxingForType {
                scope;
                rhsType;
                rhsErasedToNative;
                rhsErasedToObject;
                dartExpression;
            };

    DartExpression withBoxingForType(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  let (lhsType =
                    if (exists denotable = ctx.lhsDenotableTop)
                    then ctx.ceylonTypes.denotableType(rhsType, denotable)
                    else ctx.assertedLhsTypeTop)
            if (is NoType lhsType) then
                dartExpression
            else
                withBoxingLhsRhs {
                    scope;
                    lhsType;
                    ctx.assertedLhsErasedToNativeTop;
                    ctx.assertedLhsErasedToObjectTop;
                    rhsType;
                    rhsErasedToNative;
                    rhsErasedToObject;
                    dartExpression;
                };

    DartExpression withBoxingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            TypeModel lhsType,
            Boolean lhsErasedToNative,
            Boolean lhsErasedToObject,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  let (conversion = ctx.dartTypes.boxingConversionFor(
                    lhsType, lhsErasedToNative,
                    rhsType, rhsErasedToNative))
            if (exists conversion) then
                // assume the lhsType is a supertype of the result
                // of the boxing conversion, and don't cast
                withBoxingConversion(scope, rhsType, rhsErasedToObject,
                        dartExpression, conversion)
            else
                withCastingLhsRhs(scope,
                        lhsType, lhsErasedToObject,
                        rhsType, rhsErasedToObject,
                        // if the lhsActual is native, so must be the rhsActual
                        lhsErasedToNative, dartExpression);

    shared
    DartExpression withBoxingNonNative(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            DartExpression dartExpression)
        =>  withBoxingForType {
                scope;
                rhsType;
                false;
                false;
                dartExpression;
            };

    DartExpression withCastingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            TypeModel|NoType lhsType,
            "means: lhsDefinitelyErasedToObject"
            Boolean lhsErasedToObject,
            TypeModel rhsType,
            "means: rhsDefinitelyErasedToObject"
            Boolean rhsErasedToObject,
            "Set to `true` when both [[lhsType]] and [[rhsType]] should be considered
             native types."
            Boolean erasedToNative,
            "The expression of type [[rhsType]]"
            DartExpression dartExpression) {

        DartTypeModel castType;

        value effectiveLhs =
                if(lhsErasedToObject)
                then ctx.ceylonTypes.anythingType
                else lhsType;

        value effectiveRhs =
                if(rhsErasedToObject)
                then ctx.ceylonTypes.anythingType
                else rhsType;

        if (is NoType effectiveLhs) {
            return dartExpression;
        }
        else if (effectiveLhs.isSubtypeOf(effectiveRhs)
                    && !effectiveLhs.isExactly(effectiveRhs)) {
            // lhs is the result of a narrowing operation
            castType = ctx.dartTypes.dartTypeModel(effectiveLhs, erasedToNative);
        }
        else if (!ctx.dartTypes.denotable(effectiveRhs)) {
            // may be narrowing the Dart static type
            castType = ctx.dartTypes.dartTypeModel(effectiveLhs, erasedToNative);
        }
        else {
            // narrowing neither the Ceylon type nor the Dart type; avoid unnecessary
            // widening casts
            return dartExpression;
        }

        // the rhs may still have the same Dart type
        if (castType == ctx.dartTypes.dartTypeModel(effectiveRhs, erasedToNative)) {
            return dartExpression;
        }

        // cast away
        return
        DartAsExpression {
            dartExpression;
            ctx.dartTypes.dartTypeNameForDartModel(scope, castType);
        };
    }

    shared
    Result withLhs<Result>(
            TypeModel? lhsType,
            FunctionOrValueModel? lhsDeclaration,
            Result fun()) {

        if (exists lhsDeclaration) {
            return withLhsValues {
                lhsType = lhsType else lhsDeclaration.type;
                ctx.dartTypes.erasedToNative(lhsDeclaration);
                ctx.dartTypes.erasedToObject(lhsDeclaration);
                fun;
            };
        }
        else if (exists lhsType) {
            return withLhsValues {
                lhsType = lhsType;
                ctx.dartTypes.native(lhsType);
                false;
                fun;
            };
        }
        else {
            return withLhsNoType(fun);
        }
    }

    shared
    Result withLhsCustom<Result>(
            TypeModel lhsType, Boolean lhsErasedToNative,
            Boolean lhsErasedToObject, Result fun())
        =>  withLhsValues {
                lhsType;
                lhsErasedToNative;
                lhsErasedToObject;
                fun;
            };

    shared
    Result withLhsDenotable<Result>(
            ClassOrInterfaceModel container,
            Result fun())
        =>  withLhsValues(null, false, false, fun, container);

    "Erase to native if possible"
    shared
    Result withLhsNative<Result>(
            TypeModel type,
            Result fun())
        =>  withLhs(type, null, fun);

    "No specific lhs type required; disable boxing and casting."
    shared
    Result withLhsNoType<Result>(Result fun())
        =>  withLhsValues {
                lhsType = noType;
                lhsErasedToNative = true;
                lhsErasedToObject = true;
                fun;
            };

    "Never erase to native (always box)"
    shared
    Result withLhsNonNative<Result>(
            TypeModel type,
            Result fun())
        =>  withLhsValues(type, false, false, fun);

    Result withLhsValues<Result>(
            TypeOrNoType? lhsType,
            Boolean? lhsErasedToNative,
            Boolean? lhsErasedToObject,
            Result fun(),
            ClassOrInterfaceModel? lhsDenotable = null) {
        value saveLhsType = ctx.lhsTypeTop;
        value saveLhsErasedToNative = ctx.lhsErasedToNativeTop;
        value saveLhsErasedToObject = ctx.lhsErasedToObjectTop;
        value saveLhsDenotable = ctx.lhsDenotableTop;
        try {
            ctx.lhsTypeTop = lhsType;
            ctx.lhsErasedToNativeTop = lhsErasedToNative;
            ctx.lhsErasedToObjectTop = lhsErasedToObject;
            ctx.lhsDenotableTop = lhsDenotable;
            return fun();
        }
        finally {
            ctx.lhsTypeTop = saveLhsType;
            ctx.lhsErasedToNativeTop = saveLhsErasedToNative;
            ctx.lhsErasedToObjectTop = saveLhsErasedToObject;
            ctx.lhsDenotableTop = saveLhsDenotable;
        }
    }

    shared
    Result withReturn<Result>(
            FunctionModel functionDeclaration,
            Result fun()) {
        value save = ctx.returnDeclarationTop;
        try {
            ctx.returnDeclarationTop = functionDeclaration;
            return fun();
        }
        finally {
            ctx.returnDeclarationTop = save;
        }
    }
}
