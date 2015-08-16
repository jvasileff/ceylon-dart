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
    OrAssignmentOperation,
    ArithmeticOperation,
    SetOperation,
    IntersectionOperation,
    UnionOperation,
    ComplementOperation,
    ScaleOperation,
    SpanOperation,
    MeasureOperation,
    EntryOperation,
    InOperation,
    LogicalOperation,
    AndOperation,
    OrOperation,
    GroupedExpression,
    CharacterLiteral,
    NegationOperation,
    IdentityOperation,
    WithinOperation,
    OpenBound,
    ClosedBound,
    Tuple,
    Comprehension,
    Iterable,
    WideningTransformer,
    This,
    Outer,
    StringTemplate,
    Expression
}

import com.redhat.ceylon.model.typechecker.model {
    SetterModel=Setter,
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    ClassOrInterfaceModel=ClassOrInterface,
    ClassModel=Class,
    InterfaceModel=Interface,
    ConstructorModel=Constructor
}
import com.vasileff.ceylon.dart.ast {
    DartVariableDeclarationStatement,
    DartExpression,
    DartSimpleIdentifier,
    DartDoubleLiteral,
    DartFunctionExpression,
    DartFormalParameterList,
    DartVariableDeclarationList,
    DartPrefixExpression,
    DartIdentifier,
    DartNullLiteral,
    DartArgumentList,
    DartReturnStatement,
    DartIntegerLiteral,
    DartPropertyAccess,
    DartFunctionExpressionInvocation,
    DartIfStatement,
    DartSimpleStringLiteral,
    DartVariableDeclaration,
    DartBinaryExpression,
    DartInstanceCreationExpression,
    DartConstructorName,
    DartBlock,
    DartPrefixedIdentifier,
    DartBlockFunctionBody,
    DartBooleanLiteral,
    DartExpressionStatement,
    DartConditionalExpression,
    DartListLiteral,
    DartSwitchStatement,
    DartSwitchCase,
    DartSimpleFormalParameter
}
import com.vasileff.ceylon.dart.nodeinfo {
    BaseExpressionInfo,
    FunctionExpressionInfo,
    QualifiedExpressionInfo,
    InvocationInfo,
    ExpressionInfo,
    ThisInfo,
    OuterInfo
}

shared
class ExpressionTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<DartExpression> {

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

