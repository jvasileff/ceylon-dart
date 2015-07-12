import ceylon.ast.core {
    Invocation,
    BaseExpression,
    MemberNameWithTypeArguments,
    IntegerLiteral,
    StringLiteral,
    FunctionExpression,
    FloatLiteral,
    QualifiedExpression,
    LargerOperation,
    ComparisonOperation,
    SmallerOperation,
    LargeAsOperation,
    SmallAsOperation,
    IfElseExpression,
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
    Node,
    ElseOperation,
    ThenOperation,
    SafeMemberOperator,
    SpreadMemberOperator
}

import com.redhat.ceylon.model.typechecker.model {
    ControlBlockModel=ControlBlock,
    FunctionOrValueModel=FunctionOrValue,
    SetterModel=Setter,
    ConstructorModel=Constructor,
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface
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

        if (ctx.ceylonTypes.isBooleanTrueValueDeclaration(targetDeclaration)) {
            assert (exists formalType = ctx.lhsFormalTop);
            return generateBooleanExpression(that, formalType, true);
        }
        else if (ctx.ceylonTypes.isBooleanFalseValueDeclaration(targetDeclaration)) {
            assert (exists formalType = ctx.lhsFormalTop);
            return generateBooleanExpression(that, formalType, false);
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
                            ctx.dartTypes.identifierPackagePrefix(targetDeclaration)
                                + ctx.dartTypes.getName(targetDeclaration));
                    }
                    else {
                        // qualify toplevel with Dart import prefix
                        unboxed = DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier(
                                ctx.dartTypes.moduleImportPrefix(targetDeclaration));
                            identifier = DartSimpleIdentifier(
                                ctx.dartTypes.identifierPackagePrefix(targetDeclaration)
                                    + ctx.dartTypes.getName(targetDeclaration));
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
                        ctx.unit, targetDeclaration);

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
    DartExpression transformQualifiedExpression(QualifiedExpression that) {

        if (that.memberOperator is SpreadMemberOperator) {
            throw CompilerBug(that,
                    "Member operator not yet supported: \
                     '``that.memberOperator.text``'");
        }

        value info = QualifiedExpressionInfo(that);
        value safeOperator = that.memberOperator is SafeMemberOperator;
        value receiverInfo = ExpressionInfo(that.receiverExpression);
        value receiverType = receiverInfo.typeModel; // optional with nullsafe operator!
        value targetDeclaration = info.target.declaration;
        value targetContainer = targetDeclaration.container;
        TypeModel rhsFormal;
        TypeModel rhsActual;

        // TODO test this, with a receiver expression that is a function invocation or
        //      value that returns a generic, union, or intersection, I suppose
        TypeModel denotableReceiverType;
        if (is ClassOrInterfaceModel targetContainer) {
            denotableReceiverType = ctx.ceylonTypes.denotableType(
                    receiverType, targetContainer);
        }
        else {
            // probably need to resolve type aliases, but lets wait and see.
            throw CompilerBug(that,
                "Cannot determine the receiver type for thequalified expression.");
        }

        value receiver = ctx.withLhsType {
            // use `Anything` as the formal type to disable erasure
            // since we need a non-native receiver.
            ctx.ceylonTypes.anythingType;
            denotableReceiverType;
            () => that.receiverExpression.transform(this);
        };

        value receiverDartType = ctx.dartTypes.dartTypeName {
            that;
            denotableReceiverType;
            // see above; we used `Anything` as the
            // formal type for the receiver
            disableErasure = true;
        };

        value target = DartSimpleIdentifier {
            ctx.dartTypes.getName(targetDeclaration);
        };

        DartExpression unboxed;

        switch (targetDeclaration)
        case (is ValueModel) {
            rhsActual = ctx.dartTypes.actualType(targetDeclaration);
            rhsFormal = ctx.dartTypes.formalType(targetDeclaration);

            // Should be easy; don't worry about getters/setters
            // being methods since that doesn't happen in locations
            // that can be qualified.
            unboxed =
                if (!safeOperator) then
                    DartPropertyAccess(receiver, target)
                else
                    let (parameterIdentifier = DartSimpleIdentifier("$r$"))
                    createNullSafeExpression {
                        parameterIdentifier;
                        receiverDartType;
                        maybeNullExpression = receiver;
                        ifNullExpression = DartNullLiteral();
                        ifNotNullExpression = DartPropertyAccess {
                            parameterIdentifier;
                            target;
                        };
                    };
        }
        case (is FunctionModel) {
            // will be Callable<...>, which is a noop for boxing
            rhsFormal = info.typeModel;
            rhsActual = info.typeModel;

            switch (ctx.lhsActualTop)
            case (noType) {
                // An invocation; do not wrap in a callable
                //
                // IMPORTANT NOTE: we will completely disregard possible use of the
                // SafeMemberOperator, and let the outer invocation node rewrite the
                // expression (we can't; we don't have the args)
                // see transformInvocation

                // boxing and casting must be handled by outer node
                return DartPropertyAccess(receiver, target);
            }
            else {
                // The core.Function result of the qualified expression must be
                // captured to avoid re-evaluating the receiver expression
                // each time Callable is invoked.
                // So...
                //   - create a closure that
                //     - declares a variable holding the evaluated qe (1)
                //     - returns a new Callable that holds the saved function (2)
                //   - invoke the closure to obtain the Callable (3)
                unboxed =
                DartFunctionExpressionInvocation { // (3)
                    DartFunctionExpression {
                        DartFormalParameterList();
                        DartBlockFunctionBody {
                            null; false;
                            DartBlock {
                                [DartVariableDeclarationStatement {
                                    DartVariableDeclarationList {
                                        keyword = null;
                                        type = ctx.dartTypes.dartFunction;
                                        [DartVariableDeclaration { // (1)
                                            DartSimpleIdentifier {
                                                "$capturedDelegate$";
                                            };
                                            if (!safeOperator)
                                            then DartPropertyAccess(receiver, target)
                                            else createNullSafeExpression {
                                                DartSimpleIdentifier("$r$");
                                                receiverDartType;
                                                receiver;
                                                DartNullLiteral();
                                                DartPropertyAccess {
                                                    DartSimpleIdentifier("$r$");
                                                    target;
                                                };
                                            };

                                        }];
                                    };
                                },
                                DartReturnStatement { // (2)
                                    generateNewCallable {
                                        that;
                                        targetDeclaration;
                                        DartSimpleIdentifier {
                                            "$capturedDelegate$";
                                        };
                                        delegateMayBeNull = safeOperator;
                                    };
                                }];
                            };
                        };
                    };
                    DartArgumentList(); // (3)
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
        DeclarationModel? invokedDeclaration;
        switch (invoked = that.invoked)
        case (is BaseExpression) {
            invokedDeclaration = BaseExpressionInfo(invoked).declaration;
        }
        case (is QualifiedExpression) {
            invokedDeclaration = QualifiedExpressionInfo(invoked).declaration;
        }
        else {
            // an Invocation or some other expression that yields a Callable
            invokedDeclaration = null;
        }

        // the subtypes of FunctionOrValueModel
        assert (is FunctionModel|ValueModel|SetterModel|Null invokedDeclaration);

        value argumentList = generateArgumentListFromArguments(that.arguments);
        DartExpression invocation;
        TypeModel rhsFormal;
        TypeModel rhsActual;

        switch (invokedDeclaration)
        case (is FunctionModel) {
            if (invokedDeclaration.parameterLists.size() > 1) {
                // return type will be a Callable, not the ultimate return type
                // of this function that has multiple parameter lists
                rhsFormal = InvocationInfo(that).typeModel;
                rhsActual = rhsFormal;
            }
            else {
                rhsFormal = ctx.dartTypes.formalType(invokedDeclaration);
                rhsActual = ctx.dartTypes.actualType(invokedDeclaration);
            }

            // use `noType` to disable boxing; we want to invoke the function directly,
            // not a newly created Callable!
            value func = withLhs(noType, () => that.invoked.transform(this));

            // special case where we need to handle SafeMemberOperator
            // see transformQualifiedExpression
            if (is QualifiedExpression invoked = that.invoked,
                    invoked.memberOperator is SafeMemberOperator) {
                // rewrite the expression with null safety
                assert (is DartPropertyAccess func);

                value receiverParameter = DartSimpleIdentifier("$r$");

                // determine receiverDartType, duplicating logic in
                // transformQualifiedExpression
                value receiverType = ExpressionInfo(invoked.receiverExpression).typeModel;
                // will probably fail for type aliases
                assert (is ClassOrInterfaceModel targetContainer =
                        QualifiedExpressionInfo(invoked).declaration.container);
                value denotableReceiverType = ctx.ceylonTypes.denotableType(
                        receiverType, targetContainer);
                value receiverDartType = ctx.dartTypes.dartTypeName(
                    that, denotableReceiverType, true);

                invocation = createNullSafeExpression {
                    parameterIdentifier = receiverParameter;
                    receiverDartType;
                    // func.target (the receiver) has alread been cast correctly by
                    // transformQualifiedExpression
                    maybeNullExpression = func.target;
                    DartNullLiteral();
                    DartFunctionExpressionInvocation {
                        DartPropertyAccess {
                            receiverParameter;
                            func.propertyName;
                        };
                        argumentList;
                    };
                };
            }
            else {
                invocation =
                DartFunctionExpressionInvocation {
                    func;
                    argumentList;
                };
            }
        }
        case (is ValueModel?) {
            // callables (being generic) always return `core.Object`
            rhsFormal = ctx.ceylonTypes.anythingType;
            rhsActual = ctx.ceylonTypes.anythingType;

            // the expression might have a union or intersection type or something,
            // so determine a `Callable` type we can use. (Of course, for our purposes,
            // *any* Callable would work, so this is a bit unnecessary)
            value expressionType = ExpressionInfo(that.invoked).typeModel;
            value denotableType = expressionType.getSupertype(
                    ctx.ceylonTypes.callableDeclaration);

            invocation =
            DartFunctionExpressionInvocation {
                // resolve the $delegate$ property of the Callable
                DartPropertyAccess {
                    ctx.withLhsType {
                        denotableType;
                        denotableType;
                        () => that.invoked.transform(this);
                    };
                    DartSimpleIdentifier("$delegate$");
                };
                argumentList;
            };
        }
        case (is SetterModel) {
            throw CompilerBug(that,
                "The invoked expression's declaration type is not supported: \
                 '``className(invokedDeclaration)``'");
        }

        return withBoxingTypes {
            that;
            rhsFormal;
            rhsActual;
            invocation;
        };
    }

    shared actual
    DartExpression transformFunctionExpression(FunctionExpression that)
        // FunctionExpressions are always wrapped in a Callable, although we probably
        // could optimize for expressions that are immediately invoked
        =>  generateNewCallable(
                that,
                FunctionExpressionInfo(that).declarationModel,
                generateFunctionExpression(that), 0, false, false);

    DartExpression generateBooleanExpression(
            Node scope,
            "The *formal* type; determines boxing."
            TypeOrNoType type,
            "The value to produce"
            Boolean boolean)
        =>  let (native =
                switch(type)
                case (is NoType) false
                case (is TypeModel) ctx.ceylonTypes.isCeylonBoolean(
                        ctx.ceylonTypes.definiteType(type)))
            if (native) then
                DartBooleanLiteral(boolean)
            else if (boolean) then
                ctx.dartTypes.qualifyIdentifier(scope,ctx.ceylonTypes
                    .booleanTrueValueDeclaration)
            else
                ctx.dartTypes.qualifyIdentifier(scope, ctx.ceylonTypes
                    .booleanFalseValueDeclaration);

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
    DartExpression transformThenOperation(ThenOperation that)
        =>  DartConditionalExpression {
                ctx.withLhsType {
                    ctx.ceylonTypes.booleanType;
                    ctx.ceylonTypes.booleanType;
                    () => that.leftOperand.transform(this);
                };
                that.result.transform(this);
                DartNullLiteral();
            };

    shared actual
    DartExpression transformElseOperation(ElseOperation that)
        =>  let (parameterIdentifier = DartSimpleIdentifier("$lhs$"))
            createNullSafeExpression {
                parameterIdentifier;
                // the result of the leftOperand transformation should be this:
                if (is TypeModel lhsActual = ctx.lhsActualTop,
                    is TypeModel lhsFormal = ctx.lhsFormalTop)
                    then ctx.dartTypes.dartTypeNameFormalActual(
                            that, lhsFormal, lhsActual)
                    else ctx.dartTypes.dartObject;
                maybeNullExpression = that.leftOperand.transform(this);
                ifNullExpression = that.rightOperand.transform(this);
                ifNotNullExpression = parameterIdentifier;
            };

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
    see(`function StatementTransformer.transformIfElse`)
    DartExpression transformIfElseExpression(IfElseExpression that) {
        // TODO IsCondition & ExistsOrNonemptyCondition
        value dartCondition = generateBooleanDartCondition(that.conditions);

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
