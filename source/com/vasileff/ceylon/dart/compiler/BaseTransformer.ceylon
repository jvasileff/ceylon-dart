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
    Expression
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
            Node that, FunctionModel functionModel,
            DartExpression delegateFunction,
            Integer parameterListNumber = 0,
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
                                // generic; Anything prevents erasure
                                lhsFormal = ctx.ceylonTypes.anythingType;
                                lhsActual = returnTypeActual;
                                () => withBoxingTypes {
                                    scope = that;
                                    rhsFormal = returnTypeFormal;
                                    rhsActual = returnTypeActual;
                                    DartFunctionExpressionInvocation {
                                        delegateFunction;
                                        DartArgumentList {
                                            innerArguments;
                                        };
                                    };
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
                lhsFormal,
                lhsActual,
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
                ctx.withLhsType(noType, noType, fun)
            else
                ctx.withLhsType(
                    ctx.dartTypes.formalType(lhsDeclaration),
                    ctx.dartTypes.actualType(lhsDeclaration),
                    fun);

    shared
    Result withReturn<Result>(
            FunctionOrValueModel|NoType lhsDeclaration,
            Result fun())
        =>  if (is NoType lhsDeclaration) then
                ctx.withReturnType(noType, noType, fun)
            else
                ctx.withReturnType(
                    ctx.dartTypes.formalType(lhsDeclaration),
                    ctx.dartTypes.actualType(lhsDeclaration),
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
             expected [[lhsType]] indicates an unerased Ceylon object rather than a
             native type. This happens for narrowing operations where the lhs is the
             argument to an unboxing function, and for generic types and covariant
             refinements."
            Boolean disableErasure = false) {

        DartTypeModel castType;

        if (is NoType lhsType) {
            return dartExpression;
        }
        else if (lhsType.isSubtypeOf(rhsType)) {
            // they're either the same, or this is the result of a narrowing operation
            castType = ctx.dartTypes.dartTypeModel(lhsType, disableErasure);
        }
        else if (ctx.dartTypes.erasedToObject(rhsType)) {
            // the result of a call to a generic function, or something like a Ceylon
            // intersection type. May result in a Dart narrowing.
            castType = ctx.dartTypes.dartTypeModel(lhsType, disableErasure);
        }
        else {
            // rhs is neither a supertype of lhs nor erased, so don't bother
            return dartExpression;
        }

        // the rhs may still have the same dart type, which is actually the normal case
        if (castType == ctx.dartTypes.dartTypeModel(rhsType, disableErasure)) {
            return dartExpression;
        }

        // cast away
        return
        DartAsExpression {
            dartExpression;
            ctx.dartTypes.dartTypeName(scope, castType, false);
        };
    }

    shared
    DartExpression withBoxing(
            Node|ElementModel|ScopeModel scope,
            FunctionOrValueModel rhsDeclaration,
            DartExpression dartExpression) {

        assert (exists lhsFormal = ctx.lhsFormalTop);
        assert (exists lhsActual = ctx.lhsActualTop);
        return withBoxingLhsRhs(
                scope, lhsFormal, lhsActual,
                ctx.dartTypes.formalType(rhsDeclaration),
                ctx.dartTypes.actualType(rhsDeclaration),
                dartExpression);
    }

    shared
    DartExpression withBoxingTypes(
            Node|ElementModel|ScopeModel scope,
            TypeModel rhsFormal,
            TypeModel rhsActual,
            DartExpression dartExpression) {

        assert (exists lhsFormal = ctx.lhsFormalTop);
        assert (exists lhsActual = ctx.lhsActualTop);
        return withBoxingLhsRhs(
                scope, lhsFormal, lhsActual, rhsFormal, rhsActual, dartExpression);
    }

    DartExpression withBoxingLhsRhs(
            Node|ElementModel|ScopeModel scope,
            TypeModel|NoType lhsFormal,
            TypeModel|NoType lhsActual,
            TypeModel rhsFormal,
            TypeModel rhsActual,
            DartExpression dartExpression)
        =>  let (conversion =
                    switch (lhsFormal)
                    case (is NoType) null
                    case (is TypeModel) ctx.ceylonTypes
                        .boxingConversionFor(lhsFormal, rhsFormal))
            if (exists conversion) then
                // we'll assume that lhsActual is a supertype of the result
                // of the boxing conversion
                withBoxingConversion(scope, rhsActual, dartExpression, conversion)
            else
                withCastingLhsRhs(
                        scope, lhsActual, rhsActual, dartExpression,
                        // disable erasure to native types if the rhs static
                        // type is erased to Object
                        ctx.dartTypes.erasedToObject(rhsFormal));

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

        value [boxingFunction, lhsActual, unbox] =
            switch (conversion)
            case (ceylonBooleanToNative)
                [DartSimpleIdentifier("dart$ceylonBooleanToNative"),
                 ctx.ceylonTypes.booleanType, true]
            case (ceylonFloatToNative)
                [DartSimpleIdentifier("dart$ceylonFloatToNative"),
                 ctx.ceylonTypes.floatType, true]
            case (ceylonIntegerToNative)
                [DartSimpleIdentifier("dart$ceylonIntegerToNative"),
                 ctx.ceylonTypes.integerType, true]
            case (ceylonStringToNative)
                [DartSimpleIdentifier("dart$ceylonStringToNative"),
                 ctx.ceylonTypes.stringType, true]
            case (nativeToCeylonBoolean)
                [DartSimpleIdentifier("dart$nativeToCeylonBoolean"),
                 ctx.ceylonTypes.booleanType, false]
            case (nativeToCeylonFloat)
                [DartSimpleIdentifier("dart$nativeToCeylonFloat"),
                 ctx.ceylonTypes.floatType, false]
            case (nativeToCeylonInteger)
                [DartSimpleIdentifier("dart$nativeToCeylonInteger"),
                 ctx.ceylonTypes.integerType, false]
            case (nativeToCeylonString)
                [DartSimpleIdentifier("dart$nativeToCeylonString"),
                 ctx.ceylonTypes.stringType, false];

        value castedExpression =
                if (!unbox) then
                    // for native to ceylon, an `as` cast is required in the
                    // unusual case that `rhsActual` is `Anything`, which happens
                    // for defaulted parameters
                    withCastingLhsRhs(scope, lhsActual, rhsActual, expression, false)
                else
                    // for ceylon to native, we may need to narrow the arg
                    // disable erasure; we *know* that the result of the expression is
                    // not erased, regardless of `rhsActual`
                    withCastingLhsRhs(scope, lhsActual, rhsActual, expression, true);

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
