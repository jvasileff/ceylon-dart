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
    Expression,
    Package,
    NameWithTypeArguments,
    ExistsOperation,
    IsOperation,
    NonemptyOperation,
    OfOperation,
    ElementOrSubrangeExpression,
    KeySubscript,
    SpanSubscript,
    MeasureSubscript,
    SpanFromSubscript,
    SpanToSubscript,
    BooleanCondition,
    Condition,
    ObjectExpression,
    Super,
    Primary,
    SwitchCaseElseExpression,
    IsCase,
    MatchCase,
    CaseExpression,
    LetExpression,
    SpecifiedPattern,
    VariablePattern,
    TuplePattern,
    EntryPattern,
    SpreadArgument,
    ComprehensionClause,
    ForComprehensionClause,
    IfComprehensionClause,
    ExpressionComprehensionClause
}
import ceylon.collection {
    LinkedList
}
import ceylon.language.meta {
    type
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
    DartSimpleFormalParameter,
    DartStatement,
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartThrowExpression,
    DartFunctionDeclarationStatement,
    DartFunctionDeclaration,
    dartFormalParameterListEmpty,
    DartWhileStatement,
    DartIsExpression,
    DartTypeName,
    DartContinueStatement
}
import com.vasileff.ceylon.dart.nodeinfo {
    BaseExpressionInfo,
    FunctionExpressionInfo,
    QualifiedExpressionInfo,
    InvocationInfo,
    ExpressionInfo,
    ThisInfo,
    OuterInfo,
    TypeInfo,
    IfElseExpressionInfo,
    ObjectExpressionInfo,
    SuperInfo,
    IsCaseInfo,
    UnspecifiedVariableInfo
}
import com.vasileff.jl4c.guava.collect {
    javaList
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
    DartExpression transformBaseExpression(BaseExpression that)
        =>  generateForBaseExpression {
                that;
                that.nameAndArgs;
                BaseExpressionInfo(that).declaration;
            };

    DartExpression generateForBaseExpression(
            Expression that,
            NameWithTypeArguments nameAndArgs,
            DeclarationModel targetDeclaration) {

        // TODO Consider consolidating/refactoring all base expression
        //      and qualified expression functions.

        if (!is MemberNameWithTypeArguments nameAndArgs) {
            throw CompilerBug(that,
                    "BaseExpression nameAndArgs type not yet supported: \
                     '``className(nameAndArgs)``'");
        }
        assert (is MemberNameWithTypeArguments nameAndArgs);

        value info = ExpressionInfo(that);

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
        if (that.receiverExpression is Package) {
            // treat Package qualified expressions as base expressions
            return
            generateForBaseExpression {
                that;
                that.nameAndArgs;
                QualifiedExpressionInfo(that).declaration;
            };
        }

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
        //if (sequenceArgument is Comprehension) {
        //    throw CompilerBug(that, "Comprehension for Tuple not suported");
        //}
        //assert (!is Comprehension sequenceArgument);

        if (that.argumentList.listedArguments.empty) {
            "Not Empty and no listed arguments; a sequence argument must exist."
            assert (exists sequenceArgument);
            return generateSequentialFromArgument(sequenceArgument);
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
                        switch (sequenceArgument)
                        case (is Comprehension | SpreadArgument)
                            // Whatever Iterable type we come up with is surely correct.
                            withLhsDenotable {
                                ceylonTypes.iterableDeclaration;
                                () => sequenceArgument.transform(this);
                            }
                        case (is Null)
                            DartNullLiteral()
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
            // Just evaluate and return the spread expression. We don't care about the
            // lhs type, which should have already been set by code that does care.
            assert (exists sequenceArgument);
            return sequenceArgument.transform(this);
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
                        switch (sequenceArgument)
                        case (is Comprehension | SpreadArgument)
                            // Whatever Iterable type we come up with is surely correct.
                            withLhsDenotable {
                                ceylonTypes.iterableDeclaration;
                                () => sequenceArgument.transform(this);
                            }
                        case (is Null)
                            DartNullLiteral()
                        ];
                    };
                };
            };
        }
    }

    shared actual
    DartExpression transformSpreadArgument(SpreadArgument that)
        =>  that.argument.transform(this);

    "The non-intersection type of a `super` reference; should map directly to a Dart type."
    TypeModel? denotableSuperType(
            "Primary may be `super` or `(super of T)`"
            Primary primary)
        =>  if (is Super primary) then
                let (superInfo = SuperInfo(primary))
                superInfo.typeModel.getSupertype(superInfo.declarationModel)
            else if (is GroupedExpression primary,
                     is OfOperation ofOp = primary.innerExpression,
                     is Super s = ofOp.operand) then
                let (superInfo = SuperInfo(s))
                superInfo.typeModel.getSupertype(superInfo.declarationModel)
            else
                null;

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

        "The subtypes of FunctionOrValueModel, ClassModel, and ConstructorModel, with
         Null for expressions to Callables."
        assert (is FunctionModel | ValueModel | SetterModel
                | ClassModel | ConstructorModel | Null invokedDeclaration);

        value invokedDeclarationContainer
            =  if (exists invokedDeclaration)
               then getContainingClassOrInterface(invokedDeclaration)
               else null;

        if (is FunctionModel | ValueModel invokedDeclaration,
                !invokedDeclaration.shared,
                // callable parameters are local values!
                !invokedDeclaration.parameter,
                is InterfaceModel invokedDeclarationContainer,
                is BaseExpression invoked = that.invoked) {

            // Special case: invoking private interface member using a BaseExpression.
            //
            // Private interface members are not polymorphic and cannot be accessed
            // through $this. Instead, we must invoke the `getStaticInterfaceMethodName`
            // directly, passing in a suitable `$this` value.
            //
            // Note: private interface members may also be invoked using a
            // QualifiedExpression, but that can be handled by `generateInvocation`.

            "The 'reciever' of the invocation, that will be passed as the first argument
             to the Dart static implementation of invokedDeclaration."
            DartExpression thisExpression;

            // Find a value for the receiver ($this argument), starting from the
            // container and searching ancestors until a match is found.
            //
            // It's simply the thisOrOuter for the exact type of the member's
            // (invokedDeclaration's) interface.

            "The scope of a BaseExpression to a function or value member of a class
             or interface will have a containing class or interface."
            assert (exists scopeContainer
                =   getContainingClassOrInterface(that));

            thisExpression
                =   dartTypes.expressionToThisOrOuter {
                        dartTypes.ancestorChainToExactDeclaration {
                            scopeContainer;
                            invokedDeclarationContainer;
                        };
                    };

            value hasMultipleParameterLists
                =   if (is FunctionModel invokedDeclaration)
                    then invokedDeclaration.parameterLists.size() > 1
                    else false;

            return withBoxing {
                that;
                info.typeModel;
                // If there are multiple parameter lists, the function returns a
                // Callable, not the ultimate return type as advertised by the
                // declaration.
                !hasMultipleParameterLists then invokedDeclaration;
                DartFunctionExpressionInvocation {
                    // qualified reference to the static interface method
                    DartPropertyAccess {
                        dartTypes.dartIdentifierForClassOrInterface {
                            that;
                            invokedDeclarationContainer;
                        };
                        DartSimpleIdentifier {
                            dartTypes.getStaticInterfaceMethodName(invokedDeclaration);
                        };
                    };
                    DartArgumentList {
                        concatenate {
                            [thisExpression],
                            generateArgumentListFromArguments {
                                that.arguments;
                                invokedInfo.typeModel;
                            }.arguments
                        };
                    };
                };
            };
        }

        switch (invokedDeclaration)
        case (is FunctionModel) {
            // Invoke a Dart function (*probably* not a Callable value)

            "If the declaration is FunctionModel, the expression must be a base
             expression or a qualified expression"
            assert (is QualifiedExpression|BaseExpression invoked = that.invoked);

            if (is QualifiedExpression invoked,
                exists superType = denotableSuperType(invoked.receiverExpression)) {
                // receiver is a `super` reference
                return generateInvocation {
                    that;
                    info.typeModel;
                    superType;
                    null;
                    invokedDeclaration;
                    callableTypeAndArguments = [
                        invokedInfo.typeModel,
                        that.arguments
                    ];
                    invoked.memberOperator is SafeMemberOperator;
                };
            }
            // QualifiedExpressions, but exclude those w/Package "receivers"; they are
            // more like BaseExpressions
            else if (is QualifiedExpression invoked,
                    !invoked.receiverExpression is Package) {

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
            else {
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
            "We only handle topelevel classes for now"
            assert (is BaseExpression invoked = that.invoked);

            value captureArguments
                =   generateArgumentsForOutersAndCaptures {
                        that;
                        invokedDeclaration;
                    };

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
                    DartArgumentList {
                        concatenate {
                            captureArguments,
                            generateArgumentListFromArguments {
                                that.arguments;
                                invokedInfo.typeModel;
                            }.arguments
                        };
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
    DartExpression transformElementOrSubrangeExpression
            (ElementOrSubrangeExpression that) {

        switch (subscript = that.subscript)
        case (is KeySubscript) {
            return
            generateInvocationFromName {
                that;
                that.primary;
                "get";
                [subscript.key];
            };
        }
        case (is SpanSubscript) {
            return
            generateInvocationFromName {
                that;
                that.primary;
                "span";
                [subscript.from, subscript.to];
            };
        }
        case (is MeasureSubscript) {
            return
            generateInvocationFromName {
                that;
                that.primary;
                "measure";
                [subscript.from, subscript.length];
            };
        }
        case (is SpanFromSubscript) {
            return
            generateInvocationFromName {
                that;
                that.primary;
                "spanFrom";
                [subscript.from];
            };
        }
        case (is SpanToSubscript) {
            return
            generateInvocationFromName {
                that;
                that.primary;
                "spanTo";
                [subscript.to];
            };
        }
    }

    shared actual
    DartExpression transformObjectExpression(ObjectExpression that) {
        value info = ObjectExpressionInfo(that);

        that.transform(topLevelVisitor);

        return
        generateObjectInstantiation {
            info.scope.container;
            info.anonymousClass;
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
    DartExpression transformExistsOperation(ExistsOperation that)
        =>  withBoxing {
                that;
                ceylonTypes.booleanType;
                null;
                generateExistsExpression {
                    that;
                    withLhsNoType {
                        () => that.operand.transform(this);
                    };
                };
            };

    shared actual
    DartExpression transformIsOperation(IsOperation that)
        =>  withBoxing {
                that;
                ceylonTypes.booleanType;
                null;
                generateIsExpression {
                    that;
                    withLhsNoType {
                        () => that.operand.transform(this);
                    };
                    TypeInfo(that.type).typeModel;
                };
            };

    shared actual
    DartExpression transformNonemptyOperation(NonemptyOperation that)
        =>  withBoxing {
                that;
                ceylonTypes.booleanType;
                null;
                generateNonemptyExpression {
                    that;
                    withLhsNoType {
                        () => that.operand.transform(this);
                    };
                };
            };

    shared actual
    DartExpression transformOfOperation(OfOperation that)
        // noop; dart casting is always performed based
        // on the model and lhs, rhs types
        =>  that.operand.transform(this);

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
        =>  generateInvocationForBinaryOperation(that,
                switch(that)
                case (is IntersectionOperation) "intersection"
                case (is UnionOperation) "union"
                case (is ComplementOperation) "complement");

    shared actual
    DartExpression transformScaleOperation(ScaleOperation that)
        =>  generateInvocationForBinaryOperation(that, "scale");

    shared actual
    DartExpression transformSpanOperation(SpanOperation that) {
        value info = ExpressionInfo(that);
        value firstInfo = ExpressionInfo(that.first);
        value lastInfo = ExpressionInfo(that.last);

        // Determine Enumerable type (Enumerable<T>)
        value enumerableType =
            ceylonTypes.union(
                firstInfo.typeModel,
                lastInfo.typeModel
            ).getSupertype(ceylonTypes.enumerableDeclaration);

        // Determine element type (the `T`)
        assert(exists elementType = ceylonTypes.typeArgument(enumerableType));

        // Callable type for `span<T>`
        value callableType = ceylonTypes
                .spanFunctionDeclaration
                .appliedTypedReference(null,
                    javaList { elementType })
                .fullType;

        return generateTopLevelInvocation {
            that;
            info.typeModel;
            ceylonTypes.spanFunctionDeclaration;
            [callableType, [that.first, that.last]];
        };
    }

    shared actual
    DartExpression transformMeasureOperation(MeasureOperation that) {
        value info = ExpressionInfo(that);
        value firstInfo = ExpressionInfo(that.first);

        // Determine Enumerable type (Enumerable<T>)
        value enumerableType = firstInfo.typeModel.getSupertype(
                ceylonTypes.enumerableDeclaration);

        // Determine element type (the `T`)
        assert(exists elementType = ceylonTypes.typeArgument(enumerableType));

        // Callable type for `measure<T>`
        value callableType = ceylonTypes
                .measureFunctionDeclaration
                .appliedTypedReference(null,
                    javaList { elementType })
                .fullType;

        return generateTopLevelInvocation {
            that;
            info.typeModel;
            ceylonTypes.measureFunctionDeclaration;
            [callableType, [that.first, that.size]];
        };
    }

    shared actual
    DartExpression transformEntryOperation(EntryOperation that)
        =>  withBoxingNonNative {
                that;
                ExpressionInfo(that).typeModel;
                DartInstanceCreationExpression {
                    false;
                    dartTypes.dartConstructorName {
                        that;
                        ceylonTypes.entryDeclaration;
                    };
                    DartArgumentList {
                        [withLhsNonNative {
                            ceylonTypes.objectType;
                            () => that.key.transform(this);
                        },
                        withLhsNonNative {
                            ceylonTypes.objectType;
                            () => that.item.transform(this);
                        }];
                    };
                };
            };

    shared actual
    DartExpression transformInOperation(InOperation that)
        =>  generateInvocationFromName {
                that;
                // Note: the *right* operand is the receiver
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

            withBoxing {
                that;
                ceylonTypes.booleanType;
                null;
                withLhsNative { // for the two transformations
                    ceylonTypes.booleanType;
                    () => DartBinaryExpression {
                        that.leftOperand.transform(this);
                        dartOperator;
                        that.rightOperand.transform(this);
                    };
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
        withBoxing {
            that;
            ceylonTypes.booleanType;
            null;
            withLhsNative { // for the two generateInvocations
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
        };
    }

    shared actual
    DartExpression transformLetExpression(LetExpression that) {
        [DartStatement+] generateVariableDeclarations(SpecifiedPattern sp) {
            switch (p = sp.pattern)
            case (is VariablePattern) {
                value variableDeclaration
                    =   UnspecifiedVariableInfo(p.variable).declarationModel;

                value variableIdentifier
                    =   DartSimpleIdentifier(dartTypes.getName(variableDeclaration));

                value definition
                    =   DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                keyword = null;
                                dartTypes.dartTypeNameForDeclaration {
                                    that;
                                    variableDeclaration;
                                };
                                [DartVariableDeclaration {
                                    variableIdentifier;
                                    withLhs {
                                        null;
                                        variableDeclaration;
                                        () => sp.specifier.expression.transform {
                                            expressionTransformer;
                                        };
                                    };
                                }];
                            };
                        };
                return [definition];
            }
            case (is TuplePattern | EntryPattern) {
                throw CompilerBug(p, "Destructure not yet supported");
            }
        }

        [DartStatement+] variableDeclarations
            =   sequence(that.patterns.children.flatMap(generateVariableDeclarations));

        return
        DartFunctionExpressionInvocation {
            DartFunctionExpression {
                DartFormalParameterList();
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        concatenate {
                            variableDeclarations,
                            [DartReturnStatement {
                                that.expression.transform {
                                    expressionTransformer;
                                };
                            }]
                        };
                    };
                };
            };
            DartArgumentList { []; };
        };
    }

    shared actual
    DartExpression transformComprehension(Comprehension that) {
        function generateStepFunctionName(Integer step)
            =>  DartSimpleIdentifier {
                    dartTypes.createTempNameCustom {
                        "step$" + step.string;
                    };
                };

        function generateStepInitFunctionName(Integer step)
            =>  DartSimpleIdentifier {
                    dartTypes.createTempNameCustom {
                        "step$" + step.string + "$Init";
                    };
                };

        "Dart variable declarations for variables used to effectively pass values among
         functions for each clause/step of the comprehension. The variable names
         (`capture[1]`) are generated.

         These variables are synthetic and will not be accessed directly by program code,
         but are instead used to hold values that will be assigned to variables that will
         be directly referenced by program code, and are suitably scoped for capture."
        function dartOuterVariableDeclarations
                (Node scope, {[ValueModel, DartSimpleIdentifier]*} captures)
            =>  captures.collect((capture)
                =>  DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                scope;
                                capture[0];
                            };
                            [DartVariableDeclaration {
                                capture[1];
                            }];
                        };
                    });

        "Dart variable definitions (declaration + initialization) for values defined
         or refined/replaced within the comprehension. In order for proper scoping of
         values for capture, declarations may be made multiple times, once per step
         function."
        function dartVariableDefinitions
                (Node scope, {[ValueModel, DartSimpleIdentifier]*} captures)
            =>  captures.collect((capture)
                =>  DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                that;
                                capture[0];
                            };
                            [DartVariableDeclaration {
                                dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                                    scope;
                                    capture[0];
                                    false;
                                }[0];
                                capture[1];
                            }];
                        };
                    });

        "Dart statements to perform assignments to outer variables, using the normal
         variable name of the declaration for the rhs value."
        function dartAssignmentsToOuterVariables
                (Node scope, {[ValueModel, DartSimpleIdentifier]*} captures)
            =>  captures.collect((capture)
                =>  DartExpressionStatement {
                        DartAssignmentExpression {
                            capture[1];
                            DartAssignmentOperator.equal;
                            dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                                scope;
                                capture[0];
                                false;
                            }[0];
                        };
                    });

        // step 0 bootstraps the chain; returns true a single time
        value step0ExpiredVariable
            =   DartSimpleIdentifier {
                    dartTypes.createTempNameCustom("step$0$expired");
                };

        value step0FunctionId
            =   generateStepFunctionName(0);

        value step0Statements
            =   [DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartBool;
                        [DartVariableDeclaration {
                            step0ExpiredVariable;
                            DartBooleanLiteral(false);
                        }];
                    };
                },
                createDartFunctionDeclarationStatement {
                    dartTypes.dartBool;
                    step0FunctionId;
                    dartFormalParameterListEmpty;
                    [DartIfStatement {
                        step0ExpiredVariable;
                        DartReturnStatement {
                            DartBooleanLiteral(false);
                        };
                    },
                    DartExpressionStatement {
                        DartAssignmentExpression {
                            step0ExpiredVariable;
                            DartAssignmentOperator.equal;
                            DartBooleanLiteral(true);
                        };
                    },
                    DartReturnStatement {
                        DartBooleanLiteral(true);
                    }];
                }];

        "Recursively generate steps 1 through n (for Comprehension clauses 1 through n)."
        [DartStatement*] generateSteps(
                ComprehensionClause clause,
                Integer count,
                DartSimpleIdentifier prevStepFunction,
                {[ValueModel, DartSimpleIdentifier]*} accumulatedCapturables) {

            switch (clause)
            case (is ForComprehensionClause) {
                value pattern = clause.iterator.pattern;
                if (!pattern is VariablePattern) {
                    throw CompilerBug(pattern,
                        "For pattern type not yet supported: " + type(pattern).string);
                }
                assert (is VariablePattern pattern);

                value variableInfo = UnspecifiedVariableInfo(pattern.variable);

                value variableDeclaration = variableInfo.declarationModel;

                // Don't erase to native; avoid premature unboxing
                ctx.disableErasureToNative.add(variableDeclaration);

                "The iterator for the iterable in this `for` clause"
                value iteratorVariable
                    =   DartSimpleIdentifier {
                            dartTypes.createTempNameCustom("iterator_" + count.string);
                        };

                "The synthetic variable used to hold the current value outside of the
                 function (simple case; for destructuring, we'll need more)"
                value dartValueVariable
                    =   DartSimpleIdentifier {
                            dartTypes.createTempName(variableDeclaration);
                        };

                "Temp variable for result of `next()`"
                value nextVariable
                    =   DartSimpleIdentifier {
                            dartTypes.createTempNameCustom("next");
                        };

                // Discover the type of the iterator and obtain a function that
                // will create an expression that yields the iterator
                value [iteratorType, _, iteratorGenerator]
                    =   generateInvocationDetailsFromName {
                            clause;
                            clause.iterator.iterated;
                            "iterator";
                            [];
                        };

                "A denotable supertype of the iterator type in case the iterator type
                 is a union, intersection, or other non-denotable type.
                 See also notes in `transformForFail`."
                value iteratorDenotableType
                    =   ceylonTypes.denotableType {
                            iteratorType;
                            ceylonTypes.iteratorDeclaration;
                        };

                // Discover the type of the result of `next()`. Obtain a function that
                // will create an expression that calls `next` on the iterator
                value [nextType, __, nextInvocationGenerator]
                    =   generateInvocationDetailsSynthetic {
                            that;
                            iteratorDenotableType;
                            () => withBoxing {
                                that;
                                iteratorDenotableType;
                                null;
                                iteratorVariable;
                            };
                            "next";
                            [];
                        };

                value stepInitFunctionName
                    =   generateStepInitFunctionName(count);

                value stepFunctionName
                    =   generateStepFunctionName(count);

                "An uninitialized dart variable declaration for the Iterator."
                value dartIteratorVariableDeclaration
                    =   DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartTypeName {
                                    that;
                                    iteratorDenotableType;
                                    eraseToNative = false;
                                    eraseToObject = false;
                                };
                                [DartVariableDeclaration {
                                    iteratorVariable;
                                }];
                            };
                        };

                "A dart function declaration for the stepInit function. This function

                 - Calls the previous step
                 - Creats and assigns the iterator
                 - Returns true or false to 'subsequent' steps, indicating whether or
                   not new values are available for continued processing."
                value dartInitFunctionDeclaration
                    =   createDartFunctionDeclarationStatement {
                            dartTypes.dartBool;
                            stepInitFunctionName;
                            dartFormalParameterListEmpty;
                            concatenate {
                                // If the iterator already exists, just return true
                                [DartIfStatement {
                                    DartBinaryExpression {
                                        iteratorVariable;
                                        "!=";
                                        DartNullLiteral();
                                    };
                                    DartReturnStatement {
                                        DartBooleanLiteral(true);
                                    };
                                }],
                                // If the previous step returns false, just return false
                                [DartIfStatement {
                                    DartPrefixExpression {
                                        "!";
                                        DartFunctionExpressionInvocation {
                                            prevStepFunction;
                                            DartArgumentList();
                                        };
                                    };
                                    DartReturnStatement {
                                        DartBooleanLiteral(false);
                                    };
                                }],
                                dartVariableDefinitions {
                                    clause;
                                    accumulatedCapturables;
                                },
                                // Otherwise, create and assign the iterator and return
                                // true.
                                [DartExpressionStatement {
                                    DartAssignmentExpression {
                                        iteratorVariable;
                                        DartAssignmentOperator.equal;
                                        withLhsNonNative {
                                            iteratorDenotableType;
                                            iteratorGenerator;
                                        };
                                    };
                                }],
                                [DartReturnStatement {
                                    DartBooleanLiteral(true);
                                }]
                            };
                        };

                "Declare the 'outer' variable."
                value dartValueVariableDeclaration
                    =   DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartTypeNameForDeclaration {
                                    that;
                                    variableDeclaration;
                                };
                                [DartVariableDeclaration {
                                    dartValueVariable;
                                }];
                            };
                        };

                value capturables
                    =   [[variableDeclaration, dartValueVariable]];

                "A dart function declaration for the step function. This function

                 - Calls the init function for this step, to initialize the iterator
                 - Obtains `next()` from the iterator
                 - Destructures (not done yet)
                 - Assigns to 'outer' variables"
                value dartStepFunctionDeclaration
                    =   createDartFunctionDeclarationStatement {
                            dartTypes.dartBool;
                            stepFunctionName;
                            dartFormalParameterListEmpty;
                            [DartWhileStatement {
                                DartFunctionExpressionInvocation {
                                    stepInitFunctionName;
                                    DartArgumentList();
                                };
                                DartBlock {
                                    concatenate {
                                        dartVariableDefinitions {
                                            clause;
                                            accumulatedCapturables;
                                        },
                                        // declare variable to hold result of next()
                                        [DartVariableDeclarationStatement {
                                            DartVariableDeclarationList {
                                                null;
                                                dartTypes.dartTypeName {
                                                    that;
                                                    nextType;
                                                    false; false;
                                                };
                                                [DartVariableDeclaration {
                                                    nextVariable;
                                                }];
                                            };
                                        }],
                                        // invoke next(), assign to nextVariable
                                        [DartIfStatement {
                                            DartIsExpression {
                                                DartAssignmentExpression {
                                                    nextVariable;
                                                    DartAssignmentOperator.equal;
                                                    withLhs {
                                                        nextType;
                                                        null;
                                                        nextInvocationGenerator;
                                                    };
                                                };
                                                dartTypes.dartTypeName {
                                                    that;
                                                    ceylonTypes.finishedType;
                                                    false; false;
                                                };
                                                true;
                                            };
                                            DartBlock {
                                                [// assign dartVariable = nextVariable
                                                // Simple case; for destructuring we'll
                                                // need more.
                                                DartExpressionStatement {
                                                    DartAssignmentExpression {
                                                        dartValueVariable;
                                                        DartAssignmentOperator.equal;
                                                        withLhs {
                                                            null;
                                                            variableDeclaration;
                                                            () => withBoxing {
                                                                clause;
                                                                nextType;
                                                                null;
                                                                nextVariable;
                                                            };
                                                        };
                                                    };
                                                },
                                                DartReturnStatement {
                                                    DartBooleanLiteral(true);
                                                }];
                                            };
                                        }],
                                        // Assign null to the iterator. The while loop
                                        // will attempt to start from the top (if
                                        // previous step is not also finished.)
                                        [DartExpressionStatement {
                                            DartAssignmentExpression {
                                                iteratorVariable;
                                                DartAssignmentOperator.equal;
                                                DartNullLiteral();
                                            };
                                        }]
                                    };
                                };
                            },
                            // We are finished, and so is the previous step.
                            // Return false.
                            DartReturnStatement {
                                DartBooleanLiteral(false);
                            }];
                        };

                return [dartIteratorVariableDeclaration,
                        dartInitFunctionDeclaration,
                        dartValueVariableDeclaration,
                        dartStepFunctionDeclaration,
                        *generateSteps {
                            clause.clause; count+1; stepFunctionName;
                            expand { accumulatedCapturables, capturables };
                        }];
            }
            case (is IfComprehensionClause) {
                value stepFunctionId
                    =   generateStepFunctionName(count);

                if (clause.conditions.conditions.every((c) => c is BooleanCondition)) {
                    // Simple case, no new variable declarations
                    value functionBody
                        =   [DartWhileStatement {
                                DartFunctionExpressionInvocation {
                                    prevStepFunction;
                                    DartArgumentList();
                                };
                                DartBlock {
                                    concatenate {
                                        dartVariableDefinitions {
                                            clause;
                                            accumulatedCapturables;
                                        },
                                        [DartIfStatement {
                                            generateBooleanDartCondition {
                                                clause.conditions.conditions.map {
                                                    asserted<BooleanCondition>;
                                                };
                                            };
                                            DartReturnStatement {
                                                DartBooleanLiteral(true);
                                            };
                                        }]
                                    };
                                };
                            },
                            DartReturnStatement {
                                DartBooleanLiteral(false);
                            }];

                    return
                    [createDartFunctionDeclarationStatement {
                        dartTypes.dartBool;
                        stepFunctionId;
                        dartFormalParameterListEmpty;
                        functionBody;
                    }, *generateSteps {
                        clause.clause;
                        count+1;
                        stepFunctionId;
                        accumulatedCapturables;
                    }];
                }

                // Non-Simple case, conditions may declare new variables.

                "Sequence of Tuples holding
                    - replacementDeclarations,
                    - tempDefinition,
                    - conditionExpression,
                    - replacementDefinitions"
                value conditionExpressionParts
                    =   clause.conditions.conditions.collect(generateConditionExpression);

                "ValueModels for all of the replacement declarations."
                value declarationModels
                    =   conditionExpressionParts
                            .flatMap((p) => p[2...])
                            .map(VariableTriple.declarationModel);

                "All of the replacement declarations."
                value dartVariableDeclarations
                    =   conditionExpressionParts
                            .flatMap((p) => p[2...])
                            .map(VariableTriple.dartDeclaration);

                "All of the 'outer' variables, to hold values outside of the function."
                value dartOuterVariableNames
                    =   declarationModels.collect {
                            compose {
                                DartSimpleIdentifier;
                                dartTypes.createTempName;
                            };
                        };

                value capturables
                    =   zipPairs(declarationModels, dartOuterVariableNames);

                "All of the tests and assignments, serialized."
                value dartTestsAndAssignments
                    =   conditionExpressionParts.flatMap {
                            (parts) => {
                                parts[0], // tmp variable definition
                                DartIfStatement {
                                    condition = DartPrefixExpression {
                                        "!"; parts[1];
                                    };
                                    DartContinueStatement();
                                },
                                // assign values (for new values or replacements)
                                *parts[2...].map(VariableTriple.dartAssignment)
                            }.coalesced;
                        };

                "A dart function declaration for the step function. This function

                 - Calls the previous step in a while loop to initialize values
                 - Evaluates each `Condition`'s test, immediately continuing the loop on
                   the first false
                 - Assigns newly declared/replaced values to outer variables for use
                   by subsequent steps"
                value dartStepFunctionDeclaration
                    =   createDartFunctionDeclarationStatement {
                            dartTypes.dartBool;
                            stepFunctionId;
                            dartFormalParameterListEmpty;
                            [DartWhileStatement {
                                DartFunctionExpressionInvocation {
                                    prevStepFunction;
                                    DartArgumentList();
                                };
                                DartBlock {
                                    concatenate {
                                        dartVariableDefinitions {
                                            clause;
                                            accumulatedCapturables;
                                        },
                                        dartVariableDeclarations,
                                        dartTestsAndAssignments,
                                        dartAssignmentsToOuterVariables {
                                            clause;
                                            capturables;
                                        },
                                        [DartReturnStatement {
                                            DartBooleanLiteral(true);
                                        }]
                                    };
                                };
                            },
                            DartReturnStatement {
                                DartBooleanLiteral(false);
                            }];
                        };

                return concatenate {
                    dartOuterVariableDeclarations(clause, capturables),
                    [dartStepFunctionDeclaration],
                    generateSteps {
                        clause.clause;
                        count+1;
                        stepFunctionId;
                        expand { accumulatedCapturables, capturables };
                    }
                };
            }
            case (is ExpressionComprehensionClause) {
                value stepFunctionId
                    =   generateStepFunctionName(count);

                "A function that performs the role of Iterator.next()"
                value dartStepFunctionDeclaration
                    =   createDartFunctionDeclarationStatement {
                            // not using expressionType; actual type is
                            // expressionType | Finished
                            dartTypes.dartObject;
                            stepFunctionId;
                            dartFormalParameterListEmpty;
                            concatenate {
                                // if the previous step returns false,
                                // return `finished`
                                [DartIfStatement {
                                    DartPrefixExpression {
                                        "!";
                                        DartFunctionExpressionInvocation {
                                            prevStepFunction;
                                            DartArgumentList();
                                        };
                                    };
                                    DartReturnStatement {
                                        // TODO Use generateInvocation to call finished?
                                        //      Not yet; finished is a toplevel.
                                        dartTypes.dartIdentifierForFunctionOrValue {
                                            that;
                                            ceylonTypes.finishedValueDeclaration;
                                            false;
                                        }[0];
                                    };
                                }],
                                dartVariableDefinitions {
                                    clause;
                                    accumulatedCapturables;
                                },
                                // evaluate and return the expression
                                [DartReturnStatement {
                                    // Effectively, this is the return for Iterator.next()
                                    // which is generic. So, lhs will be erased to a Dart
                                    // Object.
                                    withLhsNonNative {
                                        ceylonTypes.anythingType;
                                        () => clause.expression.transform {
                                            expressionTransformer;
                                        };
                                    };
                                }]
                            };
                        };

                "Return the function we just declared (but, as a Callable)"
                value outerReturn
                    =   DartReturnStatement {
                            // Easy. Until we reify generics.
                            DartInstanceCreationExpression {
                                false;
                                DartConstructorName {
                                    dartTypes.dartTypeNameForDartModel {
                                        that;
                                        dartTypes.dartCallableModel;
                                    };
                                    null;
                                };
                                DartArgumentList {
                                    [stepFunctionId];
                                };
                            };
                        };

                return [dartStepFunctionDeclaration, outerReturn];
            }
        }

        "The type of the Iterable we are creating and the return type of
         `dartFunctionIterableFactory`.

         Note: when we reify, we'll need to make sure the `Absent` type parameter is
         correct. It would also be better to have dartFunctionIterableFactory model
         information, and calculate the return type using a `FunctionModel`."
        value resultType = iterableComprehensionType(that);

        // Return a new Iterable based on a function that returns a
        // function that returns the elements of the comprehension.
        return
        withBoxing {
            that;
            resultType;
            null;
            DartFunctionExpressionInvocation {
                dartTypes.dartIdentifierForDartModel {
                    that;
                    dartTypes.dartFunctionIterableFactory;
                };
                DartArgumentList {
                    // Easy. Until we reify generics.
                    [DartInstanceCreationExpression {
                        false;
                        DartConstructorName {
                            dartTypes.dartTypeNameForDartModel {
                                that;
                                dartTypes.dartCallableModel;
                            };
                            null;
                        };
                        DartArgumentList {
                            [DartFunctionExpression {
                                dartFormalParameterListEmpty;
                                DartBlockFunctionBody {
                                    null; false;
                                    DartBlock {
                                        concatenate<DartStatement> {
                                            step0Statements,
                                            generateSteps {
                                                that.clause;
                                                1; step0FunctionId; {};
                                            }
                                        };
                                    };
                                };
                            }];
                        };
                    }];
                };
            };
        };
    }

    shared actual
    DartExpression transformSwitchCaseElseExpression(SwitchCaseElseExpression that) {
        value [switchedType, switchedVariable, variableDeclaration]
            =   generateForSwitchClause(that.clause);

        "Recursive function to generate an if statement for the switch clauses."
        DartStatement generateIf({CaseExpression|Expression*} clauses) {
            switch (clause = clauses.first)
            case (is CaseExpression) {
                switch (caseItem = clause.caseItem)
                case (is MatchCase) {
                    return
                    DartIfStatement {
                        generateMatchCondition {
                            that;
                            switchedType;
                            switchedVariable;
                            caseItem.expressions;
                        };
                        thenStatement = DartReturnStatement {
                            clause.expression.transform(this);
                        };
                        elseStatement = generateIf(clauses.rest);
                    };
                }
                case (is IsCase) {
                    value variableDeclaration
                        =   IsCaseInfo(caseItem).variableDeclarationModel;

                    "Narrowed variable for case block, if any."
                    value replacementVariable
                        =   if (exists variableDeclaration) then
                                generateReplacementVariableDefinition {
                                    that; variableDeclaration;
                                }
                            else
                                [];

                    return
                    DartIfStatement {
                        generateIsExpression {
                            that;
                            switchedVariable;
                            TypeInfo(caseItem.type).typeModel;
                        };
                        thenStatement = DartBlock {
                            concatenate {
                                replacementVariable,
                                [DartReturnStatement {
                                    clause.expression.transform(this);
                                }]
                            };
                        };
                        elseStatement = generateIf(clauses.rest);
                    };
                }
            }
            case (is Expression) {
                return DartReturnStatement {
                    clause.transform(this);
                };
            }
            case (is Null) {
                return
                DartExpressionStatement {
                    DartThrowExpression {
                        DartInstanceCreationExpression {
                            const = false;
                            DartConstructorName {
                                dartTypes.dartTypeName {
                                    that;
                                    ceylonTypes.assertionErrorType;
                                    false; false;
                                };
                            };
                            DartArgumentList {
                                [DartSimpleStringLiteral {
                                    "Supposedly exhaustive switch was not exhaustive";
                                }];
                            };
                        };
                    };
                };
            }
        }

        value ifStatement = generateIf(
                that.children.rest.narrow<CaseExpression|Expression>());

        return
        DartFunctionExpressionInvocation {
            DartFunctionExpression {
                DartFormalParameterList();
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        [variableDeclaration, ifStatement];
                    };
                };
            };
            DartArgumentList { []; };
        };
    }

    shared actual
    see(`function StatementTransformer.transformIfElse`)
    DartExpression transformIfElseExpression(IfElseExpression that) {


        // Create a function expression for the IfElseExpression and invoke it.
        // No need for `withLhs` or `withBoxing`; our parent should have set the
        // lhs, and child transformations should perform boxing.
        //
        // Alternately, we could wrap in withBoxing, and perform each transformation
        // inside withLhs, but that would run the risk of unnecessary boxing/unboxing ops.

        if (that.conditions.conditions.every((c) => c is BooleanCondition)) {
            // simple case, no variable declarations
            return
            DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    DartFormalParameterList();
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            [DartIfStatement {
                                generateBooleanDartCondition {
                                    that.conditions.conditions.map {
                                        asserted<BooleanCondition>;
                                    };
                                };
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

        value info = IfElseExpressionInfo(that);

        value doElseVariable // always exists for expressions
            =   DartSimpleIdentifier(dartTypes.createTempNameCustom("doElse"));

        "Narrowed variable for else block, if any."
        value elseReplacementVariable
            =   if (exists variableDeclaration =
                        info.elseVariableDeclarationModel)
                then generateReplacementVariableDefinition(that, variableDeclaration)
                else [];

        value statements = LinkedList<DartStatement?>();

        // declare doElse variable (always present for if expressions)
        statements.add {
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartBool;
                    [DartVariableDeclaration {
                        doElseVariable;
                        DartBooleanLiteral(true);
                    }];
                };
            };
        };

        "Recursive function to generate nested if statements, one if per condition."
        [DartStatement+] generateIf([Condition+] conditions, Boolean outermost = false) {

            value [tempDefinition, conditionExpression, *replacements]
                =   generateConditionExpression(conditions.first);

            value result
                =   [tempDefinition,
                    DartIfStatement {
                        conditionExpression;
                        DartBlock {
                            concatenate {
                                // declare and define new variables, if any
                                replacements.map(VariableTriple.dartDeclaration),
                                replacements.map(VariableTriple.dartAssignment),

                                // nest if statement for next condition, if any
                                if (nonempty rest = conditions.rest) then
                                    generateIf(rest)
                                else [
                                    // last condition; output if block statements
                                    DartExpressionStatement {
                                        DartAssignmentExpression {
                                            doElseVariable;
                                            DartAssignmentOperator.equal;
                                            DartBooleanLiteral(false);
                                        };
                                    },
                                    DartReturnStatement {
                                        that.thenExpression.transform(this);
                                    }
                                ]
                            };
                        };
                        // TODO if outermost, and there is only one condition, optimize
                        //      away the doElseVariable and put "else" block here.
                    }].coalesced.sequence();

            assert(nonempty result);

            // wrap in a block to scope temp variable, if exists
            return if (exists tempDefinition)
                then [DartBlock(result)]
                else result;
        }

        statements.addAll(generateIf(that.conditions.conditions));

        statements.add {
            DartIfStatement {
                doElseVariable;
                DartBlock {
                    concatenate {
                        elseReplacementVariable,
                        [DartReturnStatement {
                            that.elseExpression.transform(this);
                        }]
                    };
                };
            };
        };

        return
        DartFunctionExpressionInvocation {
            DartFunctionExpression {
                DartFormalParameterList();
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        statements.coalesced.sequence();
                    };
                };
            };
            DartArgumentList { []; };
        };
    }

    shared actual
    DartExpression transformPackage(Package that)
        // Should never be called; handled by transformQualifiedExpression
        // and transformInvocation.
        =>  super.transformPackage(that);

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
        assert (exists outerDeclaration = getContainingClassOrInterface(container(ci)));
        value outerIdentifier = dartTypes.identifierForOuter(outerDeclaration);

        return withBoxing {
            that;
            info.typeModel;
            rhsDeclaration = null; // the field is synthetic
            if (ci is InterfaceModel) then
                // static implementations for interface methods need $this
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$this");
                    outerIdentifier;
                }
            else
                outerIdentifier;
        };
    }

    shared actual default
    DartExpression transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node (ExpressionTransformer): '``className(that)``'");
    }

    DartFunctionDeclarationStatement createDartFunctionDeclarationStatement(
            DartTypeName returnType,
            DartSimpleIdentifier name,
            DartFormalParameterList parameterList,
            [DartStatement*] statements)
        =>  DartFunctionDeclarationStatement {
                DartFunctionDeclaration {
                    false;
                    returnType;
                    null;
                    name;
                    DartFunctionExpression {
                        parameterList;
                        DartBlockFunctionBody {
                            null; false;
                            DartBlock {
                                statements;
                            };
                        };
                    };
                };
            };
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
