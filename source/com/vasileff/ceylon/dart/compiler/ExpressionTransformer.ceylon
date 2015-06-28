import ceylon.ast.core {
    ValueParameter,
    DefaultedValueParameter,
    FunctionDefinition,
    Block,
    Invocation,
    BaseExpression,
    MemberNameWithTypeArguments,
    IntegerLiteral,
    StringLiteral,
    ParameterReference,
    VariadicParameter,
    DefaultedCallableParameter,
    DefaultedParameterReference,
    CallableParameter,
    LazySpecifier,
    FunctionExpression,
    Parameters,
    FunctionShortcutDefinition,
    FloatLiteral,
    Node,
    Expression,
    QualifiedExpression,
    LargerOperation,
    ComparisonOperation,
    SmallerOperation,
    LargeAsOperation,
    SmallAsOperation,
    IfElseExpression,
    BooleanCondition
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    ControlBlockModel=ControlBlock,
    FunctionOrValueModel=FunctionOrValue,
    ConstructorModel=Constructor,
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter
}

class ExpressionTransformer
        (CompilationContext ctx)
        extends BaseTransformer<DartExpression>(ctx) {

    shared actual
    DartExpression transformBaseExpression(BaseExpression that) {
        "Supports MNWTA for BaseExpressions"
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        value info = BaseExpressionInfo(that);
        value targetDeclaration = info.declaration;
        value rhsType = info.typeModel.type;

        assert (exists lhsType = ctx.lhsTypeTop);

        if (ctx.typeFactory.isBooleanTrueValueDeclaration(targetDeclaration)) {
            return generateBooleanLiteral(lhsType, true);
        }
        else if (ctx.typeFactory.isBooleanFalseValueDeclaration(targetDeclaration)) {
            return generateBooleanLiteral(lhsType, false);
        }
        else if (ctx.typeFactory.isNullValueDeclaration(targetDeclaration)) {
            return DartNullLiteral();
        }
        else {
            DartExpression unboxed;
            switch (targetDeclaration)
            case (is ValueModel) {
                switch (container = containerOfDeclaration(targetDeclaration))
                case (is PackageModel) {
                    if (sameModule(ctx.unit, targetDeclaration)) {
                        // qualify toplevel in same module with '$package.'
                        unboxed = DartSimpleIdentifier(
                            "$package$" +
                            ctx.naming.identifierPackagePrefix(targetDeclaration) +
                            ctx.naming.getName(targetDeclaration));
                    }
                    else {
                        // qualify toplevel with Dart import prefix
                        unboxed = DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier(
                                ctx.naming.moduleImportPrefix(targetDeclaration));
                            identifier = DartSimpleIdentifier(
                                ctx.naming.identifierPackagePrefix(targetDeclaration) +
                                ctx.naming.getName(targetDeclaration));
                        };
                    }
                }
                case (is ClassOrInterfaceModel
                            | FunctionOrValueModel
                            | ControlBlockModel
                            | ConstructorModel) {
                    if (useGetterSetterMethods(targetDeclaration)) {
                        // invoke the getter
                        unboxed = DartFunctionExpressionInvocation {
                            func = DartSimpleIdentifier(
                                ctx.naming.getName(targetDeclaration) + "$get");
                            argumentList = DartArgumentList();
                        };
                    }
                    else {
                        // identifier for the variable
                        unboxed = DartSimpleIdentifier(
                                ctx.naming.getName(targetDeclaration));
                    }
                }
                else {
                    throw CompilerBug(that,
                        "Unexpected container for base expression: \
                         declaration type '``className(targetDeclaration)``' \
                         container type '``className(container)``'");
                }
            }
            case (is FunctionModel) {
                switch (ctx.lhsTypeTop)
                case (noType) {
                    // must be an invocation, do not wrap in a callable
                    // withBoxing below will be a noop
                    unboxed = DartSimpleIdentifier(
                            ctx.naming.getName(targetDeclaration));
                }
                else {
                    // Anything, Callable, etc.
                    // take a reference to the function
                    // withBoxing below will be a noop
                    unboxed = generateNewCallable {
                        that = that;
                        functionModel = targetDeclaration;
                        delegateFunction = DartSimpleIdentifier(
                                ctx.naming.getName(targetDeclaration));
                    };
                }
            }
            else {
                throw CompilerBug(that,
                        "Unexpected declaration type for base expression: \
                         ``className(targetDeclaration)``");
            }
            return withBoxing(rhsType, unboxed);
        }
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(
                ctx.typeFactory.floatType,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(
                ctx.typeFactory.integerType,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxing(
                ctx.typeFactory.stringType,
                DartSimpleStringLiteral(that.text));

    shared actual
    DartExpression transformInvocation(Invocation that) {
        // Note: `ExpressionInfo(that).typeModel` is the correct result
        //       type of the invocation, but it doesn't let us account
        //       for generics and covariant refinements, which affect
        //       erasure.

        // FIXME covariant refinement erasure calc.
        // FIXME what about references to functions?
        // FIXME what about anonymous functions?

        // Erasure is based on the return type of the function,
        // not on the type of the invocation expression:
        TypeModel rhsType;

        value primary = that.invoked;

        // find the declaration for `invoked`
        DeclarationModel primaryDeclaration;
        switch (primary)
        case (is BaseExpression) {
            primaryDeclaration = BaseExpressionInfo(primary).declaration;
        }
        case (is QualifiedExpression) {
            primaryDeclaration = QualifiedExpressionInfo(primary).declaration;
        }
        else {
            throw CompilerBug(that,
                "Primary type not yet supported: '``className(primary)``'");
        }

        "Are we invoking a real function, or a value of type Callable?"
        Boolean isCallable;

        // calculate rhsType from the declaration
        switch (primaryDeclaration)
        case (is FunctionModel) {
            rhsType = primaryDeclaration.type;
            isCallable = false;
        }
        case (is ValueModel) {
            // callables never return erased values
            rhsType = ctx.typeFactory.anythingType;
            isCallable = true;
        }
        else {
            throw CompilerBug(that,
                "The invoked expression's declaration type is not supported: \
                 '``className(primaryDeclaration)``'");
        }

        DartExpression func;
        if (!isCallable) {
            // use `noType` to disable boxing. We want to invoke the function
            // directly, not a newly created Callable!
            func = ctx.withLhsType(noType, ()
                =>  that.invoked.transform(this));
        }
        else {
            // Boxing/erasure shouldn't matter here, right? With any luck, the
            // expression will evaluate to a `Callable`
            func =
                DartPropertyAccess {
                    DartParenthesizedExpression {
                        ctx.withLhsType(noType, ()
                            =>  that.invoked.transform(this));
                    };
                    DartSimpleIdentifier("$delegate$");
                };
        }

        return withBoxing(rhsType,
            DartFunctionExpressionInvocation {
                func;
                dartTransformer.transformArguments(that.arguments);
            }
        );
    }

    shared actual
    DartExpression transformFunctionExpression
            (FunctionExpression that) {

        // FunctionExpressions always get wrapped in a
        // Callable immediately.
        //
        // Technically, we should be honoring `ctx.lhsTypeTop`,
        // and will need to if we discover a need to optimize
        // expressions that are immediately invoked.

        value info = FunctionExpressionInfo(that);

        return generateNewCallable {
            that = that;
            functionModel = info.declarationModel;
            delegateFunction = generateFunctionExpression(that);
        };
    }

    shared
    DartInstanceCreationExpression generateNewCallable
            (Node that, functionModel, delegateFunction) {

        FunctionModel functionModel;
        {ParameterModel*} parameters;
        DartExpression delegateFunction;
        DartExpression outerFunction;

        if (functionModel.parameterLists.size() != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
        }
        else {
            value list = functionModel.parameterLists.get(0);
            parameters = CeylonList(list.parameters);
        }

        value innerReturnType = functionModel.type;

        // determine if return or arguments need boxing
        value boxingRequired =
                ctx.typeFactory.boxingConversionFor(
                    ctx.typeFactory.anythingType,
                    innerReturnType) exists ||
                parameters.any((parameterModel)
                    =>  ctx.typeFactory.boxingConversionFor(
                        ctx.typeFactory.anythingType,
                        parameterModel.type) exists);

        // generate outerFunction to handle boxing
        if (!boxingRequired) {
            outerFunction = delegateFunction;
        }
        else {
            value outerParameters = parameters.collect((parameterModel) {
                value dartSimpleParameter =
                        DartSimpleFormalParameter {
                            false; false;
                            ctx.naming.dartTypeName {
                                inRelationTo = parameterModel.model;
                                type = parameterModel.type;
                                // no erasure for the outer parameters,
                                // which will be for the generic Callable
                                disableErasure =  true;
                            };
                            DartSimpleIdentifier {
                                ctx.naming.getName(parameterModel);
                            };
                        };

                if (parameterModel.defaulted) {
                    return
                    DartDefaultFormalParameter {
                        dartSimpleParameter;
                        DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$ceylon$language");
                            identifier = DartSimpleIdentifier("dart$defaulted");
                        };
                    };
                }
                else {
                    return dartSimpleParameter;
                }
            });

            value innerArguments = parameters.collect((parameterModel) {
                //value parameterInfo = ParameterInfo(parameter);
                //value parameterModel = parameterInfo.parameterModel;

                value parameterName = ctx.naming.getName(parameterModel);
                value parameterIdentifier = DartSimpleIdentifier(parameterName);

                value unboxed = withBoxingLhsRhs {
                    // "lhs" is the inner function's parameter
                    // "rhs" the outer function's argument which
                    // is never erased
                    lhsType = parameterModel.type;
                    rhsType = ctx.typeFactory.anythingType;
                    parameterIdentifier;
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
                            withBoxingLhsRhs {
                                // Anything prevents erasure
                                ctx.typeFactory.anythingType;
                                innerReturnType;
                                DartFunctionExpressionInvocation {
                                    delegateFunction;
                                    DartArgumentList {
                                        innerArguments;
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
                    ctx.naming.identifierPackagePrefix(targetDeclaration) +
                    ctx.naming.getName(targetDeclaration));
            }
            else {
                // qualify toplevel with Dart import prefix
                targetOrSetter = DartPrefixedIdentifier(
                    DartSimpleIdentifier(
                        ctx.naming.moduleImportPrefix(targetDeclaration)),
                    DartSimpleIdentifier(
                        ctx.naming.identifierPackagePrefix(targetDeclaration) +
                        ctx.naming.getName(targetDeclaration)));
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
                        ctx.naming.getName(targetDeclaration))
                else
                    // setter method
                    DartSimpleIdentifier(
                        ctx.naming.getName(targetDeclaration) + "$set");
        }
        else {
            throw CompilerBug(that,
                "Unexpected container for base expression: \
                 declaration type '``className(targetDeclaration)``' \
                 container type '``className(container)``'");
        }

        DartExpression rhs = ctx.withLhsType(targetDeclaration.type, ()
                =>  rhsExpression.transform(this));

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

    DartExpression generateBooleanLiteral(TypeOrNoType type, Boolean boolean) {
        value box =
            switch(type)
            case (is NoType) false
            case (is TypeModel) ctx.typeFactory.isCeylonBoolean(
                    ctx.typeFactory.definiteType(type));
        if (box) {
            return DartBooleanLiteral(boolean);
        }
        else {
            // TODO naming
            return DartPrefixedIdentifier(
                DartSimpleIdentifier("$ceylon$language"),
                DartSimpleIdentifier(if(boolean) then "$true" else "$false"));
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
            functionName = ctx.naming.getName(functionModel);
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = ctx.naming.getName(functionModel);
        }

        if (parameterLists.size != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
        }

        value returnType = functionModel.type;

        function dartParameterList() {
            value list = parameterLists.first;
            if (list.parameters.empty) {
                return DartFormalParameterList();
            }

            value parameters = list.parameters.collect((parameter) {
                value parameterInfo = ParameterInfo(parameter);
                value parameterModel = parameterInfo.parameterModel;
                value parameterType = ctx.naming.dartTypeName(
                        parameterModel.model, parameterModel.type);

                switch(parameter)
                case (is DefaultedValueParameter) {
                    return
                    DartDefaultFormalParameter {
                        DartSimpleFormalParameter {
                            false; false;
                            parameterType;
                            DartSimpleIdentifier {
                                ctx.naming.getName(parameterModel);
                            };
                        };
                        DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$ceylon$language");
                            identifier = DartSimpleIdentifier("dart$defaulted");
                        };
                    };
                }
                case (is ValueParameter) {
                    return
                    DartSimpleFormalParameter {
                        false; false;
                        parameterType;
                        DartSimpleIdentifier {
                            ctx.naming.getName(parameterModel);
                        };
                    };
                }
                case (is VariadicParameter
                        | CallableParameter
                        | ParameterReference
                        | DefaultedCallableParameter
                        | DefaultedParameterReference) {
                    throw CompilerBug(that,
                            "Parameter type not supported: \
                             ``className(parameter)``");
                }
            });
            return DartFormalParameterList {
                positional = true;
                parameters = parameters;
            };
        }

        //Defaulted Parameters:
        //If any exist, use a block (not lazy specifier)
        //At start of block, assign values as necessary
        value defaultedParameters = parameterLists.first
                .parameters.narrow<DefaultedValueParameter>();

        DartFunctionBody body;
        if (defaultedParameters.empty) {
            // no defaulted parameters
            switch (definition)
            case (is Block) {
                body = ctx.withReturnType(returnType, ()
                    => DartBlockFunctionBody(null, false, statementTransformer
                            .transformBlock(definition)[0]));
            }
            case (is LazySpecifier) {
                body = DartExpressionFunctionBody(false, ctx.withLhsType(returnType, ()
                    => definition.expression.transform(expressionTransformer)));
            }
        }
        else {
            // defaulted parameters exist
            value statements = LinkedList<DartStatement>();

            for (param in defaultedParameters) {
                value parameterInfo = ParameterInfo(param);
                value model = parameterInfo.parameterModel;
                value parameterType = model.type;
                value paramName = DartSimpleIdentifier(
                        ctx.naming.getName(parameterInfo.parameterModel));
                statements.add(DartIfStatement {
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
                                identifier = DartSimpleIdentifier("dart$defaulted");
                            }];
                        };
                    };
                    // then statement
                    DartExpressionStatement {
                        DartAssignmentExpression {
                            paramName;
                            DartAssignmentOperator.equal;
                            ctx.withLhsType(parameterType, ()
                                =>  param.specifier.expression
                                        .transform(expressionTransformer));
                        };
                    };
                });
            }
            switch (definition)
            case (is Block) {
                statements.addAll(expand(ctx.withReturnType(returnType, ()
                    =>  definition.transformChildren(statementTransformer))));
            }
            case (is LazySpecifier) {
                // for FunctionShortcutDefinition
                statements.add(
                    DartReturnStatement {
                        ctx.withLhsType(returnType, ()
                            =>  definition.expression.transform(this));
                });
            }
            body = DartBlockFunctionBody(null, false, DartBlock([*statements]));
        }
        return DartFunctionExpression(dartParameterList(), body);
    }

    shared actual
    DartExpression transformComparisonOperation(ComparisonOperation that) {
        // unoptimized approach: box & invoke Comparable method, unbox
        value info = ExpressionInfo(that);

        value lhsBoxed = ctx.withLhsType(ctx.typeFactory.anythingType, ()
            =>  that.leftOperand.transform(this));

        value rhsBoxed =  ctx.withLhsType(ctx.typeFactory.anythingType, ()
            =>  that.rightOperand.transform(this));

        value method
            =   switch (that)
                case (is LargerOperation) "largerThan"
                case (is SmallerOperation) "smallerThan"
                case (is LargeAsOperation) "notSmallerThan"
                case (is SmallAsOperation) "notLargerThan";

        return withBoxing {
            rhsType = info.typeModel;
            DartMethodInvocation {
                lhsBoxed;
                DartSimpleIdentifier { method; };
                DartArgumentList { [rhsBoxed]; };
            };
        };
    }

    shared actual
    DartExpression transformIfElseExpression(IfElseExpression that) {
        // TODO IsCondition & ExistsOrNonemptyCondition
        if (that.conditions.conditions.any((condition)
                =>  !condition is BooleanCondition)) {
            throw CompilerBug(that,
                "Only BooleanConditions are currently supported.");
        }

        value dartCondition = ctx.withLhsType(ctx.typeFactory.booleanType, ()
            =>  that.conditions.conditions
                    .reversed
                    .narrow<BooleanCondition>()
                    .map((c)
                        =>  c.condition.transform(this))
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial)));
        assert (exists dartCondition);

        // create a function expression for the
        // IfElseExpression, then invoke it.
        return ctx.withLhsType((ExpressionInfo(that).typeModel), () =>
            DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    DartFormalParameterList();
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            [DartIfStatement {
                                dartCondition;
                                DartReturnStatement {
                                    that.thenExpression.transform(this);
                                };
                                DartReturnStatement {
                                    that.elseExpression.transform(this);
                                };
                            }];
                        };
                    };
                };
                DartArgumentList { []; };
            });
    }
}

// TODO come up with a plan for this stuff
//      and it should be integrated with the
//      typechecker, since prefixing is dependent
//      on scope
DartIdentifier dartDCIdentical
    =   DartPrefixedIdentifier {
            prefix = DartSimpleIdentifier("$dart$core");
            identifier = DartSimpleIdentifier("identical");
        };

DartIdentifier dartCLDDefaulted
    =   DartPrefixedIdentifier {
            prefix = DartSimpleIdentifier("$ceylon$language");
            identifier = DartSimpleIdentifier("dart$defaulted");
        };