        if (ceylonTypes.isBooleanTrueValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(
                    that, ctx.assertedLhsErasedToNativeTop, true);
        }
        else if (ceylonTypes.isBooleanFalseValueDeclaration(targetDeclaration)) {
            return generateBooleanExpression(
                    that, ctx.assertedLhsErasedToNativeTop, false);
        }
        else if (ceylonTypes.isNullValueDeclaration(targetDeclaration)) {
            return DartNullLiteral();
        }
        else {
            switch (targetDeclaration)
            case (is ValueModel) {
                value [dartIdentifier, dartIdentifierIsFunction] =
                        dartTypes.expressionForBaseExpression {
                    that;
                    targetDeclaration;
                    false;
                };

                return withBoxing {
                    that;
                    info.typeModel;
                    targetDeclaration;
                    if (dartIdentifierIsFunction) then
                        DartFunctionExpressionInvocation {
                            dartIdentifier;
                            DartArgumentList();
                        }
                    else
                        dartIdentifier;
                };
            }
            case (is FunctionModel) {
                if (targetDeclaration.parameter) {
                    // The Callable parameter, which is not erased
                    // For now, we are calculating erased-to-Object with the defaulted
                    // check.
                    // TODO consider teaching  `withBoxing()`, `erasedToNative()`, and
                    //      `erasedToObject()` about Callable parameters, and then
                    //      use `withBoxing()`.
                    return withBoxingCustom {
                        that;
                        info.typeModel;
                        false;
                        targetDeclaration.initializerParameter.defaulted;
                        dartTypes.dartIdentifierForFunctionOrValue {
                            that;
                            targetDeclaration;
                            false;
                        }[0];
                    };
                }
                else {
                    // A newly created Callable, which is not erased
                    return withBoxingNonNative {
                        that;
                        info.typeModel;
                        generateNewCallable {
                            that;
                            functionModel = targetDeclaration;
                            dartTypes.dartIdentifierForFunctionOrValue {
                                scope = that;
                                targetDeclaration;
                            }[0];
                        };
                    };
                }
            }
            else {
                throw CompilerBug(that,
                        "Unexpected declaration type for base expression: \
                         ``className(targetDeclaration)``");
            }
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
        value receiverInfo = ExpressionInfo(that.receiverExpression);
        value memberDeclaration = info.target.declaration;
        value memberContainer = memberDeclaration.container;
        value safeMemberOperator = that.memberOperator is SafeMemberOperator;

        "Maybe this is a type alias?"
        assert (is ClassOrInterfaceModel memberContainer);

        switch (memberDeclaration)
        case (is ValueModel) {
            // Return an expression that will yield the value
            return generateInvocation {
                that;
                info.typeModel;
                receiverInfo.typeModel;
                () => that.receiverExpression.transform(this);
                memberDeclaration;
                null;
                safeMemberOperator;
            };
        }
        case (is FunctionModel) {
            // Return a new Callable
            value receiverDenotableType = ceylonTypes.denotableType {
                receiverInfo.typeModel;
                memberContainer;
            };

            value receiverDartType = dartTypes.dartTypeName {
                that;
                receiverDenotableType;
                eraseToNative = false;
            };

            value receiver = withLhsNonNative {
                receiverDenotableType;
                () => that.receiverExpression.transform(this);
            };

            value [memberIdentifier, isFunction] = dartTypes
                    .dartIdentifierForFunctionOrValue {
                that;
                memberDeclaration;
                false;
            };

            "Qualified expressions aren't toplevels, and only toplevels
             are qualified by dartIdentifierForFunctionOrValue()"
            assert (is DartSimpleIdentifier memberIdentifier);

            "Ignore the possibility that a Ceylon function is a Dart
             property, for which there are no known cases."
            assert (isFunction);

            // The core.Function result of the qualified expression must be
            // captured to avoid re-evaluating the receiver expression
            // each time Callable is invoked.
            //
            // So...
            //   - create a closure that
            //     - declares a variable holding the evaluated qe (1)
            //     - returns a new Callable that holds the saved function (2)
            //   - invoke the closure to obtain the Callable (3)
            value unboxed =
            DartFunctionExpressionInvocation { // (3)
                DartFunctionExpression {
                    DartFormalParameterList();
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            [DartVariableDeclarationStatement {
                                DartVariableDeclarationList {
                                    keyword = null;
                                    type = dartTypes.dartFunction;
                                    [DartVariableDeclaration { // (1)
                                        DartSimpleIdentifier {
                                            "$capturedDelegate$";
                                        };
                                        if (!safeMemberOperator)
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
                                    memberDeclaration;
                                    DartSimpleIdentifier {
                                        "$capturedDelegate$";
                                    };
                                    delegateMayBeNull = safeMemberOperator;
                                };
                            }];
                        };
                    };
                };
                DartArgumentList(); // (3)
            };
            // a new Callable, so never erased to native
            return withBoxingNonNative {
                that;
                info.typeModel;
                unboxed;
            };

        }
        else {
            throw CompilerBug(that,
                "Unexpected declaration type for qualified expression: \
                 ``className(memberDeclaration)``");
        }
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(that,
                ceylonTypes.floatType, null,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(that,
                ceylonTypes.integerType, null,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxing(that,
                ceylonTypes.stringType, null,
                DartSimpleStringLiteral(that.text));

    shared actual
    DartExpression transformCharacterLiteral(CharacterLiteral that)
        =>  withBoxing(that,
                ceylonTypes.characterType, null,
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeName {
                            that;
                            ceylonTypes.characterType;
                            false; false;
                        };
                        DartSimpleIdentifier("$fromInt");
                    };
                    DartArgumentList {
                        // FIXME text may be an escape sequence
                        [DartIntegerLiteral(that.text.first?.integer else 0)];
                    };
                });

    shared actual
    DartExpression transformStringTemplate(StringTemplate that) {
        variable DartExpression unboxed = withLhsNative {
            ceylonTypes.stringType;
            () => that.literals.first.transform(this);
        };

        "Caller must properly set `withLhs`."
        DartExpression asString(Expression e) {
            value info = ExpressionInfo(e);
            if (ceylonTypes.isCeylonString(info.typeModel)) {
                return e.transform(this);
            } else {
                return generateInvocationFromName(that, e, "string", []);
            }
        }

        for (child in that.children.rest) {
            unboxed = DartBinaryExpression {
                unboxed;
                "+";
                withLhsNative {
                    ceylonTypes.stringType;
                    () => asString(child);
                };
            };
        }
        return withBoxing {
            that;
            ceylonTypes.stringType;
            null;
            unboxed;
        };
    }

    shared actual
    DartExpression transformTuple(Tuple that) {
        value info = ExpressionInfo(that);

        // We know statically if it's empty
        if (ceylonTypes.isCeylonEmpty(info.typeModel)) {
            return withBoxingNonNative {
                that;
                info.typeModel;
                dartTypes.dartIdentifierForFunctionOrValue {
                    that;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }[0];
            };
        }

        // Ok, not empty, create a Sequential or a Tuple
        value sequenceArgument = that.argumentList.sequenceArgument;
        if (sequenceArgument is Comprehension) {
            throw CompilerBug(that, "Comprehension for Tuple not suported");
        }
        assert (!is Comprehension sequenceArgument);

        if (that.argumentList.listedArguments.empty) {
            "Not Empty and no listed arguments; a sequence argument must exist."
            assert (exists sequenceArgument);

            value argumentInfo = ExpressionInfo(sequenceArgument.argument);
            if (ceylonTypes.isCeylonSequential(argumentInfo.typeModel)) {
                // Basically a noop; `x[*y] === y` if `y is Sequential`.
                // Result may be a Sequential, Sequence, or Tuple
                return sequenceArgument.argument.transform(this);
            }
            else {
                // The argument is an Iterable; result may be a Sequential or Sequence.
                // Would it be more correct to create the sequential from the iterator
                // rather than trusting `arg.sequence()` to produce the same result?
                return generateInvocationFromName {
                    that;
                    sequenceArgument.argument;
                    "sequence";
                    [];
                };
            }
        }
        else {
            // Listed arguments, and possibly a spread argument.
            // If we ever wire up internal methods and constructors to the metamodel,
            // we can use generateInvocation() instead.
            return withBoxingNonNative {
                that;
                info.typeModel;
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeName {
                            scope = that;
                            ceylonTypes.tupleDeclaration.type;
                            false; false;
                        };
                        DartSimpleIdentifier {
                            "$withList";
                        };
                    };
                    DartArgumentList {
                        [DartListLiteral {
                            false;
                            // Sequences are generic, so elements must
                            // not be erased to native.
                            withLhsNonNative {
                                ctx.unit.getIteratedType(info.typeModel);
                                () => that.argumentList.listedArguments.collect {
                                    (element) => element.transform(this);
                                };
                            };
                        },
                        if (!exists sequenceArgument)
                            then DartNullLiteral()
                            else withLhsDenotable {
                                ceylonTypes.iterableDeclaration;
                                () => sequenceArgument.argument.transform(this);
                            }
                        ];
                    };
                };
            };
        }
    }

    shared actual
    DartExpression transformIterable(Iterable that) {
        value info = ExpressionInfo(that);
        value arguments = that.argumentList.listedArguments;
        value sequenceArgument = that.argumentList.sequenceArgument;

        if (sequenceArgument is Comprehension) {
            throw CompilerBug(that, "Comprehension for Iterable not suported");
        }
        assert(!is Comprehension sequenceArgument);

        if (arguments.empty && !sequenceArgument exists) {
            // Easy; there are no elements.
            return withBoxingNonNative {
                that;
                info.typeModel;
                dartTypes.dartIdentifierForFunctionOrValue {
                    that;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }[0];
            };
        }
        else if (!nonempty arguments) {
            // Just evaluate and return the spread expression
            assert (exists sequenceArgument);
            return sequenceArgument.argument.transform(this);
        }
        else {
            // Return a LazyIterable, which takes as an argument a function that lazily
            // evaluates expressions by index.
            value indexIdentifier = DartSimpleIdentifier("$i$");

            return withBoxingNonNative {
                that;
                info.typeModel;
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeNameForDartModel {
                            scope = that;
                            dartTypes.dartLazyIterable;
                        };
                    };
                    DartArgumentList {
                        [DartIntegerLiteral(arguments.size),
                        DartFunctionExpression {
                            DartFormalParameterList {
                                false; false;
                                [DartSimpleFormalParameter {
                                    true;
                                    false;
                                    dartTypes.dartInt;
                                    indexIdentifier;
                                }];
                            };
                            DartBlockFunctionBody {
                                null; false;
                                DartBlock {
                                    [DartSwitchStatement {
                                        indexIdentifier;
                                        // Sequences are generic, so elements must
                                        // not be erased to native.
                                        withLhsNonNative {
                                            ctx.unit.getIteratedType(info.typeModel);
                                            () => [for (i -> argument
                                                        in arguments.indexed)
                                                DartSwitchCase {
                                                    [];
                                                    DartIntegerLiteral(i);
                                                    [DartReturnStatement {
                                                        argument.transform(this);
                                                    }];
                                                }
                                            ];
                                        };
                                    }];
                                };
                            };
                        },
                        if (exists sequenceArgument) then
                            withLhsDenotable {
                                ceylonTypes.iterableDeclaration;
                                () => sequenceArgument.argument.transform(this);
                            }
                        else
                            DartNullLiteral()
                        ];
                    };
                };
            };
        }
    }

    shared actual
    DartExpression transformInvocation(Invocation that) {
        value info = InvocationInfo(that);
        value invokedInfo = ExpressionInfo(that.invoked);

        DeclarationModel? invokedDeclaration
            =   let (d = switch (invoked = that.invoked)
                           case (is BaseExpression)
                                BaseExpressionInfo(invoked).declaration
                           case (is QualifiedExpression)
                                QualifiedExpressionInfo(invoked).declaration
                           else
                                null) // some other expression that yields a Callable

                if (is FunctionModel d,
                    is ConstructorModel constructor = d.type.declaration) then
                    // Constructor invocations present the invoked as a Function,
                    // but let's use the Constructor declaration.
                    constructor
                else
                    d;

        "Generate an invocation on `ValueModel`s, or `FunctionModel`s for Callable
         parameters, which are implemented as Callable values. This function is called
         in two locations in the main `switch` statement below."
        function invocationForCallable() {
            // Callables (being generic) always erase to `core.Object`.
            // We don't have a declaration to to use, so explicitly
            // specify erasure:
            return
            withBoxingCustom {
                that;
                info.typeModel;
                rhsErasedToNative = false;
                rhsErasedToObject = true;
                DartFunctionExpressionInvocation {
                    // resolve the $delegate$ property of the Callable
                    DartPropertyAccess {
                        withLhsDenotable {
                            ceylonTypes.callableDeclaration;
                            () => that.invoked.transform(this);
                        };
                        DartSimpleIdentifier("$delegate$");
                    };
                    generateArgumentListFromArguments {
                        that.arguments;
                        invokedInfo.typeModel;
                        true;
                    };
                };
            };
        }

        // the subtypes of FunctionOrValueModel, ClassModel, and ConstructorModel
        assert (is FunctionModel | ValueModel | SetterModel
                | ClassModel | ConstructorModel | Null invokedDeclaration);

        switch (invokedDeclaration)
        case (is FunctionModel) {
            // Invoke a Dart function (*probably* not a Callable value)

            "If the declaration is FunctionModel, the expression must be a base
             expression or a qualified expression"
            assert (is QualifiedExpression|BaseExpression invoked = that.invoked);

            switch (invoked)
            case (is QualifiedExpression) {
                value receiverInfo = ExpressionInfo(invoked.receiverExpression);

                return generateInvocation {
                    that;
                    info.typeModel;
                    receiverInfo.typeModel;
                    () => receiverInfo.node.transform(this);
                    invokedDeclaration;
                    callableTypeAndArguments = [
                        invokedInfo.typeModel,
                        that.arguments
                    ];
                    invoked.memberOperator is SafeMemberOperator;
                };
            }
            case (is BaseExpression) {
                if (invokedDeclaration.parameter) {
                    // Invoking a Callable parameter
                    return invocationForCallable();
                }
                else {
                    return withBoxing {
                        that;
                        info.typeModel;
                        // If there are multiple parameter lists, the function returns a
                        // Callable, not the ultimate return type as advertised by the
                        // declaration.
                        invokedDeclaration.parameterLists.size() == 1
                            then invokedDeclaration;
                        DartFunctionExpressionInvocation {
                            dartTypes.expressionForBaseExpression {
                                scope = that;
                                invokedDeclaration;
                            }[0];
                            generateArgumentListFromArguments {
                                that.arguments;
                                invokedInfo.typeModel;
                            };
                        };
                    };
                }
            }
        }
        case (is ValueModel?) {
            return invocationForCallable();
        }
        case (is ClassModel) {
            if (!withinPackage(invokedDeclaration)) {
                throw CompilerBug(that,
                    "Invocations of member classes not yet supported.");
            }

            "We only handle topelevel classes for now"
            assert (is BaseExpression invoked = that.invoked);

            return
            withBoxingNonNative {
                that;
                info.typeModel;
                DartInstanceCreationExpression {
                    false;
                    // no need to transform the base expression:
                    dartTypes.dartConstructorName {
                        that;
                        invokedDeclaration;
                    };
                    generateArgumentListFromArguments {
                        that.arguments;
                        invokedInfo.typeModel;
                    };
                };
            };
        }
        case (is ConstructorModel) {
            assert (is ClassModel clazzModel = invokedDeclaration.container);
            if (!withinPackage(clazzModel)) {
                throw CompilerBug(that,
                    "Invocations of constructors of member classes not yet supported.");
            }

            "that.invoked is a QualifiedExpression, even for constructors of
             topelevel classes"
            assert (is QualifiedExpression invoked = that.invoked);

            "We only handle topelevel classes for now"
            assert (invoked.receiverExpression is BaseExpression);

            return
            withBoxingNonNative {
                that;
                info.typeModel;
                DartInstanceCreationExpression {
                    false;
                    dartTypes.dartConstructorName {
                        that;
                        invokedDeclaration;
                    };
                    generateArgumentListFromArguments {
                        that.arguments;
                        invokedInfo.typeModel;
                    };
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
                dartTypes.dartIdentifierForFunctionOrValue(scope,
                    ceylonTypes.booleanTrueValueDeclaration)[0]
            else
                dartTypes.dartIdentifierForFunctionOrValue(scope,
                    ceylonTypes.booleanFalseValueDeclaration)[0];

    shared actual
    DartExpression transformNotOperation(NotOperation that)
        =>  DartPrefixExpression {
                "!";
                withLhsNative {
                    ceylonTypes.booleanType;
                    () => that.operand.transform(this);
                };
            };

    shared actual
    DartExpression transformNegationOperation(NegationOperation that)
        =>  generateInvocationFromName {
                that;
                that.operand;
                "negated";
                [];
            };

    shared actual
    DartExpression transformIdentityOperation(IdentityOperation that)
        =>  that.operand.transform(this);

    shared actual
    DartExpression transformPrefixOperation(PrefixOperation that) {
        String method = switch (that)
                case (is PrefixIncrementOperation) "successor"
                case (is PrefixDecrementOperation) "predecessor";

        assert (is BaseExpression | QualifiedExpression operand = that.operand);

        return
        generateAssignmentExpression {
            that;
            operand;
            () => generateInvocationFromName {
                that;
                that.operand;
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
                () => generateInvocationFromName {
                    that;
                    that.operand;
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
            tempVarType = ceylonTypes.denotableType {
                ExpressionInfo(that).typeModel;
                lhsDenotable;
            };
        }

        value tempVar =
            DartSimpleIdentifier {
                dartTypes.createTempNameCustom();
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
                    () => generateInvocationFromName {
                        that;
                        that.operand;
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
    DartExpression transformGroupedExpression(GroupedExpression that)
        =>  that.innerExpression.transform(this);

    DartExpression generateInvocationForBinaryOperation
            (BinaryOperation that, String methodName)
        =>  generateInvocationFromName {
                that;
                that.leftOperand;
                methodName;
                [that.rightOperand];
            };

    shared actual
    DartExpression transformArithmeticOperation(ArithmeticOperation that)
        =>  generateInvocationForBinaryOperation(that,
                switch(that)
                case (is ExponentiationOperation) "power"
                case (is ProductOperation) "times"
                case (is QuotientOperation) "divided"
                case (is RemainderOperation) "remainder"
                case (is SumOperation) "plus"
                case (is DifferenceOperation) "minus");

    shared actual
    DartExpression transformSetOperation(SetOperation that)
        // TODO test
        =>  generateInvocationForBinaryOperation(that,
                switch(that)
                case (is IntersectionOperation) "intersection"
                case (is UnionOperation) "union"
                case (is ComplementOperation) "complement");

    shared actual
    DartExpression transformScaleOperation(ScaleOperation that)
        // TODO test
        =>  generateInvocationForBinaryOperation(that, "scale");

    shared actual
    DartExpression transformSpanOperation(SpanOperation that)
        // FIXME implement this; span is a toplevel function
        =>  super.transformSpanOperation(that);

    shared actual
    DartExpression transformMeasureOperation(MeasureOperation that)
        // FIXME implement this; measure is a toplevel function
        =>  super.transformMeasureOperation(that);

    shared actual
    DartExpression transformEntryOperation(EntryOperation that)
        // FIXME implement this; Entry is a constructor
        =>  super.transformEntryOperation(that);

    shared actual
    DartExpression transformInOperation(InOperation that)
        // TODO test
        // Note: the *right* operand is the receiver
        =>  generateInvocationFromName {
                that;
                that.rightOperand;
                "contains";
                [that.leftOperand];
            };

    shared actual
    DartExpression transformComparisonOperation(ComparisonOperation that)
        =>  generateInvocationForBinaryOperation(that,
                switch (that)
                case (is LargerOperation) "largerThan"
                case (is SmallerOperation) "smallerThan"
                case (is LargeAsOperation) "notSmallerThan"
                case (is SmallAsOperation) "notLargerThan");

    shared actual
    DartExpression transformCompareOperation(CompareOperation that)
        =>  generateInvocationForBinaryOperation(that, "compare");

    shared actual
    DartExpression transformEqualOperation(EqualOperation that)
        =>  generateInvocationForBinaryOperation(that, "equals");

    shared actual
    DartExpression transformNotEqualOperation(NotEqualOperation that)
        =>  DartPrefixExpression("!",
                generateInvocationForBinaryOperation(that, "equals"));

    shared actual
    DartExpression transformIdenticalOperation(IdenticalOperation that)
        =>  withBoxing {
                that;
                rhsType = ceylonTypes.booleanType;
                rhsDeclaration = null;
                withLhsDenotable {
                    // this withLhs wraps transformations of both operands
                    ceylonTypes.identifiableDeclaration;
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
    DartExpression transformLogicalOperation(LogicalOperation that)
        =>  let (dartOperator =
                    switch (that)
                    case (is AndOperation) "&&"
                    case (is OrOperation) "||")
            withLhsNative {
                ceylonTypes.booleanType;
                () => DartBinaryExpression {
                    that.leftOperand.transform(this);
                    dartOperator;
                    that.rightOperand.transform(this);
                };
            };

    shared actual
    DartExpression transformThenOperation(ThenOperation that)
        =>  DartConditionalExpression {
                withLhsNative {
                    ceylonTypes.booleanType;
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
                dartTypes.dartTypeName {
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
            () => generateInvocationForBinaryOperation(that, methodName);
        };
    }

    shared actual
    DartExpression transformSetAssignmentOperation(SetAssignmentOperation that) {
        // TODO test
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
            () => generateInvocationForBinaryOperation(that, methodName);
        };
    }

    shared actual
    DartExpression transformLogicalAssignmentOperation(LogicalAssignmentOperation that) {
        // TODO test
        value methodName
            =   switch(that)
                case (is AndAssignmentOperation) "and"
                case (is OrAssignmentOperation) "or";

        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            that;
            leftOperand;
            () => generateInvocationForBinaryOperation(that, methodName);
        };
    }

    shared actual
    DartExpression transformWithinOperation(WithinOperation that) {
        value lowerMethodName =
            switch (lb = that.lowerBound)
            case (is OpenBound) "largerThan"
            case (is ClosedBound) "notSmallerThan";

        value upperMethodName =
            switch (ub = that.upperBound)
            case (is OpenBound) "smallerThan"
            case (is ClosedBound) "notLargerThan";

        return
        withLhsNative {
            // lhs boolean for both generateInvocations
            ceylonTypes.booleanType;
            () => DartBinaryExpression {
                generateInvocationFromName {
                    that;
                    that.operand;
                    lowerMethodName;
                    [that.lowerBound.endpoint];
                };
                "&&";
                generateInvocationFromName {
                    that;
                    that.operand;
                    upperMethodName;
                    [that.upperBound.endpoint];
                };
            };
        };
    }

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

    shared actual
    DartExpression transformThis(This that) {
        value info = ThisInfo(that);
        DartSimpleIdentifier identifier;
        if (getContainingClassOrInterface(info.scope) is InterfaceModel) {
            identifier = DartSimpleIdentifier("$this");
        }
        else {
            identifier = DartSimpleIdentifier("this");
        }
        return withBoxing {
            that;
            info.typeModel;
            rhsDeclaration = null; // no declaration for `this`
            identifier;
        };
    }

    shared actual
    DartExpression transformOuter(Outer that) {
        value info = OuterInfo(that);
        assert (is ClassOrInterfaceModel ci = getContainingClassOrInterface(info.scope));
        assert (exists [d, fieldName] = dartTypes.outerDeclarationAndFieldName(ci));

        // Qualify outer field with `this`. Required within interfaces,
        // doesn't hurt within classes.
        value thisIdentifier =
                if (d is InterfaceModel)
                then DartSimpleIdentifier("$this")
                else DartSimpleIdentifier("this");

        return withBoxing {
            that;
            info.typeModel;
            rhsDeclaration = null; // the field is synthetic
            DartPrefixedIdentifier {
                thisIdentifier;
                DartSimpleIdentifier(fieldName);
            };
        };
    }

    shared actual default
    DartExpression transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node: '``className(that)``'");
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
