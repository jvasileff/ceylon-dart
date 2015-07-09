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
    SetterModel=Setter,
    ConstructorModel=Constructor,
    DeclarationModel=Declaration,
    TypeDeclarationModel=TypeDeclaration,
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

    """
       A base expression can be:

       - a reference to a toplevel function, value, or class
       - a reference to a function, value, constructor, or class in the current scope
       - a reference to a function, value, constructor, or class in the current block

       If a base expression is a reference to an attribute, method, member class,
       or member class constructor of a class, the receiving instance is the current
       instance of that class. Otherwise, there is no receiving instance.
    """
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
        value expressionType = info.typeModel;
        TypeModel rhsFormal;
        TypeModel rhsActual;

        assert (exists lhsType = ctx.lhsActualTop);

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
                rhsActual = ctx.dartTypes.actualType(targetDeclaration);
                rhsFormal = ctx.dartTypes.formalType(targetDeclaration);

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
                // will be Callable<...>, which is a noop for boxing
                rhsFormal = expressionType;
                rhsActual = expressionType;

                value qualified = ctx.dartTypes.qualifyIdentifier(
                        ctx.unit, targetDeclaration,
                        ctx.dartTypes.getName(targetDeclaration));

                switch (ctx.lhsActualTop)
                case (noType) {
                    // must be an invocation, do not wrap in a callable
                    unboxed = qualified;
                }
                else {
                    // probably `Anything` or `Callable`; doesn't really
                    // matter. Take a reference to the function:
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

            return withBoxingTypes(that, rhsFormal, rhsActual, unboxed);
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
        value expressionType = info.typeModel;
        value targetContainer = targetDeclaration.container;
        TypeModel rhsFormal;
        TypeModel rhsActual;

        // The receiverType may be generic or a union or something.
        // Try to determine the exact receiver type needed, that
        // should be denotable in Dart
        // TODO test this, with a receiver expression that is a function invocation or
        //      value that returns a generic, union, or intersection, I suppose
        TypeModel denotableReceiverType;
        if (is TypeDeclarationModel targetContainer) {
            denotableReceiverType = receiverType.getSupertype(targetContainer);
        }
        else {
            // TODO try harder...
            denotableReceiverType = receiverType;
        }

        DartExpression unboxed;

        switch (targetDeclaration)
        case (is ValueModel) {
            // TODO needs a test
            rhsActual = ctx.dartTypes.actualType(targetDeclaration);
            rhsFormal = ctx.dartTypes.formalType(targetDeclaration);

            // Should be easy; don't worry about getters/setters
            // being methods since that doesn't happen in locations
            // that can be qualified.
            unboxed = DartPropertyAccess {
                // use `Anything` as the formal type to disable erasure since we need
                // a non-native receiver.
                ctx.withLhsType {
                    ctx.ceylonTypes.anythingType;
                    denotableReceiverType;
                    () => that.receiverExpression.transform(this);
                };
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(targetDeclaration);
                };
            };
        }
        case (is FunctionModel) {
            // will be Callable<...>, which is a noop for boxing
            rhsFormal = expressionType;
            rhsActual = expressionType;

            value dartQualified = DartPropertyAccess {
                // use `Anything` as the formal type to disable erasure since we need
                // a non-native receiver.
                ctx.withLhsType {
                    ctx.ceylonTypes.anythingType;
                    denotableReceiverType;
                    () => that.receiverExpression.transform(this);
                };
                DartSimpleIdentifier {
                    ctx.dartTypes.getName(targetDeclaration);
                };
            };

            switch (ctx.lhsActualTop)
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

        return withBoxingTypes(that, rhsFormal, rhsActual, unboxed);
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxingTypes(that,
                ctx.ceylonTypes.floatType,
                ctx.ceylonTypes.floatType,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxingTypes(that,
                ctx.ceylonTypes.integerType,
                ctx.ceylonTypes.integerType,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxingTypes(that,
                ctx.ceylonTypes.stringType,
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
        // the subtypes of FunctionOrValueModel
        assert (is FunctionModel|ValueModel|SetterModel invokedDeclaration);

        "Are we invoking a real function, or a value of type Callable?"
        Boolean isCallableValue;

        TypeModel rhsFormal;
        TypeModel rhsActual;

        switch (invokedDeclaration)
        case (is FunctionModel) {
            isCallableValue = false;
            rhsFormal = ctx.dartTypes.formalType(invokedDeclaration);
            rhsActual = ctx.dartTypes.actualType(invokedDeclaration);
        }
        case (is ValueModel) {
            // callables (being generic) always return `core.Object`
            isCallableValue = true;
            rhsFormal = ctx.ceylonTypes.anythingType;
            rhsActual = ctx.ceylonTypes.anythingType;
        }
        case (is SetterModel) {
            throw CompilerBug(that,
                "The invoked expression's declaration type is not supported: \
                 '``className(invokedDeclaration)``'");
        }

        DartExpression functionExpression;
        if (isCallableValue) {
            // the expression might have a union or intersection type or something,
            // so determine a `Callable` type we can use. (Of course, for our purposes,
            // *any* Callable would work, so this is a bit unnecessary)
            // TODO tests for complex expression types
            value expressionType = ExpressionInfo(that.invoked).typeModel;
            value denotableType = expressionType.getSupertype(
                    ctx.ceylonTypes.callableDeclaration);

            // resolve the $delegate$ property of the Callable
            functionExpression =
                DartPropertyAccess {
                    ctx.withLhsType {
                        denotableType;
                        denotableType;
                        () => that.invoked.transform(this);
                    };
                    DartSimpleIdentifier("$delegate$");
                };
        }
        else {
            // use `noType` to disable boxing; we want to invoke the function directly,
            // not a newly created Callable!
            functionExpression = withLhs(noType, () => that.invoked.transform(this));
        }

        return withBoxingTypes {
            that;
            rhsFormal;
            rhsActual;
            DartFunctionExpressionInvocation {
                functionExpression;
                generateArgumentListFromArguments(that.arguments);
            };
        };
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
            (that, functionModel, delegateFunction) {

        Node that;
        FunctionModel functionModel;
        DartExpression delegateFunction;
        {ParameterModel*} parameters;
        {ParameterModel*} formalParameters;
        DartExpression outerFunction;

        if (functionModel.parameterLists.size() != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
        }

        parameters = CeylonList(functionModel.parameterLists.get(0).parameters);
        assert (is FunctionModel refined = functionModel.refinedDeclaration);
        formalParameters = CeylonList(refined.parameterLists.get(0).parameters);

        value innerReturnTypeFormal = ctx.dartTypes.formalType(functionModel);
        value innerReturnTypeActual = ctx.dartTypes.actualType(functionModel);

        // determine if return or arguments need boxing
        value boxingRequired =
                ctx.ceylonTypes.boxingConversionFor(
                    ctx.ceylonTypes.anythingType,
                    innerReturnTypeFormal) exists ||
                formalParameters.any((parameterModel)
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
                                lhsActual = innerReturnTypeActual;
                                () => withBoxingTypes {
                                    scope = that;
                                    rhsFormal = innerReturnTypeFormal;
                                    rhsActual = innerReturnTypeActual;
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
                () => rhsExpression.transform(this));

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
                body = withReturn(
                    functionModel,
                    () => DartBlockFunctionBody(null, false, statementTransformer
                            .transformBlock(definition)[0]));
            }
            case (is LazySpecifier) {
                body = DartExpressionFunctionBody(false, withLhs(
                    functionModel,
                    () => definition.expression.transform(expressionTransformer)));
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
                            () => definition.expression.transform(this);
                        };
                    };
                };
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
                    case (is LargerOperation) "largerThan"
                    case (is SmallerOperation) "smallerThan"
                    case (is LargeAsOperation) "notSmallerThan"
                    case (is SmallAsOperation) "notLargerThan")
            generateInvocationForBinaryOperation(that, method);

    shared actual
    DartExpression transformCompareOperation(CompareOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "compare");

    shared actual
    DartExpression transformEqualOperation(EqualOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "equals");

    shared actual
    DartExpression transformNotEqualOperation(NotEqualOperation that)
        =>  DartPrefixExpression("!", generateInvocationForBinaryOperation(
                that, "equals"));

    shared actual
    DartExpression transformProductOperation(ProductOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "times");

    shared actual
    DartExpression transformQuotientOperation(QuotientOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "divided");

    shared actual
    DartExpression transformRemainderOperation(RemainderOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "remainder");

    shared actual
    DartExpression transformSumOperation(SumOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "plus");

    shared actual
    DartExpression transformDifferenceOperation(DifferenceOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "minus");

    shared actual
    DartExpression transformExponentiationOperation
            (ExponentiationOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "power");

    DartExpression generateInvocationForBinaryOperation(
            BinaryOperation that,
            String methodName) {

        value leftType = ExpressionInfo(that.leftOperand).typeModel;

        assert (is FunctionModel method =
                leftType.declaration.getMember(methodName, null, false));
        assert (is ClassOrInterfaceModel container = method.container);

        value receiverType = leftType.getSupertype(container);
        value parameterModel = method.firstParameterList.parameters.get(0).model;

        value leftOperandBoxed = ctx.withLhsType(
                // defeat erasure, we need a non-native object
                ctx.ceylonTypes.anythingType,
                receiverType,
                () => that.leftOperand.transform(this));

        value rightOperandBoxed = withLhs(
                parameterModel,
                () => that.rightOperand.transform(this));

        return withBoxing {
            that;
            method;
            DartMethodInvocation {
                leftOperandBoxed;
                DartSimpleIdentifier { ctx.dartTypes.getName(method); };
                DartArgumentList { [rightOperandBoxed]; };
            };
        };
    }

    shared actual
    DartExpression transformIdenticalOperation
            (IdenticalOperation that)
        =>  withBoxingTypes {
                that;
                ctx.ceylonTypes.booleanType;
                ctx.ceylonTypes.booleanType;
                dartExpression = ctx.withLhsType {
                    // both operands should be "Identifiable", which isn't generic
                    ctx.ceylonTypes.identifiableType;
                    ctx.ceylonTypes.identifiableType;
                    () => DartFunctionExpressionInvocation {
                        DartPrefixedIdentifier {
                            DartSimpleIdentifier("$dart$core");
                            DartSimpleIdentifier("identical");
                        };
                        DartArgumentList {
                            [
                                that.leftOperand.transform(this),
                                that.rightOperand.transform(this)
                            ];
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

        value dartCondition = ctx.withLhsType(
            ctx.ceylonTypes.booleanType,
            ctx.ceylonTypes.booleanType,
            () => that.conditions.conditions
                    .reversed
                    .narrow<BooleanCondition>()
                    .map((c)
                        =>  c.condition.transform(this))
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial)));
        assert (exists dartCondition);

        // Create a function expression for the IfElseExpression and invoke it.
        // No need for `withLhs` or `withBoxing`; our parent should have set the
        // lhs, and child transformations should perform boxing.
        //
        // Alternately, we could wrap in withBoxing, and perform each transformation
        // inside withLhs, but that would run the risk of unnecessary boxing/unboxing ops.
        return
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
        };
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
