import ceylon.ast.core {
    Node,
    WideningTransformer,
    FunctionShortcutDefinition,
    FunctionDefinition,
    AnyFunction,
    Parameters,
    Arguments,
    PositionalArguments,
    NamedArguments,
    ArgumentList,
    FunctionExpression,
    Block,
    LazySpecifier,
    DefaultedParameter,
    Expression,
    Conditions,
    BooleanCondition
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionModel=Function,
    TypeModel=Type,
    ScopeModel=Scope,
    ElementModel=Element,
    FunctionOrValueModel=FunctionOrValue,
    ControlBlockModel=ControlBlock,
    ConstructorModel=Constructor,
    ValueModel=Value,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter
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

    "Note: technically callers should cast the returned DartExpression to the desired
     lhs type, since Dart appears to treat the result of anonymous function invocations
     as `var`. So type information is lost. But lets not get too pedantic."
    shared
    DartExpression createNullSafeExpression(
            "Identifier for result of [[maybeNullExpression]]"
            DartSimpleIdentifier parameterIdentifier,
            "The type of the [[maybeNullExpression]] that will be exposed as
             [[parameterIdentifier]]"
            DartTypeName parameterType,
            "Evaluate, test for null, and make available as [[parameterIdentifier]].
             Must be of [[parameterType]]."
            DartExpression maybeNullExpression,
            "Only evaluate if maybeNullExpression is null"
            DartExpression ifNullExpression,
            "Only evaluate if maybeNullExpression is not null"
            DartExpression ifNotNullExpression)
        =>  DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            false;
                            false;
                            parameterType;
                            parameterIdentifier;
                        }];
                    };
                    body = DartExpressionFunctionBody {
                        async = false;
                        DartConditionalExpression {
                            DartBinaryExpression {
                                parameterIdentifier;
                                "==";
                                DartNullLiteral();
                            };
                            ifNullExpression;
                            ifNotNullExpression;
                        };
                    };
                };
                DartArgumentList {
                    [maybeNullExpression];
                };
            };

    shared
    DartFunctionDeclaration generateFunctionDefinition(
            FunctionShortcutDefinition | FunctionDefinition that,
            "The function name of toplevels is prefixed with `$package$`"
            Boolean topLevel = false) {

        value info = AnyFunctionInfo(that);
        value functionModel = info.declarationModel;
        value functionPrefix = if (topLevel) then "$package$" else "";
        value functionName = functionPrefix + ctx.dartTypes.getName(functionModel);

        return
        DartFunctionDeclaration {
            external = false;
            returnType = generateFunctionReturnType(info);
            propertyKeyword = null;
            name = DartSimpleIdentifier(functionName);
            functionExpression = generateFunctionExpression(that);
        };
    }

    shared
    DartTypeName generateFunctionReturnType(AnyFunctionInfo<AnyFunction> info)
        =>  let (functionModel = info.declarationModel)
            if (functionModel.parameterLists.size() > 1) then
                // return type is a `Callable`; we're not get generic, so the Callable's
                // return is erased. Even on the Java backend, the arguments are erased.
                ctx.dartTypes.dartTypeName(info.node,
                    ctx.ceylonTypes.callableDeclaration.type, false)
            else if (!functionModel.declaredVoid) then
                ctx.dartTypes.dartTypeNameForDeclaration(info.node, functionModel)
            else
                // TODO seems like a hacky way to create a void keyword
                DartTypeName(DartSimpleIdentifier("void"));

    shared
    DartFunctionExpression generateFunctionExpression(
            FunctionExpression
                | FunctionDefinition
                | FunctionShortcutDefinition that) {

        FunctionModel functionModel;
        [Parameters+] parameterLists;
        LazySpecifier|Block definition;
        String? functionName;

        switch (that)
        case (is FunctionExpression) {
            value info = FunctionExpressionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = null;
        }
        case (is FunctionDefinition) {
            value info = FunctionDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = ctx.dartTypes.getName(functionModel);
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = ctx.dartTypes.getName(functionModel);
        }

        variable DartExpression? result = null;

        for (i -> list in parameterLists.indexed.sequence().reversed) {
            if (i < parameterLists.size - 1) {
                // wrap nested function in a callable
                assert(exists previous = result);
                result = generateNewCallable(that, functionModel, previous, i+1);
            }

            //Defaulted Parameters:
            //If any exist, use a block (not lazy specifier)
            //At start of block, assign values as necessary
            value defaultedParameters = list.parameters.narrow<DefaultedParameter>();

            DartFunctionBody body;
            if (defaultedParameters.empty) {
                // no defaulted parameters
                if (i == parameterLists.size - 1) {
                    // the actual function body
                    switch (definition)
                    case (is Block) {
                        body = withReturn(
                            functionModel,
                            () => DartBlockFunctionBody(null, false, statementTransformer
                                    .transformBlock(definition)[0]));
                    }
                    case (is LazySpecifier) {
                        body = DartExpressionFunctionBody(false, withLhs(
                            null,
                            functionModel,
                            () => definition.expression
                                    .transform(expressionTransformer)));
                    }
                }
                else {
                    assert(exists previous = result);
                    body = DartExpressionFunctionBody(false, previous);
                }
            }
            else {
                // defaulted parameters exist
                value statements = LinkedList<DartStatement>();

                for (param in defaultedParameters) {
                    value parameterInfo = ParameterInfo(param);
                    value paramName = DartSimpleIdentifier(
                            ctx.dartTypes.getName(parameterInfo.parameterModel));
                    statements.add {
                        DartIfStatement {
                            // if (parm === default)
                            DartFunctionExpressionInvocation {
                                DartPrefixedIdentifier {
                                    DartSimpleIdentifier("$dart$core");
                                    DartSimpleIdentifier("identical");
                                };
                                DartArgumentList {
                                    [paramName,
                                     DartPrefixedIdentifier {
                                        DartSimpleIdentifier("$ceylon$language");
                                        DartSimpleIdentifier("dart$default");
                                    }];
                                };
                            };
                            // then set to default expression
                            DartExpressionStatement {
                                DartAssignmentExpression {
                                    paramName;
                                    DartAssignmentOperator.equal;
                                    withLhs {
                                        null;
                                        parameterInfo.parameterModel.model;
                                        () => param.specifier.expression
                                                .transform(expressionTransformer);
                                    };
                                };
                            };
                        };
                    };
                }
                if (i == parameterLists.size - 1) {
                    // the actual function body
                    switch (definition)
                    case (is Block) {
                        statements.addAll(expand(withReturn(
                            functionModel,
                            () => definition.transformChildren(statementTransformer))));
                    }
                    case (is LazySpecifier) {
                        // for FunctionShortcutDefinition
                        statements.add {
                            DartReturnStatement {
                                withLhs {
                                    null;
                                    functionModel;
                                    () => definition.expression.transform(
                                            expressionTransformer);
                                };
                            };
                        };
                    }
                }
                else {
                    assert(exists previous = result);
                    statements.add(DartReturnStatement(previous));
                }
                body = DartBlockFunctionBody(null, false, DartBlock([*statements]));
            }
            result = DartFunctionExpression {
                generateFormalParameterList(that, list);
                body;
            };
        }
        assert (is DartFunctionExpression r = result);
        return r;
    }

    shared
    DartFormalParameterList generateFormalParameterList
            (Node that, Parameters parameters) {

        if (parameters.parameters.empty) {
            return DartFormalParameterList();
        }

        value dartParameters = parameters.parameters.collect((parameter) {
            value parameterInfo = ParameterInfo(parameter);
            value parameterModel = parameterInfo.parameterModel;

            value defaulted = parameterModel.defaulted;
            value callable = parameterModel.model is FunctionModel;
            value variadic = parameterModel.sequenced;

            if (callable) {
                throw CompilerBug(that, "Callable parameters not yet supported");
            }
            else if (variadic) {
                throw CompilerBug(that, "Variadic parameters not yet supported");
            }
            else {
                // Use core.Object for defaulted parameters so we can
                // initialize with `dart$default`
                value dartParameterType =
                    if (defaulted)
                    then ctx.dartTypes.dartObject
                    else ctx.dartTypes.dartTypeNameForDeclaration(
                            that, parameterModel.model);

                value dartSimpleParameter =
                DartSimpleFormalParameter {
                    false; false;
                    dartParameterType;
                    DartSimpleIdentifier {
                        ctx.dartTypes.getName(parameterModel);
                    };
                };

                if (defaulted) {
                    return
                    DartDefaultFormalParameter {
                        dartSimpleParameter;
                        DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$ceylon$language");
                            identifier = DartSimpleIdentifier("dart$default");
                        };
                    };
                }
                else {
                    return dartSimpleParameter;
                }
            }
        });
        return DartFormalParameterList {
            positional = true;
            parameters = dartParameters;
        };
    }

    shared
    DartInstanceCreationExpression generateNewCallable(
            Node that,
            FunctionModel functionModel,
            DartExpression delegateFunction,
            Integer parameterListNumber = 0,
            "Handle null delegates produces with the null safe member operator"
            Boolean delegateMayBeNull = false,
            Boolean delegateReturnsCallable =
                    parameterListNumber <
                    functionModel.parameterLists.size() - 1) {

        // TODO take the Callable's TypeModel as an argument in order to have
        //      correct (non-erased-to-Object) parameter and return types for
        //      generic functions

        DartExpression outerFunction;

        TypeModel returnType;
        FunctionOrValueModel? returnDeclaration;
        if (delegateReturnsCallable) {
            returnType = ctx.ceylonTypes.callableDeclaration.type;
            returnDeclaration = null;
        }
        else {
            returnType = functionModel.type;
            returnDeclaration = functionModel;
        }

        value parameters = CeylonList(functionModel.parameterLists
                .get(parameterListNumber).parameters);

        // determine if return or arguments need boxing
        value boxingRequired =
                (!delegateReturnsCallable
                    && ctx.dartTypes.erasedToNative(functionModel))
                || parameters.any((parameterModel)
                    =>  ctx.dartTypes.erasedToNative(parameterModel.model));

        // generate outerFunction to handle boxing
        if (!boxingRequired) {
            outerFunction = delegateFunction;
        }
        else {
            value outerParameters = parameters.collect((parameterModel) {
                value dartSimpleParameter =
                        DartSimpleFormalParameter {
                            false; false;
                            // core.Object for the type of all parameters since
                            // `Callable` is generic
                            ctx.dartTypes.dartObject;
                            DartSimpleIdentifier {
                                ctx.dartTypes.getName(parameterModel);
                            };
                        };

                if (parameterModel.defaulted) {
                    return
                    DartDefaultFormalParameter {
                        dartSimpleParameter;
                        DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$ceylon$language");
                            identifier = DartSimpleIdentifier("dart$default");
                        };
                    };
                }
                else {
                    return dartSimpleParameter;
                }
            });

            value innerArguments = parameters.collect((parameterModel) {
                value parameterName = ctx.dartTypes.getName(parameterModel);
                value parameterIdentifier = DartSimpleIdentifier(parameterName);

                value unboxed = withLhs {
                    null;
                    // "lhs" is the inner function's parameter
                    lhsDeclaration = parameterModel.model;
                    () => withBoxing {
                        that;
                        // Parameters for Callables are always `core.Object`
                        rhsType = ctx.ceylonTypes.anythingType;
                        rhsDeclaration = null;
                        parameterIdentifier;
                    };
                };

                if (parameterModel.defaulted) {
                    return
                    DartConditionalExpression {
                        // condition
                        DartFunctionExpressionInvocation {
                            dartDCIdentical;
                            DartArgumentList {
                                [parameterIdentifier,
                                 dartCLDDefaulted];
                            };
                        };
                        // propagate defaulted
                        dartCLDDefaulted;
                        // not default, unbox as necessary
                        unboxed;

                    };
                }
                else {
                    return
                    unboxed;
                }
            });

            // prepare the actual invocation expression, which
            // may need to protect against a null receiver.
            value invocation =
                DartFunctionExpressionInvocation {
                    delegateFunction;
                    DartArgumentList {
                        innerArguments;
                    };
                };

            value wrappedInvocation =
                if (!delegateMayBeNull) then
                    invocation
                else
                    DartConditionalExpression {
                        DartBinaryExpression {
                            delegateFunction;
                            "==";
                            DartNullLiteral();
                        };
                        DartNullLiteral();
                        invocation;
                    };

            // the outer function accepts and returns non-erased types
            // using the inner function that follows normal erasure rules
            outerFunction =
            DartFunctionExpression {
                DartFormalParameterList {
                    positional = true;
                    named = false;
                    parameters = outerParameters;
                };
                DartBlockFunctionBody {
                    keyword = null;
                    star = false;
                    DartBlock {
                        // return boxed (no erasure) result of
                        // the invocation of the original function
                        [DartReturnStatement {
                            withLhsNonNative {
                                returnType;
                                () => withBoxing {
                                    that;
                                    returnType;
                                    returnDeclaration;
                                    wrappedInvocation;
                                };
                            };
                        }];
                    };
                };
            };
        }

        // create the Callable!
        return
        DartInstanceCreationExpression {
            const = false;
            DartConstructorName {
                type = DartTypeName {
                    DartPrefixedIdentifier {
                        DartSimpleIdentifier("$ceylon$language");
                        DartSimpleIdentifier("dart$Callable");
                    };
                };
                name = null;
            };
            argumentList = DartArgumentList {
                [outerFunction];
            };
        };
    }

    "Only handles `BooleanCondition`s!!!"
    shared
    DartExpression generateBooleanDartCondition(Conditions that) {
        // TODO IsCondition & ExistsOrNonemptyCondition
        if (that.conditions.any((condition)
                =>  !condition is BooleanCondition)) {
            throw CompilerBug(that,
                "Only BooleanConditions are currently supported.");
        }

        value dartCondition = withLhsNative {
            ctx.ceylonTypes.booleanType;
            () => that.conditions
                    .reversed
                    .narrow<BooleanCondition>()
                    .map((c)
                        =>  c.condition.transform(expressionTransformer))
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial));
        };

        assert (exists dartCondition);
        return dartCondition;
    }

    shared
    DartArgumentList generateArgumentListFromArguments(Arguments that) {
        switch (that)
        case (is PositionalArguments) {
            return generateArgumentListFromArgumentList(that.argumentList);
        }
        case (is NamedArguments) {
            throw CompilerBug(that, "NamedArguments not supported");
        }
    }

    shared
    DartArgumentList generateArgumentListFromArgumentList(ArgumentList that) {
        "spread arguments not supported"
        assert(that.sequenceArgument is Null);

        value info = ArgumentListInfo(that);

        // use the passed in `formal` parameters, not the parameter models
        // available from the argument list.
        value args = that.listedArguments.indexed.collect((e) {
            value i -> expression = e;
            assert (is ParameterModel? parameterModel =
                    info.listedArgumentModels.getFromFirst(i)?.get(1));

            // FIXME we need the caller to pass in the Callable we are invoking,
            //       which would allow us to use unit.getCallableArgumentTypes
            //       for a "good" lhsType
            // For now, hack into old system.

            TypeModel? lhsType;
            FunctionOrValueModel? lhsDeclaration;

            if (exists parameterModel) {
                // Invoking a real function (not a callable value)
                lhsType = null; // see fixme; use a better type
                lhsDeclaration = parameterModel.model;
            }
            else {
                // Invoking a generic callable; all parameters take `core.Object`
                lhsType = ctx.ceylonTypes.anythingType;
                lhsDeclaration = null;
            }

            return withLhs {
                lhsType;
                lhsDeclaration;
                () => expression.transform(expressionTransformer);
            };
        });
        return DartArgumentList(args);
    }

    shared
    DartFunctionExpressionInvocation | DartAssignmentExpression
    generateAssignmentExpression(
                Node that,
                ValueModel targetDeclaration,
                Expression rhsExpression) {

        // TODO make sure setters return the new value, or do somthing here
        DartIdentifier targetOrSetter;
        Boolean isMethod;

        switch (container = containerOfDeclaration(targetDeclaration))
        case (is PackageModel) {
            isMethod = false;
            if (sameModule(ctx.unit, targetDeclaration)) {
                // qualify toplevel in same module with '$package$'
                targetOrSetter = DartSimpleIdentifier(
                    "$package$" +
                    ctx.dartTypes.identifierPackagePrefix(targetDeclaration) +
                    ctx.dartTypes.getName(targetDeclaration));
            }
            else {
                // qualify toplevel with Dart import prefix
                targetOrSetter = DartPrefixedIdentifier(
                    DartSimpleIdentifier(
                        ctx.dartTypes.moduleImportPrefix(targetDeclaration)),
                    DartSimpleIdentifier(
                        ctx.dartTypes.identifierPackagePrefix(targetDeclaration) +
                        ctx.dartTypes.getName(targetDeclaration)));
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            isMethod = useGetterSetterMethods(targetDeclaration);
            targetOrSetter =
                if (!isMethod) then
                    // regular variable; no lazy or block getter
                    DartSimpleIdentifier(
                        ctx.dartTypes.getName(targetDeclaration))
                else
                    // setter method
                    DartSimpleIdentifier(
                        ctx.dartTypes.getName(targetDeclaration) + "$set");
        }
        else {
            throw CompilerBug(that,
                "Unexpected container for base expression: \
                 declaration type '``className(targetDeclaration)``' \
                 container type '``className(container)``'");
        }

        DartExpression rhs = withLhs(
                null,
                targetDeclaration,
                () => rhsExpression.transform(expressionTransformer));

        if (isMethod) {
            return DartFunctionExpressionInvocation {
                func = targetOrSetter;
                argumentList = DartArgumentList([rhs]);
            };
        }
        else {
            return DartAssignmentExpression {
                targetOrSetter;
                DartAssignmentOperator.equal;
                rhs;
            };
        }
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
    Result withLhsDenotable<Result>(
            TypeModel expressionType,
            ClassOrInterfaceModel container,
            Result fun())
        =>  withLhsValues {
                ctx.ceylonTypes.denotableType(expressionType, container);
                false;
                false;
                fun;
            };

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
            TypeOrNoType lhsType,
            Boolean lhsErasedToNative,
            Boolean lhsErasedToObject,
            Result fun()) {
        value saveLhsType = ctx.lhsTypeTop;
        value saveLhsErasedToNative = ctx.lhsErasedToNativeTop;
        value saveLhsErasedToObject = ctx.lhsErasedToObjectTop;
        try {
            ctx.lhsTypeTop = lhsType;
            ctx.lhsErasedToNativeTop = lhsErasedToNative;
            ctx.lhsErasedToObjectTop = lhsErasedToObject;
            return fun();
        }
        finally {
            ctx.lhsTypeTop = saveLhsType;
            ctx.lhsErasedToNativeTop = saveLhsErasedToNative;
            ctx.lhsErasedToObjectTop = saveLhsErasedToObject;
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
    DartExpression withBoxing(
            Node|ElementModel|ScopeModel scope,
            TypeModel? rhsType,
            "The declaration that produces the value. For `Function`s, the declaration
             is used for its return type."
            FunctionOrValueModel? rhsDeclaration,
            DartExpression dartExpression)
        =>  let (type = rhsType
                    else rhsDeclaration?.type
                    else ctx.ceylonTypes.anythingType)
            withBoxingForType {
                scope;
                type;
                if (exists rhsDeclaration)
                    then ctx.dartTypes.erasedToNative(rhsDeclaration)
                    else ctx.dartTypes.native(type);
                if (exists rhsDeclaration)
                    then ctx.dartTypes.erasedToObject(rhsDeclaration)
                    else false;
                dartExpression;
            };

    DartExpression withBoxingForType(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsType,
            Boolean rhsErasedToNative,
            Boolean rhsErasedToObject,
            DartExpression dartExpression)
        =>  let (lhsType = ctx.assertedLhsTypeTop)
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
                    ctx.dartTypes.qualifyIdentifier {
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
}
