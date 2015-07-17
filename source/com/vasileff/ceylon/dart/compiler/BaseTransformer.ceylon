import ceylon.ast.core {
    Node,
    WideningTransformer,
    FunctionShortcutDefinition,
    FunctionDefinition,
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
    FunctionOrValueModel=FunctionOrValue,
    ControlBlockModel=ControlBlock,
    ConstructorModel=Constructor,
    ValueModel=Value,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter
}

abstract
class BaseTransformer<Result>(CompilationContext ctx)
        extends CoreTransformer<Result>(ctx)
        satisfies WideningTransformer<Result> {

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
    DartTypeName generateFunctionReturnType(AnyFunctionInfo info)
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
    DartExpression generateInvocation(
            Node scope,
            ExpressionInfo receiver,
            String memberName,
            [ExpressionInfo*] arguments) {

        // 1. Get a TypedDeclaration for the member
        // 2. Get a TypeDeclaration for the member's container
        // 3. Get a TypedReference for the member, to get the return and arg types
        // 4. Cast the receiver to a Dart denotable type for the member's container
        // 5. Invoke with each argument boxed as necessary
        // 6. Box and return

        // TODO translate toString() => string, etc.

        assert (is FunctionOrValueModel memberDeclaration =
                    receiver.typeModel.declaration.getMember(memberName, null, false));

        assert (is ClassOrInterfaceModel container = memberDeclaration.container);

        value typedReference = receiver.typeModel
                .getTypedReference(memberDeclaration, null);

        value rhsType = typedReference.type;

        value rhsDeclaration =
                if (is FunctionModel memberDeclaration,
                        memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        value boxedReceiver = withLhsDenotable {
            receiver.typeModel;
            container;
            () => receiver.node.transform(expressionTransformer);
        };

        DartExpression unboxed;
        if (is FunctionModel memberDeclaration) {
            value argumentTypes = CeylonList(ctx.unit.getCallableArgumentTypes(
                typedReference.fullType));

            value parameterDeclarations = CeylonList(
                    memberDeclaration.firstParameterList.parameters)
                    .collect(ParameterModel.model);
            unboxed =
            DartMethodInvocation {
                boxedReceiver;
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(memberDeclaration);
                };
                DartArgumentList {
                    [for (i -> argument in arguments.indexed)
                        withLhs {
                            argumentTypes[i];
                            parameterDeclarations[i];
                            () => argument.node.transform(expressionTransformer);
                        }
                    ];
                };
            };
        }
        else {
            unboxed =
            DartPropertyAccess {
                boxedReceiver;
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(memberDeclaration);
                };
            };
        }

        return withBoxing(scope, rhsType, rhsDeclaration, unboxed);
    }

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
    DartArgumentList generateArgumentListFromArguments
            (Arguments that, TypeModel callableType) {
        switch (that)
        case (is PositionalArguments) {
            return generateArgumentListFromArgumentList(that.argumentList, callableType);
        }
        case (is NamedArguments) {
            throw CompilerBug(that, "NamedArguments not supported");
        }
    }

    shared
    DartArgumentList generateArgumentListFromArgumentList
            (ArgumentList that, TypeModel callableType) {

        "spread arguments not supported"
        assert(that.sequenceArgument is Null);

        value info = ArgumentListInfo(that);
        value argumentTypes = CeylonList(ctx.unit.getCallableArgumentTypes(callableType));

        // NOTE info.listedArgumentModels[x][0] is the argument type model for argument x.
        //      But, this is actually the type of the expression for the callsite value.
        //      So, for the `lhs` type, we are instead using argument types obtained from
        //      callableType, which is what the function actually requires.

        value args = that.listedArguments.indexed.collect((e) {
            value i -> expression = e;

            assert (is ParameterModel? parameterModel =
                    info.listedArgumentModels.getFromFirst(i)?.get(1));

            TypeModel? lhsType;
            FunctionOrValueModel? lhsDeclaration;

            if (exists parameterModel) {
                // Invoking a real function (not a callable value)
                // Use the argument type, even though the parameter type should be
                // sufficient until we add support for generics
                assert (exists argumentType = argumentTypes[i]);

                lhsType = argumentType;
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
}
