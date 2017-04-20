import ceylon.ast.core {
    Node
}

import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type,
    FunctionOrValueModel=FunctionOrValue,
    ClassModel=Class,
    FunctionModel=Function,
    ConstructorModel=Constructor,
    ClassOrInterfaceModel=ClassOrInterface
}
import com.vasileff.ceylon.dart.compiler {
    DScope
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartArgumentList,
    DartExpression,
    DartFunctionExpressionInvocation,
    DartSimpleIdentifier,
    DartAsExpression
}

"""Provides:

   - Convenience attributes for concrete transformers
   - Fallback and error handling methods
   - Boxing, casting, and other type utility methods

   Shared code generation methods should be placed in [[BaseGenerator]].
"""
abstract
shared
class CoreGenerator(CompilationContext ctx) {

    shared
    CeylonTypes ceylonTypes
        =>  ctx.ceylonTypes;

    shared
    DartTypes dartTypes
        =>  ctx.dartTypes;

    shared
    ClassMemberTransformer classMemberTransformer
        =>  ctx.classMemberTransformer;

    shared
    ClassStatementTransformer classStatementTransformer
        =>  ctx.classStatementTransformer;

    shared
    ExpressionTransformer expressionTransformer
        =>  ctx.expressionTransformer;

    shared
    StatementTransformer statementTransformer
        =>  ctx.statementTransformer;

    shared
    TopLevelVisitor topLevelVisitor
        =>  ctx.topLevelVisitor;

    shared
    void error(Node that, Anything message)
        =>  process.writeErrorLine(
                message?.string else "<null>");

    shared
    DartExpression withBoxing(
            DScope scope,
            TypeModel rhsType,
            "The declaration that produces the value.

             Note: for `Function`s, the declaration is used for its return type.

             If a declaration is not provided, boxing will erase to native if possible,
             and casting will *not* assume erased to Object (except for non-denotable
             [[rhsType]]s, as always.)"
            FunctionOrValueModel? | ClassModel | ConstructorModel rhsDeclaration,
            DartExpression dartExpression)
        =>  switch (rhsDeclaration)
            case (is ClassModel)
                // Result of a constructor invocation is never native
                withBoxingNonNative {
                    scope;
                    rhsType;
                    dartExpression;
                }
            case (is ConstructorModel)
                // Result of a constructor invocation is never native
                withBoxingNonNative {
                    scope;
                    rhsType;
                    dartExpression;
                }
            case (is FunctionOrValueModel?)
                let (actualDeclaration
                        = dartTypes.declarationConsideringElidedReplacements(
                                rhsDeclaration),
                     actualType
                        = dartTypes.typeConsideringElidedReplacements(rhsType,
                                rhsDeclaration))
                withBoxingCustom {
                    scope;
                    actualType;
                    if (exists actualDeclaration)
                        then dartTypes.erasedToNative(actualDeclaration)
                        else dartTypes.native(rhsType);
                    if (exists actualDeclaration)
                        then dartTypes.erasedToObject(actualDeclaration)
                        else false;
                    dartExpression;
                };

