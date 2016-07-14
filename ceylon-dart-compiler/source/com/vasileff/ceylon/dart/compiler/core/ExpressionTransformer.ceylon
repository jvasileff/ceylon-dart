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
    SwitchCaseElseExpression,
    IsCase,
    MatchCase,
    CaseExpression,
    LetExpression,
    SpecifiedPattern,
    SpreadArgument,
    ComprehensionClause,
    ForComprehensionClause,
    IfComprehensionClause,
    ExpressionComprehensionClause,
    TypeNameWithTypeArguments,
    PositionalArguments,
    Meta,
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue,
    MemberOperator,
    Dec,
    ModuleDec
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList
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
    DScope,
    Warning
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
    createExpressionEvaluationWithSetup,
    createInlineDartStatements,
    createNullSafeExpression,
    createVariableDeclaration,
    DartAwaitExpression
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    BaseExpressionInfo,
    QualifiedExpressionInfo,
    expressionInfo,
    nodeInfo,
    invocationInfo,
    typeInfo,
    thisInfo,
    outerInfo,
    baseExpressionInfo,
    typeNameWithTypeArgumentsInfo,
    qualifiedExpressionInfo,
    objectExpressionInfo,
    functionExpressionInfo,
    isCaseInfo,
    ifElseExpressionInfo,
    moduleDecInfo
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
                baseExpressionInfo(that).declaration;
            };

    DartExpression generateForBaseExpression(
            BaseExpression | QualifiedExpression that,
            "The [[NameWithTypeArguments]], or null to indicate a synthetic declaration
             that should be treated as if [[nameAndArgs]] is a
             [[MemberNameWithTypeArguments]]"
            NameWithTypeArguments? nameAndArgs,
            DeclarationModel targetDeclaration) {

        value info = expressionInfo(that);

        switch (nameAndArgs)
        case (is MemberNameWithTypeArguments?) {
            if (!is ValueModel | FunctionModel targetDeclaration) {
                addError(that,
                    "Unexpected declaration type for base expression: \
                     ``className(targetDeclaration)``");
                return DartNullLiteral();
            }

            // Handle constructors
            if (exists constructorModel = getConstructor(targetDeclaration)) {
                switch (targetDeclaration)
                case (is FunctionModel) {
                    // For callable constructors, return a Callable that takes arguments
                    // for the constructor and returns an instance of the constructor's
                    // class.

                    // generateCallableForBE() can handle constructors and will take care
                    // of the implicit `outer` argument if the constructor's class is a
                    // member class.
                    return generateCallableForBE {
                        info;
                        constructorModel;
                    };
                }
                case (is ValueModel) {
                    // Value constructors act like values of the constructor's class's container.
                    // Return the value by invoking the synthetic function that lazily generates
                    // the value.
                    return dartTypes.invocableForBaseExpression {
                        info;
                        dartTypes.syntheticValueForValueConstructor {
                            constructorModel;
                        };
                        false;
                    }.expressionForInvocation([]);
                }
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
                if (dartTypes.isCallableValue(targetDeclaration)) {
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
                        dartTypes.erasedToObjectCallableParam {
                            targetDeclaration.initializerParameter;
                        };
                        dartTypes.invocableForBaseExpression {
                            info;
                            targetDeclaration;
                        }
                        // get an expression for the Dart reference to the Callable:
                        .expressionForLocalCapture();
                    };
                }
                else {
                    // A newly created Callable, which is not erased
                    return withBoxingNonNative {
                        info;
                        info.typeModel;
                        generateCallableForBE {
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

            value typeNameInfo = typeNameWithTypeArgumentsInfo(nameAndArgs);

            "BaseExpressions to types are references to classes."
            assert (is ClassModel declaration = typeNameInfo.declarationModel);

            // Note: if `declaration` is not toplevel, the Dart constructor may need
            // some outers and captures. `generateCallableForBE` will take care of that.
            return generateCallableForBE {
                info;
                declaration;
            };
        }
    }

    shared actual
    DartExpression transformQualifiedExpression(QualifiedExpression that) {
        value info
            =   qualifiedExpressionInfo(that);

        if (that.receiverExpression is Package) {
            // treat Package qualified expressions as base expressions
            return
            generateForBaseExpression {
                that;
                that.nameAndArgs;
                info.declaration;
            };
        }

        // Simplify qualified expressions for constructors.
        value [receiver, memberDeclaration]
            =   effectiveReceiverAndMemberDeclaration(that);

        value receiverInfo
            =   if (exists receiver)
                then expressionInfo(receiver)
                else null;

        "Qualified expressions not involving assignments or specifications must not be
         Setters."
        assert (is ValueModel | FunctionModel | ClassModel
                    | ConstructorModel memberDeclaration);

        if (!exists receiverInfo) {
            // Special case:
            //
            // This is more like a base expression. It is only a qualified expression
            // syntactically since constructors appear as regular class members in the
            // ast.
            //
            // The actual receiver/container, if this is a constructor for a *member*
            // class, must be determined from the scope. For example, an expression like
            // `Foo.create`, and if `Foo` is a member class, the expression will be in the
            // scope of the container to use for `Foo`.
            //
            // Bottom line: this is a staticMethodReference to the *Constructor*, but
            // it is not a static reference to the constructor's container.

            "If there is no receiver, the original receiver must have been an expression
             for a constructor's class."
            assert (is ConstructorModel memberDeclaration);

            return
            generateForBaseExpression {
                that;
                that.nameAndArgs;
                info.declaration;
            };
        }

        if (isStaticMethodReferencePrimary(receiverInfo)) {
            "Null safe and spread not allowed for static member references."
            assert (is MemberOperator memberOperator = that.memberOperator);

            "The receiver of a static method reference must be a base or qualified
             expression to a type."
            assert (is QualifiedExpressionInfo | BaseExpressionInfo receiverInfo);

            value isConstructorOfStaticClass {
                if (is ConstructorModel memberDeclaration) {
                    assert (is ClassModel container = memberDeclaration.container);
                    return container.staticallyImportable;
                }
                return false;
            }

            // Static members (and constructors of static classes) for interop are more
            // like base expressions to toplevels
            if (memberDeclaration.staticallyImportable || isConstructorOfStaticClass) {
                return
                generateForBaseExpression {
                    that;
                    that.nameAndArgs;
                    info.declaration;
                };
            }

            "The receiver's target must be the qualifying type for the member."
            assert (is TypeModel receiverType
                =   targetForExpressionInfo(receiverInfo));

            // TODO desugar in generateCallableForStaticMemberReference instead?

            "The [[memberDeclaration]], or, for value constructors, the synthetic value
             which is a member of [[memberDeclaration]]'s class's containing class."
            value deSugaredTarget
                =   if (is ConstructorModel memberDeclaration,
                            memberDeclaration.valueConstructor)
                    then dartTypes.syntheticValueForValueConstructor(memberDeclaration)
                    else memberDeclaration;

            // Return a `Callable` that takes a `containerType` and returns a
            // `Callable` that can be used to invoke the `memberDeclaration`
            return generateCallableForStaticMemberReference {
                info;
                receiverType;
                info.target.fullType;
                deSugaredTarget;
                memberOperator;
            };
        }

        // Else, the QualifiedExpression expression is not a static reference

        switch (memberDeclaration)
        case (is ValueModel) {
            // Return an expression that will yield the value.

            if (exists superType
                    =   dartTypes.denotableSuperType(receiverInfo.node)) {

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
                    () => receiverInfo.node.transform(this);
                    memberDeclaration;
                    null;
                    that.memberOperator;
                };
            }
        }
        case (is FunctionModel | ClassModel | ConstructorModel) {

            if (is ConstructorModel memberDeclaration,
                    memberDeclaration.valueConstructor) {

                // value constructors are more like the "is ValueModel" case above
                return generateInvocation {
                    info;
                    info.typeModel;
                    receiverInfo.typeModel;
                    () => receiverInfo.node.transform(this);
                    dartTypes.syntheticValueForValueConstructor {
                        memberDeclaration;
                    };
                    null;
                    that.memberOperator;
                };
            }

            // Return a new Callable.

            // QualifiedExpression with a `super` receiver
            if (exists superType
                    =   dartTypes.denotableSuperType(receiverInfo.node)) {

                return generateCallableForQE {
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
            return generateCallableForQE {
                info;
                receiverInfo.typeModel;
                () => receiverInfo.node.transform(this);
                !isConstant(receiverInfo.node);
                memberDeclaration;
                info.typeModel;
                that.memberOperator;
            };
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
                parseCeylonInteger(that.text));

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
            value info = expressionInfo(e);
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
                expressionInfo(that);
                that.argumentList.listedArguments;
                that.argumentList.sequenceArgument;
            };

    shared actual
    DartExpression transformIterable(Iterable that)
        =>  generateIterable {
                expressionInfo(that);
                that.argumentList.listedArguments;
                that.argumentList.sequenceArgument;
            };

    shared actual
    DartExpression transformSpreadArgument(SpreadArgument that)
        =>  that.argument.transform(this);

    shared actual
    DartExpression transformInvocation(Invocation that) {
        value info
            =   invocationInfo(that);

        value invokedInfo
            =   expressionInfo(that.invoked);

        value invokedDeclaration
            =   let (d = switch (invoked = that.invoked)
                           case (is BaseExpression)
                                baseExpressionInfo(invoked).declaration
                           case (is QualifiedExpression)
                                qualifiedExpressionInfo(invoked).declaration
                           else null) // some other expression that yields a Callable
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
        function indirectInvocationOnCallable(
                "The model for the invoked declaration, or [[null]] if the invocation
                 will be on a newly-generated Callable that cannot properly be represented
                 by the original declaration, as is the case for invocations of static
                 references."
                FunctionModel | ValueModel | ClassModel | ConstructorModel | Null
                invokedDeclaration) {

            value signature
                =   CeylonList {
                        ctx.unit.getCallableArgumentTypes(invokedInfo.typeModel);
                    };

            value [argsSetup, argumentList, hasSpread]
                =   generateArgumentListFromArguments {
                        info;
                        that.arguments;
                        signature;
                        invokedDeclaration;
                    };

            return
            createExpressionEvaluationWithSetup {
                argsSetup;
                // Callables (being generic) always erase to `core.Object`.
                // We may not have a declaration to to use, so explicitly
                // specify erasure:
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

        switch (invokedDeclaration)
        case (is ValueModel?) {
            return indirectInvocationOnCallable(invokedDeclaration);
        }
        case (is FunctionModel) {
            // Invoke a Dart function (*probably* not a Callable value)

            "If the declaration is FunctionModel, the expression must be a base
             expression or a qualified expression"
            assert (is QualifiedExpression|BaseExpression invoked = that.invoked);

            // QualifiedExpression with a `super` receiver
            if (is QualifiedExpression invoked,
                exists superType = dartTypes.denotableSuperType(
                                        invoked.receiverExpression)) {

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
            // Other QualifiedExpressions, but exclude those w/Package "receivers" and
            // static methods; they are more like BaseExpressions
            else if (is QualifiedExpression invoked,
                    !invoked.receiverExpression is Package,
                    !invokedDeclaration.staticallyImportable) {

                assert (is QualifiedExpressionInfo invokedInfo);

                if(invokedInfo.staticMethodReference) {
                    // Note: Needs optimization! This causes a Callable to be created for
                    // the function ref, which is immediately invoked with the argument,
                    // returning a Callable that can be used to invoke the now bound
                    // method.

                    // Passing "null" to avoid having the FunctionModel incorrectly
                    // considered as providing useful information about the necessary
                    // arguments. The required argument is an instance of the qualifying
                    // type for the static reference, and not the arguments required by
                    // the function itself.
                    return(indirectInvocationOnCallable(null));
                }

                value receiverInfo = expressionInfo(invoked.receiverExpression);

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
            // BaseExpression, QualifiedExpression w/Package "receiver", or
            // QualifiedExpression to static method
            else {
                value [argsSetup, argumentList, hasSpread]
                    =   generateArgumentListFromArguments {
                            info;
                            that.arguments;
                            signature;
                            invokedDeclaration;
                        };

                if (ceylonTypes.isAwaitDeclaration(invokedDeclaration)) {
                    // fake await() function used to create an await expression

                    assert (exists expression = argumentList.arguments[0]);

                    return
                    createExpressionEvaluationWithSetup {
                        argsSetup;
                        withBoxing {
                            info;
                            info.typeModel;
                            invokedDeclaration;
                            DartAwaitExpression {
                                expression;
                            };
                        };
                    };
                }

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
                            hasSpread;
                        };
                    };
                };
            }
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

            "Expression for when classInvoked is a BaseExpression (which, depending on
             scope, *could* be for a member class), or a QualifiedExpression classInvoked
             where the classInvoked is a static member class (for Dart, this is always
             the fictional `.Class` static member class for interop)"
            function expressionForNonQualifiedClass() {
                value [argsSetup, argumentList, _]
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
                        dartTypes.invocableForBaseExpression {
                            info;
                            invokedDeclaration;
                        }.expressionForInvocation {
                            DartArgumentList {
                                concatenate {
                                    // only capture for non-toplevel non-members or
                                    // members that are not shared. For members, we call
                                    // a factory that handles captures.
                                    if (!classModel.shared
                                            || !getClassOfConstructor(classModel).shared)
                                    then generateArgumentsForCaptures(info, classModel)
                                    else [],
                                    argumentList.arguments
                                };
                            };
                        };
                    };
                };
            }

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

                return expressionForNonQualifiedClass();
            }

            "We already handled the BaseExpression cases."
            assert (!is BaseExpression invoked);

            value invokedQEInfo = qualifiedExpressionInfo(classInvoked);

            if (invokedQEInfo.staticMethodReference) {
                if (invokedQEInfo.declaration.staticallyImportable) {
                    // if the class is statically importable (static member class), we
                    // are invoking the constructor, not creating a callable for the
                    // constructor. 'classInvoked' acts more like a bse expression.
                    return expressionForNonQualifiedClass();
                }

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
                generateCallableForQE {
                    info;
                    expressionInfo(argument).typeModel;
                    () => argument.transform(expressionTransformer);
                    !isConstant(argument);
                    invokedDeclaration;
                    info.typeModel;
                    null;
                };
            }

            // QualifiedExpression with a `super` receiver
            if (exists superType
                    =   dartTypes.denotableSuperType(invoked.receiverExpression)) {

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

            // Normal case, receiver is an object.
            value receiverInfo = expressionInfo(invoked.receiverExpression);
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
            if (ceylonTypes.isCeylonList(expressionInfo(that.primary).typeModel)) {
                // The extra withBoxing/withLhs combo below is important. Here's why:
                //
                // The return type of the `getFromFirst` invocation may be something like
                // `Integer | Float | Null` because `getFromFirst` is a method of
                // iterable, and doesn't account for the type of the element at a
                // *particular* index as the typechecker does (the typechecker, through
                // magic, has better type info that the method's return type would
                // indicate.)
                //
                // Now, if `Integer` is the type of the expression per the typechecker,
                // then it is a candidate for widening/coercion to `Float`. *But*, for
                // this to work, our coercion machinery must see a `Integer`-to-`Float`
                // boxing/casting; an `Integer|Float`-to-`Float` boxing, for example, will
                // not trigger a coercion.
                //
                // So we must *first* box/cast to `Integer` (or whatever the the
                // type should be, per the typechecker), and then box/cast to whatever
                // the context lhs is. The second boxing will then have full information
                // to perform whatever coercions or processing is necessary.

                "The expression type, which may be more specific that the return type
                 of `getFromFirst`, due to typechecker magic."
                value preciseType
                    =   expressionInfo(that).typeModel;

                return
                withBoxingNonNative {
                    dScope(that);
                    preciseType;
                    withLhsNonNative {
                        preciseType;
                        () => generateInvocationFromName {
                            dScope(that);
                            that.primary;
                            "getFromFirst";
                            [subscript.key];
                        };
                    };
                };
            }
            else {
                return
                generateInvocationFromName {
                    dScope(that);
                    that.primary;
                    "get";
                    [subscript.key];
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
            };
        }
        case (is MeasureSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "measure";
                [subscript.from, subscript.length];
            };
        }
        case (is SpanFromSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "spanFrom";
                [subscript.from];
            };
        }
        case (is SpanToSubscript) {
            return
            generateInvocationFromName {
                dScope(that);
                that.primary;
                "spanTo";
                [subscript.to];
            };
        }
    }

    shared actual
    DartExpression transformObjectExpression(ObjectExpression that) {
        value info = objectExpressionInfo(that);

        that.visit(topLevelVisitor);

        return
        generateObjectInstantiation {
            dScope(info, info.scope.container);
            info.anonymousClass;
        };
    }

    shared actual
    DartExpression transformFunctionExpression(FunctionExpression that)
        =>  let (info = functionExpressionInfo(that))
            withBoxingNonNative {
                info;
                info.typeModel;
                generateCallableForBE {
                    info;
                    info.declarationModel;
                    generateFunctionExpression(that);
                };
            };

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
        =>  let (info = nodeInfo(that),
                 operandInfo = expressionInfo(that.operand))
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
        =>  let (info = nodeInfo(that),
                 operandInfo = expressionInfo(that.operand))
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
                    typeInfo(that.type).typeModel;
                };
            };

    shared actual
    DartExpression transformNonemptyOperation(NonemptyOperation that)
        =>  let (info = nodeInfo(that),
                 operandInfo = expressionInfo(that.operand))
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
        =>  withBoxing {
                nodeInfo(that);
                ceylonTypes.booleanType;
                null;
                DartPrefixExpression {
                    "!";
                    withLhsNative {
                        ceylonTypes.booleanType;
                        () => that.operand.transform(this);
                    };
                };
            };

    shared actual
    DartExpression transformNegationOperation(NegationOperation that)
        =>  generateInvocationFromName {
                nodeInfo(that);
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

        value info = expressionInfo(that);

        return
        generateAssignment {
            info;
            operand;
            info.typeModel;
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

        value info = expressionInfo(that);

        // the expected type after boxing
        TypeModel tempVarType;

        switch (lhsTypeTop = ctx.lhsTypeTop)
        case (is NoType) {
            // no need to save and return original value
            return
            generateAssignment {
                info;
                operand;
                noType;
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
                expressionInfo(that).typeModel;
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
                generateAssignment {
                    info;
                    operand;
                    info.typeModel;
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
                nodeInfo(that);
                that.leftOperand;
                methodName;
                [that.rightOperand];
            };

    shared actual
    DartExpression transformArithmeticOperation(ArithmeticOperation that)
        =>  let (info = expressionInfo(that),
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
    // workaround https://github.com/ceylon/ceylon.ast/issues/106
    DartExpression transformIntersectionOperation(IntersectionOperation that)
        =>  transformSetOperation(that);

    shared actual
    DartExpression transformScaleOperation(ScaleOperation that) {
        // The left and right operands are swapped compared to other binary operations,
        // but we must evaluate the left operand first.

        value info
            =   nodeInfo(that);

        value leftOperandInfo
            =   expressionInfo(that.leftOperand);

        value tempIdentifier
            =   DartSimpleIdentifier {
                    dartTypes.createTempNameCustom();
                };

        return
        createExpressionEvaluationWithSetup {
            [createVariableDeclaration {
                dartTypes.dartTypeName {
                    leftOperandInfo;
                    leftOperandInfo.typeModel;
                    eraseToNative = false;
                    eraseToObject = false;
                };
                tempIdentifier;
                withLhsNonNative {
                    leftOperandInfo.typeModel;
                    () => that.leftOperand.transform(expressionTransformer);
                };
            }];
            generateInvocationFromName {
                info;
                that.rightOperand;
                "scale";
                [() => withBoxingNonNative {
                    leftOperandInfo;
                    leftOperandInfo.typeModel;
                    tempIdentifier;
                }];
            };
        };
    }

    shared actual
    DartExpression transformSpanOperation(SpanOperation that) {
        value info = expressionInfo(that);
        value firstInfo = expressionInfo(that.first);
        value lastInfo = expressionInfo(that.last);

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
        value info = expressionInfo(that);
        value firstInfo = expressionInfo(that.first);

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
        =>  let (info = nodeInfo(that))
            withBoxingNonNative {
                info;
                expressionInfo(that).typeModel;
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
        =>  let (info = nodeInfo(that))
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
        =>  let (info = nodeInfo(that))
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
        =>  let (info = nodeInfo(that),
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
            =   expressionInfo(that);

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
        value info = expressionInfo(that);
        return generateAssignment {
            info;
            leftOperand;
            info.typeModel;
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
        value info = expressionInfo(that);
        return generateAssignment {
            info;
            leftOperand;
            info.typeModel;
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
        value info = expressionInfo(that);
        return generateAssignment {
            info;
            leftOperand;
            info.typeModel;
            () => generateInvocationForBinaryOperation(that, methodName);
        };
    }

    shared actual
    DartExpression transformLogicalAssignmentOperation(LogicalAssignmentOperation that) {
        assert (is BaseExpression | QualifiedExpression leftOperand = that.leftOperand);
        value info = expressionInfo(that);
        return
        generateAssignment {
            info;
            leftOperand;
            info.typeModel;
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

        value info = nodeInfo(that);

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
        // TODO generateForPattern for VariablePatterns creates ugly code with the
        //      declaration split from the assignment. Try to consolidate the two for
        //      simple cases?
        function generateVariableDeclarations(SpecifiedPattern sp)
            =>  let (eInfo = expressionInfo(sp.specifier.expression),
                    parts = generateForPattern {
                        sp.pattern;
                        eInfo.typeModel;
                        () => sp.specifier.expression.transform {
                            expressionTransformer;
                        };
                    })
                concatenate {
                    parts.map(VariableTriple.dartDeclaration),
                    [DartBlock {
                        [*parts.flatMap(VariableTriple.dartAssignment)];
                    }]
                };

        value variableDeclarations
            =   [*that.patterns.children.flatMap(generateVariableDeclarations)];

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
        value info = nodeInfo(that);

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

            value clauseInfo = nodeInfo(clause);

            switch (clause)
            case (is ForComprehensionClause) {
                "The iterator for the iterable in this `for` clause"
                value iteratorVariable
                    =   DartSimpleIdentifier {
                            dartTypes.createTempNameCustom("iterator_" + count.string);
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

                // Don't erase to native loop variables; avoid premature unboxing
                dartTypes.disableErasureToNative(clause.iterator.pattern);

                "VariableTriples for inside the loop"
                value variableTriples
                    =   generateForPattern {
                            clause.iterator.pattern;
                            // minus Finished, since this will be in the loop after
                            // the test.
                            nextType.minus(ceylonTypes.finishedType);
                            () => withBoxing {
                                info;
                                nextType;
                                null;
                                nextVariable;
                            };
                        };

                "Variable declarations and assignements for inside the loop"
                value variables
                    =   concatenate {
                            variableTriples.map(VariableTriple.dartDeclaration),
                            [DartBlock {
                                [*variableTriples.flatMap(VariableTriple.dartAssignment)];
                            }]
                        };

                "The synthetic variables used to hold the current values outside of the
                 function"
                value dartValueVariables
                    =   variableTriples
                            .map(VariableTriple.declarationModel)
                            .collect((variableDeclaration)
                                =>  DartSimpleIdentifier {
                                        dartTypes.createTempName(variableDeclaration);
                                    });

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

                "Declare the 'outer' variables."
                value dartValueVariableDeclarations
                    =   zipPairs(variableTriples, dartValueVariables).collect((pair)
                        =>  DartVariableDeclarationStatement {
                                DartVariableDeclarationList {
                                    null;
                                    dartTypes.dartTypeNameForDeclaration {
                                        info;
                                        pair[0].declarationModel;
                                    };
                                    [DartVariableDeclaration {
                                        pair[1];
                                    }];
                                };
                            });

                value capturables
                    =   zipPairs(variableTriples, dartValueVariables).collect((pair)
                        =>  [pair[0].declarationModel, pair[1]]);

                "A dart function declaration for the step function. This function

                 - Calls the init function for this step, to initialize the iterator
                 - Obtains `next()` from the iterator
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
                                                concatenate {
                                                    // Define the "inner" variables
                                                    variables,
                                                    // Assign them to the outers
                                                    // This used to be all in one step.
                                                    // Might be nice to consolidate:
                                                    // we're wasting a bunch of variables
                                                    // since we never need the inners.
                                                    dartAssignmentsToOuterVariables {
                                                        clauseInfo;
                                                        capturables;
                                                    },
                                                    [DartReturnStatement {
                                                        DartBooleanLiteral(true);
                                                    }]
                                                };
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

                return
                concatenate {
                    [dartIteratorVariableDeclaration],
                    [dartInitFunctionDeclaration],
                    dartValueVariableDeclarations,
                    [dartStepFunctionDeclaration],
                    generateSteps {
                        clause.clause; count+1; stepFunctionName;
                        expand { accumulatedCapturables, capturables };
                    }
                };
            }
            case (is IfComprehensionClause) {
                value stepFunctionId
                    =   generateStepFunctionName(count);

                function assertBooleanCondition(Anything a) {
                    assert (is BooleanCondition a);
                    return a;
                }

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
                                                    assertBooleanCondition;
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

                "All of the replacement and destructure declarations."
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
                                *parts[2...].flatMap(VariableTriple.dartAssignment)
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
        value info = nodeInfo(that);

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
                        =   isCaseInfo(caseItem).variableDeclarationModel;

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
                            dScope(caseItem);
                            switchedType;
                            switchedDeclaration;
                            switchedVariable;
                            typeInfo(caseItem.type).typeModel;
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

        value ifStatement
            =   generateIf {
                    for (node in that.children.rest)
                        if (is CaseExpression | Expression node)
                            node
                };

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
            DartConditionalExpression {
                generateBooleanDartCondition {
                    that.conditions.conditions.map {
                        (condition) {
                            "All conditions will be BooleanConditions per prior check"
                            assert (is BooleanCondition condition);
                            return condition;
                        };
                    };
                };
                that.thenExpression.transform(this);
                that.elseExpression.transform(this);
            };
        }

        value info = ifElseExpressionInfo(that);

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
                                replacements.flatMap(VariableTriple.dartAssignment),

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
    DartExpression transformThis(This that)
        =>  let (info = thisInfo(that))
            withBoxingNonNative {
                info;
                info.typeModel;
                dartTypes.expressionForThis(info);
            };

    shared actual
    DartExpression transformOuter(Outer that) {
        value info = outerInfo(that);
        assert (is ClassOrInterfaceModel ci = getContainingClassOrInterface(info.scope));
        assert (exists outerDeclaration = getContainingClassOrInterface(ci.container));
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
    DartExpression transformMeta(Meta that) {
        value info = expressionInfo(that);

        // TODO unsupported feature warning type
        addWarning(info, Warning.unknownWarning,
            "**unsupported feature** metamodel expressions are not yet supported");

        return DartThrowExpression {
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
    }

    shared actual
    DartExpression transformModuleDec(ModuleDec that) {
        value info = moduleDecInfo(that);

        return dartTypes.dartInvocable(info, ceylonTypes.moduleImplDeclaration)
                    .expressionForInvocation {
            receiver = null;
            arguments = [
                if (getModule(info) == info.model)
                then DartSimpleIdentifier("$module")
                else DartPrefixedIdentifier {
                    DartSimpleIdentifier {
                        moduleImportPrefix(info.model);
                    };
                    DartSimpleIdentifier("$module");
                }];
        };
    }

    shared actual DartExpression transformDec(Dec that) {
        value info = expressionInfo(that);

        // TODO unsupported feature warning type
        addWarning(info, Warning.unknownWarning,
            "**unsupported feature** metamodel expressions are not yet supported");

        return DartThrowExpression {
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
                        "Dec expressions not yet supported at \
                         '``info.filename``: ``info.location``'";
                    }];
                };
            };
        };
    }

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
