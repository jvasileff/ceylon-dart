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
    SpreadMemberOperator,
    NotOperation,
    AssignOperation,
    PostfixIncrementOperation,
    PostfixOperation,
    PostfixDecrementOperation,
    PrefixOperation,
    PrefixIncrementOperation,
    PrefixDecrementOperation,
    AddAssignmentOperation,
    ArithmeticAssignmentOperation,
    SubtractAssignmentOperation,
    MultiplyAssignmentOperation,
    DivideAssignmentOperation,
    RemainderAssignmentOperation,
    SetAssignmentOperation,
    IntersectAssignmentOperation,
    UnionAssignmentOperation,
    ComplementAssignmentOperation,
    LogicalAssignmentOperation,
    AndAssignmentOperation,
    OrAssignmentOperation
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionOrValueModel=FunctionOrValue,
    SetterModel=Setter,
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    ClassOrInterfaceModel=ClassOrInterface
}

class ExpressionTransformer(CompilationContext ctx)
        extends BaseTransformer<DartExpression>(ctx) {

    shared actual
    DartExpression transformAssignOperation(AssignOperation that) {
        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            that;
            leftOperand;
            () => that.rightOperand.transform(expressionTransformer);
        };
    }

    shared actual
    DartExpression transformArithmeticAssignmentOperation
            (ArithmeticAssignmentOperation that) {

        value methodName
            =   switch(that)
                case (is AddAssignmentOperation) "plus"
                case (is SubtractAssignmentOperation) "minus"
                case (is MultiplyAssignmentOperation) "times"
                case (is DivideAssignmentOperation) "divided"
                case (is RemainderAssignmentOperation) "remainder";

        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            that;
            leftOperand;
            () => generateInvocation {
                scope = that;
                receiver = ExpressionInfo(that.leftOperand);
                methodName;
                arguments = [ExpressionInfo(that.rightOperand)];
            };
        };
    }

    shared actual
    DartExpression transformSetAssignmentOperation
            (SetAssignmentOperation that) {

        // FIXME untested!
        value methodName
            =   switch(that)
                case (is IntersectAssignmentOperation) "intersection"
                case (is UnionAssignmentOperation) "union"
                case (is ComplementAssignmentOperation) "complement";

        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            that;
            leftOperand;
            () => generateInvocation {
                scope = that;
                receiver = ExpressionInfo(that.leftOperand);
                methodName;
                arguments = [ExpressionInfo(that.rightOperand)];
            };
        };
    }

    shared actual
    DartExpression transformLogicalAssignmentOperation
            (LogicalAssignmentOperation that) {

        // FIXME untested!
        value methodName
            =   switch(that)
                case (is AndAssignmentOperation) "and"
                case (is OrAssignmentOperation) "or";

        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            that;
            leftOperand;
            () => generateInvocation {
                scope = that;
                receiver = ExpressionInfo(that.leftOperand);
                methodName;
                arguments = [ExpressionInfo(that.rightOperand)];
            };
        };
    }

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

        FunctionOrValueModel? rhsDeclaration;

        if (ctx.ceylonTypes.isBooleanTrueValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(
                    that, ctx.assertedLhsErasedToNativeTop, true);
        }
        else if (ctx.ceylonTypes.isBooleanFalseValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(
                    that, ctx.assertedLhsErasedToNativeTop, false);
        }
        else if (ctx.ceylonTypes.isNullValueDeclaration(targetDeclaration)) {
            return DartNullLiteral();
        }
        else {
            DartExpression unboxed;
            switch (targetDeclaration)
            case (is ValueModel) {
                rhsDeclaration = targetDeclaration;

                value [dartIdentifier, dartIdentifierIsFunction] =
                        ctx.dartTypes.dartIdentifierForFunctionOrValue(
                            that, targetDeclaration, false);

                unboxed =
                    if (dartIdentifierIsFunction) then
                        DartFunctionExpressionInvocation {
                            dartIdentifier;
                            DartArgumentList();
                        }
                    else
                        dartIdentifier;
            }
            case (is FunctionModel) {
                // will be newly created Callable<...>, which is not erased
                rhsDeclaration = null;

                value dartIdentifier = ctx.dartTypes.dartIdentifierForFunctionOrValue(
                        that, targetDeclaration, false)[0];

                switch (ctx.assertedLhsTypeTop)
                case (noType) {
                    // must be an invocation, do not wrap in a callable
                    unboxed = dartIdentifier;
                }
                else {
                    // probably `Anything` or `Callable`; doesn't really
                    // matter. Take a reference to the function:
                    unboxed = generateNewCallable {
                        that;
                        functionModel = targetDeclaration;
                        delegateFunction = dartIdentifier;
                    };
                }
            }
            else {
                throw CompilerBug(that,
                        "Unexpected declaration type for base expression: \
                         ``className(targetDeclaration)``");
            }

            return withBoxing {
                that;
                info.typeModel;
                rhsDeclaration;
                unboxed;
            };
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
        value receiverType = receiverInfo.typeModel; // is optional w/nullsafe operator!
        value targetDeclaration = info.target.declaration;
        value targetContainer = targetDeclaration.container;

        FunctionOrValueModel? rhsDeclaration;

        "Maybe this is a type alias?"
        assert (is ClassOrInterfaceModel targetContainer);

        value denotableReceiverType = ctx.ceylonTypes.denotableType {
            receiverType;
            targetContainer;
        };

        value receiverDartType = ctx.dartTypes.dartTypeName {
            that;
            denotableReceiverType;
            eraseToNative = false;
        };

        value receiver = withLhsNonNative {
            denotableReceiverType;
            () => that.receiverExpression.transform(this);
        };

        DartExpression unboxed;

        switch (targetDeclaration)
        case (is ValueModel) {
            rhsDeclaration = targetDeclaration;

            // Should be easy; don't worry about getters/setters
            // being methods since that doesn't happen in locations
            // that can be qualified.

            assert (is DartSimpleIdentifier memberIdentifier =
                    ctx.dartTypes.dartIdentifierForFunctionOrValue(
                        that, targetDeclaration, false)[0]);

            unboxed =
                if (!safeOperator) then
                    DartPropertyAccess(receiver, memberIdentifier)
                else
                    let (parameterIdentifier = DartSimpleIdentifier("$r$"))
                    createNullSafeExpression {
                        parameterIdentifier;
                        receiverDartType;
                        maybeNullExpression = receiver;
                        ifNullExpression = DartNullLiteral();
                        ifNotNullExpression = DartPropertyAccess {
                            parameterIdentifier;
                            memberIdentifier;
                        };
                    };
        }
        case (is FunctionModel) {
            // will be newly created Callable<...>, which is not erased
            rhsDeclaration = null;

            assert (is DartSimpleIdentifier memberIdentifier =
                    ctx.dartTypes.dartIdentifierForFunctionOrValue(
                        that, targetDeclaration, false)[0]);

            switch (ctx.assertedLhsTypeTop)
            case (noType) {
                // An invocation; do not wrap in a callable
                //
                // IMPORTANT NOTE: we will completely disregard possible use of the
                // SafeMemberOperator, and let the outer invocation node rewrite the
                // expression (we can't; we don't have the args)
                // see transformInvocation

                // boxing and casting must be handled by outer node
                return DartPropertyAccess(receiver, memberIdentifier);
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
                                            then DartPropertyAccess(
                                                    receiver, memberIdentifier)
                                            else createNullSafeExpression {
                                                DartSimpleIdentifier("$r$");
                                                receiverDartType;
                                                receiver;
                                                DartNullLiteral();
                                                DartPropertyAccess {
                                                    DartSimpleIdentifier("$r$");
                                                    memberIdentifier;
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

        return withBoxing {
            that;
            info.typeModel;
            rhsDeclaration;
            unboxed;
        };
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.floatType, null,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.integerType, null,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxing(that,
                ctx.ceylonTypes.stringType, null,
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

        value argumentList = generateArgumentListFromArguments(
                that.arguments, ExpressionInfo(that.invoked).typeModel);

        switch (invokedDeclaration)
        case (is FunctionModel) {
            TypeModel rhsType;
            FunctionOrValueModel? rhsDeclaration;
            DartExpression invocation;

            if (invokedDeclaration.parameterLists.size() > 1) {
                // The function actually returns a Callable, not the ultimate return type
                // as advertised by the declaration.
                rhsType = InvocationInfo(that).typeModel;
                rhsDeclaration = null;
            }
            else {
                rhsType = InvocationInfo(that).typeModel;
                rhsDeclaration = invokedDeclaration;
            }

            // use `noType` to disable boxing; we want to invoke the function directly,
            // not a newly created Callable!
            value func = withLhsNoType(() => that.invoked.transform(this));

            // special case where we need to handle SafeMemberOperator
            // see transformQualifiedExpression
            if (is QualifiedExpression invoked = that.invoked,
                    invoked.memberOperator is SafeMemberOperator) {

                // rewrite the expression with null safety
                assert (is DartPropertyAccess func);

                // determine receiverDartType; same as in transformQualifiedExpression
                value receiverType = ExpressionInfo(invoked.receiverExpression).typeModel;

                "Maybe this is a type alias?"
                assert (is ClassOrInterfaceModel targetContainer =
                        QualifiedExpressionInfo(invoked).declaration.container);

                value denotableReceiverType = ctx.ceylonTypes.denotableType {
                    receiverType;
                    targetContainer;
                };

                value receiverDartType = ctx.dartTypes.dartTypeName {
                    that;
                    denotableReceiverType;
                    eraseToNative = false;
                };

                value receiverParameter = DartSimpleIdentifier("$r$");

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

            return withBoxing {
                that;
                rhsType;
                rhsDeclaration;
                invocation;
            };
        }
        case (is ValueModel?) {
            // Callables (being generic) always erase to `core.Object`.
            // We don't have a declaration to to use, so explicitly
            // specify erasure:
            return withBoxingCustom {
                that;
                InvocationInfo(that).typeModel;
                rhsErasedToNative = false;
                rhsErasedToObject = true;
                DartFunctionExpressionInvocation {
                    // resolve the $delegate$ property of the Callable
                    DartPropertyAccess {
                        // use a denotable `Callable` type. Although, for non-generic Dart,
                        // any Callable would work, so this is a bit over engineered
                        withLhsDenotable {
                            ctx.ceylonTypes.callableDeclaration;
                            () => that.invoked.transform(this);
                        };
                        DartSimpleIdentifier("$delegate$");
                    };
                    argumentList;
                };
            };
        }
        case (is SetterModel) {
            throw CompilerBug(that,
                "The invoked expression's declaration type is not supported: \
                 '``className(invokedDeclaration)``'");
        }
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
            Boolean native,
            "The value to produce"
            Boolean boolean)
        =>  if (native) then
                DartBooleanLiteral(boolean)
            else if (boolean) then
                ctx.dartTypes.dartIdentifierForFunctionOrValue(scope,
                    ctx.ceylonTypes.booleanTrueValueDeclaration)[0]
            else
                ctx.dartTypes.dartIdentifierForFunctionOrValue(scope,
                    ctx.ceylonTypes.booleanFalseValueDeclaration)[0];

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
                withLhsNative {
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
                ctx.dartTypes.dartTypeName {
                    that;
                    ctx.assertedLhsTypeTop;
                    ctx.assertedLhsErasedToNativeTop;
                    ctx.assertedLhsErasedToObjectTop;
                };
                maybeNullExpression = that.leftOperand.transform(this);
                ifNullExpression = that.rightOperand.transform(this);
                ifNotNullExpression = parameterIdentifier;
            };

    shared actual
    DartExpression transformNotOperation(NotOperation that)
        =>  DartPrefixExpression {
                "!";
                withLhsNative {
                    ctx.ceylonTypes.booleanType;
                    () => that.operand.transform(this);
                };
            };

    shared actual
    DartExpression transformPrefixOperation(PrefixOperation that) {
        String method = switch (that)
                case (is PrefixIncrementOperation) "successor"
                case (is PrefixDecrementOperation) "predecessor";

        value operandInfo = ExpressionInfo(that.operand);
        assert (is BaseExpression | QualifiedExpression operand = that.operand);

        return
        generateAssignmentExpression {
            that;
            operand;
            () => generateInvocation {
                that;
                operandInfo;
                method;
                [];
            };
        };
    }

    shared actual
    DartExpression transformPostfixOperation(PostfixOperation that) {
        String method = switch (that)
                case (is PostfixIncrementOperation) "successor"
                case (is PostfixDecrementOperation) "predecessor";

        value operandInfo = ExpressionInfo(that.operand);
        assert (is BaseExpression | QualifiedExpression operand = that.operand);

        // the expected type after boxing
        TypeModel tempVarType;

        switch (lhsTypeTop = ctx.lhsTypeTop)
        case (is NoType) {
            // no need to save and return original value
            return
            generateAssignmentExpression {
                that;
                operand;
                () => generateInvocation {
                    that;
                    operandInfo;
                    method;
                    [];
                };
            };
        }
        case (is TypeModel) {
            tempVarType = lhsTypeTop;
        }
        case (is Null) {
            assert (exists lhsDenotable = ctx.lhsDenotableTop);
            tempVarType = ctx.ceylonTypes.denotableType {
                ExpressionInfo(that).typeModel;
                lhsDenotable;
            };
        }

        value tempVar =
            DartSimpleIdentifier {
                ctx.dartTypes.createTempNameCustom();
            };

        return
        createInlineDartStatements {
            // save the original value
            [DartVariableDeclarationStatement {
                generateVariableDeclarationSynthetic {
                    that;
                    tempVar;
                    tempVarType;
                    ctx.assertedLhsErasedToNativeTop;
                    ctx.assertedLhsErasedToObjectTop;
                    () => operand.transform(this);
                };
            },
            // perform the postfix operation
            DartExpressionStatement {
                generateAssignmentExpression {
                    that;
                    operand;
                    () => generateInvocation {
                        that;
                        operandInfo;
                        method;
                        [];
                    };
                };
            },
            // return the saved value
            DartReturnStatement {
                withBoxingCustom {
                    that;
                    tempVarType;
                    ctx.assertedLhsErasedToNativeTop;
                    ctx.assertedLhsErasedToObjectTop;
                    tempVar;
                };
            }];
        };
    }

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
    DartExpression transformExponentiationOperation(ExponentiationOperation that)
        =>  generateInvocationForBinaryOperation(
                that, "power");

    DartExpression generateInvocationForBinaryOperation(
            BinaryOperation that, String methodName)
        =>  generateInvocation {
                scope = that;
                receiver = ExpressionInfo(that.leftOperand);
                memberName = methodName;
                arguments = [ExpressionInfo(that.rightOperand)];
            };

    shared actual
    DartExpression transformIdenticalOperation(IdenticalOperation that)
        =>  withBoxing {
                that;
                rhsType = ctx.ceylonTypes.booleanType;
                rhsDeclaration = null;
                withLhsNonNative {
                    // both operands should be "Identifiable", which isn't generic, so
                    // using the denotable type isn't necessary
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
