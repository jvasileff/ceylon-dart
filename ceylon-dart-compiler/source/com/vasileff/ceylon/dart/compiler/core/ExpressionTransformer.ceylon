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
    ExpressionComprehensionClause,
    TypeNameWithTypeArguments,
    PositionalArguments,
    NamedArguments,
    Meta,
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList
}
import ceylon.language.meta {
    type
}

import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ValueModel=Value,
    TypeModel=Type,
    ClassOrInterfaceModel=ClassOrInterface,
    ClassModel=Class,
    InterfaceModel=Interface,
    ConstructorModel=Constructor
}
import com.vasileff.ceylon.dart.compiler {
    DScope
}
import com.vasileff.ceylon.dart.compiler.dartast {
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
    DartContinueStatement,
    DartExpressionFunctionBody,
    createExpressionEvaluationWithSetup,
    createInlineDartStatements,
    createNullSafeExpression
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
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
    UnspecifiedVariableInfo,
    NodeInfo,
    TypeNameWithTypeArgumentsInfo
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
            BaseExpression | QualifiedExpression that,
            NameWithTypeArguments nameAndArgs,
            DeclarationModel targetDeclaration) {

        value info = ExpressionInfo(that);

        switch (nameAndArgs)
        case (is MemberNameWithTypeArguments) {
            if (!is ValueModel | FunctionModel targetDeclaration) {
                addError(that,
                    "Unexpected declaration type for base expression: \
                     ``className(targetDeclaration)``");
                return DartNullLiteral();
            }

            // Is this a Function that's really a Constructor?
            if (is FunctionModel targetDeclaration,
                exists constructorModel = getConstructor(targetDeclaration)) {
                // generateNewCallable() can handle constructors and will take care
                // of the implicit `outer` argument if the constructor's class is a
                // member class.

                // Return a Callable that returns an instance of a class:
                return generateNewCallable {
                    info;
                    constructorModel;
                };
            }

            // Be sure to detect *all* true, false, and null literals here, even if they
            // have been narrowed to something like `Null & Element`. Otherwise,
            // replacements won't be handled here and we'll end up with too much casting
            // (true, false, and null don't require casts, so `withBoxing` is not used.)
            value originalDeclaration
                =   dartTypes.declarationConsideringElidedReplacements(targetDeclaration);

            if (ceylonTypes.isBooleanTrueValueDeclaration(originalDeclaration)) {
                return generateBooleanExpression(
                        info, ctx.assertedLhsErasedToNativeTop, true);
            }
            else if (ceylonTypes.isBooleanFalseValueDeclaration(originalDeclaration)) {
                return generateBooleanExpression(
                        info, ctx.assertedLhsErasedToNativeTop, false);
            }
            else if (ceylonTypes.isNullValueDeclaration(originalDeclaration)) {
                return DartNullLiteral();
            }

            switch (targetDeclaration)
            case (is ValueModel) {
                // We always invoke values... to obtain the value.
                return withBoxing {
                    info;
                    info.typeModel;
                    targetDeclaration;
                    dartTypes.invocableForBaseExpression {
                        info;
                        targetDeclaration;
                        false;
                    }.expressionForInvocation();
                };
            }
            case (is FunctionModel) {
                if (targetDeclaration.parameter) {
                    // The Callable parameter, which is not erased.
                    //
                    // `withBoxing` cannot be used when taking a reference to a callable
                    // parameter, since the logic for `Function` declarations is to
                    // consider the *return* type of the `Callable`, but here, we're
                    // concerned about the `Callable` value itself.
                    return withBoxingCustom {
                        info;
                        info.typeModel;
                        false;
                        // erased-to-object if defaulted
                        targetDeclaration.initializerParameter.defaulted;
                        dartTypes.invocableForBaseExpression {
                            info;
                            targetDeclaration;
                        }.expressionForInvocation();// it's a value, so we "invoke" it.
                    };
                }
                else {
                    // A newly created Callable, which is not erased
                    return withBoxingNonNative {
                        info;
                        info.typeModel;
                        generateNewCallable {
                            info;
                            targetDeclaration;
                        };
                    };
                }
            }
        }
        case (is TypeNameWithTypeArguments) {
            // Return a `Callable` that takes the same arguments as the class
            // initializer and returns an instance of the class.

            value typeNameInfo = TypeNameWithTypeArgumentsInfo(nameAndArgs);

            "BaseExpressions to types are references to classes."
            assert (is ClassModel declaration = typeNameInfo.declarationModel);

            // Note: if `declaration` is not toplevel, the Dart constructor may need
            // some outers and captures. `generateNewCallable` will take care of that.
            return generateNewCallable {
                info;
                declaration;
            };
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
            addError(that, "Spread member operator not yet supported");
            return DartNullLiteral();
        }

        value info
            =   QualifiedExpressionInfo(that);

        value receiverInfo
            =   switch (receiver = that.receiverExpression)
                case (is BaseExpression) BaseExpressionInfo(receiver)
                case (is QualifiedExpression) QualifiedExpressionInfo(receiver)
                else ExpressionInfo(receiver);

        value memberDeclaration
            =   if (is FunctionModel d = info.declaration,
                    is ConstructorModel constructor = d.type.declaration) then
                    // Constructors are presented as Functions, but lets use the
                    // Constructor declaration instead.
                    constructor
                else
                    info.declaration;

        value memberContainer
            =   memberDeclaration.container;

        "What else would the container be than a Class or Interface?"
        assert (is ClassModel | InterfaceModel memberContainer);

        if (info.staticMethodReference) {
            "The receiver of a qualified expression that is a static reference will
             be a BaseExpression or QualifiedExpression."
            assert (is BaseExpressionInfo | QualifiedExpressionInfo receiverInfo);

            "The target of the receiver expression of a qualified expression that is
             a static member reference will be a Type, since the receiver is a class or
             interface."
            assert (is TypeModel containerType
                =   switch (receiverInfo)
                    case (is BaseExpressionInfo) receiverInfo.target
                    case (is QualifiedExpressionInfo) receiverInfo.target);

            switch (memberDeclaration)
            case (is ValueModel) {
                // Return a Callable that takes a `containerType` and returns the result
                // of the invocation of memberDeclaration

                "The type of the value member."
                value memberReturnType
                    =   info.target.type;

                "The invocation of `memberDeclaration` on `$r` which is the
                 parameter to the `Callable`."
                value invocation
                    =   withLhsNonNative {
                            memberReturnType;
                            () => generateInvocation {
                                info;
                                memberReturnType;
                                containerType;
                                generateReceiver()
                                    =>  withBoxingNonNative {
                                            info;
                                            // Callable argument; erasedToObject
                                            ceylonTypes.anythingType;
                                            DartSimpleIdentifier("$r");
                                        };
                                memberDeclaration;
                            };
                        };

                "A Dart function that takes a receiver of `containerType` and returns
                 the result of the invoking `memberDeclaration` on the receiver."
                value outerFunction
                    =   DartFunctionExpression {
                            DartFormalParameterList {
                                true; false;
                                // takes the container
                                [DartSimpleFormalParameter {
                                    false; false;
                                    // dartObject since Callable is generic
                                    dartTypes.dartObject;
                                    DartSimpleIdentifier("$r");
                                }];
                            };
                            DartExpressionFunctionBody {
                                false;
                                invocation;
                            };
                        };

                // The Callable that takes a `containerType`
                return createCallable(info, outerFunction);
            }
            case (is FunctionModel | ClassModel | ConstructorModel) {
                if (is ConstructorModel memberDeclaration,
                    is BaseExpressionInfo receiverInfo) {

                    // The receiver is a BaseExpression, which is *never* itself a
                    // staticMethodReference, and can therefore provide its own `outer`
                    // if it is a member class. (Something like `Foo.create`, and if
                    // `Foo` is a member class, the expression will be in the scope of
                    // the container to use for the `Foo`.)

                    // So, this is a staticMethodReference to the *Constructor*, but it
                    // is not a static reference to the constructor's container.

                    // GenerateNewCallable will provide the necessary `outer` reference.
                    // The returned value will be a Callable for the constructor,
                    // rather than a Callable that takes an `outer` and returns a
                    // callable for the constructor.
                    return generateNewCallable {
                        info;
                        memberDeclaration;
                    };
                }

                // Return a `Callable` that takes a `containerType` and returns a
                // `Callable` that can be used to invoke the `memberDeclaration`

                "A Callable that invokes `memberDeclaration`."
                value innerCallable
                    =   generateNewCallableForQualifiedExpression {
                            info;
                            containerType;
                            generateReceiver()
                                =>  withBoxingNonNative {
                                        info;
                                        // Callable argument; erasedToObject
                                        ceylonTypes.anythingType;
                                        DartSimpleIdentifier("$r");
                                    };
                            false;
                            memberDeclaration;
                            info.target.fullType;
                            that.memberOperator;
                        };

                "A Dart function that takes a receiver of `containerType` and returns
                 a Callable that invokes `memberDeclaration`."
                value outerFunction
                    =   DartFunctionExpression {
                            DartFormalParameterList {
                                true; false;
                                // takes the container
                                [DartSimpleFormalParameter {
                                    false; false;
                                    // dartObject since Callable is generic
                                    dartTypes.dartObject;
                                    DartSimpleIdentifier("$r");
                                }];
                            };
                            DartExpressionFunctionBody {
                                false;
                                innerCallable;
                            };
                        };

                // The Callable that takes a `containerType`
                return createCallable(info, outerFunction);
            }
            else {
                addError(that,
                    "Unsupported type member type for qualified expression: "
                    + type(memberDeclaration).string);
                return DartNullLiteral();
            }
        }

        // The QualifiedExpression expression is *not* a static member reference
        switch (memberDeclaration)
        case (is ValueModel) {
            // Return an expression that will yield the value
            // See transformInvocation()

            if (exists superType = denotableSuperType(that.receiverExpression)) {
                // QualifiedExpression with a `super` receiver
                return generateInvocation {
                    info;
                    info.typeModel;
                    superType;
                    null;
                    memberDeclaration;
                    null;
                    that.memberOperator;
                };
            }
            else {
                // Boring case
                return generateInvocation {
                    info;
                    info.typeModel;
                    receiverInfo.typeModel;
                    () => that.receiverExpression.transform(this);
                    memberDeclaration;
                    null;
                    that.memberOperator;
                };
            }
        }
        case (is FunctionModel) {
            // Return a new Callable.

            // QualifiedExpression with a `super` receiver
            if (exists superType = denotableSuperType(that.receiverExpression)) {
                return generateNewCallableForQualifiedExpression {
                    info;
                    superType;
                    null;
                    false;
                    memberDeclaration;
                    info.typeModel;
                    that.memberOperator;
                };
            }

            // QualifiedExpression with a non-`super` receiver
            return generateNewCallableForQualifiedExpression {
                info;
                receiverInfo.typeModel;
                () => that.receiverExpression.transform(this);
                !isConstant(that.receiverExpression);
                memberDeclaration;
                info.typeModel;
                that.memberOperator;
            };
        }
        else {
            addError(that,
                "Unsupported member type for qualified expression: \
                 ``type(memberDeclaration)``");
            return DartNullLiteral();
        }
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(dScope(that),
                ceylonTypes.floatType, null,
                DartDoubleLiteral(parseCeylonFloat(that.text)));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(dScope(that),
                ceylonTypes.integerType, null,
                DartIntegerLiteral(parseCeylonInteger(that.text)));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        // FIXME proper parsing/handling of escape sequences
        =>  withBoxing(dScope(that),
                ceylonTypes.stringType, null,
                DartSimpleStringLiteral(that.text));

    shared actual
    DartExpression transformCharacterLiteral(CharacterLiteral that)
        // FIXME proper parsing/handling of escape sequences
        =>  withBoxing(dScope(that),
                ceylonTypes.characterType, null,
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeName {
                            dScope(that);
                            ceylonTypes.characterType;
                            false; false;
                        };
                        DartSimpleIdentifier("$fromInt");
                    };
                    DartArgumentList {
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
                return generateInvocationFromName(info, e, "string", []);
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
            dScope(that);
            ceylonTypes.stringType;
            null;
            unboxed;
        };
    }

    shared actual
    DartExpression transformTuple(Tuple that)
        =>  generateTuple {
                ExpressionInfo(that);
                that.argumentList.listedArguments;
                that.argumentList.sequenceArgument;
            };

    shared actual
    DartExpression transformIterable(Iterable that)
        =>  generateIterable {
                ExpressionInfo(that);
                that.argumentList.listedArguments;
                that.argumentList.sequenceArgument;
            };

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

        value invokedInfo
            =   switch (invoked = that.invoked)
                case (is BaseExpression)
                    BaseExpressionInfo(invoked)
                case (is QualifiedExpression)
                    QualifiedExpressionInfo(invoked)
                else
                    ExpressionInfo(invoked);

        DeclarationModel? invokedDeclaration
            =   let (d = switch (invoked = that.invoked)
                           case (is BaseExpression)
                                BaseExpressionInfo(invoked).declaration
                           case (is QualifiedExpression)
                                QualifiedExpressionInfo(invoked).declaration
                           else
                                null) // some other expression that yields a Callable
                // Constructor invocations present the invoked as a Function,
                // but let's use the Constructor declaration.
                replaceFunctionWithConstructor(d);

        "Generate an invocation on `ValueModel`s, or `FunctionModel`s for Callable
         parameters, which are implemented as Callable values. This function is called
         a few places in the main `switch` statement below.

         Note: this function can also be used as a fallback or unoptimized code path,
         relying on [[transformBaseExpression]] and [[transformQualifiedExpression]] to
         generate `Callable`s via `that.invoked.transform(this)` which are then
         immediately invoked."
        function indirectInvocationOnCallable() {

            "NamedArguments not supported for indirect invocations."
            assert (!is NamedArguments arguments = that.arguments);

            value [argumentList, hasSpread]
                =   generateArgumentListForIndirectInvocation(arguments.argumentList);

            // Callables (being generic) always erase to `core.Object`.
            // We don't have a declaration to to use, so explicitly
            // specify erasure:
            return
            withBoxingCustom {
                info;
                info.typeModel;
                rhsErasedToNative = false;
                rhsErasedToObject = true;
                DartFunctionExpressionInvocation {
                    // resolve the f/s property of the Callable
                    DartPropertyAccess {
                        withLhsDenotable {
                            ceylonTypes.callableDeclaration;
                            () => that.invoked.transform(this);
                        };
                        DartSimpleIdentifier {
                            if (hasSpread) then "s" else "f";
                        };
                    };
                    argumentList;
                };
            };
        }

        "The subtypes of FunctionOrValueModel, ClassModel, and ConstructorModel, with
         Null for expressions to Callables, and excluding SetterModel"
        assert (is FunctionModel | ValueModel | ClassModel | ConstructorModel
                    | Null invokedDeclaration);

        value signature
            =   CeylonList {
                    ctx.unit.getCallableArgumentTypes(invokedInfo.typeModel);
                };

        if (is FunctionModel | ValueModel invokedDeclaration,
                !invokedDeclaration.shared,
                // callable parameters are local values!
                !invokedDeclaration.parameter,
                is InterfaceModel invokedContainer
                    =   container(invokedDeclaration),
                is BaseExpression invoked
                    =   that.invoked) {

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
                            invokedContainer;
                        };
                    };

            value [argsSetup, argumentList]
                =   generateArgumentListFromArguments {
                        info;
                        that.arguments;
                        signature;
                        invokedDeclaration;
                    };

            return
            createExpressionEvaluationWithSetup {
                argsSetup;
                withBoxing {
                    info;
                    info.typeModel;
                    invokedDeclaration;
                    DartFunctionExpressionInvocation {
                        // qualified reference to the static interface method
                        DartPropertyAccess {
                            dartTypes.dartIdentifierForClassOrInterface {
                                info;
                                invokedContainer;
                            };
                            DartSimpleIdentifier {
                                dartTypes.getStaticInterfaceMethodName(invokedDeclaration);
                            };
                        };
                        DartArgumentList {
                            concatenate {
                                [thisExpression],
                                argumentList.arguments
                            };
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

            // QualifiedExpression with a `super` receiver
            if (is QualifiedExpression invoked,
                exists superType = denotableSuperType(invoked.receiverExpression)) {

                return generateInvocation {
                    info;
                    info.typeModel;
                    superType;
                    null;
                    invokedDeclaration;
                    signatureAndArguments = [
                        signature,
                        that.arguments
                    ];
                    invoked.memberOperator;
                };
            }
            // Other QualifiedExpressions, but exclude those w/Package "receivers";
            // they are more like BaseExpressions
            else if (is QualifiedExpression invoked,
                    !invoked.receiverExpression is Package) {

                value invokedQEInfo = QualifiedExpressionInfo(invoked);

                if(invokedQEInfo.staticMethodReference) {
                    // Note: Needs optimization! This causes a Callable to be created for
                    // the function ref, which is immediately invoked with the argument,
                    // returning a Callable that can be used to invoke the now bound
                    // method.
                    return(indirectInvocationOnCallable());
                }

                value receiverInfo = ExpressionInfo(invoked.receiverExpression);

                return generateInvocation {
                    info;
                    info.typeModel;
                    receiverInfo.typeModel;
                    () => receiverInfo.node.transform(this);
                    invokedDeclaration;
                    signatureAndArguments = [
                        signature,
                        that.arguments
                    ];
                    invoked.memberOperator;
                };
            }
            // BaseExpression or QualifiedExpression w/Package "receiver"
            else {
                if (invokedDeclaration.parameter) {
                    // Invoking a Callable parameter
                    return indirectInvocationOnCallable();
                }
                else {
                    value [argsSetup, argumentList]
                        =   generateArgumentListFromArguments {
                                info;
                                that.arguments;
                                signature;
                                invokedDeclaration;
                            };

                    return
                    createExpressionEvaluationWithSetup {
                        argsSetup;
                        withBoxing {
                            info;
                            info.typeModel;
                            // If there are multiple parameter lists, the function returns a
                            // Callable, not the ultimate return type as advertised by the
                            // declaration.
                            invokedDeclaration.parameterLists.size() == 1
                                then invokedDeclaration;
                            dartTypes.invocableForBaseExpression {
                                info;
                                invokedDeclaration;
                            }.expressionForInvocation {
                                argumentList;
                            };
                        };
                    };
                }
            }
        }
        case (is ValueModel?) {
            return indirectInvocationOnCallable();
        }
        case (is ClassModel | ConstructorModel) {
            assert (is ClassModel classModel
                =   switch (invokedDeclaration)
                    case (is ClassModel) invokedDeclaration
                    case (is ConstructorModel) invokedDeclaration.container);

            "that.invoked will be a BaseExpression or QualifiedExpression, even for
             constructors of toplevel classes, where a BaseExpression may be used for
             the constructor from within the class."
            assert (is BaseExpression | QualifiedExpression invoked = that.invoked);

            // Peel back a layer if this is a constructor invocation; invoked.receiver
            // for constructor invocations is basically the same as invoked for class
            // initializer invocations.

            "The invoked expression will always be a BaseExpression
             or QualifiedExpression"
            assert (is BaseExpression | QualifiedExpression | Null classInvoked
                =   switch (invokedDeclaration)
                    case (is ClassModel)
                        invoked
                    case (is ConstructorModel)
                        if (is QualifiedExpression invoked)
                        then invoked.receiverExpression
                        else null);

            if (is BaseExpression? classInvoked) {
                // Handle the following cases:
                //
                // - Constructor called from within the class (Null case), or
                // - Constructor of a toplevel class, or
                // - Constructor of member class called from within
                //   scope of `outer`, so no explicit receiver, or
                // - Class initializer of a toplevel class, or
                // - Class initializer of member class called from within
                //   scope of `outer`, so no explicit receiver.

                value captureArguments
                    =   generateArgumentsForOuterAndCaptures {
                            info;
                            classModel;
                        };

                value [argsSetup, argumentList]
                    =   generateArgumentListFromArguments {
                            info;
                            that.arguments;
                            signature;
                            invokedDeclaration;
                        };

                return
                createExpressionEvaluationWithSetup {
                    argsSetup;
                    withBoxingNonNative {
                        info;
                        info.typeModel;
                        DartInstanceCreationExpression {
                            false;
                            dartTypes.dartConstructorName {
                                info;
                                invokedDeclaration;
                            };
                            DartArgumentList {
                                concatenate {
                                    captureArguments,
                                    argumentList.arguments
                                };
                            };
                        };
                    };
                };
            }

            "We already handled the BaseExpression cases."
            assert (!is BaseExpression invoked);

            value invokedQEInfo = QualifiedExpressionInfo(classInvoked);

            if (invokedQEInfo.staticMethodReference) {
                // Invoking a member class, statically. Just return a callable. It's
                // possible that the callable we return will immediately be called
                // with args to construct the class. Not optimizing this now.
                "Named arguments not allowed for indirect invocations per spec."
                assert (is PositionalArguments positionalArguments = that.arguments);

                if (positionalArguments.argumentList.sequenceArgument exists) {
                    // TODO support sequence argument (a single element Tuple...)
                    //      This is:
                    //          class A() {
                    //              shared class B() {}
                    //          }
                    //          A.B() b = A.B(*[A()]);
                    addError(that, "Sequence arguments not yet supported on static \
                                    invocations of member classes");
                    return DartNullLiteral();
                }

                "There must be a single argument, which is the container (outer)."
                assert (exists argument
                    =   positionalArguments.argumentList.listedArguments.first);

                return
                generateNewCallableForQualifiedExpression {
                    info;
                    ExpressionInfo(argument).typeModel;
                    () => argument.transform(expressionTransformer);
                    !isConstant(argument);
                    invokedDeclaration;
                    info.typeModel;
                    null;
                };
            }

            // Normal case, receiver is an object.

            value receiverInfo = ExpressionInfo(invoked.receiverExpression);

            return generateInvocation {
                info;
                info.typeModel;
                receiverInfo.typeModel;
                () => classInvoked.receiverExpression.transform(expressionTransformer);
                invokedDeclaration;
                signatureAndArguments = [
                    signature,
                    that.arguments
                ];
                invoked.memberOperator;
            };
        }
    }

    shared actual
    DartExpression transformElementOrSubrangeExpression
            (ElementOrSubrangeExpression that) {

        switch (subscript = that.subscript)
        case (is KeySubscript) {
            if (ceylonTypes.isCeylonList(ExpressionInfo(that.primary).typeModel)) {
                return
                generateInvocationFromName {
                    dScope(that);
                    that.primary;
                    "getFromFirst";
                    [subscript.key];
                    ExpressionInfo(that).typeModel;
                };
            }
            else {
                return
                generateInvocationFromName {
                    dScope(that);
                    that.primary;
                    "get";
                    [subscript.key];
                    ExpressionInfo(that).typeModel;
                };
            }
        }
        case (is SpanSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "span";
                [subscript.from, subscript.to];
                ExpressionInfo(that).typeModel;
            };
        }
        case (is MeasureSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "measure";
                [subscript.from, subscript.length];
                ExpressionInfo(that).typeModel;
            };
        }
        case (is SpanFromSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "spanFrom";
                [subscript.from];
                ExpressionInfo(that).typeModel;
            };
        }
        case (is SpanToSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "spanTo";
                [subscript.to];
                ExpressionInfo(that).typeModel;
            };
        }
    }

    shared actual
    DartExpression transformObjectExpression(ObjectExpression that) {
        value info = ObjectExpressionInfo(that);

        that.transform(topLevelVisitor);

        return
        generateObjectInstantiation {
            dScope(info, info.scope.container);
            info.anonymousClass;
        };
    }

    shared actual
    DartExpression transformFunctionExpression(FunctionExpression that)
        // FunctionExpressions are always wrapped in a Callable, although we probably
        // could optimize for expressions that are immediately invoked
        =>  let (info = FunctionExpressionInfo(that))
            generateNewCallable(
                info,
                info.declarationModel,
                generateFunctionExpression(that), 0, false);

    DartExpression generateBooleanExpression(
            DScope scope,
            Boolean native,
            "The value to produce"
            Boolean boolean)
        =>  if (native) then
                DartBooleanLiteral(boolean)
            else if (boolean) then
                dartTypes.dartInvocable(scope,
                    ceylonTypes.booleanTrueValueDeclaration).expressionForInvocation()
            else
                dartTypes.dartInvocable(scope,
                    ceylonTypes.booleanFalseValueDeclaration).expressionForInvocation();

    shared actual
    DartExpression transformExistsOperation(ExistsOperation that)
        =>  let (info = NodeInfo(that),
                 operandInfo = ExpressionInfo(that.operand))
            withBoxing {
                info;
                ceylonTypes.booleanType;
                null;
                generateExistsExpression {
                    info;
                    operandInfo.typeModel;
                    // no declaration; native, if possible
                    null;
                    withLhsNative {
                        operandInfo.typeModel;
                        () => that.operand.transform(this);
                    };
                };
            };

    shared actual
    DartExpression transformIsOperation(IsOperation that)
        =>  let (info = NodeInfo(that),
                 operandInfo = ExpressionInfo(that.operand))
            withBoxing {
                info;
                ceylonTypes.booleanType;
                null;
                generateIsExpression {
                    info;
                    operandInfo.typeModel;
                    // no declaration; native, if possible
                    null;
                    withLhsNative {
                        operandInfo.typeModel;
                        () => that.operand.transform(this);
                    };
                    TypeInfo(that.type).typeModel;
                };
            };

    shared actual
    DartExpression transformNonemptyOperation(NonemptyOperation that)
        =>  let (info = NodeInfo(that),
                 operandInfo = ExpressionInfo(that.operand))
            withBoxing {
                info;
                ceylonTypes.booleanType;
                null;
                generateNonemptyExpression {
                    info;
                    operandInfo.typeModel;
                    // no declaration; native, if possible
                    null;
                    withLhsNative {
                        operandInfo.typeModel;
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
                NodeInfo(that);
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

        value info = NodeInfo(that);

        return
        generateAssignmentExpression {
            info;
            operand;
            () => generateInvocationFromName {
                info;
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

        value info = NodeInfo(that);

        // the expected type after boxing
        TypeModel tempVarType;

        switch (lhsTypeTop = ctx.lhsTypeTop)
        case (is NoType) {
            // no need to save and return original value
            return
            generateAssignmentExpression {
                info;
                operand;
                () => generateInvocationFromName {
                    info;
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
                    info;
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
                    info;
                    operand;
                    () => generateInvocationFromName {
                        info;
                        that.operand;
                        method;
                        [];
                    };
                };
            },
            // return the saved value
            DartReturnStatement {
                withBoxingCustom {
                    info;
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
                NodeInfo(that);
                that.leftOperand;
                methodName;
                [that.rightOperand];
            };

    shared actual
    DartExpression transformArithmeticOperation(ArithmeticOperation that)
        =>  let (info = ExpressionInfo(that),
                 methodName = switch(that)
                        case (is ExponentiationOperation) "power"
                        case (is ProductOperation) "times"
                        case (is QuotientOperation) "divided"
                        case (is RemainderOperation) "remainder"
                        case (is SumOperation) "plus"
                        case (is DifferenceOperation) "minus")
            if (ceylonTypes.isCeylonFloat(info.typeModel)) then
                // The receiver type may be `Float` despite the lhs
                // possibly being `Integer`!
                generateInvocationSynthetic {
                    info;
                    ceylonTypes.floatType;
                    () => that.leftOperand.transform(expressionTransformer);
                    methodName;
                    [that.rightOperand];
                }
            else
                generateInvocationForBinaryOperation(that, methodName);

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
            ceylonTypes.union {
                firstInfo.typeModel,
                lastInfo.typeModel
            }.getSupertype(ceylonTypes.enumerableDeclaration);

        // Determine element type (the `T`)
        assert(exists elementType = ceylonTypes.typeArgument(enumerableType));

        // Signature type for `span<elementType>`
        value signature = [elementType, elementType];

        return generateTopLevelInvocation {
            info;
            info.typeModel;
            ceylonTypes.spanFunctionDeclaration;
            [signature, [that.first, that.last]];
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

        // Signature type for `measure<elementType>`
        value signature = [elementType, ceylonTypes.integerType];

        return generateTopLevelInvocation {
            info;
            info.typeModel;
            ceylonTypes.measureFunctionDeclaration;
            [signature, [that.first, that.size]];
        };
    }

    shared actual
    DartExpression transformEntryOperation(EntryOperation that)
        =>  let (info = NodeInfo(that))
            withBoxingNonNative {
                info;
                ExpressionInfo(that).typeModel;
                DartInstanceCreationExpression {
                    false;
                    dartTypes.dartConstructorName {
                        info;
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
        =>  let (info = NodeInfo(that))
            generateInvocationFromName {
                info;
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
        =>  withBoxing {
                dScope(that);
                ceylonTypes.booleanType;
                null;
                DartPrefixExpression {
                    "!";
                    withLhsNative {
                        ceylonTypes.booleanType;
                        () => generateInvocationForBinaryOperation(that, "equals");
                    };
                };
            };

    shared actual
    DartExpression transformIdenticalOperation(IdenticalOperation that)
        =>  let (info = NodeInfo(that))
            withBoxing {
                info;
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
        =>  let (info = NodeInfo(that),
                 dartOperator =
                    switch (that)
                    case (is AndOperation) "&&"
                    case (is OrOperation) "||")

            withBoxing {
                info;
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
    DartExpression transformElseOperation(ElseOperation that) {
        // The current `ctx.lhsTypeTop` or `ctx.lhsDenotableTop` is non-Null, given
        // that this is an else operation. But our left operand is potentially null.

        // It's true that Dart doesn't have null safe types, but evaluating the left
        // operand with a non-nullable lhsType may result in unnecessary casting from
        // Sub? to Super, in some cases.

        value info
            =   ExpressionInfo(that);

        // Find out what type the result of this elseOperation will be assigned to
        value [lhsType, lhsNative, lhsObject]
            =   contextLhsTypeForRhs(info.typeModel);

        "A Nullable version of the ultimate type of this elseOperation to use as the
         result type of the left operand expression (which of course may be null)"
        value nullableLhsType
            =   switch (lhsType)
                case (is NoType)
                    ceylonTypes.anythingType
                case (is  TypeModel)
                    ceylonTypes.union {
                        lhsType,
                        ceylonTypes.nullType
                };

        value parameterIdentifier
            =   DartSimpleIdentifier("$lhs$");

        return
        createNullSafeExpression {
            parameterIdentifier;
            // The result of the leftOperand transformation should be this type:
            parameterType = dartTypes.dartTypeName {
                info;
                nullableLhsType;
                lhsNative;
                lhsObject;
            };
            maybeNullExpression = withLhsCustom {
                nullableLhsType;
                lhsNative;
                lhsObject;
                () => that.leftOperand.transform(this);
            };
            // The current withLhs context is fine for the right operand
            ifNullExpression = that.rightOperand.transform(this);
            ifNotNullExpression = parameterIdentifier;
        };
    }

    shared actual
    DartExpression transformAssignOperation(AssignOperation that) {
        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        // passthrough; no new lhs
        return generateAssignmentExpression {
            NodeInfo(that);
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
            NodeInfo(that);
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
            NodeInfo(that);
            leftOperand;
            () => generateInvocationForBinaryOperation(that, methodName);
        };
    }

    shared actual
    DartExpression transformLogicalAssignmentOperation(LogicalAssignmentOperation that) {
        value info = NodeInfo(that);
        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);

        return
        generateAssignmentExpression {
            NodeInfo(that);
            leftOperand;
            () => let (dartOperator
                        =   switch (that)
                            case (is AndAssignmentOperation) "&&"
                            case (is OrAssignmentOperation) "||")
                withBoxing {
                    info;
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

        value info = NodeInfo(that);

        return
        withBoxing {
            info;
            ceylonTypes.booleanType;
            null;
            withLhsNative { // for the two generateInvocations
                ceylonTypes.booleanType;
                () => DartBinaryExpression {
                    generateInvocationFromName {
                        info;
                        that.operand;
                        lowerMethodName;
                        [that.lowerBound.endpoint];
                    };
                    "&&";
                    generateInvocationFromName {
                        info;
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
        value info = NodeInfo(that);

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
                                    info;
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
                addError(p, "Destructuring not yet supported");
                return [DartExpressionStatement(DartNullLiteral())];
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
        value info = NodeInfo(that);

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
                (DScope scope, {[ValueModel, DartSimpleIdentifier]*} captures)
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
                (DScope scope, {[ValueModel, DartSimpleIdentifier]*} captures)
            =>  captures.collect((capture)
                =>  DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                scope;
                                capture[0];
                            };
                            [DartVariableDeclaration {
                                dartTypes.dartInvocable {
                                    scope;
                                    capture[0];
                                    false;
                                }.assertedSimpleIdentifier;
                                capture[1];
                            }];
                        };
                    });

        "Dart statements to perform assignments to outer variables, using the normal
         variable name of the declaration for the rhs value."
        function dartAssignmentsToOuterVariables
                (DScope scope, {[ValueModel, DartSimpleIdentifier]*} captures)
            =>  captures.collect((capture)
                =>  DartExpressionStatement {
                        DartAssignmentExpression {
                            capture[1];
                            DartAssignmentOperator.equal;
                            dartTypes.dartInvocable {
                                scope;
                                capture[0];
                                false;
                            }.assertedSimpleIdentifier;
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

            value clauseInfo = NodeInfo(clause);

            switch (clause)
            case (is ForComprehensionClause) {
                value pattern = clause.iterator.pattern;
                if (!pattern is VariablePattern) {
                    addError(pattern, "Destructuring not yet supported");
                    return [];
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
                            clauseInfo;
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
                            info;
                            iteratorDenotableType;
                            () => withBoxing {
                                info;
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
                                    info;
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
                                    clauseInfo;
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
                                    info;
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
                                            clauseInfo;
                                            accumulatedCapturables;
                                        },
                                        // declare variable to hold result of next()
                                        [DartVariableDeclarationStatement {
                                            DartVariableDeclarationList {
                                                null;
                                                dartTypes.dartTypeName {
                                                    info;
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
                                                    info;
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
                                                                clauseInfo;
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
                                            clauseInfo;
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
                                            clauseInfo;
                                            accumulatedCapturables;
                                        },
                                        dartVariableDeclarations,
                                        dartTestsAndAssignments,
                                        dartAssignmentsToOuterVariables {
                                            clauseInfo;
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
                    dartOuterVariableDeclarations(clauseInfo, capturables),
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
                                        dartTypes.dartInvocable {
                                            info;
                                            ceylonTypes.finishedValueDeclaration;
                                            false;
                                        }.expressionForInvocation();
                                    };
                                }],
                                dartVariableDefinitions {
                                    clauseInfo;
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
                            createCallable(info, stepFunctionId);
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
            info;
            resultType;
            null;
            DartFunctionExpressionInvocation {
                dartTypes.dartIdentifierForDartModel {
                    info;
                    dartTypes.dartFunctionIterableFactory;
                };
                DartArgumentList {
                    // Easy. Until we reify generics.
                    [createCallable {
                        info;
                        DartFunctionExpression {
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
                        };
                    }];
                };
            };
        };
    }

    shared actual
    DartExpression transformSwitchCaseElseExpression(SwitchCaseElseExpression that) {
        value info = NodeInfo(that);

        value [switchedType, switchedDeclaration, switchedVariable, variableDeclaration]
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
                            info;
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
                                    info; variableDeclaration;
                                }
                            else
                                [];

                    return
                    DartIfStatement {
                        generateIsExpression {
                            info;
                            switchedType;
                            switchedDeclaration;
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
                                    info;
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
                then generateReplacementVariableDefinition(info, variableDeclaration)
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
            info;
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
            info;
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

    shared actual
    DartExpression transformMeta(Meta that)
        =>  let(info = ExpressionInfo(that))
            DartThrowExpression {
                DartInstanceCreationExpression {
                    const = false;
                    DartConstructorName {
                        dartTypes.dartTypeName {
                            info;
                            ceylonTypes.assertionErrorType;
                            false; false;
                        };
                    };
                    DartArgumentList {
                        [DartSimpleStringLiteral {
                            "Meta expressions not yet supported at \
                             '``info.filename``: ``info.location``'";
                        }];
                    };
                };
            };

    shared actual default
    DartExpression transformNode(Node that) {
        if (that is DynamicBlock | DynamicInterfaceDefinition
                | DynamicModifier | DynamicValue) {
            addError(that, "dynamic is not supported on the Dart VM");
            return DartNullLiteral();
        }
        addError(that,
            "Node type not yet supported (ExpressionTransformer): ``className(that)``");
        return DartNullLiteral();
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
