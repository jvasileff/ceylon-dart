import ceylon.ast.core {
    FunctionShortcutDefinition,
    FunctionDefinition,
    Parameters,
    Arguments,
    PositionalArguments,
    NamedArguments,
    ArgumentList,
    FunctionExpression,
    Block,
    LazySpecifier,
    DefaultedParameter,
    BooleanCondition,
    QualifiedExpression,
    BaseExpression,
    IsCondition,
    Expression,
    DefaultedCallableParameter,
    ValueDeclaration,
    ValueDefinition,
    Specifier,
    ValueGetterDefinition,
    SpecifiedPattern,
    VariablePattern,
    ExistsOrNonemptyCondition,
    ExistsCondition,
    NonemptyCondition,
    Condition,
    ValueSetterDefinition,
    ObjectDefinition,
    SwitchClause,
    SpecifiedVariable,
    Comprehension,
    SpreadArgument,
    AnyMemberOperator,
    MemberOperator,
    SafeMemberOperator,
    AnySpecifier,
    FunctionArgument,
    Parameter
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList,
    CeylonIterable
}

import com.redhat.ceylon.model.typechecker.model {
    PackageModel=Package,
    FunctionModel=Function,
    TypeModel=Type,
    FunctionOrValueModel=FunctionOrValue,
    ValueModel=Value,
    ClassModel=Class,
    ClassOrInterfaceModel=ClassOrInterface,
    InterfaceModel=Interface,
    ConstructorModel=Constructor,
    ParameterModel=Parameter,
    DeclarationModel=Declaration,
    SetterModel=Setter,
    ParameterListModel=ParameterList,
    Reference
}
import com.vasileff.ceylon.dart.ast {
    DartVariableDeclarationStatement,
    DartExpression,
    DartSimpleIdentifier,
    DartSimpleFormalParameter,
    DartIsExpression,
    DartFunctionExpression,
    DartFormalParameterList,
    DartVariableDeclarationList,
    DartPrefixExpression,
    DartFunctionDeclaration,
    DartNullLiteral,
    DartArgumentList,
    DartReturnStatement,
    DartPropertyAccess,
    DartFunctionExpressionInvocation,
    DartTypeName,
    DartIfStatement,
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartBinaryExpression,
    DartVariableDeclaration,
    DartInstanceCreationExpression,
    DartConstructorName,
    dartFormalParameterListEmpty,
    DartBlock,
    DartDefaultFormalParameter,
    DartExpressionFunctionBody,
    DartBlockFunctionBody,
    DartBooleanLiteral,
    DartExpressionStatement,
    DartConditionalExpression,
    DartFunctionBody,
    DartStatement,
    DartSwitchCase,
    DartIntegerLiteral,
    DartSwitchStatement,
    DartListLiteral,
    createNullSafeExpression,
    createExpressionEvaluationWithSetup
}
import com.vasileff.ceylon.dart.nodeinfo {
    FunctionExpressionInfo,
    BaseExpressionInfo,
    FunctionShortcutDefinitionInfo,
    QualifiedExpressionInfo,
    ParameterInfo,
    ArgumentListInfo,
    ExpressionInfo,
    FunctionDefinitionInfo,
    AnyFunctionInfo,
    IsConditionInfo,
    TypeInfo,
    ValueDefinitionInfo,
    ValueGetterDefinitionInfo,
    UnspecifiedVariableInfo,
    ExistsOrNonemptyConditionInfo,
    AnyValueInfo,
    ValueSetterDefinitionInfo,
    ObjectDefinitionInfo,
    SpecifiedVariableInfo,
    ComprehensionClauseInfo,
    NodeInfo,
    namedArgumentInfo,
    AnonymousArgumentInfo,
    SpecifiedArgumentInfo,
    ValueArgumentInfo,
    FunctionArgumentInfo,
    ObjectArgumentInfo,
    NamedArgumentInfo,
    SpreadArgumentInfo,
    sequenceArgumentInfo,
    ComprehensionInfo
}
import com.vasileff.jl4c.guava.collect {
    ImmutableMap,
    javaList
}

