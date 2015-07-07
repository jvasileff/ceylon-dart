import ceylon.ast.core {
    FunctionDefinition,
    Block,
    Invocation,
    BaseExpression,
    MemberNameWithTypeArguments,
    IntegerLiteral,
    StringLiteral,
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
    BooleanCondition,
    DefaultedParameter,
    IdenticalOperation,
    SumOperation,
    ProductOperation,
    BinaryOperation,
    ExponentiationOperation,
    QuotientOperation,
    RemainderOperation,
    DifferenceOperation,
    CompareOperation,
    EqualOperation,
    NotEqualOperation,
    Arguments,
    PositionalArguments,
    NamedArguments,
    ArgumentList
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
    TypeDeclarationModel=TypeDeclaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter,
    ParameterListModel=ParameterList
}

class ExpressionTransformer
        (CompilationContext ctx)
        extends BaseTransformer<DartExpression>(ctx) {

    shared actual
    DartExpression transformBaseExpression(BaseExpression that) {

        if (!is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs) {
            throw CompilerBug(that,
                    "BaseExpression nameAndArgs type not yet supported: \
                     '``className(that.nameAndArgs)``'");
        }
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        value info = BaseExpressionInfo(that);
        value targetDeclaration = info.declaration;
        value rhsType = info.typeModel.type;

        // If dynamic, the rhsType will actually be `Anything`/`core.Object`
        // Currently, this is for defaulted parameters which are not assigned
        // precise types
        Boolean dartDynamic;

        assert (exists lhsType = ctx.lhsTypeTop);

        if (ctx.ceylonTypes.isBooleanTrueValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(lhsType, true);
        }
        else if (ctx.ceylonTypes.isBooleanFalseValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(lhsType, false);
        }
        else if (ctx.ceylonTypes.isNullValueDeclaration(targetDeclaration)) {
            return DartNullLiteral();
        }
        else {
            DartExpression unboxed;
            switch (targetDeclaration)
            case (is ValueModel) {
                // Does this baseExpression target a defaulted parameter?
                dartDynamic = targetDeclaration.initializerParameter?.defaulted
                                    else false;

                switch (container = containerOfDeclaration(targetDeclaration))
                case (is PackageModel) {
                    if (sameModule(ctx.unit, targetDeclaration)) {
                        // qualify toplevel in same module with '$package.'
                        unboxed = DartSimpleIdentifier(
                            "$package$" +
                            ctx.dartTypes.identifierPackagePrefix(targetDeclaration) +
                            ctx.dartTypes.getName(targetDeclaration));
                    }
                    else {
                        // qualify toplevel with Dart import prefix
                        unboxed = DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier(
                                ctx.dartTypes.moduleImportPrefix(targetDeclaration));
                            identifier = DartSimpleIdentifier(
                                ctx.dartTypes.identifierPackagePrefix(targetDeclaration) +
                                ctx.dartTypes.getName(targetDeclaration));
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
                                ctx.dartTypes.getName(targetDeclaration) + "$get");
                            argumentList = DartArgumentList();
                        };
                    }
                    else {
                        // identifier for the variable
                        unboxed = DartSimpleIdentifier(
                                ctx.dartTypes.getName(targetDeclaration));
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
                dartDynamic = false;
                value qualified = ctx.dartTypes.qualifyIdentifier(
                        ctx.unit, targetDeclaration,
                        ctx.dartTypes.getName(targetDeclaration));

                switch (ctx.lhsTypeTop)
                case (noType) {
                    // must be an invocation, do not wrap in a callable
                    // withBoxing below will be a noop
                    unboxed = qualified;
                }
                else {
                    // Anything, Callable, etc.
                    // take a reference to the function
                    // withBoxing below will be a noop
                    unboxed = generateNewCallable {
                        that = that;
                        functionModel = targetDeclaration;
                        delegateFunction = qualified;
                    };
                }
            }
            else {
                throw CompilerBug(that,
                        "Unexpected declaration type for base expression: \
                         ``className(targetDeclaration)``");
            }

            return withBoxing {
                scope = that;
                rhsType = rhsType;
                dartExpression =
                    if (dartDynamic) then
                        // Special case where the Dart static type is
                        // equiv to `Anything` despite the Ceylon static
                        // type possibly being denotable in Dart
                        withCastingLhsRhs {
                            scope = that;
                            lhsType = rhsType;
                            rhsType = ctx.ceylonTypes.anythingType;
                            dartExpression = unboxed;
                        }
                    else unboxed;
            };
        }
    }

    shared actual
    DartExpression transformQualifiedExpression
            (QualifiedExpression that) {

        if (that.memberOperator.text != ".") {
            throw CompilerBug(that,
                    "Member operator not yet supported: \
                     '``that.memberOperator.text``'");
        }

        value info = QualifiedExpressionInfo(that);
        value receiverInfo = ExpressionInfo(that.receiverExpression);
        value receiverType = receiverInfo.typeModel;
        value targetDeclaration = info.target.declaration;
        value rhsType = info.typeModel.type;
        value targetContainer = targetDeclaration.container;

        // The receiverType may be generic or a union or something.
        // Try to determine the exact receiver type needed, that
        // should be denotable in Dart
        // TODO test this, with a receiver expression that is a function invocation or
        //      value that returns a generic, union, or intersection, I suppose
        TypeModel exactReceiverType;
        if (is TypeDeclarationModel targetContainer) {
            exactReceiverType = receiverType.getSupertype(targetContainer);
        }
        else {
            // TODO try harder...
            exactReceiverType = receiverType;
        }

        DartExpression unboxed;

        switch (targetDeclaration)
        case (is ValueModel) {
            // Should be easy; don't worry about getters/setters
            // being methods since that doesn't happen in locations
            // that can be qualified.
            unboxed = DartPropertyAccess {
                // Use `Anything` to disable erasure since we need
                // a non-native receiver.
                withLhsTypeNoErasure {
                    that;
                    exactReceiverType;
                    receiverType;
                    () => that.receiverExpression.transform(this);
                };
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(targetDeclaration);
                };
            };
        }
        case (is FunctionModel) {
            value dartQualified = DartPropertyAccess {
                // Use `Anything` to disable erasure since we need
                // a non-native receiver.
                withLhsTypeNoErasure {
                    that;
                    exactReceiverType;
                    // FIXME problem is: we don't actually know what the receiverType
                    //       will be; we're being optimistic that it is the same as the
                    //       expression type, but it may just be `core.Object`. Casting
                    //       needs to be handled by the transformer; the
                    //       `withLhsTypeNoErasure` hack fails to acknowledge this.
                    receiverType;
                    () => that.receiverExpression.transform(this);
                };
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(targetDeclaration);
                };
            };

            switch (ctx.lhsTypeTop)
            case (noType) {
                // must be an invocation; do not wrap in a callable
                unboxed = dartQualified;
            }
            else {
                // The function result of the qualified expression must be
                // captured to avoid re-evaluating the receiver expression
                // each time Callable is invoked.
                // So...
                //   - create a closure that
                //     - declares a variable holding the evaluated qe
                //     - returns a new Callable that invokes the saved function
                //   - invoke it
                unboxed =
                DartFunctionExpressionInvocation {
                    DartFunctionExpression {
                        DartFormalParameterList();
                        DartBlockFunctionBody {
                            null; false;
                            DartBlock {
                                [DartVariableDeclarationStatement {
                                    DartVariableDeclarationList {
                                        keyword = null;
                                        type = ctx.dartTypes.dartFunction;
                                        [DartVariableDeclaration {
                                            DartSimpleIdentifier {
                                                "$capturedDelegate$";
                                            };
                                            dartQualified;
                                        }];
                                    };
                                },
                                DartReturnStatement {
                                    generateNewCallable {
                                        that;
                                        targetDeclaration;
                                        DartSimpleIdentifier {
                                            "$capturedDelegate$";
                                        };
                                    };
                                }];
                            };
                        };
                    };
                    DartArgumentList();
                };
            }
        }
        else {
            throw CompilerBug(that,
                "Unexpected declaration type for qualified expression: \
                 ``className(targetDeclaration)``");
        }

        return withBoxing(that, rhsType, unboxed);
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.floatType,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.integerType,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.stringType,
                DartSimpleStringLiteral(that.text));

    shared actual
    DartExpression transformInvocation(Invocation that) {

        DeclarationModel invokedDeclaration;
        switch (invoked = that.invoked)
        case (is BaseExpression) {
            invokedDeclaration = BaseExpressionInfo(invoked).declaration;
        }
        case (is QualifiedExpression) {
            invokedDeclaration = QualifiedExpressionInfo(invoked).declaration;
        }
        else {
            throw CompilerBug(that,
                "Primary type not yet supported: '``className(invoked)``'");
        }

        "Erasure is based on the return type of the function,
         not on the type of the invocation expression. If it's
         generic, we'll fully erase to `core.Object`. But, if
         we add support for Dart generics, we'll need the function's
         type to determine boxing, and the expression's type to
         determine the Dart type, taking boxing into account.

         This is also a concern for covariant refinement. I suppose
         we need both `formal` and `actual` types."
        TypeModel rhsType;

        "Are we invoking a real function, or a value of type Callable?"
        Boolean isCallable;

        ParameterListModel? parameterList;

        // use types from the original, `formal` declaration
        switch (refinedDeclaration = invokedDeclaration.refinedDeclaration)
        case (is FunctionModel) {
            isCallable = false;
            rhsType = refinedDeclaration.type;
            parameterList = refinedDeclaration.firstParameterList;
        }
        case (is ValueModel) {
            // callables (being generic) always return `core.Object`
            isCallable = true;
            rhsType = ctx.ceylonTypes.anythingType;
            parameterList = null;
        }
        else {
            throw CompilerBug(that,
                "The invoked expression's declaration type is not supported: \
                 '``className(invokedDeclaration)``'");
        }

        DartExpression functionExpression;
        if (!isCallable) {
            // use `noType` to disable boxing. We want to invoke the function
            // directly, not a newly created Callable!
            functionExpression = ctx.withLhsType(noType, ()
                =>  that.invoked.transform(this));
        }
        else {
            // Boxing/erasure shouldn't matter here, right? With any luck, the
            // expression will evaluate to a `Callable`
            functionExpression =
                DartPropertyAccess {
                    ctx.withLhsType(noType, () =>
                        that.invoked.transform(this));
                    DartSimpleIdentifier("$delegate$");
                };
        }

        return withBoxing(that,
            rhsType,
            DartFunctionExpressionInvocation {
                functionExpression;
                generateArgumentListFromArguments(
                    that.arguments, parameterList);
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
                ctx.ceylonTypes.boxingConversionFor(
                    ctx.ceylonTypes.anythingType,
                    innerReturnType) exists ||
                parameters.any((parameterModel)
                    =>  ctx.ceylonTypes.boxingConversionFor(
                        ctx.ceylonTypes.anythingType,
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
                            ctx.dartTypes.dartTypeName {
                                // use Anything (core.Object) for all
                                // parameters since `Callable` is generic
                                scope = that;
                                type = ctx.ceylonTypes.anythingType;
                            };
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
                //value parameterInfo = ParameterInfo(parameter);
                //value parameterModel = parameterInfo.parameterModel;

                value parameterName = ctx.dartTypes.getName(parameterModel);
                value parameterIdentifier = DartSimpleIdentifier(parameterName);

                value unboxed = withBoxingLhsRhs {
                    // "lhs" is the inner function's parameter
                    // "rhs" the outer function's argument which
                    // is never erased
                    scope = that;
                    lhsType = parameterModel.type;
                    rhsType = ctx.ceylonTypes.anythingType;
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
                                scope = that;
                                ctx.ceylonTypes.anythingType;
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

    DartExpression generateBooleanExpression
            (TypeOrNoType type, Boolean boolean) {
        value box =
            switch(type)
            case (is NoType) false
            case (is TypeModel) ctx.ceylonTypes.isCeylonBoolean(
                    ctx.ceylonTypes.definiteType(type));
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
            functionName = ctx.dartTypes.getName(functionModel);
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = ctx.dartTypes.getName(functionModel);
        }

        if (parameterLists.size != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
        }

        value returnType = functionModel.type;

        //Defaulted Parameters:
        //If any exist, use a block (not lazy specifier)
        //At start of block, assign values as necessary
        value defaultedParameters = parameterLists.first
                .parameters.narrow<DefaultedParameter>();

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
                        ctx.dartTypes.getName(parameterInfo.parameterModel));
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
                                identifier = DartSimpleIdentifier("dart$default");
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
        return DartFunctionExpression(
                generateFormalParameterList(
                    that, parameterLists.first), body);
    }

    shared actual
    DartExpression transformComparisonOperation(ComparisonOperation that)
        =>  let (method =
                    switch (that)
                    case (is LargerOperation) ctx.ceylonTypes.largerThanFunction
                    case (is SmallerOperation) ctx.ceylonTypes.smallerThanFunction
                    case (is LargeAsOperation) ctx.ceylonTypes.notSmallerThanFunction
                    case (is SmallAsOperation) ctx.ceylonTypes.notLargerThanFunction)
            generateInvocationForBinaryOperation(that, method);

    shared actual
    DartExpression transformCompareOperation(CompareOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.compareFunction);

    shared actual
    DartExpression transformEqualOperation(EqualOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.equalsFunction);

    shared actual
    DartExpression transformNotEqualOperation(NotEqualOperation that)
        =>  DartPrefixExpression("!", generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.equalsFunction));

    shared actual
    DartExpression transformProductOperation(ProductOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.timesFunction);

    shared actual
    DartExpression transformQuotientOperation(QuotientOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.dividedFunction);

    shared actual
    DartExpression transformRemainderOperation(RemainderOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.remainderFunction);

    shared actual
    DartExpression transformSumOperation(SumOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.plusFunction);

    shared actual
    DartExpression transformDifferenceOperation(DifferenceOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.minusFunction);

    shared actual
    DartExpression transformExponentiationOperation
            (ExponentiationOperation that)
        =>  generateInvocationForBinaryOperation(
                that, ctx.ceylonTypes.powerFunction);

    DartExpression generateInvocationForBinaryOperation(
            BinaryOperation that,
            FunctionModel functionModel) {

        assert (is ClassOrInterfaceModel definingInterface = functionModel.container);

        value leftOperand = that.leftOperand;
        value rightOperand = that.rightOperand;

        // find a suitable type that is denotable in Dart
        // this will be something like
        // "ceylon.language::Summable<ceylon.language::Integer>"
        // better would be "Integer" with forced boxing
        value denotableType = ExpressionInfo(leftOperand).typeModel
                .getSupertype(definingInterface);

        // TODO force boxing; the code below boxes (un-erases) almost by accident
        value leftOperandBoxed = ctx.withLhsType(denotableType, () =>
                leftOperand.transform(this));

        // assume generic parameter, so we'll use Anything
        value rightOperandBoxed = ctx.withLhsType(ctx.ceylonTypes.anythingType, () =>
                rightOperand.transform(this));

        // The return value of the function. This ends up being something like
        // "ceylon.language::Summable<Other>", even though the Dart return type is
        // usually more precise, such as "Integer", causing us to produce unnecessary
        // "as" casts.
        value rhsType = functionModel.reference.type;

        return withBoxing {
            scope = that;
            rhsType;
            DartMethodInvocation {
                leftOperandBoxed;
                DartSimpleIdentifier { ctx.dartTypes.getName(functionModel); };
                DartArgumentList { [rightOperandBoxed]; };
            };
        };
    }

    shared actual
    DartExpression transformIdenticalOperation
            (IdenticalOperation that)
        =>  withBoxing {
                scope = that;
                rhsType = ctx.ceylonTypes.booleanType;
                dartExpression = ctx.withLhsType {
                    // both operands should be "Identifiable"
                    ctx.ceylonTypes.identifiableType; () =>
                    DartFunctionExpressionInvocation {
                        DartPrefixedIdentifier {
                            DartSimpleIdentifier("$dart$core");
                            DartSimpleIdentifier("identical");
                        };
                        DartArgumentList {
                            [that.leftOperand.transform(this),
                             that.rightOperand.transform(this)];
                        };
                    };
                };
            };

    shared actual
    DartExpression transformIfElseExpression(IfElseExpression that) {
        // TODO IsCondition & ExistsOrNonemptyCondition
        if (that.conditions.conditions.any((condition)
                =>  !condition is BooleanCondition)) {
            throw CompilerBug(that,
                "Only BooleanConditions are currently supported.");
        }

        value dartCondition = ctx.withLhsType(ctx.ceylonTypes.booleanType, ()
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
                print(parameterModel.model.name);
                print(parameterModel.name);
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
                    then ctx.dartTypes.dartTypeName(that, ctx.ceylonTypes.anythingType)
                    else ctx.dartTypes.dartTypeName(that, parameterModel.type);

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
    DartArgumentList generateArgumentListFromArguments(
            Arguments that,
            ParameterListModel? forParameterList) {

        switch (that)
        case (is PositionalArguments) {
            return generateArgumentListFromArgumentList(
                    that.argumentList, forParameterList);
        }
        case (is NamedArguments) {
            throw CompilerBug(that, "NamedArguments not supported");
        }
    }

    shared
    DartArgumentList generateArgumentListFromArgumentList(
            ArgumentList that,
            "The `ParameterList` from the `refinedDeclaration` which may
             have generic or more general types than the `Parameter`s of
             the `actual` declaration being invoked, or `null` if a
             `Callable` value is being invoked."
            ParameterListModel? forParameterList) {

        "spread arguments not supported"
        assert(that.sequenceArgument is Null);

        value parameters =
                if (exists forParameterList)
                then CeylonList(forParameterList.parameters)
                else [];

        // use the passed in `formal` parameters, not the parameter models
        // available from the argument list.
        value args = that.listedArguments.indexed.collect((x) {
            value i -> expression = x;
            value parameterModel = parameters[i];

            // If parameterModel is null, we must be invoking a value, so use
            // type `Anything` to disable erasure. We don't need to cast, since
            // `Callable`'s take `core.Object`s.
            return ctx.withLhsType(
                        parameterModel?.type
                        else ctx.ceylonTypes.anythingType, ()
                =>  expression.transform(expressionTransformer));
        });
        return DartArgumentList(args);
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
            identifier = DartSimpleIdentifier("dart$default");
        };
