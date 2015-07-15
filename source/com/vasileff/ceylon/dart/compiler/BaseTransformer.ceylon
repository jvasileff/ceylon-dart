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
                assert(exists previous = result);
                TypeModel formalReturn;
                TypeModel actualReturn;
                if (i == parameterLists.size - 2) {
                    // innermost Callable, return is the actual Function's result
                    formalReturn = ctx.dartTypes.formalType(functionModel);
                    actualReturn = ctx.dartTypes.actualType(functionModel);
                }
                else {
                    // outer Callable that returns a Callable
                    formalReturn = ctx.ceylonTypes.callableDeclaration.type;
                    actualReturn = ctx.ceylonTypes.callableDeclaration.type;
                }

                // wrap nested function in a callable
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
                            // condition
                            DartFunctionExpressionInvocation {
                                DartPrefixedIdentifier {
                                    prefix = DartSimpleIdentifier("$dart$core");
                                    identifier = DartSimpleIdentifier("identical");
                                };
                                DartArgumentList {
                                    [paramName,
                                     DartPrefixedIdentifier {
                                        prefix = DartSimpleIdentifier("$ceylon$language");
                                        identifier = DartSimpleIdentifier("dart$default");
                                    }];
                                };
                            };
                            // then statement
                            DartExpressionStatement {
                                DartAssignmentExpression {
                                    paramName;
                                    DartAssignmentOperator.equal;
                                    withLhs {
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

        DartExpression outerFunction;

        TypeModel returnType;
        FunctionOrValueModel? returnDeclaration;
        Boolean returnErasedToNative;

        if (delegateReturnsCallable) {
            returnType = ctx.ceylonTypes.callableDeclaration.type;
            returnDeclaration = null;
            returnErasedToNative = false;
        }
        else {
            returnType = functionModel.type;
            returnDeclaration = functionModel;
            returnErasedToNative = ctx.dartTypes.erasedToNative(functionModel);
        }
        value parameters = CeylonList(functionModel.parameterLists
                .get(parameterListNumber).parameters);

        // determine if return or arguments need boxing
        value boxingRequired =
                returnErasedToNative ||
                parameters.any((parameterModel)
                    =>  ctx.dartTypes.native(ctx.dartTypes
                                .formalType(parameterModel.model)));

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

            // If parameterModel is null, we must be invoking a value, so use type
            // `Anything` to disable erasure. We don't need to cast, since `Callable`'s
            // take `core.Object`s.
            TypeModel lhsFormal =
                    if (exists parameterModel)
                    then ctx.dartTypes.formalType(parameterModel.model)
                    else ctx.ceylonTypes.anythingType;

            TypeModel lhsActual =
                    if (exists parameterModel)
                    then ctx.dartTypes.actualType(parameterModel.model)
                    else ctx.ceylonTypes.anythingType;

            return withLhsType(
                [lhsFormal, lhsActual],
                () => expression.transform(expressionTransformer));
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
    Result withLhsType<Result>(
            FormalActualOrNoType lhsFormalActual,
            Result fun()) {
        value save = ctx.lhsFormalActualTop;
        try {
            ctx.lhsFormalActualTop = lhsFormalActual;
            value result = fun();
            return result;
        }
        finally {
            ctx.lhsFormalActualTop = save;
        }
    }

    shared
    Result withLhsNoType<Result>(Result fun())
        =>  withLhsType(noType, fun);

    shared
    Result withLhs<Result>(
            FunctionOrValueModel lhsDeclaration,
            Result fun())
        =>  withLhsType(
                [ctx.dartTypes.formalType(lhsDeclaration),
                 ctx.dartTypes.actualType(lhsDeclaration)],
                fun);

    shared
    Result withLhsDenotable<Result>(
            TypeModel expressionType,
            ClassOrInterfaceModel container,
            Result fun())
        =>  withLhsNonNative {
                ctx.ceylonTypes.denotableType(expressionType, container);
                fun;
            };

    "Erase to native if possible"
    shared
    Result withLhsNative<Result>(
            TypeModel type,
            Result fun())
        =>  withLhsType {
                [type, type];
                fun;
            };

    "Never erase to native (always box)"
    shared
    Result withLhsNonNative<Result>(
            TypeModel type,
            Result fun())
        =>  withLhsType {
                [ctx.ceylonTypes.anythingType, type];
                fun;
            };

    shared
    Result withReturnType<Result>(
            FormalActualOrNoType returnFormalActual,
            Result fun()) {
        value save = ctx.returnFormalActualTop;
        try {
            ctx.returnFormalActualTop = returnFormalActual;
            return fun();
        }
        finally {
            ctx.returnFormalActualTop = save;
        }
    }

    shared
    Result withReturn<Result>(
            FunctionOrValueModel|NoType lhsDeclaration,
            Result fun())
        =>  if (is NoType lhsDeclaration) then
                withReturnType(noType, fun)
            else
                withReturnType(
                    [ctx.dartTypes.formalType(lhsDeclaration),
                     ctx.dartTypes.actualType(lhsDeclaration)],
                    fun);

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
            DartExpression dartExpression) {

        value lhsFormalActual = ctx.assertedLhsFormalActualTop;

        if (is NoType lhsFormalActual) {
            return dartExpression;
        }
        else {
            value [lhsFormal, lhsActual] = lhsFormalActual;

            // normally, actual will be a subtype of formal. But, due to our hack
            // replacement of actual with Anything to signal "erasedToObject", we
            // don't always have a good rhsActual. So, another hack, for now:
            value lhsType = if (lhsActual.anything) then lhsFormal else lhsActual;

            // and another hack, for now:
            value lhsErasedToObject = if (lhsActual.anything)
                    then true else !ctx.dartTypes.denotable(lhsActual);

            return withBoxingLhsRhs {
                scope;
                lhsType;
                ctx.dartTypes.native(lhsFormal);
                lhsErasedToObject;
                rhsType;
                rhsErasedToNative;
                rhsErasedToObject;
                dartExpression;
            };
        }
    }

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
            BoxingConversion conversion) {

        value [boxTypeDeclaration, toNative] =
            switch (conversion)
            case (ceylonBooleanToNative)
                [ctx.ceylonTypes.booleanDeclaration, true]
            case (ceylonFloatToNative)
                [ctx.ceylonTypes.floatDeclaration, true]
            case (ceylonIntegerToNative)
                [ctx.ceylonTypes.integerDeclaration, true]
            case (ceylonStringToNative)
                [ctx.ceylonTypes.stringDeclaration, true]
            case (nativeToCeylonBoolean)
                [ctx.ceylonTypes.booleanDeclaration, false]
            case (nativeToCeylonFloat)
                [ctx.ceylonTypes.floatDeclaration, false]
            case (nativeToCeylonInteger)
                [ctx.ceylonTypes.integerDeclaration, false]
            case (nativeToCeylonString)
                [ctx.ceylonTypes.stringDeclaration, false];

        value castedArgument =
                // For ceylon to native, we may need to narrow the non-native
                // argument.
                //
                // For native to ceylon, we may need to narrow the native argument
                // in the unusual case that `rhsActual` is `Anything` despite being
                // native, which happens for defaulted parameters.
                withCastingLhsRhs(scope,
                    boxTypeDeclaration.type, false,
                    rhsType, erasedToObject, !toNative, expression);

        return
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
                [castedArgument];
            };
        };
    }
}