shared abstract
class BaseGenerator(CompilationContext ctx)
        extends CoreGenerator(ctx) {

    // hack to avoid error using the inherited member ceylonTypes in the initializer
    value ceylonTypes = ctx.ceylonTypes;

    [TypeModel, TypeModel, String, TypeModel]?(DeclarationModel)
    simpleNativeBinaryFunctions = (() {
        return ImmutableMap {
            ceylonTypes.stringDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.stringType,
                    ceylonTypes.stringType, "+",
                    ceylonTypes.stringType],
            ceylonTypes.integerDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "+",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("plusInteger", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "+",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("minus", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "-",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("times", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "*",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("divided", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "~/",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("largerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, ">",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("smallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, "<",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("notLargerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, "<=",
                    ceylonTypes.integerType],
            ceylonTypes.integerDeclaration.getMember("notSmallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, ">=",
                    ceylonTypes.integerType],
            ceylonTypes.floatDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "+",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("plusInteger", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "+",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("minus", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "-",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("times", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "*",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("divided", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "/",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("largerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, ">",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("smallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, "<",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("notLargerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, "<=",
                    ceylonTypes.floatType],
            ceylonTypes.floatDeclaration.getMember("notSmallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, ">=",
                    ceylonTypes.floatType]
        }.get;
    })();

    value booleanEquals = ceylonTypes.booleanDeclaration.getMember("equals", null, false);
    value stringEquals = ceylonTypes.stringDeclaration.getMember("equals", null, false);
    value integerEquals = ceylonTypes.integerDeclaration.getMember("equals", null, false);
    value floatEquals = ceylonTypes.floatDeclaration.getMember("equals", null, false);

    function nativeBinaryOptimization(
            DeclarationModel declaration,
            TypeModel receiverType,
            TypeModel? argumentType) {

        if (exists o = simpleNativeBinaryFunctions(declaration)) {
            return o;
        }

        if (exists argumentType) {
            value definiteArgument = ceylonTypes.definiteType(argumentType);
            if (declaration == stringEquals
                    && ceylonTypes.isCeylonString(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.stringType, "==",
                        ceylonTypes.stringType];
            }

            if (declaration == integerEquals
                    && ceylonTypes.isCeylonInteger(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.integerType, "==",
                        ceylonTypes.integerType];
            }

            if (declaration == floatEquals
                    && ceylonTypes.isCeylonFloat(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.floatType, "==",
                        ceylonTypes.floatType];
            }

            if (declaration == booleanEquals
                    && ceylonTypes.isCeylonBoolean(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.booleanType, "==",
                        ceylonTypes.booleanType];
            }
        }

        return null;
    }

    shared
    DartInstanceCreationExpression createCallable(
            DScope scope,
            DartExpression delegateFunction,
            Integer? variadicParameterIndex = null) {

        if (exists variadicParameterIndex) {
            assert (!variadicParameterIndex.negative);
        }

        return
        DartInstanceCreationExpression {
            false;
            DartConstructorName {
                dartTypes.dartTypeNameForDartModel {
                    scope;
                    dartTypes.dartCallableModel;
                };
                null;
            };
            DartArgumentList {
                {
                    delegateFunction,
                    if (exists variadicParameterIndex)
                    then DartIntegerLiteral(variadicParameterIndex)
                    else null
                }.coalesced.sequence();
            };
        };
    }

    shared
    DartFunctionDeclaration generateFunctionDefinition
            (FunctionShortcutDefinition | FunctionDefinition that) {

        value info = AnyFunctionInfo(that);

        value functionModel = info.declarationModel;

        // Toplevel and local functions will never be implemented as Dart values
        // or operators. Just grab the identifier and define a function.
        value functionIdentifier
            =   dartTypes.dartInvocable {
                    info;
                    functionModel;
                    false;
                }.reference;

        "Functions have simple identifiers."
        assert (is DartSimpleIdentifier functionIdentifier);

        return
        DartFunctionDeclaration {
            false;
            generateFunctionReturnType(info, functionModel);
            null;
            functionIdentifier;
            generateFunctionExpression(that);
        };
    }

    "For the Value, or the return type of the Function"
    shared
    DartTypeName generateFunctionReturnType
            (DScope scope, FunctionOrValueModel declaration) {

        assert (is FunctionModel | ValueModel | SetterModel declaration);

        return switch (declaration)
            case (is FunctionModel)
                if (declaration.parameterLists.size() > 1) then
                    // return type is a `Callable`; we're not get generic, so the
                    // Callable's return is erased. Even on the Java backend, the
                    // arguments are erased.
                    dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.callableDeclaration.type;
                        false;
                    }
                else if (!declaration.declaredVoid) then
                    dartTypes.dartReturnTypeNameForDeclaration {
                        scope;
                        declaration;
                    }
                else
                    // hacky way to create a void keyword
                    DartTypeName(DartSimpleIdentifier("void"))
            case (is ValueModel)
                dartTypes.dartReturnTypeNameForDeclaration {
                        scope;
                        declaration;
                }
            case (is SetterModel)
                // hacky way to create a void keyword
                DartTypeName(DartSimpleIdentifier("void"));
    }

    "Generate an invocation or propery access expression for a toplevel."
    shared
    DartExpression generateTopLevelInvocation(
            DScope scope,
            TypeModel resultType,
            FunctionOrValueModel memberDeclaration,
            [List<TypeModel>, [Expression*] | PositionalArguments]?
                    signatureAndArguments = null) {

        "Only toplevels are supported; declaration's container must be a package."
        assert (memberDeclaration.container is PackageModel);

        // TODO Use this in transformInvocation, transformBaseExpression, etc.
        //      Which will also require support for NamedArguments

        value [signature, a]
            = signatureAndArguments else [null, []];

        value arguments
            =   switch (a)
                case (is [Expression*]) a
                case (is PositionalArguments) a.argumentList.listedArguments;

        value dartFunctionOrValue
            =   dartTypes.dartInvocable(
                    scope, memberDeclaration, false);

        [DartExpression*] dartArguments;

        if (arguments nonempty) {
            "If there are arguments, the member is surely a FunctionModel and must
             translate to a Dart function"
            assert (is FunctionModel memberDeclaration);

            "If we have arguments, we'll have a signature."
            assert (exists signature);

            value parameterDeclarations
                =   CeylonList(memberDeclaration.firstParameterList.parameters)
                        .collect(ParameterModel.model);

            dartArguments
                =   [for (i -> argument in arguments.indexed)
                        withLhs {
                            signature[i];
                            parameterDeclarations[i];
                            () => argument.transform(expressionTransformer);
                        }
                    ];
        }
        else {
            dartArguments = [];
        }

// FIXME WIP is this still necessary? If so, add it back to generateInvocation. Or
//           better, make it unnecessary.
        value resultDeclaration =
                if (is FunctionModel memberDeclaration,
                        memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        return
        withBoxing {
            scope;
            resultType;
            resultDeclaration;
            dartFunctionOrValue.expressionForInvocation {
                null;
                dartArguments;
            };
        };
    }

    [[DartStatement*], [DartExpression*]] generateArguments(
            DScope scope,
            List<TypeModel | TypeDetails> signature,
            ParameterListModel parameterList,
            [DartExpression()*] | [Expression*] | Arguments arguments) {

        if (is PositionalArguments | NamedArguments arguments) {
            value [a, b]
                =   generateArgumentListFromArguments {
                        scope;
                        arguments;
                        signature;
                        parameterList;
                    };
            return [a, b.arguments];
        }

        [DartStatement*] argsSetup;
        [DartExpression()*] argGenerators;

        if (is [DartExpression()*] arguments) {
            argsSetup = [];
            argGenerators = arguments;
        }
        else { // is [Expression*]
            argsSetup = [];
            argGenerators = arguments.collect((a) => ()
                    => a.transform(expressionTransformer));
        }

        value argExpressions
            =   [for (i -> argument in argGenerators.indexed)
                    withLhs {
                        signature[i];
                        parameterList.parameters.get(i)?.model;
                        argument;
                    }
                ];

        return [argsSetup, argExpressions];
    }

    "Generate an invocation or propery access expression."
    shared
    DartExpression generateInvocation(
            DScope scope,
            "The return type of the invocation. If [[signatureAndArguments]]
             is also provided, the [[resultType]] should match exactly the
             return type of the given callable type."
            TypeModel resultType,
            "The type of the receiver, which may be:
             -  the type of an expression if [[generateReceiver]] is not null, or
             -  an interface that is the container of the [[memberDeclaration]] to invoke
                [[generateReceiver]] is null, indicating that the receiver is a `super`
                reference."
            TypeModel receiverType,
            "A function to generate the receiver of type [[receiverType]], or null if the
             receiver is a `super` reference."
            DartExpression()? generateReceiver,
            FunctionOrValueModel | ClassModel | ConstructorModel memberDeclaration,
            [List<TypeModel>, [DartExpression()*]
                        | [Expression*]
                        | Arguments]? signatureAndArguments = null,
            AnyMemberOperator? memberOperator = null) {

        "By definition."
        assert (is FunctionModel | ValueModel | SetterModel
                    | ClassModel | ConstructorModel memberDeclaration);

        "SpreadMemberOperator not yet supported."
        assert (is Null | MemberOperator | SafeMemberOperator memberOperator);

        value safeMemberOperator = memberOperator is SafeMemberOperator;

        value [signature, a] = signatureAndArguments else [null, []];

        function standardArgs() {
            if (!exists signatureAndArguments) {
                return [[], []];
            }
            assert (!is ValueModel | SetterModel memberDeclaration);
            return generateArguments {
                scope;
                signatureAndArguments[0];
                memberDeclaration.firstParameterList;
                a;
            };
        }

        "For optimized invocations, the result type. Null for non-optimized invocations."
        TypeModel? optimizedNativeRhsType;

        "The arguments."
        [[DartStatement*], [DartExpression*]] argsSetupAndExpressions;

        "The receiver object (outer for constructors of member classes)."
        DartExpression dartReceiver;

        "The Dart type of [[dartReceiver]]."
        DartTypeName dartReceiverType;

        "The Dart function, value, or constructor to invoking."
        DartInvocable dartFunctionOrValue;

        if (is ClassModel | ConstructorModel memberDeclaration) {
            if (!exists generateReceiver) {
                throw CompilerBug(scope,
                    "Member class and constructor invocations on super not supported.");
            }

            // Invoking a member class; must call the statically known Dart constructor,
            // passing the receiver (outer) as the first argument.

            "The container of a member class invoked with a receiver must be a class
             or interface."
            assert (is ClassOrInterfaceModel memberContainer
                 =  getContainingClassOrInterface {
                        switch (memberDeclaration)
                        case (is ClassModel)
                            memberDeclaration.container
                        case (is ConstructorModel)
                            memberDeclaration.container.container;
                    });

            optimizedNativeRhsType
                =   null;

            dartReceiverType
                =   dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.denotableType {
                            receiverType;
                            memberContainer;
                        };
                        eraseToNative = false;
                    };

            dartReceiver
                =   withLhsDenotable {
                        memberContainer;
                        generateReceiver;
                    };

            dartFunctionOrValue
                =   dartTypes.dartInvocable {
                        scope;
                        memberDeclaration;
                    };

            argsSetupAndExpressions
                =   standardArgs();
        }
        else if (!exists generateReceiver) {
            // Receiver is `super`

            // dartReceiverType is only used for null safe operator, and `super` is never
            // null. So let's save a nanosecond and avoid the calculation.
            dartReceiverType
                =   dartTypes.dartObject;

            if (receiverType.declaration is InterfaceModel) {
                // Invoking a specific interface's implementation. Abandon polymorphism
                // and invoke the Dart static method directly. This also works when
                // `super` is used to invoke private interface methods, which must
                // *always* use the static methods.

                "A `super` reference is surely contained within a class or interface."
                assert (exists scopeContainer = getContainingClassOrInterface(scope));

                // Note: It's nice that we have the declaration pointed to by
                //       referenced by `super`, but it's also completely useless.
                //
                //       Instead, we'll ues the interface that is the container of
                //       memberDeclaration, which will be a supertype of `super` if
                //       `super` doesn't refine the member. (Since we're calling a static
                //       method, we need the interface that actually provides the
                //       definition.)
                assert (is InterfaceModel implementingContainer
                    =   container(memberDeclaration));

                optimizedNativeRhsType
                    =   null;

                dartReceiver
                    =   dartTypes.expressionForThis(scopeContainer);

                dartFunctionOrValue
                    =   DartInvocable {
                            DartPropertyAccess {
                                dartTypes.dartIdentifierForClassOrInterface {
                                    scope;
                                    implementingContainer;
                                };
                                dartTypes.getStaticInterfaceMethodIdentifier {
                                    memberDeclaration;
                                    false;
                                };
                            };
                            dartFunction; // Static interface functions are... functions
                        };

                argsSetupAndExpressions
                    =   standardArgs();
            }
            else {
                // super refers to the superclass

                optimizedNativeRhsType
                    =   null;

                dartReceiver
                    =   DartSimpleIdentifier("super");

                dartFunctionOrValue
                    =   dartTypes.dartInvocable {
                            scope;
                            memberDeclaration;
                            false;
                        };

                argsSetupAndExpressions
                    =   standardArgs();
            }
        }
        else if (!memberDeclaration.shared,
                 is InterfaceModel memberContainer
                         =  getContainingClassOrInterface(memberDeclaration)) {

            // Invoking private interface member; must call static implementation method.

            optimizedNativeRhsType
                =   null;

            dartReceiverType
                =   dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.denotableType {
                            receiverType;
                            memberContainer;
                        };
                        eraseToNative = false;
                    };

            dartReceiver
                =   withLhsDenotable {
                        memberContainer;
                        generateReceiver;
                    };

            dartFunctionOrValue
                =   DartInvocable {
                        DartPropertyAccess {
                            dartTypes.dartIdentifierForClassOrInterface {
                                scope;
                                memberContainer;
                            };
                            dartTypes.getStaticInterfaceMethodIdentifier {
                                memberDeclaration;
                                false;
                            };
                        };
                        dartFunction;
                    };

            argsSetupAndExpressions
                =   standardArgs();
        }
        else {
            // receiver is not `super`

            // WIP native optimizations
            value firstArgType
                // This leaves something on the table. We should be able to get the
                // *argument list* signature from the typechecker.
                =   if (is [Expression+] a) then
                        ExpressionInfo(a[0]).typeModel
                    else if (is PositionalArguments a,
                             exists arg = a.argumentList.listedArguments.first) then
                        ExpressionInfo(arg).typeModel
                    else null;

            if (exists optimization
                    =   nativeBinaryOptimization(
                            memberDeclaration, receiverType, firstArgType)) {

                assert (!is ValueModel | SetterModel memberDeclaration);

                value [type, leftOperandType, operand, rightOperandType]
                    =   optimization;

                value rightOperandTypeDetail
                    =   TypeDetails(rightOperandType, true, false);

                optimizedNativeRhsType
                    =   type;

                dartReceiverType
                    =   dartTypes.dartTypeName {
                            scope;
                            leftOperandType;
                            eraseToNative = true;
                        };

                dartReceiver
                    =   withLhsNative {
                            leftOperandType;
                            generateReceiver;
                        };

                dartFunctionOrValue
                    =   DartInvocable {
                            DartSimpleIdentifier(operand);
                            dartBinaryOperator;
                        };

                argsSetupAndExpressions
                    =   generateArguments {
                            scope;
                            [rightOperandTypeDetail];
                            memberDeclaration.firstParameterList;
                            a;
                        };
            }
            else {
                // Determine usable receiver type. Computing `dartReceiver` with
                // `withLhsDenotable` would be simpler, but we may need the type
                // for `dartReceiverType` if this invocation involves the
                // safeMemberOperator.
                assert (is ClassOrInterfaceModel container
                    =   container(memberDeclaration));

                value receiverDenotableType
                    =   ceylonTypes.denotableType {
                            receiverType;
                            container;
                        };

                optimizedNativeRhsType
                    =   null;

                dartReceiverType
                    =   dartTypes.dartTypeName {
                            scope;
                            receiverDenotableType;
                            eraseToNative = false;
                        };

                dartReceiver
                    =   withLhsCustom {
                            receiverDenotableType;
                            false; false;
                            generateReceiver;
                        };

                dartFunctionOrValue
                    =   dartTypes.dartInvocable {
                            scope;
                            memberDeclaration;
                            false;
                        };

                argsSetupAndExpressions
                    =   standardArgs();
            }
        }

        value invocation
            =   if (safeMemberOperator) then
                    // We're delaying argsSetup evaluation against the spec. We're also
                    // not eagerly evaluating arguments themselves.
                    // See https://github.com/ceylon/ceylon-compiler/issues/2386
                    createNullSafeExpression {
                        parameterIdentifier = DartSimpleIdentifier("$r");
                        parameterType = dartReceiverType;
                        // The receiver, which will be passed as an argument
                        maybeNullExpression = dartReceiver;
                        ifNullExpression = DartNullLiteral();
                        // The invocation, with a replaced receiver
                        ifNotNullExpression
                            =   createExpressionEvaluationWithSetup {
                                    argsSetupAndExpressions[0];
                                    dartFunctionOrValue.expressionForInvocation {
                                        DartSimpleIdentifier("$r");
                                        argsSetupAndExpressions[1];
                                    };
                                };
                    }
                else
                    createExpressionEvaluationWithSetup {
                        argsSetupAndExpressions[0];
                        dartFunctionOrValue.expressionForInvocation {
                            dartReceiver;
                            argsSetupAndExpressions[1];
                        };
                    };

        return if (exists optimizedNativeRhsType)
            then withBoxingCustom {
                scope;
                optimizedNativeRhsType;
                true; false;
                invocation;
            }
            else withBoxing {
                scope;
                resultType;
                memberDeclaration;
                //resultDeclaration;
                invocation;
            };
    }

    shared
    DartExpression generateInvocationFromName(
            DScope scope,
            Expression receiver,
            String memberName,
            [Expression*] arguments,
            "The return type of the invocation, if know. This should be provided when
             possible, since the type checker may have more specific type information
             than what could otherwise be determined. For instance, when a subscript
             operation is performed on a Tuple."
            TypeModel? returnType = null)
        =>  generateInvocationDetailsFromName(
                scope, receiver, memberName, arguments, returnType)[2]();

    """Returns a Tuple holding:

       - The `Type` of the result of the invocation
       - The `FunctionOrValueModel` of the member, or `null` when invoking a function with
         multiple parameter lists, in which case the `Type` will be a `Callable`.
       - A function that will build and box an expression for the invocation. Callers
         should call the generator function within a [[withLhs]] context.

       The purpose of this method is to allow callers to calculate (and therefore have
       access to) the desired lhs type (often a denotable type) for use when making
       synthetic declarations to hold the result of the invocation.
    """
    shared
    [TypeModel, FunctionOrValueModel?, DartExpression()]
    generateInvocationDetailsFromName(
            DScope scope,
            Expression receiver,
            String memberName,
            [Expression*] | [DartExpression()*] arguments,
            "See notes on [[generateInvocationFromName.returnType]]."
            TypeModel? returnType = null) {

        return
        generateInvocationDetailsSynthetic {
            scope;
            ExpressionInfo(receiver).typeModel;
            () => receiver.transform(expressionTransformer);
            memberName;
            arguments;
            returnType;
        };
    }

    """The same as [[generateInvocationFromName]], but with parameters that are more
       fundamental (i.e. `TypeModel` and `DartExpression()` rather than `ExpressionInfo`).
    """
    shared
    DartExpression generateInvocationSynthetic(
            DScope scope,
            TypeModel receiverType,
            DartExpression generateReceiver(),
            String memberName,
            [Expression*] | [DartExpression()*] arguments,
            "See notes on [[generateInvocationFromName.returnType]]."
            TypeModel? returnType = null)
        =>  generateInvocationDetailsSynthetic {
                scope;
                receiverType;
                generateReceiver;
                memberName;
                arguments;
                returnType;
            }[2]();

    """The same as [[generateInvocationFromName]], but with parameters that are more
       fundamental (i.e. `TypeModel` and `DartExpression()` rather than `ExpressionInfo`).
    """
    shared
    [TypeModel, FunctionOrValueModel?, DartExpression()]
    generateInvocationDetailsSynthetic(
            DScope scope,
            TypeModel receiverType,
            DartExpression generateReceiver(),
            String memberName,
            [Expression*] | [DartExpression()*] arguments,
            "See notes on [[generateInvocationFromName.returnType]]."
            TypeModel? returnType = null) {

        // 1. Get a TypedDeclaration for the member
        // 2. Get a TypeDeclaration for the member's container
        // 3. Get a TypedReference for the member, to get the return and arg types
        // 4. Delegate to function that will that will:
        //      - Cast the receiver to a Dart denotable type for the member's container
        //      - Invoke with each argument boxed as necessary
        //      - Box and return

        // Note: `memberDeclaration` will be some refinement, not necessarily the original
        // declaration available with `memberDeclaration.refined`. This seems to work well
        // with Dart, since the most refined declaration will have the most refined
        // covariant returns, which is what we want, especially since we are not
        // supporting generics in Dart.
        //
        // For example, for `Sequential.spanFrom()`, we'll get `List.spanFrom()` that
        // returns `List<Element>`, rather than `Ranged.spanFrom()` that returns the
        // generic type `Subrange`, which, for us, would be erased-to-Object.
        //
        // What's not clear, is how we could get a TypedReference for
        // `Sequential.spanFrom()`, which would have the most precise return type,
        // since in this case, the realzation of `Ranged.spanFrom()` is `[Element*]`
        // rather than `List<Element>`.
        assert (is FunctionOrValueModel memberDeclaration =
                    receiverType.declaration.getMember(memberName, null, false));

        value typedReference = receiverType.getTypedMember(memberDeclaration, null);

        value signature = CeylonList {
            ctx.unit.getCallableArgumentTypes(typedReference.fullType);
        };

        value rhsType = returnType else typedReference.type;

        value rhsDeclaration =
                if (is FunctionModel memberDeclaration,
                    memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        return [
            rhsType,
            rhsDeclaration,
            () => generateInvocation {
                scope;
                rhsType;
                receiverType;
                generateReceiver;
                memberDeclaration;
                (arguments nonempty) then
                    [signature, arguments];
            }
        ];
    }

    shared
    DartExpression generateIterable(
            DScope scope,
            [Expression*] listedArguments,
            SpreadArgument | Comprehension | Null sequenceArgument) {

        if (listedArguments.empty && !sequenceArgument exists) {
            // Easy; there are no elements.
            return withBoxingNonNative {
                scope;
                ceylonTypes.emptyType;
                dartTypes.dartInvocable {
                    scope;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }.expressionForInvocation();
            };
        }
        else if (!nonempty listedArguments) {
            // Just evaluate and return the spread expression. We don't care about the
            // lhs type, which should have already been set by code that does care.
            assert (exists sequenceArgument);
            return sequenceArgument.transform(expressionTransformer);
        }
        else {
            // Return a LazyIterable, which takes as an argument a function that lazily
            // evaluates expressions by index.
            value indexIdentifier = DartSimpleIdentifier("$i$");

            return withBoxingNonNative {
                scope;
                // Lazily using '{Anything*}' as the type, since Dart types are not
                // generic, and we haven't bothered to calculate a proper type for this
                // DartInstanceCreationExpression base on the arguments.
                //
                // If `Iterable` did have a generic supertype, we would need more
                // specific type information to avoid unecessary casts. Since it
                // doesn't, all of `Iterable<Nothing>`'s non-`Iterable` supertypes are
                // also supertypes of `Iterable<Anything>`. And, casting for
                // `Iterable<Super>` -> `Iterable<Sub>` is already suppressed in
                // `withCastingLhsRhs`.
                ceylonTypes.iterableAnythingType;
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeNameForDartModel {
                            scope;
                            dartTypes.dartLazyIterable;
                        };
                    };
                    DartArgumentList {
                        [DartIntegerLiteral(listedArguments.size),
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

                                        // Note: lazily using Anything as the LHS type,
                                        // since we really don't care about the type as
                                        // long as it's not native. If we had a proper
                                        // type for the iterable, we could use the type:
                                        //     ctx.unit.getIteratedType(typeModel);
                                        withLhsNonNative {
                                            ceylonTypes.anythingType;
                                            () => [for (i -> argument
                                                        in listedArguments.indexed)
                                                DartSwitchCase {
                                                    [];
                                                    DartIntegerLiteral(i);
                                                    [DartReturnStatement {
                                                        argument.transform {
                                                            expressionTransformer;
                                                        };
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
                                () => sequenceArgument.transform {
                                    expressionTransformer;
                                };
                            }
                        case (is Null)
                            DartNullLiteral()
                        ];
                    };
                };
            };
        }
    }

    shared
    DartExpression generateTuple(
            DScope scope,
            [Expression*] listedArguments,
            SpreadArgument | Comprehension | Null sequenceArgument) {

        if (listedArguments.empty && !sequenceArgument exists) {
            // If there are no arguments, its empty.
            return
            withBoxingNonNative {
                scope;
                ceylonTypes.emptyType;
                dartTypes.dartInvocable {
                    scope;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }.expressionForInvocation();
            };
        }

        if (!nonempty listedArguments) {
            "Not Empty and no listed arguments; a sequence argument must exist."
            assert (exists sequenceArgument);
            return generateSequentialFromArgument(sequenceArgument);
        }
        else {
            // Listed arguments, and possibly a spread argument.
            //
            // Note: we should really let the typechecker know about our internal/native
            // elements and use generateInvocation().

            value sequenceArgumentType
                =   switch (sequenceArgument)
                    case (is SpreadArgument)
                        SpreadArgumentInfo(sequenceArgument).typeModel
                    case (is Comprehension)
                        iterableComprehensionType(sequenceArgument)
                    case (is Null)
                        null;

            "The type of the sequence argument, if any."
            value restType
                =   if (exists sequenceArgumentType) then
                        ceylonTypes.getSequentialTypeForIterable(sequenceArgumentType)
                    else
                        null;

            "The type of the tuple that we are instantiating."
            value tupleType
                =   ceylonTypes.getTupleType {
                        listedArguments.collect {
                            compose(ExpressionInfo.typeModel, ExpressionInfo);
                        };
                        firstDefaulted = null;
                        restType;
                    };

            return
            withBoxingNonNative {
                scope;
                tupleType;
                DartInstanceCreationExpression {
                    false;
                    DartConstructorName {
                        dartTypes.dartTypeName {
                            scope;
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
                                // if we cared about the type, we'd find the union of all
                                // of the expression types, to use as the sequence type.
                                ceylonTypes.anythingType;
                                () => listedArguments.collect {
                                    (element) => element.transform(expressionTransformer);
                                };
                            };
                        },
                        if (exists sequenceArgument) then
                            // Using `sequentialAnythingType` since the non-generic
                            // Dart function takes a non-generic `Sequential`. If we
                            // instead used `restType`, there would be some unecessary
                            // casts from `Sequential` to `Sequence`.
                            withLhsNonNative {
                                ceylonTypes.sequentialAnythingType;
                                () => generateSequentialFromArgument {
                                    sequenceArgument;
                                };
                            }
                        else
                            null
                        ].coalesced.sequence();
                    };
                };
            };
        }
    }

    "Generates a DartExpression that produces a native boolean.

     NOTE: This function unconventionally wraps the transformation in
     `withLhsNative`, relieving callers of that duty."
    shared
    DartExpression generateBooleanConditionExpression
            (BooleanCondition that, Boolean negate = false)
        =>  let (e = withLhsNative {
                ceylonTypes.booleanType;
                () => that.condition.transform(expressionTransformer);
            })
            if (negate)
            then DartPrefixExpression("!", e)
            else e;

    shared
    [DartVariableDeclarationStatement?, DartExpression, VariableTriple=]
    generateIsConditionExpression(IsCondition that, Boolean negate = false) {
        // IsCondition holds a TypedVariable that may
        // or may not include a specifier to define a new variable

        // NOTE: There is no ast node for the typechecker's
        // Tree.IsCondition.Variable (we just get the specifier
        // and identifier from that node, but not the model info).
        // Instead, use ConditionInfo.variableDeclarationModel.

        // TODO string escaping
        // TODO types! (including union and intersection, but not reified yet)
        // TODO check not null for Objects
        // TODO check null for Null
        // TODO consider null issues for negated checks
        // TODO consider erased types, like `Integer? i = 1; assert (is Integer i);`

        value info = IsConditionInfo(that);

        "The type we are testing for"
        value isType = TypeInfo(that.variable.type).typeModel;

        "The declaration model for the new variable"
        value variableDeclaration = info.variableDeclarationModel;

        //"The type of the new variable (intersection of isType and expression/old type)"
        //value variableType = variableDeclaration.type;

        "The expression node if defining a new variable"
        value expression = that.variable.specifier?.expression;


        []|[VariableTriple] replacements;
        DartVariableDeclarationStatement? tempDefinition;
        DartExpression conditionExpression;

        // new variable, or narrowing existing?
        if (exists expression) {
            // 1. declare the new variable
            // 2. evaluate expression to temp variable of type of expression
            // 3. check type of the temp variable
            // 4. set the new variable, with appropriate boxing
            // (perform 2-4 in a new block to scope the temp var)

            value variableIdentifier = DartSimpleIdentifier(
                    dartTypes.getName(variableDeclaration));

            value expressionType = ExpressionInfo(expression).typeModel;

            value tempIdentifier = DartSimpleIdentifier(
                    dartTypes.createTempName(variableDeclaration));

            // 1. declare the new variable
            value replacementDeclaration
                =   DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            dartTypes.dartTypeNameForDeclaration {
                                info;
                                variableDeclaration;
                            };
                            [DartVariableDeclaration {
                                variableIdentifier;
                            }];
                        };
                    };

            // 2. evaluate to tmp variable
            tempDefinition =
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    dartTypes.dartTypeName(info, expressionType, true);
                    [DartVariableDeclaration {
                        tempIdentifier;
                        // possibly erase to a native type!
                        withLhsNative {
                            expressionType;
                            () => expression.transform(expressionTransformer);
                        };
                    }];
                };
            };

            // 3. perform is check on tmp variable
            conditionExpression
                =   generateIsExpression {
                        info;
                        expressionType;
                        // no declaration; native, if possible
                        null;
                        tempIdentifier;
                        isType;
                    };

            // 4. set replacement variable
            value replacementDefinition
                =   DartExpressionStatement {
                        DartAssignmentExpression {
                            variableIdentifier;
                            DartAssignmentOperator.equal;
                            withLhs {
                                null;
                                variableDeclaration;
                                () => withBoxing {
                                    info;
                                    // as noted above, tmpVariable may be erased. Maybe
                                    // when narrowing optionals like String?.
                                    expressionType;
                                    null;
                                    tempIdentifier;
                                };
                            };
                        };
                    };

            replacements
                =   [VariableTriple {
                        variableDeclaration;
                        replacementDeclaration;
                        replacementDefinition;
                    }];
        }
        else {
            tempDefinition = null;

            // check type of the original variable,
            // possibly declare new variable with a narrowed type
            assert (is FunctionOrValueModel od
                =   variableDeclaration.originalDeclaration);

            value originalDeclaration
                =   dartTypes.declarationConsideringElidedReplacements(od);

            value originalIdentifier
                =   DartSimpleIdentifier(dartTypes.getName(originalDeclaration));

            conditionExpression
                =   generateIsExpression {
                        info;
                        originalDeclaration.type;
                        originalDeclaration;
                        originalIdentifier;
                        isType;
                    };

            replacements
                =   if (nonempty r = generateReplacementVariableDefinition(
                                        info, variableDeclaration))
                    then [VariableTriple(variableDeclaration, *r)]
                    else [];
        }

        return [tempDefinition,
                if (that.negated != negate)
                    then DartPrefixExpression("!", conditionExpression)
                    else conditionExpression,
                *replacements];
    }

    "Generate a replacement variable declaration and assignment for a narrowing operation
     *iff* the dart type changed. If a non-empty value is returned, a replacement name
     will have been generated by [[DartTypes.getOrCreateReplacementName]].

     The declaration and assignment are returned as separate statements for consistency
     with other operations (particularly `is` and `exists` conditions) that require
     separate declarations for scoping reasons."
    shared
    []|[DartVariableDeclarationStatement,DartExpressionStatement]
    generateReplacementVariableDefinition(DScope scope, ValueModel variableDeclaration) {

        assert(is ValueModel originalDeclaration
            =   variableDeclaration.originalDeclaration);

        // erasure to native may have changed
        // erasure to object may have changed
        // type may have narrowed
        value dartTypeChanged
            =   dartTypes.dartTypeModelForDeclaration(originalDeclaration) !=
                dartTypes.dartTypeModelForDeclaration(variableDeclaration);

        if (!dartTypeChanged) {
            return [];
        }

        value replacementName
            =   DartSimpleIdentifier {
                    dartTypes.getOrCreateReplacementName(variableDeclaration);
                };

        return
        [DartVariableDeclarationStatement {
            DartVariableDeclarationList {
                keyword = null;
                dartTypes.dartTypeNameForDeclaration {
                    scope;
                    variableDeclaration;
                };
                [DartVariableDeclaration {
                    replacementName;
                }];
            };
        },
        DartExpressionStatement {
            DartAssignmentExpression {
                replacementName;
                DartAssignmentOperator.equal;
                withLhs {
                    null;
                    variableDeclaration;
                    () => withBoxing {
                        scope;
                        originalDeclaration.type; // good enough???
                        // FIXME possibly false assumption that refined
                        // will be null for non-initial declarations
                        // (is refinedDeclaration propagated?)
                        originalDeclaration;
                        DartSimpleIdentifier {
                            dartTypes.getName(originalDeclaration);
                        };
                    };
                };
            };
        }];
    }

    shared
    ConditionCodeTuple generateConditionExpression
            (Condition condition, Boolean negate = false)
        =>  switch (condition)
            case (is BooleanCondition)
                [null, generateBooleanConditionExpression(condition, negate)]
            case (is IsCondition)
                generateIsConditionExpression(condition, negate)
            case (is ExistsOrNonemptyCondition)
                generateExistsOrNonemptyConditionExpression(condition, negate);

    shared
    ConditionCodeTuple generateExistsOrNonemptyConditionExpression(
            ExistsOrNonemptyCondition that, Boolean negate = false) {

        value info = ExistsOrNonemptyConditionInfo(that);

        // ExistsCondition holds
        //  - a MemberName to test existing values, or
        //  - a SpecifiedPattern for new declarations and destructures

        if (is SpecifiedPattern sp = that.tested) {
            // New variable or destructure. We'll treat new variables as
            // degenerate destructures, as ceylon.ast does.
            value tempIdentifier = DartSimpleIdentifier {
                dartTypes.createTempNameCustom();
            };

            value expression = sp.specifier.expression;
            value expressionType = ExpressionInfo(expression).typeModel;

            value tempVariableDeclaration
                =   DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            dartTypes.dartTypeName(info, expressionType, true);
                            [DartVariableDeclaration {
                                tempIdentifier;
                                // possibly erase to a native type (although not really
                                // for exists and nonempty tests
                                withLhsNative {
                                    expressionType;
                                    () => expression.transform(expressionTransformer);
                                };
                            }];
                        };
                    };

            value conditionExpression
                =   switch (that)
                    case (is ExistsCondition)
                        generateExistsExpression {
                            info;
                            expressionType;
                            // no declaration; native, if possible
                            null;
                            tempIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            info;
                            expressionType;
                            // no declaration; native, if possible
                            null;
                            tempIdentifier;
                            that.negated != negate;
                        };

            if (is VariablePattern p = sp.pattern) {
                value variableDeclaration
                    =   UnspecifiedVariableInfo(p.variable).declarationModel;

                value variableIdentifier
                    =   DartSimpleIdentifier(dartTypes.getName(variableDeclaration));

                value replacementDeclaration
                    =   DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                keyword = null;
                                dartTypes.dartTypeNameForDeclaration {
                                    info;
                                    variableDeclaration;
                                };
                                [DartVariableDeclaration {
                                    variableIdentifier;
                                }];
                            };
                        };

                value replacementDefinition
                    =   DartExpressionStatement {
                            DartAssignmentExpression {
                                variableIdentifier;
                                DartAssignmentOperator.equal;
                                withLhs {
                                    null;
                                    variableDeclaration;
                                    () => withBoxing {
                                        info;
                                        expressionType;
                                        null;
                                        tempIdentifier;
                                    };
                                };
                            };
                        };

                value replacements
                    =   VariableTriple {
                            variableDeclaration;
                            replacementDeclaration;
                            replacementDefinition;
                        };

                return [tempVariableDeclaration, conditionExpression, replacements];
            }
            else {
                throw CompilerBug(that, "destructure not yet supported");
            }
        }
        else {
            assert (exists variableDeclaration = info.variableDeclarationModel);

            // check type of the original variable,
            // possibly declare new variable with a narrowed type
            assert (is FunctionOrValueModel od
                =   variableDeclaration.originalDeclaration);

            value originalDeclaration
                =   dartTypes.declarationConsideringElidedReplacements(od);

            value originalIdentifier
                =   DartSimpleIdentifier(dartTypes.getName(originalDeclaration));

            value conditionExpression
                =   switch (that)
                    case (is ExistsCondition)
                        generateExistsExpression {
                            info;
                            originalDeclaration.type;
                            originalDeclaration;
                            originalIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            info;
                            originalDeclaration.type;
                            originalDeclaration;
                            originalIdentifier;
                            that.negated != negate;
                        };

            // We could *almost* just delete this for "exists". On dart, intersecting
            // with Object never changes the type since numbers, etc. can be null.
            // But... the type *does* change on `!exists`, since null erases to object!
            value replacements
                =   if (nonempty r = generateReplacementVariableDefinition(
                                info, variableDeclaration))
                    then [VariableTriple(variableDeclaration, *r)]
                    else [];

            return [null, conditionExpression, *replacements];
        }
    }

    shared
    DartExpression generateExistsExpression(
            DScope scope,
            TypeModel | TypeDetails typeToCheck,
            FunctionOrValueModel? declarationToCheck,
            DartExpression expressionToCheck,
            Boolean negated = false)
        =>  let (expression = generateIsExpression {
                    scope;
                    typeToCheck;
                    declarationToCheck;
                    expressionToCheck;
                    ctx.ceylonTypes.nullType;
                })
            if (!negated)
            then DartPrefixExpression("!", expression)
            else expression;

    shared
    DartExpression generateNonemptyExpression(
            DScope scope,
            TypeModel | TypeDetails typeToCheck,
            FunctionOrValueModel? declarationToCheck,
            DartExpression expressionToCheck,
            Boolean negated = false)
        =>  let (expression = generateIsExpression {
                    scope;
                    typeToCheck;
                    declarationToCheck;
                    expressionToCheck;
                    ctx.ceylonTypes.sequenceAnythingType;
                })
            if (negated)
            then DartPrefixExpression("!", expression)
            else expression;

    shared
    DartExpression generateIsExpression(
            DScope scope,
            TypeModel | TypeDetails typeToCheck,
            FunctionOrValueModel? declarationToCheck,
            DartExpression expressionToCheck,
            TypeModel isType) {

        // TODO - Warn if non-denotable or if non-reified checks are not sufficient.
        //      - Optimize away unecessary checks

        if (isType.union) {
            value result = CeylonList(isType.caseTypes).reversed
                .map((isTypeComponent)
                    =>  generateIsExpression {
                            scope;
                            typeToCheck;
                            declarationToCheck;
                            expressionToCheck;
                            isTypeComponent;
                        })
                .reduce((DartExpression partial, c) =>
                    DartBinaryExpression(c, "||", partial));

            assert (exists result);
            return result;
        }
        else if (isType.intersection) {
            value result = CeylonList(isType.satisfiedTypes).reversed
                .map((isTypeComponent)
                    =>  generateIsExpression {
                            scope;
                            typeToCheck;
                            declarationToCheck;
                            expressionToCheck;
                            isTypeComponent;
                        })
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "&&", partial));

            assert (exists result);
            return result;
        }
        // Non-denotable types we can handle
        else if (ceylonTypes.isCeylonNull(isType)) {
            return
            DartBinaryExpression {
                expressionToCheck;
                "==";
                DartNullLiteral();
            };
        }
        else if (ceylonTypes.isCeylonNothing(isType)) {
            return DartBooleanLiteral(false);
        }
        else if (!dartTypes.denotable(isType)) {
            // This isn't good! But no alternative w/o reified generics
            // TODO check satisfied types && isType.isSubtypeOf(ceylonTypes.nullType)
            if (isType.isSubtypeOf(ceylonTypes.objectType)) {
                return
                DartBinaryExpression {
                    expressionToCheck;
                    "!=";
                    DartNullLiteral();
                };
            }
            else {
                return DartBooleanLiteral(true);
            }
        }
        else {
            return
            DartIsExpression {
                expressionToCheck;
                dartTypes.dartTypeNameForIsTest {
                    scope;
                    typeToCheck;
                    declarationToCheck;
                    isType;
                };
            };
        }
    }

    "Generate a dart *declaration* for a [[ValueDeclaration]] or [[ValueDefinition]]. The
     latter is supported for eager class values which must be declared as members but
     initialized in a dart constructor."
    shared
    DartVariableDeclarationList generateForValueDeclaration
            (ValueDeclaration | ValueDefinition that)
        =>  let (info = AnyValueInfo(that))
            generateForValueDeclarationRaw(info, info.declarationModel);

    "Generate a dart *declaration*."
    shared see(`function generateForValueDeclaration`)
    DartVariableDeclarationList generateForValueDeclarationRaw
            (DScope scope, ValueModel declarationModel) {

        // TODO Handle translations to/from value/function, like toString.
        //      What about `variable`s?
        //      Find out where else this could be used, and use it
        //      Combine with similar functionality for declaring functions?

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                scope;
                declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    dartTypes.getPackagePrefixedName(declarationModel);
                };
                initializer = null;
            }];
        };
    }

    shared
    DartVariableDeclarationList generateForObjectDefinition(ObjectDefinition that) {
        value info = ObjectDefinitionInfo(that);

        return
        DartVariableDeclarationList {
            "final"; // TODO const for toplevels
            dartTypes.dartTypeNameForDeclaration {
                info;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    dartTypes.getPackagePrefixedName(info.declarationModel);
                };
                withLhs {
                    null;
                    info.declarationModel;
                    () => generateObjectInstantiation {
                        dScope(info, info.declarationModel);
                        info.anonymousClass;
                    };
                };
            }];
        };
    }

    shared
    DartExpression generateObjectInstantiation
            (DScope valueScope, ClassModel classModel)
        =>  withBoxingNonNative {
                valueScope;
                classModel.type;
                DartInstanceCreationExpression {
                    const = false; // TODO const for toplevels
                    dartTypes.dartConstructorName {
                        valueScope;
                        classModel;
                    };
                    DartArgumentList {
                        generateArgumentsForOuterAndCaptures {
                            // scope must be the value's scope, not the scope
                            // of the object definition!
                            valueScope;
                            classModel;
                        };
                    };
                };
            };

    shared
    [DartStatement*] generateDefaultValueAssignments
            (DScope scope, {DefaultedParameter*} defaultedParameters)
        =>  defaultedParameters.collect((param) {
                value parameterInfo
                    =   ParameterInfo(param);

                value parameterModelModel
                    =   parameterInfo.parameterModel.model;

                value paramName
                    =   DartSimpleIdentifier {
                            dartTypes.getName(parameterInfo.parameterModel);
                        };

                return
                DartIfStatement {
                    // If (parm === default)
                    DartFunctionExpressionInvocation {
                        dartTypes.dartIdentical;
                        DartArgumentList {
                            [paramName, dartTypes.dartDefault(scope)];
                        };
                    };
                    // Then set to default expression
                    DartExpressionStatement {
                        DartAssignmentExpression {
                            paramName;
                            DartAssignmentOperator.equal;
                            if (is DefaultedCallableParameter param,
                                is FunctionModel parameterModelModel) then
                                // Generate a Callable for the default function value
                                withLhs {
                                    null;
                                    parameterModelModel;
                                    () => generateNewCallable {
                                        scope;
                                        parameterModelModel;
                                        generateFunctionExpression(param);
                                        0; false;
                                    };
                                }
                            else
                                // Simple ValueModel default value
                                withLhs {
                                    null;
                                    parameterModelModel;
                                    () => param.specifier.expression
                                            .transform(expressionTransformer);
                                };
                        };
                    };
                };
            });

    shared
    DartVariableDeclarationList generateForValueDefinition(ValueDefinition that) {
        if (!that.definition is Specifier) {
            throw CompilerBug(that, "LazySpecifier not supported");
        }

        value info = ValueDefinitionInfo(that);

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                info;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    dartTypes.getPackagePrefixedName(info.declarationModel);
                };
                withLhs {
                    null;
                    info.declarationModel;
                    () => that.definition.expression.transform(expressionTransformer);
                };
            }];
        };
    }

    "Handles toplevel, class and interface member, and statement `ValueDefinition`s with
     `LazySpecifier`s and `ValueGetterDefinition`s.

     Note: non-lazy `ValueDefinition`s are handled by `generateForValueDefinition()`."

    shared
    throws(`class AssertionError`,
        "If provided a [[ValueDefinition]] with a non-lazy [[Specifier]].")
    DartFunctionDeclaration generateForValueDefinitionGetter(
            ValueDefinition|ValueGetterDefinition that) {

        value definition = that.definition;

        "True, but the typechecker is not smart enough to figure that out."
        assert (exists definition);

        "This method does not support non-lazy `Specifier`s."
        assert (!is Specifier definition);

        value declarationModel
            =   switch (that)
                case (is ValueDefinition)
                    ValueDefinitionInfo(that).declarationModel
                case (is ValueGetterDefinition)
                    ValueGetterDefinitionInfo(that).declarationModel;

        return
        generateDefinitionForValueModelGetter {
            dScope(that);
            declarationModel;
            definition;
        };
    }

    shared
    DartFunctionDeclaration generateDefinitionForValueModelGetter(
            DScope scope,
            ValueModel declarationModel,
            LazySpecifier|Block definition) {

        // TODO Take a look at generateFunctionExpression, and
        //      generateForValueDefinitionGetter and consider making more parallel.

        // Note toplevels are getters (no parameter list)
        //      within functions, not getters (empty parameter list)
        //      within classes and interfaces, getters, but MethodDeclaration instead

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    scope;
                    declarationModel;
                }.oldPairSimple;

        return
        DartFunctionDeclaration {
            false;
            dartTypes.dartTypeNameForDeclaration {
                scope;
                declarationModel;
            };
            dartElementType != dartFunction then "get";
            identifier;
            DartFunctionExpression {
                dartElementType == dartFunction then dartFormalParameterListEmpty;
                switch (definition)
                case (is LazySpecifier)
                    DartExpressionFunctionBody {
                        false;
                        withLhs {
                            null;
                            declarationModel;
                            () => definition.expression.transform(expressionTransformer);
                        };
                    }
                case (is Block)
                    DartBlockFunctionBody {
                        null;
                        false;
                        withReturn {
                            declarationModel;
                            () => statementTransformer.transformBlock {
                                definition;
                            }.first;
                        };
                    };
            };
        };
    }

    shared
    DartFunctionDeclaration generateForValueSetterDefinition
            (ValueSetterDefinition that) {

        // NOTE toplevels may be setters
        //      within functions, regular methods
        //      within classes and interfaces, setters, but MethodDeclaration instead

        // FIXME setter functions should return the argument (and not be void) to help
        //       with assignment expressions.

        // FIXME setter *static* functions for interfaces should also return the arg.

        value info = ValueSetterDefinitionInfo(that);
        value declarationModel = info.declarationModel;

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    info;
                    declarationModel;
                }.oldPairSimple;

        return
        DartFunctionDeclaration {
            false;
            DartTypeName {
                DartSimpleIdentifier {
                    "void";
                };
            };
            dartElementType != dartFunction then "set";
            identifier;
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [
                        DartSimpleFormalParameter {
                            false; false;
                            dartTypes.dartReturnTypeNameForDeclaration {
                                info;
                                declarationModel.getter;
                            };
                            DartSimpleIdentifier {
                                // use the attribute's name as the parameter name
                                dartTypes.getName(declarationModel);
                            };
                        }
                    ];
                };
                switch (definition = that.definition)
                case (is LazySpecifier)
                    // TODO if function, convert to block and return passed in value
                    DartExpressionFunctionBody {
                        false;
                        withLhsNoType {
                            () => definition.expression.transform(expressionTransformer);
                        };
                    }
                case (is Block)
                    // TODO if function, return passed in value
                    DartBlockFunctionBody {
                        null;
                        false;
                        withReturn {
                            declarationModel.getter;
                            () => statementTransformer.transformBlock {
                                definition;
                            }.first;
                        };
                    };
            };
        };
    }

    shared
    DartFunctionExpression generateFunctionExpression(
            FunctionExpression
                | FunctionDefinition
                | FunctionShortcutDefinition
                | DefaultedCallableParameter
                | FunctionArgument that) {

        FunctionModel functionModel;
        [Parameters+] parameterLists;
        LazySpecifier|Block definition;

        switch (that)
        case (is FunctionExpression) {
            value info = FunctionExpressionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
        }
        case (is FunctionDefinition) {
            value info = FunctionDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
        }
        case (is DefaultedCallableParameter) {
            value info = ParameterInfo(that);
            parameterLists = that.parameter.parameterLists;
            definition = that.specifier;
            assert (is FunctionModel m = info.parameterModel.model);
            functionModel = m;
        }
        case (is FunctionArgument) {
            value info = FunctionArgumentInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
        }

        return generateFunctionExpressionRaw {
            dScope(that);
            functionModel;
            parameterLists;
            definition;
        };
    }

    shared
    DartFunctionExpression generateFunctionExpressionRaw(
            DScope scope,
            FunctionModel functionModel,
            [Parameters+] parameterLists,
            LazySpecifier|Block definition) {

        variable DartExpression? result = null;

        for (i -> list in parameterLists.indexed.sequence().reversed) {
            if (i < parameterLists.size - 1) {
                // wrap nested function in a callable
                assert(exists previous = result);
                result = generateNewCallable(scope, functionModel, previous, i+1);
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
                            functionModel.type,
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

                // assign default values to defaulted arguments
                statements.addAll {
                    generateDefaultValueAssignments {
                        scope;
                        defaultedParameters;
                    };
                };

                // the rest of the dart function body
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
                                    null;
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
                generateFormalParameterList(scope, list);
                body;
            };
        }
        assert (is DartFunctionExpression r = result);
        return r;
    }

    shared
    DartFormalParameterList generateFormalParameterList(
            DScope scope,
            Parameters|{Parameter*}|{ParameterModel*} parameters,
            "For parameters, disregard parameterModel.defaulted when determining if the
             type should be erased-to-object."
            Boolean noDefaults=false) {

        value parameterList
            =   if (is Parameters parameters) then
                    parameters.parameters.map(
                        compose(ParameterInfo.parameterModel, ParameterInfo))
                else if (is {Parameter*} parameters) then
                    parameters.map(
                        compose(ParameterInfo.parameterModel, ParameterInfo))
                else parameters;

        if (parameterList.empty) {
            return DartFormalParameterList();
        }

        value dartParameters = parameterList.collect((parameterModel) {
            value defaulted = parameterModel.defaulted;

            // Use core.Object for defaulted parameters so we can
            // initialize with `dart$default`
            value dartParameterType =
                if (defaulted && !noDefaults)
                then dartTypes.dartObject
                else dartTypes.dartTypeNameForDeclaration(
                        scope, parameterModel.model);

            value dartSimpleParameter =
            DartSimpleFormalParameter {
                false; false;
                dartParameterType;
                DartSimpleIdentifier {
                    dartTypes.getName(parameterModel);
                };
            };

            if (defaulted && !noDefaults) {
                return
                DartDefaultFormalParameter {
                    dartSimpleParameter;
                    dartTypes.dartDefault(scope);
                };
            }
            else {
                return dartSimpleParameter;
            }
        });
        return DartFormalParameterList {
            positional = true;
            parameters = dartParameters;
        };
    }

    shared
    [DartExpression*] generateArgumentsForOuterAndCaptures
            (DScope scope, ClassModel | ConstructorModel declaration) {

        value classModel = getClassModelForConstructor(declaration);

        // FIXME setters?
        value captureExpressions
            =   dartTypes.captureDeclarationsForClass(classModel)
                    .map((capture)
                        =>  dartTypes.invocableForBaseExpression(scope, capture, false))
                    .map(uncurry(DartQualifiedInvocable.expressionForLocalCapture));

        value outerExpression
            =   if (exists container = getContainingClassOrInterface(scope),
                    exists outerCI = getContainingClassOrInterface(classModel.container))
                then [dartTypes.expressionToOuter(container, outerCI)]
                else []; // No outer if no containing class or interface.

        return concatenate { outerExpression, captureExpressions };
    }

    "Generate a condition expression for a MatchCase of a switch statement or expression."
    shared
    DartExpression generateMatchCondition(
            DScope scope,
            TypeModel switchedType,
            DartExpression switchedVariable,
            [Expression+] matchExpressions) {

        "equals() test for a single expression"
        function generateMatchCondition(Expression expression)
            =>  withLhsNative {
                    ceylonTypes.booleanType;
                    () => generateInvocationSynthetic {
                        scope;
                        switchedType;
                        // We may need to box the switched expression, which
                        // has already been evaluated to the potentially
                        // native switchedVariable.
                        () => withBoxing {
                            scope;
                            switchedType;
                            null;
                            switchedVariable;
                        };
                        "equals";
                        [expression];
                    };
                };

        return matchExpressions
                .reversed
                .map(generateMatchCondition)
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "||", partial));
    }

    "Determine switched expression type and generate dart expressions for
     a `SwitchClause`. Returns:

     - The [[TypeModel]] of the switched expression.
     - A [[DartSimpleIdentifier]] for a new dart variable to hold the switched value.
     - A [[DartVariableDeclarationStatement]] to declare the dart variable for the
       switched value."
    shared
    [TypeModel, ValueModel?, DartSimpleIdentifier,
        DartVariableDeclarationStatement]
    generateForSwitchClause(SwitchClause that) {
        value info = NodeInfo(that);

        TypeModel switchedType;
        ValueModel? switchedDeclaration;
        DartSimpleIdentifier switchedVariable;
        DartVariableDeclarationStatement variableDeclaration;

        switch (switched = that.switched)
        case (is Expression) {
            switchedType
                =   ExpressionInfo(switched).typeModel;

            switchedDeclaration
                =   null;

            switchedVariable
                =   DartSimpleIdentifier(dartTypes.createTempNameCustom("switch"));

            // evaluate the switched expression to a possibly native temp variable
            variableDeclaration
                =   DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeName {
                                info;
                                switchedType;
                                eraseToNative = true;
                                eraseToObject = false;
                            };
                            [DartVariableDeclaration {
                                switchedVariable;
                                withLhsNative {
                                    switchedType;
                                    () => switched.transform(expressionTransformer);
                                };
                            }];
                        };
                    };
        }
        case (is SpecifiedVariable) {
            switchedDeclaration
                =   SpecifiedVariableInfo(switched).declarationModel;

            assert (exists switchedDeclaration);

            switchedType
                =   switchedDeclaration.type;

            switchedVariable
                =   DartSimpleIdentifier {
                        dartTypes.getName(switchedDeclaration);
                    };

            // declare the specified variable
            variableDeclaration
                =   DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                info;
                                switchedDeclaration;
                            };
                            [DartVariableDeclaration {
                                DartSimpleIdentifier {
                                    dartTypes.getName(switchedDeclaration);
                                };
                                withLhs {
                                    null;
                                    switchedDeclaration;
                                    () => switched.specifier.expression.transform {
                                        expressionTransformer;
                                    };
                                };
                            }];
                        };
                    };
        }
        return [switchedType, switchedDeclaration, switchedVariable, variableDeclaration];
    }

    shared see(`function generateInvocation`)
    DartExpression generateNewCallableForQualifiedExpression(
            DScope scope,
            "The type of the receiver, which may be:
             -  the type of an expression if [[generateReceiver]] is not null, or
             -  an interface that is the container of the [[memberDeclaration]] to invoke
                [[generateReceiver]] is null, indicating that the receiver is a `super`
                reference."
            TypeModel receiverType,
            "A function to generate the receiver of type [[receiverType]], or null if the
             receiver is a `super` reference."
            DartExpression()? generateReceiver,
            "Must be true if the receiver is not a constant, and therefore should be
             eagerly evaluated to avoid re-evaluation each time the Callable is invoked."
            Boolean eagerlyEvaluateReceiver,
            FunctionModel | ClassModel | ConstructorModel memberDeclaration,
            TypeModel callableType,
            AnyMemberOperator? memberOperator = null) {

        // TODO optimize away the invocation and outer function wrapper, and simply
        //      return a Dart function reference when possible. This can be done when:
        //
        //      - neither the return nor arguments require boxing
        //      - the member operator is not null-safe or spread
        //      - we do not need to invoke a static dart interface method
        //          - non-shared methods
        //          - qualified with super
        //      - other restrictions from reviewing generateInvocation?

        "Parameters for the first parameter list"
        value parameters = CeylonList(memberDeclaration.firstParameterList.parameters);

        "The actual return type given the receiver's parameterization"
        value resultType = ctx.unit.getCallableReturnType(callableType);

        "The actual signature given the receiver's parameterization"
        value signature = CeylonList(ctx.unit.getCallableArgumentTypes(callableType));

        "Identifiers to use for the outer callable."
        DartSimpleIdentifier(ParameterModel) outerParameterIdentifier
            =   compose {
                    assertExists<DartSimpleIdentifier?>;
                    map(parameters.indexed.collect((e)
                        =>  e.item -> DartSimpleIdentifier("$``e.key``"))).get;
                };

        "Dart parameters for the *outer* function–the one with the public facing
         signature."
        value outerParameters = parameters.collect((parameterModel) {
            value dartSimpleParameter
                =   DartSimpleFormalParameter {
                        false; false;
                        // $dart$core.Object for the type of all parameters since
                        // `Callable` is generic
                        dartTypes.dartObject;
                        outerParameterIdentifier(parameterModel);
                    };

            if (parameterModel.defaulted) {
                return
                DartDefaultFormalParameter {
                    dartSimpleParameter;
                    dartTypes.dartDefault(scope);
                };
            }
            else {
                return dartSimpleParameter;
            }
        });

        "Generator functions to produce arguments for the invocation wrapped by the
         `Callable`.

         The functions will be called by `generateInvocation`, which is responsible
         for determining lhs types. But, we must by-pass boxing at runtime for default
         value indicator values."
        value innerArguments = parameters.collect((parameterModel) {
            return () {
                "The caller is responsible for `withLhs`."
                value boxed
                    =   withBoxing {
                            scope;
                            // Parameters for Callables are always `core.Object`
                            rhsType = ceylonTypes.anythingType;
                            rhsDeclaration = null;
                            outerParameterIdentifier(parameterModel);
                        };

                if (parameterModel.defaulted) {
                    return
                    DartConditionalExpression {
                        // condition
                        DartFunctionExpressionInvocation {
                            dartDCIdentical;
                            DartArgumentList {
                                [outerParameterIdentifier(parameterModel),
                                 dartTypes.dartDefault(scope)];
                            };
                        };
                        // propagate defaulted
                        thenExpression = dartTypes.dartDefault(scope);
                        // not default, use boxed/unboxed value
                        elseExpression = boxed;
                    };
                }
                else {
                    return boxed;
                }
            };
        });

        // memberContainer, receiverModel, and receiverDenotableType are really only
        // needed if eagerlyEvaluateReceiver & exists generateReceiver.

        "What else would the container be than a Class or Interface?"
        assert (is ClassModel | InterfaceModel memberContainer
            =   container(memberDeclaration));

        "What else would the receiver be than a Class or Interface?"
        assert (is ClassModel | InterfaceModel receiverModel
            =   if (is ConstructorModel memberDeclaration)
                then container(memberContainer)
                else memberContainer);

        value receiverDenotableType
            =   ceylonTypes.denotableType {
                    receiverType;
                    receiverModel;
                };

        "The outer function, serving as the delegate for the Callable. This function
         accepts and returns non-erased types."
        value outerFunction
            =   DartFunctionExpression {
                    DartFormalParameterList {
                        true; false;
                        outerParameters;
                    };
                    DartExpressionFunctionBody {
                        false;
                        withLhsNonNative {
                            lhsType = resultType;
                            () => generateInvocation {
                                scope;
                                resultType;
                                receiverType;
                                if (!eagerlyEvaluateReceiver
                                    || !generateReceiver exists) then
                                    // The receiver is a constant so the expression
                                    // produced by generateReceiver is safe to
                                    // re-evaluate on each invocation of the Callable.
                                    generateReceiver
                                else
                                    // We have to eagerly evaluate the expression that
                                    // produces the receiver in an outer closure. It will
                                    // be assigned to $r.
                                    (() => withBoxingNonNative {
                                        scope;
                                        receiverDenotableType;
                                        DartSimpleIdentifier {
                                            "$r";
                                        };
                                    });
                                memberDeclaration;
                                [signature, innerArguments];
                                memberOperator;
                            };
                        };
                    };
                };

        value variadicParameterIndex
            =   (parameters.getFromLast(0)?.sequenced else false)
                then parameters.size - 1;

        value callable
            =   createCallable(scope, outerFunction, variadicParameterIndex);

        // Eagerly evaluate the receiver, if necessary
        if (eagerlyEvaluateReceiver, exists generateReceiver) {
            return
            createExpressionEvaluationWithSetup {
                [DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartTypeName {
                            scope;
                            receiverDenotableType;
                            eraseToNative = false;
                        };
                        [DartVariableDeclaration {
                            DartSimpleIdentifier {
                                "$r";
                            };
                            withLhsNonNative {
                                receiverDenotableType;
                                generateReceiver;
                            };
                        }];
                    };
                }];
                callable;
            };
        }
        return callable;
    }

    shared
    DartInstanceCreationExpression generateNewCallable(
            DScope scope,
            FunctionModel | ClassModel | ConstructorModel functionModel,
            DartExpression? delegateFunction = null,
            Integer parameterListNumber = 0,
            Boolean delegateReturnsCallable =
                    parameterListNumber <
                    functionModel.parameterLists.size() - 1) {

        // TODO take the Callable's TypeModel as an argument in order to have
        //      correct (non-erased-to-Object) parameter and return types for
        //      generic functions

        DartExpression outerFunction;

        TypeModel returnType;
        FunctionOrValueModel | ClassModel | ConstructorModel? returnDeclaration;
        if (delegateReturnsCallable) {
            returnType = ceylonTypes.callableDeclaration.type;
            returnDeclaration = null;
        }
        else {
            returnType = functionModel.type;
            returnDeclaration = functionModel;
        }

        value parameters = CeylonList(functionModel.parameterLists
                .get(parameterListNumber).parameters);

        "True if boxing is required. If `true`, an extra outer function will be created
         to handle boxing and null safety."
        value needsWrapperFunction =
                functionModel is ClassModel | ConstructorModel
                || (!delegateReturnsCallable
                    && dartTypes.erasedToNative(functionModel))
                || parameters.any((parameterModel)
                    =>  dartTypes.erasedToNative(parameterModel.model));

        if (!needsWrapperFunction) {
            "A bit ugly, but we do know it's not a ClassModel | ConstructorModel
             from above test."
            assert (!is ClassModel | ConstructorModel functionModel);
            outerFunction
                =   delegateFunction else
                    dartTypes.invocableForBaseExpression {
                        scope;
                        functionModel;
                    }.expressionForClosure();
        }
        else {
            "Identifiers to use for the outer callable."
            DartSimpleIdentifier(ParameterModel) outerParameterIdentifier
                =   compose {
                        assertExists<DartSimpleIdentifier?>;
                        map(parameters.indexed.collect((e)
                            =>  e.item -> DartSimpleIdentifier("$``e.key``"))).get;
                    };

            // Generate outerFunction to handle boxing and/or call to constructor
            value outerParameters = parameters.collect((parameterModel) {
                value dartSimpleParameter =
                        DartSimpleFormalParameter {
                            false; false;
                            // Technically, we *should* be using `$dart$core.Object`
                            // for the param types, but then we'd need ugly casting
                            // in `innerArguments` below. This simplification is fine
                            // for Dart since function references don't really have types
                            // anyway - there is no type checking when calling a function
                            // reference.
                            dartTypes.dartTypeName {
                                scope;
                                parameterModel.type;
                                // Callables are generic, so never erase to native.
                                eraseToNative = false;
                                eraseToObject = false;
                            };
                            outerParameterIdentifier(parameterModel);
                        };

                if (parameterModel.defaulted) {
                    return
                    DartDefaultFormalParameter {
                        dartSimpleParameter;
                        dartTypes.dartDefault(scope);
                    };
                }
                else {
                    return dartSimpleParameter;
                }
            });

            "Extra leading arguments for non-toplevel classes."
            value outerAndCaptureArguments
                =   if (is ClassModel | ConstructorModel functionModel) then
                        generateArgumentsForOuterAndCaptures {
                            scope;
                            functionModel;
                        }
                    else [];

            "Arguments that are part of the public signature for the class or function.
             They have corresponding parameters in the generated Callable."
            value innerArguments = parameters.collect((parameterModel) {
                value unboxed = withLhs {
                    null;
                    // "lhs" is the inner function's parameter
                    lhsDeclaration = parameterModel.model;
                    // As noted above, Callables are generic, so params are never erased
                    // to native (iow, expect non-natives to be passed in).
                    () => withBoxingNonNative {
                        scope;
                        rhsType = parameterModel.type;
                        outerParameterIdentifier(parameterModel);
                    };
                };

                if (parameterModel.defaulted) {
                    return
                    DartConditionalExpression {
                        // condition
                        DartFunctionExpressionInvocation {
                            dartDCIdentical;
                            DartArgumentList {
                                [outerParameterIdentifier(parameterModel),
                                 dartTypes.dartDefault(scope)];
                            };
                        };
                        // propagate defaulted
                        dartTypes.dartDefault(scope);
                        // not default, unbox as necessary
                        unboxed;
                    };
                }
                else {
                    return
                    unboxed;
                }
            });

            // prepare the actual invocation expression

            DartExpression invocation;
            switch (functionModel)
            case (is FunctionModel) {
                invocation
                    =   DartFunctionExpressionInvocation {
                            delegateFunction
                            else dartTypes.invocableForBaseExpression {
                                scope;
                                functionModel;
                            }.expressionForClosure();
                            DartArgumentList {
                                innerArguments;
                            };
                        };
            }
            case (is ClassModel | ConstructorModel) {
                invocation
                    =   dartTypes.dartInvocable {
                            scope;
                            functionModel; // really class or constructor
                            false;
                        }.expressionForInvocation {
                            null;
                            concatenate {
                                outerAndCaptureArguments,
                                innerArguments
                            };
                        };
            }

            // the outer function accepts and returns non-erased types
            // using the inner function that follows normal erasure rules
            outerFunction =
            DartFunctionExpression {
                DartFormalParameterList {
                    positional = true;
                    named = false;
                    parameters = outerParameters;
                };
                DartExpressionFunctionBody {
                    false;
                    // return boxed (no erasure) result of
                    // the invocation of the original function
                    withLhsNonNative {
                        returnType;
                        () => withBoxing {
                            scope;
                            returnType;
                            returnDeclaration;
                            invocation;
                        };
                    };
                };
            };
        }

        value variadicParameterIndex
            =   (parameters.getFromLast(0)?.sequenced else false)
                then parameters.size - 1;

        // create the Callable!
        return createCallable(scope, outerFunction, variadicParameterIndex);
    }

    "Generate a DartExpression for a series of `BooleanCondition`s."
    shared
    DartExpression generateBooleanDartCondition({BooleanCondition+} conditions)
            =>  withLhsNative {
                    ceylonTypes.booleanType;
                    () => sequence(conditions)
                            .reversed
                            .map(generateBooleanConditionExpression)
                            .reduce {
                                (DartExpression partial, c)
                                    =>  DartBinaryExpression(c, "&&", partial);
                            };
                };

    shared
    [[DartStatement*], [DartExpression*]] generateArgumentsFromPositionalArguments(
            PositionalArguments positionalArguments,
            List<TypeModel | TypeDetails> signature,
            ParameterListModel parameterList) {

        value scope
            =   dScope(positionalArguments);

        value argumentList
            =   positionalArguments.argumentList;

        value listedArguments
            =   argumentList.listedArguments;

        value sequenceArg
            =   argumentList.sequenceArgument;

        value sequenceArgInfo
            =   sequenceArgumentInfo(sequenceArg);

        value sequenceArgType
            =   switch (sequenceArgInfo)
                case (is SpreadArgumentInfo)
                    sequenceArgInfo.typeModel
                case (is ComprehensionInfo)
                    iterableComprehensionType(sequenceArgInfo.node)
                case (is Null) null;

        value listedParameterCount
            =   parameterList.parameters.size()
                    - (if(parameterList.hasSequencedParameter())
                       then 1 else 0);

        // Handle the easy case where the spread argument, if present, is *not* used for
        // listed parameters. All arguments can be evaluated inline.
        if (listedArguments.size >= listedParameterCount || !sequenceArg exists) {
            [DartStatement*] dartStatements;
            value dartArguments = LinkedList<DartExpression>();

            // Handle crazy scenario where we have an Empty sequenceArg that must be
            // evaluated for side effects, but no place to put it.
            if (listedParameterCount == 0
                    && !parameterList.hasSequencedParameter(),
                    exists sequenceArg) {

                dartStatements
                    =   [DartExpressionStatement {
                            withLhsNoType {
                                () => generateSequentialFromArgument {
                                    sequenceArg;
                                };
                            };
                        }];
            }
            else {
                dartStatements = [];
            }

            // Main loop to populate dartArguments
            for (i -> parameter in CeylonIterable(parameterList.parameters).indexed) {
                assert (exists parameterType = signature[i]); // the *lhs* type
                if (parameter.sequenced) {
                    dartArguments.add {
                        withLhs {
                            parameterType;
                            parameter.model;
                            () => generateTuple {
                                scope;
                                listedArguments[i...]; // may be []
                                sequenceArg; // may be null
                            };
                        };
                    };
                }
                else if (i == listedParameterCount - 1
                            && !parameterList.hasSequencedParameter(),
                        exists expression = listedArguments[i],
                        exists sequenceArg) {

                    // Crazy scenario. There is an "extra" Empty sequence argument that
                    // doesn't have a matching parameter, but must be evaluated for
                    // side effects.

                    "Identifier for variable to hold the final listed argument"
                    value tmpVariable
                        =   DartSimpleIdentifier(dartTypes.createTempNameCustom());

                    dartArguments.add {
                        withLhs {
                            parameterType;
                            parameter.model;
                            () => createExpressionEvaluationWithSetup {
                                // Save the argument to a variable
                                [DartVariableDeclarationStatement {
                                    DartVariableDeclarationList {
                                        null;
                                        dartTypes.dartTypeNameForDeclaration {
                                            scope;
                                            parameter.model;
                                        };
                                        [DartVariableDeclaration  {
                                            tmpVariable;
                                            expression.transform(expressionTransformer);
                                        }];
                                    };
                                },
                                // Evaluate the Empty sequenceArg for side effects
                                DartExpressionStatement {
                                    withLhsNoType {
                                        () => generateSequentialFromArgument {
                                            sequenceArg;
                                        };
                                    };
                                }];
                                // Return the argument
                                tmpVariable;
                            };
                        };
                    };
                }
                else if (exists expression = listedArguments[i]) {
                    // Just add the argument, as normal
                    dartArguments.add {
                        withLhs {
                            parameterType;
                            parameter.model;
                            () => expression.transform(expressionTransformer);
                        };
                    };
                }
                else {
                    // We're out of arguments.

                    "Precondition for this branch"
                    assert (!sequenceArg exists);

                    if (parameterList.hasSequencedParameter()) {
                        // Pad with $defaults, so we can add eventually add [] for
                        // the sequenced parameter, which per spec is never defaulted.
                        dartArguments.add(dartTypes.dartDefault(scope));
                    }
                    else {
                        // The rest are defaulted. Done.
                        break;
                    }
                }
            }
            return [dartStatements, dartArguments.sequence()];
        }

        value dartStatements = LinkedList<DartStatement>();
        value dartArguments = LinkedList<DartExpression>();

        value tmpVariablePrefix
            =  dartTypes.createTempNameCustom("arg") + "$";

        value tmpIdentifierSequence
            =  DartSimpleIdentifier(tmpVariablePrefix + "s");

        value tmpIdentifierSequenceLength
            =  DartSimpleIdentifier(tmpVariablePrefix + "l");

        for (i -> argument in listedArguments.indexed) {
            // Evaluate listed arguments to a variable. Add a statement to
            // `dartStatements` to declare the variable, and add an expression to
            // `dartArguments` for the eventual invocation.

            // Note: the listed argument expressions must be evaluated prior to
            // evaluating the spread argument, since they precede the spread argument
            // in the source.

            assert (exists parameter = parameterList.parameters.get(i));
            assert (exists parameterType = signature[i]);

            value dartIdentifier = DartSimpleIdentifier(tmpVariablePrefix + i.string);

            dartStatements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartTypeNameForDeclaration {
                            scope;
                            parameter.model;
                        };
                        [DartVariableDeclaration {
                            dartIdentifier;
                            withLhs {
                                parameterType;
                                parameter.model;
                                () => argument.transform {
                                    expressionTransformer;
                                };
                            };
                        }];
                    };
                };
            };

            // change to generator (() => boxedExpr) later
            dartArguments.add(dartIdentifier);
        }

        "Precondition for branch"
        assert(exists sequenceArg, exists sequenceArgInfo, exists sequenceArgType);

        value sequenceArgMinimumLength
            =   ceylonTypes.sequentialMinimumLength(sequenceArgType);

        value sequenceArgMaximumLength
            =   ceylonTypes.sequentialMaximumLength(
                    sequenceArgType, listedParameterCount + 1);

        value sequenceArgLengthKnown
            =   sequenceArgMinimumLength
                    == sequenceArgMaximumLength;

        value sequenceArgLengthCoversListedParameters
            =   listedParameterCount
                    <= sequenceArgMinimumLength + listedArguments.size;

        value variadicDefinitelyEmpty
            =   listedParameterCount + 1
                    > listedArguments.size + sequenceArgMaximumLength;

        "The expected type from calling `sequence()` on `sequenceArg`"
        value sequenceArgSequentialType
            =   ceylonTypes.getSequentialTypeForIterable(sequenceArgType);

        // Evaluate the sequence argument and assign to `tmpIdentifierSequence`
        dartStatements.add {
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartTypeName {
                        scope;
                        sequenceArgSequentialType;
                        false;
                        false;
                    };
                    [DartVariableDeclaration {
                        tmpIdentifierSequence;
                        withLhsNonNative {
                            sequenceArgSequentialType;
                            () => generateSequentialFromArgument {
                                sequenceArg;
                            };
                        };
                    }];
                };
            };
        };

        // If the sequence argument length is not statically known, assign its runtime
        // length to `tmpIdentifierSequenceLength`
        if (!sequenceArgLengthKnown && !sequenceArgLengthCoversListedParameters) {
            dartStatements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartInt;
                        [DartVariableDeclaration {
                            tmpIdentifierSequenceLength;
                            withLhsNative {
                                ceylonTypes.integerType;
                                () => generateInvocationSynthetic {
                                    scope;
                                    sequenceArgSequentialType;
                                    () => withBoxing {
                                        scope;
                                        sequenceArgSequentialType;
                                        null;
                                        tmpIdentifierSequence;
                                    };
                                    "size";
                                    [];
                                };
                            };
                        }];
                    };
                };
            };
        }

        // Generate the remaining arguments
        for (i -> parameter in CeylonIterable(parameterList.parameters).indexed
                .skip(listedArguments.size)) {

            assert (exists parameterType = signature[i]);

            if (parameter.sequenced && !variadicDefinitelyEmpty) {
                // Use spanFrom to generate an argument for the variadic
                dartArguments.add {
                    withLhs {
                        parameterType;
                        parameter.model;
                        // Note: casts here when the sequence arg may be `empty` are'
                        // normal and safe. Sequential does not refine `spanFrom`, but
                        // it does require Sequential returns based on it's
                        // parameterization of `Ranged`.
                        () => generateInvocationSynthetic {
                            scope;
                            sequenceArgSequentialType;
                            () => withBoxing {
                                scope;
                                sequenceArgSequentialType;
                                null;
                                tmpIdentifierSequence;
                            };
                            "spanFrom";
                            [() => withBoxing {
                                scope;
                                ceylonTypes.integerType;
                                null;
                                DartIntegerLiteral {
                                    listedParameterCount - listedArguments.size;
                                };
                            }];
                        };
                    };
                };
            }
            else if (parameter.sequenced) {
                // assert (variadicDefinitelyEmpty)
                // Long winded way of adding an `[]` argument for the variadic
                dartArguments.add {
                    withLhs {
                        parameterType;
                        parameter.model;
                        () => withBoxing {
                            scope;
                            ceylonTypes.emptyType;
                            null;
                            dartTypes.dartInvocable {
                                scope;
                                ceylonTypes.emptyValueDeclaration;
                                false;
                            }.expressionForInvocation();
                        };
                    };
                };
            }
            else if (i < listedArguments.size + sequenceArgMaximumLength) {
                // Assign a value from the spread argument to a listed parameter
                value argumentFromSequence
                    =   withLhs {
                            parameterType;
                            parameter.model;
                            () => generateInvocationSynthetic {
                                scope;
                                sequenceArgSequentialType;
                                () => withBoxing {
                                    scope;
                                    sequenceArgSequentialType;
                                    null;
                                    tmpIdentifierSequence;
                                };
                                "getFromFirst";
                                [() => withBoxing {
                                    scope;
                                    ceylonTypes.integerType;
                                    null;
                                    DartIntegerLiteral {
                                        i - listedArguments.size;
                                    };
                                }];
                            };
                        };

                if (i < listedArguments.size + sequenceArgMinimumLength) {
                    // No size check needed
                    dartArguments.add(argumentFromSequence);
                }
                else {
                    // Size check needed; the sequential may be exhausted
                    dartArguments.add {
                        DartConditionalExpression {
                            DartBinaryExpression {
                                tmpIdentifierSequenceLength;
                                ">";
                                DartIntegerLiteral(i - listedArguments.size);
                            };
                            argumentFromSequence;
                            dartTypes.dartDefault(scope);
                        };
                    };
                }
            }
            else {
                // We're out of arguments.
                // assert (i >= listedArguments.size + sequenceArgMaximumLength)
                dartArguments.add {
                    dartTypes.dartDefault(scope);
                };
            }
        }

        return [dartStatements.sequence(), dartArguments.sequence()];
    }

    "Returns the DartArgumentList (with non-native and erased-to-object arguments), and
     possibly a trailing spread argument. If a spread argument exists, the returned
     boolean will be true."
    shared
    [DartArgumentList, Boolean] generateArgumentListForIndirectInvocation
            (ArgumentList argumentList)
        =>  [DartArgumentList {
                argumentList.children.collect {
                        (argument)
                    =>  withLhsNonNative {
                            ceylonTypes.anythingType;
                            () => switch (argument)
                            case (is Expression)
                                argument.transform(expressionTransformer)
                            case (is SpreadArgument|Comprehension)
                                generateSequentialFromArgument(argument);
                        };
                };
            },
            argumentList.sequenceArgument exists];

    shared
    [[DartStatement*], DartArgumentList] generateArgumentListFromArguments(
            DScope scope,
            Arguments arguments,
            // TODO accept {TypeModel*} signature instead
            List<TypeModel | TypeDetails> signature,
            ParameterListModel | FunctionModel | ValueModel
                    | ClassModel | ConstructorModel declarationOrParameterList) {

        if (is ValueModel declarationOrParameterList) {
            // Values won't have arguments.
            return [[], DartArgumentList()];
        }

        value pList
            =   switch(declarationOrParameterList)
                case (is ParameterListModel) declarationOrParameterList
                case (is FunctionModel) declarationOrParameterList.firstParameterList
                // FIXME parameterList may be null here...
                case (is ClassModel) declarationOrParameterList.parameterList
                // FIXME parameterList may be null here...
                case (is ConstructorModel) declarationOrParameterList.parameterList;

        switch (arguments)
        case (is PositionalArguments) {
            value [argsSetup, argExpressions]
                =   generateArgumentsFromPositionalArguments {
                        arguments;
                        signature;
                        pList;
                    };

            return [argsSetup, DartArgumentList(argExpressions)];
        }
        case (is NamedArguments) {
            value [argsSetup, argExpressions]
                =   generateArgumentsFromNamedArguments {
                        arguments;
                        signature;
                        pList;
                    };

            return [argsSetup, DartArgumentList(argExpressions)];
        }
    }

    shared
    [[DartStatement*], [DartExpression*]] generateArgumentsFromNamedArguments(
            NamedArguments namedArguments,
            List<TypeModel | TypeDetails> signature,
            ParameterListModel parameterList) {

        value scope = NodeInfo(namedArguments);

        variable String? tmpVariableMemo = null;

        // Lazily create the tmpVariable to avoid wasting ids!
        value tmpVariable
            =>  tmpVariableMemo else
                (tmpVariableMemo = dartTypes.createTempNameCustom("arg"));

        value parameters
            =   CeylonList {
                    parameterList.parameters;
                };

        "A map from [[ParameterModel]] to a tuple of

            - [[Integer]] index
            - [[TypeModel]] type
            - [[FunctionOrValueModel]] the parameter's declaration
            - [[DartSimpleIdentifier]] Dart temp variable identifier"
        value parameterDetails
            =   ImmutableMap {
                    for (i->[p,a] in zipPairs(parameters, signature).indexed)
                    p -> [i, a, p.model,
                          DartSimpleIdentifier(tmpVariable + "$" + i.string)]
                };

        value named
            =   namedArguments.namedArguments.collect((argument) {
                    value argumentInfo
                        =   namedArgumentInfo(argument);

                    assert (exists details
                        =   parameterDetails[argumentInfo.parameter]);

                    value [index, typeModel, parameterModelModel, dartIdentifier]
                        =   details;

                    DartExpression dartExpression;

                    switch (argumentInfo)
                    case (is AnonymousArgumentInfo) {
                        dartExpression
                            =   withLhs {
                                    typeModel;
                                    parameterModelModel;
                                    () => argumentInfo.node.expression.transform {
                                        expressionTransformer;
                                    };
                                };
                    }
                    case (is SpecifiedArgumentInfo) {
                        // Treating ValueSpecification and LazySpecification identically.
                        // A lazy function would just be evaluated right away anyway.
                        dartExpression
                            =   withLhs {
                                    typeModel;
                                    parameterModelModel;
                                    () => argumentInfo.node.specification.specifier
                                            .expression.transform {
                                        expressionTransformer;
                                    };
                                };
                    }
                    case (is ValueArgumentInfo) {
                        dartExpression
                            =   switch (definition = argumentInfo.node.definition)
                                case (is AnySpecifier)
                                    // As for SpecifiedArgumentInfo, just evaluate the
                                    // expression.
                                    withLhs {
                                        typeModel;
                                        parameterModelModel;
                                        () => definition.expression.transform {
                                            expressionTransformer;
                                        };
                                    }
                                case (is Block)
                                    // TODO split generateDefinitionForValueModelGetter?
                                    DartFunctionExpressionInvocation {
                                        DartFunctionExpression {
                                            dartFormalParameterListEmpty;
                                            DartBlockFunctionBody {
                                                null;
                                                false;
                                                withReturn {
                                                    parameterModelModel;
                                                    () => statementTransformer
                                                                .transformBlock {
                                                        definition;
                                                    }.first;
                                                };
                                            };
                                        };
                                        DartArgumentList();
                                    };
                    }
                    case (is FunctionArgumentInfo) {
                        dartExpression
                            =   withLhs {
                                    typeModel;
                                    null;
                                    () => generateNewCallable {
                                        argumentInfo;
                                        argumentInfo.declarationModel;
                                        generateFunctionExpression(argumentInfo.node);
                                        0; false;
                                    };
                                };
                    }
                    case (is ObjectArgumentInfo) {
                        argumentInfo.node.transform(topLevelVisitor);

                        dartExpression
                            =   withLhs {
                                    typeModel;
                                    null;
                                    () => generateObjectInstantiation {
                                        argumentInfo;
                                        argumentInfo.anonymousClass;
                                    };
                                };
                    }

                    return DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                scope;
                                parameterModelModel;
                                typeModel;
                            };
                            [DartVariableDeclaration {
                                dartIdentifier;
                                dartExpression;
                            }];
                        };
                    };
                });

        value iterableInfo
            =   ArgumentListInfo(namedArguments.iterableArgument);

        [DartVariableDeclarationStatement] | [] iterableArgument;

        if (namedArguments.iterableArgument.children nonempty) {
            assert (exists parameterModel = iterableInfo.parameter);
            assert (exists details = parameterDetails[parameterModel]);
            value [index, typeModel, parameterModelModel, dartIdentifier] = details;

            iterableArgument
                =   [DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                scope;
                                parameterModelModel;
                            };
                            [DartVariableDeclaration {
                                dartIdentifier;
                                withLhsNonNative {
                                    typeModel;
                                    () => expressionTransformer.generateIterable {
                                        scope;
                                        namedArguments.iterableArgument.listedArguments;
                                        namedArguments.iterableArgument.sequenceArgument;
                                    };
                                };
                            }];
                        };
                    }];
        }
        else {
            iterableArgument = [];
        }

        value definedParameters
            =   set {
                    concatenate {
                        if (nonempty iterableArgument)
                        then [assertExists(iterableInfo.parameter)]
                        else [],
                        namedArguments.namedArguments
                            .map(namedArgumentInfo)
                            .map(NamedArgumentInfo.parameter)
                    };
                };

        value argsSetup
            =   concatenate {
                    named,
                    iterableArgument
                };

        value arguments
            =   parameterDetails.collect((entry)
                =>  let (parameter -> [index, type, declaration,
                                       dartIdentifier] = entry) (
                    if (definedParameters.contains(parameter)) then
                        dartIdentifier
                    else if (parameter.sequenced) then
                        // Per spec 4.3.6: A variadic parameter may not have a
                        // default argument.
                        dartTypes.dartInvocable {
                            scope;
                            ceylonTypes.emptyValueDeclaration;
                            false;
                        }.expressionForInvocation()
                    else if (parameter.defaulted) then
                        dartTypes.dartDefault(scope)
                    else
                        ((){
                            "If not defaulted and not variadic, it must be an
                             Iterable."
                            assert (ceylonTypes.isCeylonIterable {
                                switch(type)
                                case (is TypeDetails) type.type
                                case (is TypeModel) type;
                            });

                            return
                            dartTypes.dartInvocable {
                                scope;
                                ceylonTypes.emptyValueDeclaration;
                                false;
                            }.expressionForInvocation();
                        })()));

        return [argsSetup, arguments];
    }

    shared
    DartExpression
    generateAssignmentExpression(
            DScope that,
            BaseExpression | QualifiedExpression target,
            DartExpression() rhsExpression) {

        // TODO review and test
        // TODO make sure setters return the new value, or do somthing here
        // TODO consider merging with generateInvocation()

        DeclarationModel targetDeclaration;
        DartExpression? dartTarget;
        Reference typedReference;

        switch (target)
        case (is BaseExpression) {
            value info = BaseExpressionInfo(target);
            targetDeclaration = info.declaration;
            dartTarget = null;
            assert (is FunctionOrValueModel targetDeclaration);
            typedReference = targetDeclaration.typedReference;
        }
        case (is QualifiedExpression) {
            value info = QualifiedExpressionInfo(target);
            targetDeclaration = info.declaration;
            typedReference = info.typeModel.getTypedReference(targetDeclaration, null);

            assert (is ClassOrInterfaceModel container = targetDeclaration.container);
            dartTarget = withLhsDenotable {
                container;
                () => target.receiverExpression.transform(expressionTransformer);
            };
        }
        assert (is FunctionOrValueModel targetDeclaration);

        // FIXME handle interface setters (shared and non-shared)
        value [targetIdentifier, targetDartElementType]
            =   dartTypes.dartInvocable(
                    that, targetDeclaration, true).oldPairPrefixed;

        // create the possibly qualified (by module or value) target
        DartExpression targetExpression;
        if (exists dartTarget) {
            assert (is DartSimpleIdentifier targetIdentifier);
            targetExpression = DartPropertyAccess {
                dartTarget;
                targetIdentifier;
            };
        }
        else {
            targetExpression = targetIdentifier;
        }

        DartExpression rhs = withLhs(
                typedReference.type,
                targetDeclaration,
                rhsExpression);

        value unboxed =
            if (targetDartElementType == dartFunction) then
                DartFunctionExpressionInvocation {
                    targetExpression;
                    DartArgumentList([rhs]);
                }
            else
                DartAssignmentExpression {
                    targetExpression;
                    DartAssignmentOperator.equal;
                    rhs;
                };

        // FIXME use the rhs type, since that's what Dart uses for the expression type
        //       (and so does Ceylon). So we'll need 1) the rhs type!, and 2) to calculate
        //       erasure on our own (pita). The only symptom is unnecessary casts.
        return withBoxing {
            that;
            typedReference.type;
            targetDeclaration;
            unboxed;
        };
    }

    shared
    DartVariableDeclarationList generateVariableDeclarationSynthetic(
            DScope scope,
            DartSimpleIdentifier identifier,
            TypeModel lhsType,
            Boolean lhsErasedToNative,
            Boolean lhsErasedToObject,
            DartExpression() rhsDartExpression) {

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeName {
                scope;
                lhsType;
                lhsErasedToNative;
                lhsErasedToObject;
            };
            [DartVariableDeclaration {
                identifier;
                withLhsCustom {
                    lhsType;
                    lhsErasedToNative;
                    lhsErasedToObject;
                    rhsDartExpression;
                };
            }];
        };
    }

    shared
    DartExpression generateSequentialFromArgument(SpreadArgument | Comprehension that)
        =>  switch (that)
            case (is SpreadArgument) generateSequentialFromSpreadArgument(that)
            case (is Comprehension) generateSequentialFromComprehension(that);

    shared
    DartExpression generateSequentialFromSpreadArgument(SpreadArgument that)
        =>  let (argumentInfo = ExpressionInfo(that.argument))
            if (ceylonTypes.isCeylonSequential(argumentInfo.typeModel)) then
                // Basically a noop; `x[*y] === y` if `y is Sequential`.
                that.argument.transform(expressionTransformer)
            else
                // The argument is an Iterable; result may be a Sequential or Sequence.
                // TODO It would probably be more correct to create the Sequential from
                //      the iterator using a utility method rather than trusting the
                //      implementation of `sequence()`.
                generateInvocationFromName {
                    dScope(that);
                    that.argument;
                    "sequence";
                    [];
                };

    shared
    DartExpression generateSequentialFromComprehension(Comprehension that)
        =>  let (comprehensionType = iterableComprehensionType(that))
            generateInvocationSynthetic {
                dScope(that);
                comprehensionType;
                () => that.transform(expressionTransformer);
                "sequence";
                [];
            };

    shared
    TypeModel iterableComprehensionType(Comprehension that)
        =>  let (firstClauseInfo = ComprehensionClauseInfo(that.clause))
            ceylonTypes.iterableDeclaration.appliedType(null, javaList {
                firstClauseInfo.typeModel,
                firstClauseInfo.firstTypeModel
            });
}
