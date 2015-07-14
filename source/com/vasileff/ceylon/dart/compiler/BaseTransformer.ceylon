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
                    ctx.ceylonTypes.callableDeclaration.type, true)
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
        TypeModel returnTypeFormal;
        TypeModel returnTypeActual;
        if (delegateReturnsCallable) {
            returnTypeFormal = ctx.ceylonTypes.callableDeclaration.type;
            returnTypeActual = ctx.ceylonTypes.callableDeclaration.type;
        }
        else {
            returnTypeFormal = ctx.dartTypes.formalType(functionModel);
            returnTypeActual = ctx.dartTypes.actualType(functionModel);
        }
        value parameters = CeylonList(functionModel.parameterLists
                .get(parameterListNumber).parameters);

        // determine if return or arguments need boxing
        value boxingRequired =
                ctx.ceylonTypes.boxingConversionFor(
                    ctx.ceylonTypes.anythingType,
                    returnTypeFormal) exists ||
                parameters.any((parameterModel)
                    =>  ctx.ceylonTypes.boxingConversionFor(
                        ctx.ceylonTypes.anythingType,
                        ctx.dartTypes.formalType(parameterModel.model)) exists);

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
                    () => withBoxingTypes {
                        // the outer function's argument which is never erased
                        scope = that;
                        rhsFormal = ctx.ceylonTypes.anythingType;
                        rhsActual = ctx.ceylonTypes.anythingType;
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
                            ctx.withLhsType {
                                lhsFormalActual = [
                                    // generic; Anything prevents erasure
                                    ctx.ceylonTypes.anythingType,
                                    returnTypeActual
                                ];
                                () => withBoxingTypes {
                                    scope = that;
                                    rhsFormal = returnTypeFormal;
                                    rhsActual = returnTypeActual;
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

        value dartCondition = ctx.withLhsType(
            [ctx.ceylonTypes.booleanType, ctx.ceylonTypes.booleanType],
            () => that.conditions
                    .reversed
                    .narrow<BooleanCondition>()
                    .map((c)
                        =>  c.condition.transform(expressionTransformer))
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial)));
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

            return ctx.withLhsType(
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
    Result withLhs<Result>(
            FunctionOrValueModel|NoType lhsDeclaration,
            Result fun())
        =>  if (is NoType lhsDeclaration) then
                ctx.withLhsType(noType, fun)
            else
                ctx.withLhsType(
                    [ctx.dartTypes.formalType(lhsDeclaration),
                     ctx.dartTypes.actualType(lhsDeclaration)],
                    fun);

    shared
    Result withReturn<Result>(
            FunctionOrValueModel|NoType lhsDeclaration,
            Result fun())
        =>  if (is NoType lhsDeclaration) then
                ctx.withReturnType(noType, fun)
            else
                ctx.withReturnType(
                    [ctx.dartTypes.formalType(lhsDeclaration),
                     ctx.dartTypes.actualType(lhsDeclaration)],
                    fun);

    DartExpression withCastingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            "The *actual* lhs type, which indicates the Dart static type"
            TypeModel|NoType lhsType,
            "The *actual* rhs type, which indicates the Dart static type"
            TypeModel rhsType,
            "The expression of type [[rhsType]]"
            DartExpression dartExpression,
            "Set to `true` when a `Boolean`, `Integer`, `Float`, or `String` as the
             expected [[lhsType]] is erased to the corresponding Dart native type.
             This must be false for narrowing operations where the lhs is the argument
             to an unboxing function, or the lhs is a type parameter or a covariant
             refinement."
            Boolean eraseToNative = true) {

        DartTypeModel castType;

        if (is NoType lhsType) {
            return dartExpression;
        }
        else if (lhsType.isSubtypeOf(rhsType) && !lhsType.isExactly(rhsType)) {
            // lhs is the result of a narrowing operation
            castType = ctx.dartTypes.dartTypeModel(lhsType, eraseToNative);
        }
        else if (!ctx.dartTypes.denotable(rhsType)) {
            // may be narrowing the Dart static type
            castType = ctx.dartTypes.dartTypeModel(lhsType, eraseToNative);
        }
        else {
            // narrowing neither the Ceylon type nor the Dart type; avoid unnecessary
            // widening casts
            return dartExpression;
        }

        // the rhs may still have the same Dart type
        if (castType == ctx.dartTypes.dartTypeModel(rhsType, eraseToNative)) {
            return dartExpression;
        }

        // cast away
        return
        DartAsExpression {
            dartExpression;
            ctx.dartTypes.dartTypeName(scope, castType, true);
        };
    }

    shared
    DartExpression withBoxing(
            Node|ElementModel|ScopeModel scope,
            FunctionOrValueModel rhsDeclaration,
            DartExpression dartExpression)
        =>  withBoxingLhsRhs(
                scope, ctx.assertedLhsFormalActualTop,
                ctx.dartTypes.formalType(rhsDeclaration),
                ctx.dartTypes.actualType(rhsDeclaration),
                dartExpression);

    shared
    DartExpression withBoxingTypes(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsFormal,
            TypeModel rhsActual,
            DartExpression dartExpression)
        =>  withBoxingLhsRhs(scope, ctx.assertedLhsFormalActualTop,
                    rhsFormal, rhsActual, dartExpression);

    DartExpression withBoxingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            FormalActualOrNoType lhsFormalActual,
            TypeModel rhsFormal,
            TypeModel rhsActual,
            DartExpression dartExpression)
        =>  if (is NoType lhsFormalActual) then
                dartExpression
            else
                let ([lhsFormal, lhsActual] = lhsFormalActual,
                    conversion = ctx.ceylonTypes
                            .boxingConversionFor(lhsFormal, rhsFormal))
                if (exists conversion) then
                    // we'll assume that lhsActual is a supertype of the result
                    // of the boxing conversion, and not cast
                    withBoxingConversion(scope, rhsActual, dartExpression, conversion)
                else
                    withCastingLhsRhs(
                            scope, lhsActual, rhsActual, dartExpression,
                            // indicate not erasured to native if the lhs static type
                            // cannot be represented as a native type
                            ctx.dartTypes.native(lhsFormal));

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
                withCastingLhsRhs(scope, boxTypeDeclaration.type,
                        rhsActual, expression, !toNative);

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
