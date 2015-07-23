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
    Conditions,
    BooleanCondition,
    QualifiedExpression,
    BaseExpression,
    IsCondition
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
    ValueModel=Value,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter,
    DeclarationModel=Declaration,
    Reference
}

abstract
class BaseTransformer<Result>(CompilationContext ctx)
        extends CoreTransformer<Result>(ctx)
        satisfies WideningTransformer<Result> {

    shared
    DartFunctionExpressionInvocation createInlineDartStatements(
            "Zero or more statements, followed by a Return"
            [DartStatement*] statements)
        =>  DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    dartFormalParameterListEmpty;
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock(statements);
                    };
                };
                DartArgumentList([]);
            };

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
    DartFunctionDeclaration generateFunctionDefinition
            (FunctionShortcutDefinition | FunctionDefinition that) {

        value info = AnyFunctionInfo(that);
        value functionModel = info.declarationModel;

        assert (is DartSimpleIdentifier functionIdentifier =
                ctx.dartTypes.dartIdentifierForFunctionOrValue(
                    that, functionModel, false)[0]);

        return
        DartFunctionDeclaration {
            external = false;
            returnType = generateFunctionReturnType(info);
            propertyKeyword = null;
            name = functionIdentifier;
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
            [ExpressionInfo*] arguments)
        =>  generateInvocationGenerator(scope, receiver, memberName, arguments)[2]();

    """Returns a Tuple holding:

       - The `Type` of the result of the invocation
       - The `FunctionOrValueModel` of the member, or `null` when invoking a function with
         multiple parameter lists, in which case the `Type` will be a `Callable`.
       - A function that will build and box an expression for the invocation. Callers
         should call the generator function within a [[withLhs]] context.

       The purpose of this method is to allow callers to calculate (and therefore have
       access to) the desired lhs type (often a denotable type) for use when making
       synthetic declarations to hold the result of the invocation.
    """
    shared
    [TypeModel, FunctionOrValueModel?, DartExpression()]
    generateInvocationGenerator(
            Node scope,
            ExpressionInfo receiver,
            String memberName,
            [ExpressionInfo*] arguments) {

        return
        generateInvocationGeneratorSynthetic {
            scope;
            receiver.typeModel;
            () => receiver.node.transform(expressionTransformer);
            memberName;
            arguments;
        };
    }

    see(`function generateInvocationGeneratorSynthetic`)
    shared
    DartExpression
    generateInvocationSynthetic(
            Node scope,
            TypeModel receiverType,
            DartExpression generateReceiver(),
            String memberName,
            [ExpressionInfo*] arguments)
        =>  generateInvocationGeneratorSynthetic {
                scope;
                receiverType;
                generateReceiver;
                memberName;
                arguments;
            }[2]();


    """The same as [[generateInvocation]], but with parameters that are more fundamental
       (i.e. `TypeModel` and `DartExpression()` rather than `ExpressionInfo`).
    """
    see(`function generateInvocationGenerator`)
    shared
    [TypeModel, FunctionOrValueModel?, DartExpression()]
    generateInvocationGeneratorSynthetic(
            Node scope,
            TypeModel receiverType,
            DartExpression generateReceiver(),
            String memberName,
            [ExpressionInfo*] arguments) {

        // 1. Get a TypedDeclaration for the member
        // 2. Get a TypeDeclaration for the member's container
        // 3. Get a TypedReference for the member, to get the return and arg types
        // 4. Cast the receiver to a Dart denotable type for the member's container
        // 5. Invoke with each argument boxed as necessary
        // 6. Box and return

        assert (is FunctionOrValueModel memberDeclaration =
                    receiverType.declaration.getMember(memberName, null, false));

        // TODO translate toString() => string, etc.
        assert (is DartSimpleIdentifier memberIdentifier =
                    ctx.dartTypes.dartIdentifierForFunctionOrValue(
                        scope, memberDeclaration, false)[0]);

        assert (is ClassOrInterfaceModel container = memberDeclaration.container);

        value typedReference = receiverType
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
            container;
            generateReceiver;
        };

        function expressionGenerator() {
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
                    memberIdentifier;
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
                    memberIdentifier;
                };
            }

            return
            withBoxing {
                scope;
                rhsType;
                rhsDeclaration;
                unboxed;
            };
        }

        return [rhsType, rhsDeclaration, expressionGenerator];
    }

    "Generates a DartExpression that produces a native boolean.

     NOTE: This function unconventionally wraps the transformation in
     `withLhsNative`, relieving callers of that duty."
    shared
    DartExpression generateBooleanConditionExpression
            (BooleanCondition that, Boolean negate = false)
        =>  let (e = withLhsNative {
                ctx.ceylonTypes.booleanType;
                () => that.condition.transform(expressionTransformer);
            })
            if (negate)
            then DartPrefixExpression("!", e)
            else e;

    shared
    [DartStatement?, DartStatement?, DartExpression, DartStatement?]
    generateIsConditionExpression(IsCondition that, Boolean negate = false) {

        // IsCondition holds a TypedVariable that may
        // or may not include a specifier to define a new variable

        // NOTE: There is no ast node for the typechecker's
        // Tree.IsCondition.Variable (we just get the specifier
        // and identifier from that node, but not the model info).
        // Instead, use ConditionInfo.variableDeclarationModel.

        // TODO string escaping
        // TODO types! (including union and intersection, but not reified yet)
        // TODO check not null for Objects
        // TODO check null for Null
        // TODO consider null issues for negated checks
        // TODO consider erased types, like `Integer? i = 1; assert (is Integer i);`

        value info = IsConditionInfo(that);

        "The type we are testing for"
        value isType = TypeInfo(that.variable.type).typeModel;

        "The declaration model for the new variable"
        value variableDeclaration = info.variableDeclarationModel;

        //"The type of the new variable (intersection of isType and expression/old type)"
        //value variableType = variableDeclaration.type;

        "The expression node if defining a new variable"
        value expression = that.variable.specifier?.expression;

        DartStatement? replacementDeclaration;
        DartStatement? tempDefinition;
        DartExpression conditionExpression;
        DartStatement? replacementDefinition;

        // new variable, or narrowing existing?
        if (exists expression) {
            // 1. declare the new variable
            // 2. evaluate expression to temp variable of type of expression
            // 3. check type of the temp variable
            // 4. set the new variable, with appropriate boxing
            // (perform 2-4 in a new block to scope the temp var)

            value variableIdentifier = DartSimpleIdentifier(
                    ctx.dartTypes.getName(variableDeclaration));

            value expressionType = ExpressionInfo(expression).typeModel;

            value tempIdentifier = DartSimpleIdentifier(
                    ctx.dartTypes.createTempName(variableDeclaration));

            // 1. declare the new variable
            replacementDeclaration =
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    ctx.dartTypes.dartTypeNameForDeclaration {
                        that;
                        variableDeclaration;
                    };
                    [DartVariableDeclaration {
                        variableIdentifier;
                    }];
                };
            };

            // 2. evaluate to tmp variable
            tempDefinition =
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    ctx.dartTypes.dartTypeName(that, expressionType, true);
                    [DartVariableDeclaration {
                        tempIdentifier;
                        // possibly erase to a native type!
                        withLhsNative {
                            expressionType;
                            () => expression.transform(expressionTransformer);
                        };
                    }];
                };
            };

            // 3. perform is check on tmp variable
            conditionExpression = generateIsExpression(
                    that, tempIdentifier, isType);

            // 4. set replacement variable
            replacementDefinition =
            DartExpressionStatement {
                DartAssignmentExpression {
                    variableIdentifier;
                    DartAssignmentOperator.equal;
                    withLhs {
                        null;
                        variableDeclaration;
                        () => withBoxing {
                            that;
                            // as noted above, tmpVariable may be erased. Maybe
                            // when narrowing optionals like String?.
                            expressionType;
                            null;
                            tempIdentifier;
                        };
                    };
                };
            };
        }
        else {
            tempDefinition = null;
            replacementDeclaration = null;

            // check type of the original variable,
            // possibly declare new variable with a narrowed type
            assert(is FunctionOrValueModel originalDeclaration =
                    variableDeclaration.originalDeclaration);

            value originalIdentifier = DartSimpleIdentifier(
                    ctx.dartTypes.getName(originalDeclaration));

            conditionExpression = generateIsExpression(
                    that, originalIdentifier, isType);

            // erasure to native may have changed
            // erasure to object may have changed
            // type may have narrowed
            value dartTypeChanged =
                ctx.dartTypes.dartTypeModelForDeclaration(originalDeclaration) !=
                ctx.dartTypes.dartTypeModelForDeclaration(variableDeclaration);

            replacementDefinition =
                if (!dartTypeChanged)
                then null
                else
                    DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            ctx.dartTypes.dartTypeNameForDeclaration {
                                that;
                                variableDeclaration;
                            };
                            [DartVariableDeclaration {
                                DartSimpleIdentifier {
                                    ctx.dartTypes.createReplacementName{
                                        variableDeclaration;
                                    };
                                };
                                withLhs {
                                    null;
                                    variableDeclaration;
                                    () => withBoxing {
                                        that;
                                        originalDeclaration.type; // good enough???
                                        // FIXME possibly false assumption that refined
                                        // will be null for non-initial declarations
                                        // (is refinedDeclaration propagated?)
                                        originalDeclaration;
                                        DartSimpleIdentifier {
                                            ctx.dartTypes.getName(originalDeclaration);
                                        };
                                    };
                                };
                            }];
                        };
                    };
        }

        return [replacementDeclaration,
                tempDefinition,
                if (that.negated && (!negate) || (!that.negated) && negate)
                    then DartPrefixExpression("!", conditionExpression)
                    else conditionExpression,
                replacementDefinition];
    }

    shared
    DartExpression generateIsExpression(
            Node scope,
            DartExpression expressionToCheck,
            TypeModel isType) {

        // TODO warn if non-denotable (for which we are currently returning true!)
        //      - take the type we are narrowing, and warn if non-reified checks are not
        //        sufficient
        //      - and reified generics...

        if (isType.union) {
            value result = CeylonList(isType.caseTypes).reversed
                .map((t)
                    => generateIsExpression(scope, expressionToCheck, t))
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "||", partial));

            assert (exists result);
            return result;
        }
        else if (isType.intersection) {
            value result = CeylonList(isType.satisfiedTypes).reversed
                .map((t)
                    => generateIsExpression(scope, expressionToCheck, t))
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "&&", partial));

            assert (exists result);
            return result;
        }
        else if (ctx.ceylonTypes.isCeylonNothing(isType)) {
            return DartBooleanLiteral(false);
        }
        else if (!ctx.dartTypes.denotable(isType)) {
            // This isn't good! But no alternative w/o reified generics
            return DartBooleanLiteral(true);
        }
        else if (ctx.ceylonTypes.isCeylonNull(isType)) {
            return
            DartBinaryExpression {
                expressionToCheck;
                "==";
                DartNullLiteral();
            };
        }
        else {
            // we'll assume eraseToNative is false; otherwise, test should not compile
            value dartType = ctx.dartTypes.dartTypeName(scope, isType, false);

            return
            DartIsExpression {
                expressionToCheck;
                dartType;
            };
        }
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
                                     ctx.dartTypes.dartDefault(that)];
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
                        ctx.dartTypes.dartDefault(that);
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
                        ctx.dartTypes.dartDefault(that);
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
                                 ctx.dartTypes.dartDefault(that)];
                            };
                        };
                        // propagate defaulted
                        ctx.dartTypes.dartDefault(that);
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
            false;
            DartConstructorName {
                ctx.dartTypes.dartTypeNameForDartModel {
                    that;
                    ctx.dartTypes.dartCallableModel;
                };
                null;
            };
            DartArgumentList {
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
                    .map(generateBooleanConditionExpression)
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

        if(!that.sequenceArgument is Null) {
            throw unimplementedError(that, "spread arguments not supported");
        }

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
    DartExpression
    generateAssignmentExpression(
                Node that,
                ValueModel | BaseExpression | QualifiedExpression target,
                DartExpression() rhsExpression) {

        // TODO test with receivers (not even tried yet...)
        // TODO make sure setters return the new value, or do somthing here
        // TODO consider merging with generateInvocation()

        DeclarationModel targetDeclaration;
        DartExpression? dartTarget;
        Reference typedReference;

        switch (target)
        case (is ValueModel) {
            targetDeclaration = target;
            dartTarget = null;
            typedReference = target.typedReference;
        }
        case (is BaseExpression) {
            value info = BaseExpressionInfo(target);
            targetDeclaration = info.declaration;
            dartTarget = null;
            assert (is FunctionOrValueModel targetDeclaration);
            typedReference = targetDeclaration.typedReference;
        }
        case (is QualifiedExpression) {
            value info = QualifiedExpressionInfo(target);
            targetDeclaration = info.declaration;
            typedReference = info.typeModel.getTypedReference(targetDeclaration, null);

            assert (is ClassOrInterfaceModel container = targetDeclaration.container);
            dartTarget = withLhsDenotable {
                container;
                () => target.receiverExpression.transform(expressionTransformer);
            };
        }
        assert (is FunctionOrValueModel targetDeclaration);

        value [targetIdentifier, targetIsFunction] =
                ctx.dartTypes.dartIdentifierForFunctionOrValue(
                    that, targetDeclaration, true);

        // create the possibly qualified (by module or value) target
        DartExpression targetExpression;
        if (exists dartTarget) {
            assert (is DartSimpleIdentifier targetIdentifier);
            targetExpression = DartPropertyAccess {
                dartTarget;
                targetIdentifier;
            };
        }
        else {
            targetExpression = targetIdentifier;
        }

        DartExpression rhs = withLhs(
                typedReference.type,
                targetDeclaration,
                rhsExpression);

        value unboxed =
            if (targetIsFunction) then
                DartFunctionExpressionInvocation {
                    targetExpression;
                    DartArgumentList([rhs]);
                }
            else
                DartAssignmentExpression {
                    targetExpression;
                    DartAssignmentOperator.equal;
                    rhs;
                };

        // FIXME use the rhs type, since that's what Dart uses for the expression type
        //       (and so does Ceylon). So we'll need 1) the rhs type!, and 2) to calculate
        //       erasure on our own (pita). The only symptom is unnecessary casts.
        return withBoxing {
            that;
            typedReference.type;
            targetDeclaration;
            unboxed;
        };
    }

    shared
    DartVariableDeclarationList generateVariableDeclarationSynthetic(
            Node scope,
            DartSimpleIdentifier identifier,
            TypeModel lhsType,
            Boolean lhsErasedToNative,
            Boolean lhsErasedToObject,
            DartExpression() rhsDartExpression) {

        return
        DartVariableDeclarationList {
            null;
            ctx.dartTypes.dartTypeName {
                scope;
                lhsType;
                lhsErasedToNative;
                lhsErasedToObject;
            };
            [DartVariableDeclaration {
                identifier;
                withLhsCustom {
                    lhsType;
                    lhsErasedToNative;
                    lhsErasedToObject;
                    rhsDartExpression;
                };
            }];
        };
    }
}