    DartExpression withBoxingConversion(
            DScope scope,
            "The type of [[expression]]."
            TypeModel rhsType,
            "If the [[expression]]'s static type is not denotable, is a defaulted
             parameter, or is otherwise erased to `core.Object`."
            Boolean erasedToObject,
            "The expression that produces values that can be used as inputs to
             [[conversion]]."
            DartExpression expression,
            "The conversion to apply to the result of [[expression]]."
            BoxingConversion conversion) {

        value [boxTypeDeclaration, toNative, dartFunction] =
            switch (conversion)
            case (ceylonBooleanToNative) [ceylonTypes.booleanDeclaration, true, dartTypes.dartDartBool]
            case (ceylonFloatToNative)   [ceylonTypes.floatDeclaration, true, dartTypes.dartDartDouble]
            case (ceylonIntegerToNative) [ceylonTypes.integerDeclaration, true, dartTypes.dartDartInt]
            case (ceylonStringToNative)  [ceylonTypes.stringDeclaration, true, dartTypes.dartDartString]
            case (nativeToCeylonBoolean) [ceylonTypes.booleanDeclaration, false, dartTypes.dartCeylonBoolean]
            case (nativeToCeylonFloat)   [ceylonTypes.floatDeclaration, false, dartTypes.dartCeylonFloat]
            case (nativeToCeylonInteger) [ceylonTypes.integerDeclaration, false, dartTypes.dartCeylonInteger]
            case (nativeToCeylonString)  [ceylonTypes.stringDeclaration, false, dartTypes.dartCeylonString];

        return
        DartFunctionExpressionInvocation {
            dartTypes.dartIdentifierForDartModel {
                scope;
                dartFunction;
            };
            DartArgumentList {
                // For ceylon to native, we may need to narrow the non-native argument.
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
    }

    shared
    DartExpression withBoxingCustom(
            DScope scope,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  let (lhsType =
                    if (exists denotable = ctx.lhsDenotableTop)
                    then ceylonTypes.denotableType(rhsType, denotable)
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
            DScope scope,
            TypeModel lhsType,
            Boolean lhsErasedToNative,
            Boolean lhsErasedToObject,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  if (ceylonTypes.isCeylonFloat(lhsType)
                && ceylonTypes.isCeylonInteger(rhsType)) then
                withLhsCustom  {
                    lhsType;
                    lhsErasedToNative;
                    lhsErasedToObject;
                    () => integerToFloat {
                        scope;
                        rhsErasedToNative;
                        rhsErasedToObject;
                        dartExpression;
                    };
                }
            else
                let (conversion = dartTypes.boxingConversionFor(
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

    DartExpression integerToFloat(
            DScope scope,
            Boolean erasedToNative,
            Boolean erasedToObject,
            DartExpression expression)
        =>  expressionTransformer.generateInvocationSynthetic {
                scope;
                ceylonTypes.integerType;
                () => withBoxingCustom {
                    scope;
                    ceylonTypes.integerType;
                    erasedToNative;
                    erasedToObject;
                    expression;
                };
                memberName = "nearestFloat";
                arguments = [];
            };

    shared
    DartExpression withBoxingNonNative(
            DScope scope,
            TypeModel rhsType,
            DartExpression dartExpression)
        // TODO do callers always *know* that the rhs is rhsType, and not erasedToObject?
        =>  withBoxingCustom {
                scope;
                rhsType;
                false;
                false;
                dartExpression;
            };

    DartExpression withCastingLhsRhs(
            DScope scope,
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

        // Don't cast if the type doesn't matter
        if (is NoType lhsType) {
            return dartExpression;
        }

        value effectiveLhs =
                if(lhsErasedToObject || !dartTypes.denotable(lhsType))
                then ceylonTypes.anythingType
                else lhsType;

        // We'll never cast to $dart$core.Object; don't bother with the rest
        if (ceylonTypes.isCeylonAnything(effectiveLhs)) {
            return dartExpression;
        }

        value effectiveRhs =
                if(rhsErasedToObject || !dartTypes.denotable(rhsType))
                then ceylonTypes.anythingType
                else rhsType;

        // Don't cast if we are not narrowing the type
        if (effectiveRhs.isSubtypeOf(effectiveLhs)) {
            return dartExpression;
        }

        castType = dartTypes.dartTypeModel(effectiveLhs, erasedToNative);

        // Don't cast if the *Dart* types are the same, like List<T> and List<U>
        if (castType == dartTypes.dartTypeModel(effectiveRhs, erasedToNative)) {
            return dartExpression;
        }

        // cast away
        return
        DartAsExpression {
            dartExpression;
            dartTypes.dartTypeNameForDartModel(scope, castType);
        };
    }

    shared
    Result withDoFailVariable<Result>(
            DartSimpleIdentifier? doFailVariable,
            Result fun()) {

        value saveTop = ctx.doFailVariableTop;
        ctx.doFailVariableTop = doFailVariable;
        try {
            return fun();
        }
        finally {
            ctx.doFailVariableTop = saveTop;
        }
    }

    shared
    Result withLhs<Result>(
            TypeModel | TypeDetails | Null lhsType,
            "For the Value, or the return type of the Function.

             For callable parameters, the return type will be used as default. For
             *assignments* to callable parameters (rather than function returns), set
             [[lhsIsParameter]] to `true`."
            FunctionOrValueModel? lhsDeclaration,
            Result fun(),
            "Are we are 'assigning' to a parameter? If `true`, `FunctionModel`
             declarations will be considered as a value rather than inspecting their
             return types."
            Boolean lhsIsParameter = false) {

        if (is TypeDetails lhsType) {
            // TypeDetals overrides everything
            return withLhsValues {
                lhsType.type;
                lhsType.erasedToNative;
                lhsType.erasedToObject;
                fun;
            };
        }

        if (exists lhsDeclaration) {
            return withLhsValues {
                lhsType = lhsType else (
                    if (lhsIsParameter && lhsDeclaration is FunctionModel)
                        then lhsDeclaration.typedReference.fullType
                        else lhsDeclaration.type);
                if (lhsIsParameter && lhsDeclaration is FunctionModel)
                    then false
                    else dartTypes.erasedToNative(lhsDeclaration);
                if (lhsIsParameter, lhsDeclaration is FunctionModel)
                    then dartTypes.erasedToObjectCallableParam(
                            lhsDeclaration.initializerParameter)
                    else dartTypes.erasedToObject(lhsDeclaration);
                fun;
            };
        }
        else if (exists lhsType) {
            return withLhsValues {
                lhsType = lhsType;
                dartTypes.native(lhsType);
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
            TypeOrNoType lhsType, Boolean lhsErasedToNative,
            Boolean lhsErasedToObject, Result fun())
        =>  withLhsValues {
                lhsType;
                lhsErasedToNative;
                lhsErasedToObject;
                fun;
            };

    shared
    Result withLhsDenotable<Result>(
            ClassOrInterfaceModel lhsClassOrInterface,
            Result fun())
        =>  withLhsValues(null, false, false, fun, lhsClassOrInterface);

    "Erase to native if possible"
    shared
    Result withLhsNative<Result>(
            TypeModel lhsType,
            Result fun())
        =>  withLhs(lhsType, null, fun);

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
            TypeModel | TypeDetails lhsType,
            Result fun())
        =>  withLhsValues {
                switch (lhsType)
                case (is TypeDetails) lhsType.type
                case (is TypeModel) lhsType;
                false; false; fun;
            };

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
            TypeDetails | FunctionOrValueModel typeOrDeclaration,
            Result fun()) {
        value save = ctx.returnTypeOrDeclarationTop;
        try {
            ctx.returnTypeOrDeclarationTop = typeOrDeclaration;
            return fun();
        }
        finally {
            ctx.returnTypeOrDeclarationTop = save;
        }
    }

    shared
    Result withReturnCustom<Result>(
            TypeModel lhsType, Boolean lhsErasedToNative,
            Boolean lhsErasedToObject, Result fun())
        =>  withReturn {
                TypeDetails {
                    lhsType;
                    lhsErasedToNative;
                    lhsErasedToObject;
                };
                fun;
            };

    shared
    Result withInConstructorBody<Result>(
            ClassModel classDeclaration,
            Result fun()) {
        variable Boolean remove = true;
        try {
            remove = ctx.withinConstructorBodySet.add(classDeclaration);
            return fun();
        }
        finally {
            if (remove) {
                ctx.withinConstructorBodySet.remove(classDeclaration);
            }
        }
    }

    shared
    Result withInConsolidatedConstructor<Result>(
            ClassModel classDeclaration,
            Result fun()) {
        variable Boolean remove = true;
        try {
            remove = ctx.withinConsolidatedConstructorSet.add(classDeclaration);
            return fun();
        }
        finally {
            if (remove) {
                ctx.withinConsolidatedConstructorSet.remove(classDeclaration);
            }
        }
    }

    shared
    Result withInConstructorDefaults<Result>(
            ClassModel classDeclaration,
            Result fun()) {
        variable Boolean remove = true;
        try {
            remove = ctx.withinConstructorDefaultsSet.add(classDeclaration);
            return fun();
        }
        finally {
            if (remove) {
                ctx.withinConstructorDefaultsSet.remove(classDeclaration);
            }
        }
    }

    shared
    Result withInConstructorSignature<Result>(
            ClassModel classDeclaration,
            Result fun()) {
        variable Boolean remove = true;
        try {
            remove = ctx.withinConstructorSignatureSet.add(classDeclaration);
            return fun();
        }
        finally {
            if (remove) {
                ctx.withinConstructorSignatureSet.remove(classDeclaration);
            }
        }
    }

    shared
    [TypeOrNoType, Boolean, Boolean] contextLhsTypeForRhs(TypeModel rhsType)
        =>  if (exists denotable = ctx.lhsDenotableTop) then
                [ceylonTypes.denotableType(rhsType, denotable),
                 ctx.assertedLhsErasedToNativeTop,
                 ctx.assertedLhsErasedToObjectTop]
            else (
                switch (lhsTop = ctx.assertedLhsTypeTop)
                case (is Null | NoType)
                    [noType,
                     ctx.assertedLhsErasedToNativeTop,
                     ctx.assertedLhsErasedToObjectTop]
                case (is TypeModel)
                    [lhsTop,
                     ctx.assertedLhsErasedToNativeTop,
                     ctx.assertedLhsErasedToObjectTop]);
}
