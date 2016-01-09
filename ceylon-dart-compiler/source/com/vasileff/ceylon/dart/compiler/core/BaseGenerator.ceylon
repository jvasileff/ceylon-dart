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
    SafeMemberOperator,
    AnySpecifier,
    FunctionArgument,
    Parameter,
    LazySpecification,
    SpreadMemberOperator,
    Pattern,
    TuplePattern,
    EntryPattern
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
    TypeParameterModel=TypeParameter,
    SiteVariance
}
import com.vasileff.ceylon.dart.compiler {
    DScope,
    Warning
}
import com.vasileff.ceylon.dart.compiler.dartast {
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
    createExpressionEvaluationWithSetup,
    DartFieldDeclaration,
    DartMethodDeclaration,
    DartClassMember
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    FunctionExpressionInfo,
    BaseExpressionInfo,
    FunctionShortcutDefinitionInfo,
    QualifiedExpressionInfo,
    ParameterInfo,
    ArgumentListInfo,
    ExpressionInfo,
    FunctionDefinitionInfo,
    IsConditionInfo,
    TypeInfo,
    ValueDefinitionInfo,
    ValueGetterDefinitionInfo,
    UnspecifiedVariableInfo,
    ValueSetterDefinitionInfo,
    ObjectDefinitionInfo,
    SpecifiedVariableInfo,
    ComprehensionClauseInfo,
    namedArgumentInfo,
    AnonymousArgumentInfo,
    SpecifiedArgumentInfo,
    ValueArgumentInfo,
    FunctionArgumentInfo,
    ObjectArgumentInfo,
    NamedArgumentInfo,
    SpreadArgumentInfo,
    sequenceArgumentInfo,
    ComprehensionInfo,
    LazySpecificationInfo,
    VariadicVariableInfo,
    expressionInfo,
    anyFunctionInfo,
    existsOrNonemptyConditionInfo,
    nodeInfo,
    parameterInfo,
    ParametersInfo
}
import com.vasileff.jl4c.guava.collect {
    ImmutableMap,
    javaList
}

import java.util {
    JList=List
}

shared abstract
class BaseGenerator(CompilationContext ctx)
        extends CoreGenerator(ctx) {

    // hack to avoid error using the inherited member ceylonTypes in the initializer
    value ceylonTypes = ctx.ceylonTypes;

    [TypeModel, TypeModel, String, TypeModel, DartElementType]?(DeclarationModel)
    simpleNativeBinaryFunctions = (() {
        return ImmutableMap {
            ceylonTypes.stringDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.stringType,
                    ceylonTypes.stringType, "+",
                    ceylonTypes.stringType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "+",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("plusInteger", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "+",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("minus", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "-",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("times", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "*",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("divided", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "~/",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("largerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, ">",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("smallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, "<",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("notLargerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, "<=",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("notSmallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.integerType, ">=",
                    ceylonTypes.integerType,
                    dartBinaryOperator],
            ceylonTypes.integerDeclaration.getMember("remainder", null, false)
                -> [ceylonTypes.integerType,
                    ceylonTypes.integerType, "remainder",
                    ceylonTypes.integerType,
                    dartFunction],
            ceylonTypes.floatDeclaration.getMember("plus", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "+",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("plusInteger", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "+",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("minus", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "-",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("times", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "*",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("divided", null, false)
                -> [ceylonTypes.floatType,
                    ceylonTypes.floatType, "/",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("largerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, ">",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("smallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, "<",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("notLargerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, "<=",
                    ceylonTypes.floatType,
                    dartBinaryOperator],
            ceylonTypes.floatDeclaration.getMember("notSmallerThan", null, false)
                -> [ceylonTypes.booleanType,
                    ceylonTypes.floatType, ">=",
                    ceylonTypes.floatType,
                    dartBinaryOperator]
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
                        ceylonTypes.stringType,
                        dartBinaryOperator];
            }

            if (declaration == integerEquals
                    && ceylonTypes.isCeylonInteger(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.integerType, "==",
                        ceylonTypes.integerType,
                        dartBinaryOperator];
            }

            if (declaration == floatEquals
                    && ceylonTypes.isCeylonFloat(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.floatType, "==",
                        ceylonTypes.floatType,
                        dartBinaryOperator];
            }

            if (declaration == booleanEquals
                    && ceylonTypes.isCeylonBoolean(definiteArgument)) {
                return [ceylonTypes.booleanType,
                        ceylonTypes.booleanType, "==",
                        ceylonTypes.booleanType,
                        dartBinaryOperator];
            }
        }

        return null;
    }

    [TypeModel, String, TypeModel, DartElementType]?(DeclarationModel)
    nativeNoArgOptimizations = (() {
        return ImmutableMap {
            ceylonTypes.integerDeclaration.getMember("negated", null, false)
                -> [ceylonTypes.integerType, "-",
                    ceylonTypes.integerType,
                    dartPrefixOperator],
            ceylonTypes.floatDeclaration.getMember("negated", null, false)
                -> [ceylonTypes.floatType, "-",
                    ceylonTypes.floatType,
                    dartPrefixOperator],
            ceylonTypes.integerDeclaration.getMember("magnitude", null, false)
                -> [ceylonTypes.integerType, "abs",
                    ceylonTypes.integerType,
                    dartFunction],
            ceylonTypes.floatDeclaration.getMember("magnitude", null, false)
                -> [ceylonTypes.floatType, "abs",
                    ceylonTypes.floatType,
                    dartFunction],
            ceylonTypes.stringDeclaration.getMember("string", null, false)
                -> [ceylonTypes.stringType, "toString",
                    ceylonTypes.stringType,
                    dartFunction],
            ceylonTypes.integerDeclaration.getMember("string", null, false)
                -> [ceylonTypes.stringType, "toString",
                    ceylonTypes.integerType,
                    dartFunction],
            ceylonTypes.floatDeclaration.getMember("string", null, false)
                -> [ceylonTypes.stringType, "toString",
                    ceylonTypes.floatType,
                    dartFunction],
            ceylonTypes.integerDeclaration.getMember("float", null, false)
                -> [ceylonTypes.floatType, "toDouble",
                    ceylonTypes.integerType,
                    dartFunction],
            ceylonTypes.floatDeclaration.getMember("integer", null, false)
                -> [ceylonTypes.integerType, "toInt",
                    ceylonTypes.floatType,
                    dartFunction]
        }.get;
    })();

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
                    omap(DartIntegerLiteral)(variadicParameterIndex)
                }.coalesced.sequence();
            };
        };
    }

    shared
    DartFunctionDeclaration generateFunctionDefinition
            (FunctionShortcutDefinition | FunctionDefinition that) {

        value info = anyFunctionInfo(that);

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

        return
        withBoxing {
            scope;
            resultType;
            memberDeclaration;
            dartFunctionOrValue.expressionForInvocation {
                null;
                dartArguments;
            };
        };
    }

    [[DartStatement*], [DartExpression*], Boolean] generateArguments(
            DScope scope,
            List<TypeModel | TypeDetails> signature,
            FunctionModel | ClassModel | ConstructorModel declarationModel,
            [DartExpression()*] | [Expression*] | Arguments arguments) {

        if (is PositionalArguments | NamedArguments arguments) {
            value [a, b, c]
                =   generateArgumentListFromArguments {
                        scope;
                        arguments;
                        signature;
                        declarationModel;
                    };
            return [a, b.arguments, c];
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
                        declarationModel.firstParameterList
                                .parameters.get(i)?.model;
                        argument;
                        lhsIsParameter = true;
                    }
                ];

        return [argsSetup, argExpressions, false];
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

        if (is SpreadMemberOperator memberOperator) {
            addError(memberOperator, "Spread member operator not yet supported");
            return DartNullLiteral();
        }

        value safeMemberOperator = memberOperator is SafeMemberOperator;

        value [signature, a] = signatureAndArguments else [null, []];

        function standardArgs() {
            if (!exists signatureAndArguments) {
                return [[], [], false];
            }
            assert (!is ValueModel | SetterModel memberDeclaration);
            return generateArguments {
                scope;
                signatureAndArguments[0];
                memberDeclaration;
                a;
            };
        }

        "For optimized invocations, the result type. Null for non-optimized invocations."
        TypeModel? optimizedNativeRhsType;

        "The arguments."
        [[DartStatement*], [DartExpression*], Boolean] argsSetupAndExpressions;

        "The receiver object (outer for constructors of member classes)."
        DartExpression dartReceiver;

        "The Dart type of [[dartReceiver]]."
        DartTypeName dartReceiverType;

        "The Dart function, value, or constructor to invoking."
        DartInvocable dartFunctionOrValue;

        if (is ClassModel | ConstructorModel memberDeclaration) {
            if (!exists generateReceiver) {
                addError(scope,
                    "Member class and constructor invocations on super not supported.");
                return DartNullLiteral();
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
                    =   dartTypes.expressionForThis(scope);

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
                            false;
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
                        false;
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
                        expressionInfo(a[0]).typeModel
                    else if (is PositionalArguments a,
                             exists arg = a.argumentList.listedArguments.first) then
                        expressionInfo(arg).typeModel
                    else null;

            if (exists optimization
                    =   nativeBinaryOptimization(
                            memberDeclaration, receiverType, firstArgType)) {

                assert (!is ValueModel | SetterModel memberDeclaration);

                value [type, optimizedReceiverType, optimizedMember,
                            optimizedArgumentType, elementType]
                    =   optimization;

                value rightOperandTypeDetail
                    =   TypeDetails(optimizedArgumentType, true, false);

                optimizedNativeRhsType
                    =   type;

                dartReceiverType
                    =   dartTypes.dartTypeName {
                            scope;
                            optimizedReceiverType;
                            eraseToNative = true;
                        };

                dartReceiver
                    =   withLhsNative {
                            optimizedReceiverType;
                            generateReceiver;
                        };

                dartFunctionOrValue
                    =   DartInvocable {
                            DartSimpleIdentifier(optimizedMember);
                            elementType;
                            false;
                        };

                argsSetupAndExpressions
                    =   generateArguments {
                            scope;
                            [rightOperandTypeDetail];
                            memberDeclaration;
                            a;
                        };
            }
            else if (exists optimization
                    =   nativeNoArgOptimizations(memberDeclaration)) {

                assert (!is SetterModel memberDeclaration);

                value [type, operand, leftOperandType, dartElementType]
                    =   optimization;

                dartReceiverType
                    =   dartTypes.dartTypeName {
                            scope;
                            leftOperandType;
                            eraseToNative = true;
                        };

                optimizedNativeRhsType
                    =   type;

                dartReceiver
                    =   withLhsNative {
                            leftOperandType;
                            generateReceiver;
                        };

                dartFunctionOrValue
                    =   DartInvocable {
                            DartSimpleIdentifier(operand);
                            dartElementType;
                            false;
                        };

                argsSetupAndExpressions
                    =   [[], [], false];
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

                value dartFunctionOrValueTemplate
                    =   dartTypes.dartInvocable {
                            scope;
                            memberDeclaration;
                            false;
                        };

                // Handle a rare case in which a defaulted callable parameter's
                // expression includes an invocation on a defaulted callable parameter of
                // another instance of the same type. Something like
                // '... => C().someCallableParam()'.
                //
                // Due to the way naming for defaulted callable parameters work in our
                // Dart constructors, we need to alter the name to point to the private
                // member holding the Callable.
                dartFunctionOrValue
                    =   if (ctx.withinConstructorDefaultsSet.contains(container),
                                is FunctionModel memberDeclaration,
                                memberDeclaration.shared,
                                dartTypes.isCallableValue(memberDeclaration))
                        then dartFunctionOrValueTemplate.with {
                            reference = DartSimpleIdentifier {
                                // TODO consolidate naming code
                                "_" + dartTypes.getName(memberDeclaration)  + "$c";
                            };
                        }
                        else
                            dartFunctionOrValueTemplate;

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
                                        argsSetupAndExpressions[2];
                                    };
                                };
                    }
                else
                    createExpressionEvaluationWithSetup {
                        argsSetupAndExpressions[0];
                        dartFunctionOrValue.expressionForInvocation {
                            dartReceiver;
                            argsSetupAndExpressions[1];
                            argsSetupAndExpressions[2];
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
            [Expression*] arguments)
        =>  generateInvocationDetailsFromName(
                scope, receiver, memberName, arguments)[2]();

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
            [Expression*] | [DartExpression()*] arguments) {

        return
        generateInvocationDetailsSynthetic {
            scope;
            expressionInfo(receiver).typeModel;
            () => receiver.transform(expressionTransformer);
            memberName;
            arguments;
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
            [Expression*] | [DartExpression()*] arguments)
        =>  generateInvocationDetailsSynthetic {
                scope;
                receiverType;
                generateReceiver;
                memberName;
                arguments;
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
            [Expression*] | [DartExpression()*] arguments) {

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

        value rhsType = typedReference.type;

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
    DartFunctionExpression generateForwardDeclaredForwarder
            (DScope scope, FunctionModel functionModel, [Parameters+] parameterLists) {

        // For multiple parameter lists, eagerly call the delegate in case there are side
        // effects. https://github.com/ceylon/ceylon/issues/3916

        // TODO centralize naming logic.
        value callableVariableName
            =   if (withinClass(functionModel) && functionModel.parameter)
                then "_" + dartTypes.getName(functionModel) + "$c"
                else dartTypes.getName(functionModel) + "$c";

        value callableVariable
            =   DartSimpleIdentifier(callableVariableName);

        value isVoid
            =   functionModel.declaredVoid;

        variable DartExpression? result = null;

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    scope;
                    functionModel;
                }.oldPairSimple;

        for (i -> list in parameterLists.indexed.sequence().reversed) {

            if (i < parameterLists.size - 1) {
                // wrap nested function in a callable
                assert(exists inner = result);

                // generateNewCallable() *thinks* the innermost call returns a native
                // value, but it doesn't since we're really invoking another Callable.
                // So, we're boxing/unboxing as nec. to make the Callable *look* like a
                // regular function. Unfortunately, this causes some wasteful box-unbox
                // combos. Better would be to teach generateNewCallable that our return
                // values are never erased-to-native.
                result = generateNewCallable(scope, functionModel, inner, i+1);
            }

            value delegateIdentifier
                =   if (i == 0)
                    then callableVariable
                    else DartSimpleIdentifier(callableVariableName + i.string);

            value innerDelegateIdentifier
                =   DartSimpleIdentifier(callableVariableName + (i + 1).string);

            value arguments
                =   list.parameters.collect((p) {
                        value pInfo = parameterInfo(p);

                        // we're invoking a Callable, so all arguments must be boxed
                        return
                        withLhsNonNative {
                            pInfo.parameterModel.type;
                            () => withBoxing {
                                scope;
                                pInfo.parameterModel.type;
                                pInfo.parameterModel.model;
                                DartSimpleIdentifier {
                                    dartTypes.getName(pInfo.parameterModel.model);
                                };
                            };
                        };
                    });

            value hasDefaultedParameters
                =   list.parameters
                    .map(parameterInfo)
                    .map(ParameterInfo.parameterModel)
                    .any(ParameterModel.defaulted);

            value useStaticDefaultArgumentMethods
                =   hasDefaultedParameters
                        && (functionModel.default
                            || functionModel.refinedDeclaration.default
                            || functionModel.refinedDeclaration.formal);

            value defaultArgumentAssignments
                =   if (!hasDefaultedParameters) then
                        []
                    else if (useStaticDefaultArgumentMethods) then
                        generateDefaultValueAssignmentsStatic {
                            scope;
                            functionModel;
                        }
                    else
                        generateDefaultValueAssignments {
                            scope;
                            [ for (p in list.parameters)
                              if (is DefaultedParameter p) p];
                        };

            [DartStatement*] statements;

            if (i == parameterLists.size - 1) {
                // the innermost function body

                value invocation
                    =   DartFunctionExpressionInvocation {
                            DartPropertyAccess {
                                delegateIdentifier;
                                DartSimpleIdentifier("f");
                            };
                            DartArgumentList(arguments);
                        };

                if (isVoid) {
                    statements
                        =   [DartExpressionStatement {
                                // no boxing; returning void
                                invocation;
                            }];
                }
                else {
                    statements
                        =   [DartReturnStatement {
                                withLhs {
                                    null;
                                    functionModel;
                                    () => withBoxingNonNative {
                                        scope;
                                        functionModel.type;
                                        invocation;
                                    };
                                };
                            }];
                }
            }
            else {
                // an outer function body that returns a Callable

                assert(exists inner = result);

                statements
                    =   [// Invoke the delegate to acquire the next Callable, which
                         // is called by code that was generated in the previous
                         // iteration.
                         DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartTypeName {
                                    scope;
                                    ceylonTypes.callableAnythingType;
                                };
                                [DartVariableDeclaration {
                                    innerDelegateIdentifier;
                                    // Don't bother boxing. We're calling
                                    // a Callable, and the return, which
                                    // will be a Callable, is being used
                                    // as another Callable's return.
                                    DartFunctionExpressionInvocation {
                                        DartPropertyAccess {
                                            delegateIdentifier;
                                            DartSimpleIdentifier("f");
                                        };
                                        DartArgumentList(arguments);
                                    };
                                }];
                            };
                        },
                        // Return the previously generated inner Callable
                        DartReturnStatement {
                            inner;
                        }];
            }

            result
                =   DartFunctionExpression {
                        generateFormalParameterList {
                            // For the outermost parameter list, if the function is a
                            // DartOperator, don't use a positional argument list.
                            if (i == 0)
                                then !dartElementType is DartOperator
                                else false;
                            false;
                            scope;
                            list;
                        };
                        DartBlockFunctionBody {
                            null; false;
                            DartBlock {
                                concatenate {
                                    defaultArgumentAssignments,
                                    statements
                                };
                            };
                        };
                    };
        }

        assert (is DartFunctionExpression r = result);

        return r;
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
                            compose(ExpressionInfo.typeModel, expressionInfo);
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
    ConditionCodeTuple generateIsConditionExpression(
            IsCondition that, Boolean negate = false) {

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

            value expressionType = expressionInfo(expression).typeModel;

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
                        [replacementDefinition];
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
                    then [VariableTriple(variableDeclaration, r[0], [r[1]])]
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
                        dartTypes.invocableForBaseExpression {
                            scope;
                            originalDeclaration;
                        }.expressionForInvocation();
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
    ConditionCodeTuple generateExistsOrNonemptyConditionExpression
            (ExistsOrNonemptyCondition that, Boolean negate = false) {

        value info = existsOrNonemptyConditionInfo(that);

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
            value expressionType = expressionInfo(expression).typeModel;

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

            value variables
                =   generateForPattern {
                        sp.pattern;
                        // This runs if the exists test passed. Use definiteType so
                        // generateForPattern can call methods on tempIdentifier.
                        ceylonTypes.definiteType(expressionType);
                        () => withBoxing {
                            info;
                            expressionType;
                            null;
                            tempIdentifier;
                        };
                    };

            return [tempVariableDeclaration, conditionExpression, *variables];
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
                    then [VariableTriple(variableDeclaration, r[0], [r[1]])]
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
            "Used to determine if expressionToCheck is native (i.e. int vs Integer)"
            TypeModel | TypeDetails typeToCheck,
            "Used to determine if expressionToCheck is native (i.e. int vs Integer)"
            FunctionOrValueModel? declarationToCheck,
            DartExpression expressionToCheck,
            TypeModel isType) {

        TypeModel rawType(TypeModel isType) {
            if (isType.union) {
                value result = CeylonList(isType.caseTypes).reversed
                    .map(rawType)
                    .reduce(ceylonTypes.unionType);

                assert (exists result);
                return result;
            }
            else if (isType.intersection) {
                value result = CeylonList(isType.satisfiedTypes).reversed
                    .map(rawType)
                    .reduce(ceylonTypes.intersectionType);
                assert (exists result);
                return result;
            }
            // Non-denotable types we can handle
            else if (ceylonTypes.isCeylonNull(isType)) {
                return isType;
            }
            else if (ceylonTypes.isCeylonNothing(isType)) {
                return isType;
            }
            else if (!dartTypes.denotable(isType)) {
                // a type parameter or something we can't handle... do our best
                if (isType.isSubtypeOf(ceylonTypes.objectType)) {
                    return ceylonTypes.objectType;
                }
                return ceylonTypes.anythingType;
            }
            else {
                // if generic, rebuild with least precise type arguments
                value qualifyingType
                    =   if (exists qt = isType.qualifyingType)
                        then rawType(qt)
                        else null;

                value declaration = isType.declaration;

                // generic, or possibly generic qualifying type?
                if (qualifyingType exists || !declaration.typeParameters.empty) {
                    function satisfiedTypesToRaw
                            (JList<TypeModel>? types)
                        =>  if (exists types) then
                                CeylonList(types).reversed
                                    .map(rawType)
                                    .reduce(ceylonTypes.unionType)
                            else
                                null;

                    value parameters
                        =   CeylonList(declaration.typeParameters);

                    value arguments
                        =   javaList(parameters.map((p)
                            =>  if (p.contravariant) then
                                    ceylonTypes.nothingType
                                else if (p.isSelfType()) then
                                    // FIXME TODO what should we do here?
                                    ceylonTypes.anythingType
                                else
                                    (satisfiedTypesToRaw(p.satisfiedTypes)
                                        else ceylonTypes.anythingType)));

                    value rawTypeModel
                        =   declaration.appliedType(qualifyingType, arguments);

                    parameters.filter(TypeParameterModel.invariant).each((p)
                        =>  rawTypeModel.setVariance(p, SiteVariance.\iOUT));

                    return rawTypeModel;
                }
                return isType;
            }
        }

        DartExpression generateExpression(TypeModel isType) {
            // TODO Optimize away unecessary checks?
            if (isType.union) {
                value result = CeylonList(isType.caseTypes).reversed
                    .map(generateExpression)
                    .reduce((DartExpression partial, c) =>
                        DartBinaryExpression(c, "||", partial));

                assert (exists result);
                return result;
            }
            else if (isType.intersection) {
                value result = CeylonList(isType.satisfiedTypes).reversed
                    .map(generateExpression)
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial));

                assert (exists result);
                return result;
            }
            // Non-denotable types we can handle
            else if (ceylonTypes.isCeylonNull(isType)) {
                return
                DartBinaryExpression {
                    DartNullLiteral();
                    "==";
                    expressionToCheck;
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

        value resolvedIsType
            =   isType.resolveAliases();

        value typeModelToCheck
            =   switch(typeToCheck)
                case (is TypeModel) typeToCheck
                case (is TypeDetails) typeToCheck.type;

        value desiredResultType
            =   ceylonTypes.intersectionType(typeModelToCheck, resolvedIsType);

        value actualResultType
            =   ceylonTypes.intersectionType(typeModelToCheck, rawType(resolvedIsType));

        if (!actualResultType.isSubtypeOf(desiredResultType)) {
            addWarning(scope, Warning.unsoundTypeTest,
                "**unsound type test** reified generics not yet implemented; 'is' test \
                 may produce incorrect results; the expected result type \
                 '``desiredResultType.asString()``' is a subtype of the effective result \
                 type '``actualResultType.asString()``'.");
        }

        return generateExpression(resolvedIsType);
    }

    "Generate a dart variable declaration. This is *not* to be used for class or interface
     members."
    shared
    DartVariableDeclarationList generateForValueDeclarationRaw
            (DScope scope, ValueModel declarationModel)
        =>  DartVariableDeclarationList {
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
    DartExpression generateObjectInstantiation(
            "The scope of the value, not the scope of the object definition!"
            DScope valueScope,
            ClassModel classModel)
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
                value pInfo
                    =   parameterInfo(param);

                value parameterModelModel
                    =   pInfo.parameterModel.model;

                value paramName
                    =   DartSimpleIdentifier {
                            dartTypes.getName(pInfo.parameterModel.model);
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

    "Generate statements to assign default values to parameters for defaulted arguments
     of methods that are refinements, `formal`, or `default`. In these cases, static
     method calls are made to determine default values. The Dart static methods are
     members of the Dart class for the method's original declaring class or interface."
    [DartStatement*] generateDefaultValueAssignmentsStatic
            (DScope scope, FunctionModel functionModel) {

        value parameterModels
            =   CeylonList(functionModel.firstParameterList.parameters);

        value dartArguments
            =   parameterModels[0:parameterModels.size - 1].collect((parameterModel)
                =>  withLhs {
                        null;
                        parameterModel.model;
                        () => dartTypes.invocableForBaseExpression {
                            scope; parameterModel.model; false;
                        }.expressionForLocalCapture();
                    });

        value defaultedParameters
            =   parameterModels.indexed.filter((entry)
                =>  entry.item.defaulted);

        return
        defaultedParameters.collect((entry) {
            value i -> parameterModel = entry;

            value parameterModelModel
                =   parameterModel.model;

            value paramName
                =   DartSimpleIdentifier {
                        dartTypes.getName(parameterModel.model);
                    };

            value refinedParameter
                =   dartTypes.refinedParameter {
                        parameterModel.model;
                    }.initializerParameter;

            value refinedParameterClassOrInterface
                =   getContainingClassOrInterface(refinedParameter.declaration);

            "A refined parameter must be contained by a class or interface."
            assert (exists refinedParameterClassOrInterface);

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
                        withLhs {
                            null;
                            parameterModelModel;
                            () =>  DartFunctionExpressionInvocation {
                                // qualified reference to the static interface method
                                DartPropertyAccess {
                                    dartTypes.dartIdentifierForClassOrInterface {
                                        scope;
                                        refinedParameterClassOrInterface;
                                    };
                                    dartTypes.dartIdentifierForDefaultedParameterMethod {
                                        scope;
                                        dartTypes.refinedParameter {
                                            parameterModel.model;
                                        }.initializerParameter;
                                    };
                                };
                                DartArgumentList {
                                    [
                                        dartTypes.expressionForThis(scope),
                                        // preceding arguments
                                        *dartArguments[...i - 1]
                                    ];
                                };
                            };
                        };
                    };
                };
            };
        });
    }

    shared
    DartVariableDeclarationList generateForValueDefinition(ValueDefinition that) {
        if (!that.definition is Specifier) {
            addError(that.definition, "LazySpecifier not supported");
            return DartVariableDeclarationList {
                null; null;
                [DartVariableDeclaration {
                    DartSimpleIdentifier("");
                    null;
                }];
            };
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

        // Functions, values, and operators:
        //
        //  - toplevels are getters with no parameter list
        //  - locals are functions (not getters) with an empty parameter list
        //  - class and interface members may be getters, functions, or values, but
        //    are re-written in ClassMemberTransformer.generateMethodDefinitionRaw.
        //    So we do not have to handle operators here.

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
            dartElementType == dartValue then "get";
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
                    true;
                }.oldPairSimple;

        return
        DartFunctionDeclaration {
            false;
            DartTypeName {
                DartSimpleIdentifier {
                    "void";
                };
            };
            // Will be a dartFunction for values inside functions
            dartElementType == dartValue then "set";
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
    [VariableTriple*] generateForPattern
            (Pattern pattern, TypeModel? expressionType, DartExpression() generator)
        =>  switch (pattern)
            case (is VariablePattern)
                [generateForVariablePattern(pattern, generator)]
            case (is TuplePattern)
                generateForTuplePattern(pattern, expressionType, generator)
            case (is EntryPattern)
                generateForEntryPattern(pattern, expressionType, generator);

    shared
    [VariableTriple*] generateForEntryPattern(
            EntryPattern pattern, TypeModel? expressionType,
            DartExpression() generateExpression) {

        value typeModel
            =   expressionType else ceylonTypes.entryAnythingType;

        value info
            =   nodeInfo(pattern);

        value tempVariableIdentifier
            =   DartSimpleIdentifier {
                    dartTypes.createTempNameCustom("d");
                };

        value keyInfo
            =   nodeInfo(pattern.key);

        value itemInfo
            =   nodeInfo(pattern.item);

        value tempVariable
            =   DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartTypeName {
                            info;
                            typeModel;
                        };
                        [DartVariableDeclaration {
                            tempVariableIdentifier;
                            withLhsNative {
                                typeModel;
                                generateExpression;
                            };
                        }];
                    };
                };

        value triples
            =   concatenate {
                    // variables for the key
                    generateForPattern {
                        pattern.key;
                        // we could preserve more type information by using
                        // generateInvocationDetailsFromName, but why bother? Just use
                        // types like Entry<Anything, Anything> and cast the result.
                        null;
                        () => generateInvocationSynthetic {
                            keyInfo;
                            typeModel;
                            generateReceiver() => withBoxing {
                                keyInfo;
                                typeModel;
                                null;
                                tempVariableIdentifier;
                            };
                            // we know it's an Entry
                            "key";
                            [];
                        };
                    },
                    // variables for the item
                    generateForPattern {
                        pattern.item;
                        // we could preserve more type information by using
                        // generateInvocationDetailsFromName, but why bother? Just use
                        // types like Entry<Anything, Anything> and cast the result.
                        null;
                        () => generateInvocationSynthetic {
                            itemInfo;
                            typeModel;
                            generateReceiver() => withBoxing {
                                itemInfo;
                                typeModel;
                                null;
                                tempVariableIdentifier;
                            };
                            // we know it's an Entry
                            "item";
                            [];
                        };
                    }
                };

        // hack in the temp variable
        assert (exists first = triples.first);
        return [
            VariableTriple {
                first.declarationModel;
                first.dartDeclaration;
                [ tempVariable, *first.dartAssignment ];
            },
            *triples.rest
        ];
    }

    shared
    [VariableTriple*] generateForTuplePattern(
            TuplePattern pattern, TypeModel? expressionType,
            DartExpression() generateExpression) {

        value typeModel
            =   expressionType else ceylonTypes.sequentialAnythingType;

        value info
            =   nodeInfo(pattern);

        // handle the stupid '[a*] = sequential' noop case first.
        if (pattern.elementPatterns.empty) {
            assert (exists variadicVariable
                =   pattern.variadicElementPattern);

            value variableInfo
                =   VariadicVariableInfo(variadicVariable);

            value variableIdentifier
                =   DartSimpleIdentifier {
                        dartTypes.getName {
                            variableInfo.declarationModel;
                        };
                    };

            return
            [VariableTriple {
                variableInfo.declarationModel;
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = null;
                        dartTypes.dartTypeNameForDeclaration {
                            variableInfo;
                            variableInfo.declarationModel;
                        };
                        [DartVariableDeclaration {
                            variableIdentifier;
                        }];
                    };
                };
                // The declaration and assignment *have* to be separate. We can't put
                // initialization in the declaration because the rhs may be a temp
                // variable from a prior step that will not be evaluated until all of
                // the declarations are made.
                [DartExpressionStatement {
                    DartAssignmentExpression {
                        variableIdentifier;
                        DartAssignmentOperator.equal;
                        withLhs {
                            null;
                            variableInfo.declarationModel;
                            generateExpression;
                        };
                    };
                }];
            }];
        }

        value tempVariableIdentifier
            =   DartSimpleIdentifier {
                    dartTypes.createTempNameCustom("d");
                };

        value tempVariableDefinition
            =   DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartTypeName {
                            info;
                            typeModel;
                        };
                        [DartVariableDeclaration {
                            tempVariableIdentifier;
                            withLhsNative {
                                typeModel;
                                generateExpression;
                            };
                        }];
                    };
                };

        value elementParts
            =   pattern.elementPatterns.indexed.flatMap((pair) {
                    value index -> elementPattern = pair;
                    value pInfo = nodeInfo(elementPattern);

                    return generateForPattern {
                        elementPattern;
                        // we could preserve more type information by using
                        // generateInvocationDetailsFromName, but why bother? Just use
                        // types like Entry<Anything, Anything> and cast the result.
                        null;
                        () => generateInvocationSynthetic {
                            pInfo;
                            typeModel;
                            generateReceiver() => withBoxing {
                                pInfo;
                                typeModel;
                                null;
                                tempVariableIdentifier;
                            };
                            // we know it's at least a Sequential
                            "getFromFirst";
                            [() => withBoxing {
                                pInfo;
                                ceylonTypes.integerType;
                                null;
                                DartIntegerLiteral(index);
                            }];
                        };
                    };
                });

        // NOTE when the variadicVariable is a Tuple, we are trusting Tuple.spanFrom
        //      to return a Tuple, even though its return type is Sequential.
        value variadicVariable
            =   if (exists variadicVariable = pattern.variadicElementPattern) then
                    let (variableInfo = VariadicVariableInfo(variadicVariable),
                         variableName = dartTypes.getName(variableInfo.declarationModel),
                         variableIdentifier = DartSimpleIdentifier(variableName))
                    [VariableTriple {
                        variableInfo.declarationModel;
                        DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                keyword = null;
                                dartTypes.dartTypeNameForDeclaration {
                                    variableInfo;
                                    variableInfo.declarationModel;
                                };
                                [DartVariableDeclaration {
                                    variableIdentifier;
                                }];
                            };
                        };
                        [DartExpressionStatement {
                            DartAssignmentExpression {
                                variableIdentifier;
                                DartAssignmentOperator.equal;
                                withLhs {
                                    null;
                                    variableInfo.declarationModel;
                                    () => generateInvocationSynthetic {
                                        variableInfo;
                                        typeModel;
                                        () => withBoxing {
                                            variableInfo;
                                            typeModel;
                                            null;
                                            tempVariableIdentifier;
                                        };
                                        "spanFrom";
                                        [() => withBoxing {
                                            variableInfo;
                                            ceylonTypes.integerType;
                                            null;
                                            DartIntegerLiteral {
                                                pattern.elementPatterns.size;
                                            };
                                        }];
                                    };
                                };
                            };
                        }];
                    }]
                    else [];

        value triples
            =   elementParts.chain(variadicVariable).sequence();

        // hack in the temp variable
        assert (exists first = triples.first);
        return [
            VariableTriple {
                first.declarationModel;
                first.dartDeclaration;
                [ tempVariableDefinition, *first.dartAssignment ];
            },
            *triples.rest
        ];
    }

    shared
    VariableTriple generateForVariablePattern
            (VariablePattern pattern, DartExpression() generator)
        =>  let (variableInfo = UnspecifiedVariableInfo(pattern.variable),
                 variableName = dartTypes.getName(variableInfo.declarationModel),
                 variableIdentifier = DartSimpleIdentifier(variableName))
            VariableTriple {
                variableInfo.declarationModel;
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = null;
                        dartTypes.dartTypeNameForDeclaration {
                            variableInfo;
                            variableInfo.declarationModel;
                        };
                        [DartVariableDeclaration {
                            variableIdentifier;
                        }];
                    };
                };
                [DartExpressionStatement {
                    DartAssignmentExpression {
                        variableIdentifier;
                        DartAssignmentOperator.equal;
                        withLhs {
                            null;
                            variableInfo.declarationModel;
                            generator;
                        };
                    };
                }];
            };

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
            value info = parameterInfo(that);
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
            LazySpecifier|Block definition,
            Boolean forceNonNativeReturn = false) {

        variable DartExpression? result = null;
        value isVoid = functionModel.declaredVoid;

        for (i -> list in parameterLists.indexed.sequence().reversed) {
            if (i < parameterLists.size - 1) {
                // wrap nested function in a callable
                assert(exists previous = result);
                assert(exists previousPList = parameterLists[i+1]);
                result
                    =   generateNewCallable {
                            scope;
                            functionModel;
                            previous;
                            i+1;
                            parameterList = ParametersInfo(previousPList).model;
                            hasForcedNonNativeReturn = forceNonNativeReturn;
                        };
            }

            value parameterInfos
                =   list.parameters.collect(parameterInfo);

            value hasDefaultedParameters
                =   parameterInfos
                    .map(ParameterInfo.parameterModel)
                    .any(ParameterModel.defaulted);

            value useStaticDefaultArgumentMethods
                =   hasDefaultedParameters
                        && (functionModel.default
                            || functionModel.refinedDeclaration.default
                            || functionModel.refinedDeclaration.formal);

            value defaultedParameters
                =   if (hasDefaultedParameters && !useStaticDefaultArgumentMethods)
                    then [ for (p in list.parameters) if (is DefaultedParameter p) p ]
                    else [];

            DartFunctionBody body;


            // Note: the forceNonNativeReturn case can only happen in the
            //       !hasDefaultedParameters w/LazySpecifier case, since specifications
            //       for forward declared functions cannot be Blocks or define default
            //       arguments.
            value returnTypeDetails
                =   TypeDetails {
                        functionModel.type;
                        if (forceNonNativeReturn)
                            then false
                            else dartTypes.erasedToNative(functionModel);
                        dartTypes.erasedToObject(functionModel);
                    };

            // If defaulted parameters exist, use a block (not lazy specifier)
            // At start of block, assign values as necessary
            if (!hasDefaultedParameters && !isVoid) {
                // no defaulted parameters
                if (i == parameterLists.size - 1) {
                    // the actual function body
                    switch (definition)
                    case (is Block) {
                        body = withReturn {
                            returnTypeDetails;
                            () => DartBlockFunctionBody {
                                null; false;
                                statementTransformer.transformBlock(definition)[0];
                            };
                        };
                    }
                    case (is LazySpecifier) {
                        body = DartExpressionFunctionBody {
                            false;
                            withLhs {
                                returnTypeDetails;
                                null;
                                () => definition.expression.transform(
                                        expressionTransformer);
                            };
                        };
                    }
                }
                else {
                    assert(exists previous = result);
                    body = DartExpressionFunctionBody(false, previous);
                }
            }
            else {
                // defaulted parameters exist, or the function is void

                value statements = LinkedList<DartStatement>();

                // assign default values to defaulted arguments
                if (useStaticDefaultArgumentMethods) {
                    statements.addAll {
                        generateDefaultValueAssignmentsStatic {
                            scope;
                            functionModel;
                        };
                    };
                }
                else if (!defaultedParameters.empty) {
                    statements.addAll {
                        generateDefaultValueAssignments {
                            scope;
                            defaultedParameters;
                        };
                    };
                }

                // the rest of the dart function body
                if (i == parameterLists.size - 1) {
                    // the actual function body
                    switch (definition)
                    case (is Block) {
                        statements.addAll {
                            expand {
                                withReturn {
                                    returnTypeDetails;
                                    () => definition.transformChildren {
                                        statementTransformer;
                                    };
                                };
                            };
                        };
                    }
                    case (is LazySpecifier) {
                        // for FunctionShortcutDefinition
                        if (isVoid) {
                            statements.add {
                                DartExpressionStatement {
                                    withLhsNoType {
                                        () => definition.expression.transform(
                                                expressionTransformer);
                                    };
                                };
                            };
                        }
                        else {
                            statements.add {
                                DartReturnStatement {
                                    withLhs {
                                        returnTypeDetails;
                                        null;
                                        () => definition.expression.transform(
                                                expressionTransformer);
                                    };
                                };
                            };
                        }
                    }
                }
                else {
                    assert(exists previous = result);
                    statements.add(DartReturnStatement(previous));
                }

                body = DartBlockFunctionBody(null, false, DartBlock([*statements]));
            }
            result = DartFunctionExpression {
                generateFormalParameterList(true, false, scope, list);
                body;
            };
        }
        assert (is DartFunctionExpression r = result);
        return r;
    }

    shared
    DartFormalParameterList generateFormalParameterList(
            Boolean positional,
            Boolean named,
            DScope scope,
            Parameters|{Parameter*}|{ParameterModel*} parameters,
            "For parameters, disregard parameterModel.defaulted when determining if the
             type should be erased-to-object."
            Boolean noDefaults=false) {

        // FIXME noDefaults pretty much works as required, but not as advertised.
        //       dartTypes.dartTypeNameForDeclaration erases to Object for defaulted
        //       parameters, and we are using it regardless of the noDefaults arg.
        //       *But*, dartTypeNameForDeclaration doesn't always erase to Object?

        value parameterList
            =   if (is Parameters parameters) then
                    parameters.parameters.map(
                        compose(ParameterInfo.parameterModel, parameterInfo))
                else if (is {Parameter*} parameters) then
                    parameters.map(
                        compose(ParameterInfo.parameterModel, parameterInfo))
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
                    dartTypes.getName(parameterModel.model);
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
            positional; named;
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
            =   if (exists outerCI = getContainingClassOrInterface(classModel.container))
                then [dartTypes.expressionToOuter(scope, outerCI)]
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

        value optionalType
            =   !switchedType.isSubtypeOf(ceylonTypes.objectType);

        value nonOptionalType
            =   if (optionalType)
                then ceylonTypes.objectType
                else switchedType;

        "equals() test for a single expression"
        function generateMatchCondition(Expression expression) {
            return
            withLhsNative {
                ceylonTypes.booleanType;
                () {
                    value expressionType
                        =   expressionInfo(expression).typeModel;

                    if (ceylonTypes.isCeylonNull(expressionType)) {
                        // testing against the null value
                        return generateExistsExpression {
                            scope;
                            switchedType;
                            null;
                            switchedVariable;
                            true;
                        };
                    }

                    value equalsTest
                        =   generateInvocationSynthetic {
                                scope;
                                nonOptionalType;
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

                    if (optionalType) {
                        // possibly null; test for !null first
                        return DartBinaryExpression {
                            generateExistsExpression {
                                scope;
                                switchedType;
                                null;
                                switchedVariable;
                            };
                            "&&";
                            equalsTest;
                        };
                    }
                    else {
                        return equalsTest;
                    }
                };
            };
        }

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
        value info = nodeInfo(that);

        TypeModel switchedType;
        ValueModel? switchedDeclaration;
        DartSimpleIdentifier switchedVariable;
        DartVariableDeclarationStatement variableDeclaration;

        switch (switched = that.switched)
        case (is Expression) {
            switchedType
                =   expressionInfo(switched).typeModel;

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
    DartExpression generateCallableForQualifiedExpression(
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
            =   unsafeMap(parameters.indexed.collect((e)
                =>  e.item -> DartSimpleIdentifier("$``e.key``")));

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

        // TODO Optimization: for callable values, just use the value for 'callable'
        //      if not a nullsafe member operator. Be sure to use a boxed "$r" for the
        //      receiver if 'eagerlyEvaluateReceiver'.

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
            "The parameterList, which may be different than the one indicated by the
             functionModel if the function is specified separately from its declaration,
             as is the case with forward declared functions."
            ParameterListModel parameterList
                =   functionModel.parameterLists.get(parameterListNumber),
            "Does the delegateFunction return a non-erased-to-native value despite the
             functionModel possibly indicating erased-to-native? This is useful when
             generating callables for forward declared functions, to avoid unnecessary
             boxing."
            Boolean hasForcedNonNativeReturn = false) {

        // TODO take the Callable's TypeModel as an argument in order to have
        //      correct (non-erased-to-Object) parameter and return types for
        //      generic functions

        // NOTE Don't optimize to return Callable values for for callable parameters,
        //      because this function is used to create them when they are defaulted!
        //      Optimizations should be performed by callers. This function always
        //      produces code to create a new Callable.

        value returnsCallable
            =   parameterListNumber < functionModel.parameterLists.size() - 1;

        DartExpression outerFunction;

        TypeModel returnType;
        FunctionOrValueModel | ClassModel | ConstructorModel? returnDeclaration;
        if (returnsCallable) {
            returnType = ceylonTypes.callableDeclaration.type;
            returnDeclaration = null;
        }
        else {
            returnType = functionModel.type;
            returnDeclaration = functionModel;
        }

        value parameters = CeylonList(parameterList.parameters);

        "True if boxing is required. If `true`, an extra outer function will be created
         to handle boxing and null safety."
        value needsWrapperFunction =
                functionModel is ClassModel | ConstructorModel
                || (!returnsCallable
                    && !hasForcedNonNativeReturn
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
                =   unsafeMap(parameters.indexed.collect((e)
                    =>  e.item -> DartSimpleIdentifier("$``e.key``")));

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
                        () => if (hasForcedNonNativeReturn)
                        then withBoxingNonNative {
                            scope;
                            returnType;
                            invocation;
                        }
                        else withBoxing {
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
            =   if (exists sequenceArg)
                then sequenceArgumentInfo(sequenceArg)
                else null;

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
                            lhsIsParameter = true;
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
                            lhsIsParameter = true;
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
                            lhsIsParameter = true;
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

    "Returns a tuple containing:
        - Statements required to pre-calculate argument expressions
        - The [[DartArgumentList]]
        - The boolean value `true` if the final argument in the returned argument list
          is a sequenced argument and the invoked declaration is a Function that is
          implemented as a Callable value, or false otherwise. This is used when invoking
          [[Callable]]s, for which the `.s()` method must be used to spread sequenced
          arguments (rather than the `.f()` method)."
    shared
    [[DartStatement*], DartArgumentList, Boolean] generateArgumentListFromArguments(
            DScope scope,
            Arguments arguments,
            // TODO accept {TypeModel*} signature instead
            List<TypeModel | TypeDetails> signature,
            FunctionModel | ValueModel | ClassModel | ConstructorModel | Null
                    declarationModel) {

        "Returns the DartArgumentList (with non-native and erased-to-object arguments),
         and possibly a trailing spread argument. If a spread argument exists, the
         returned boolean will be true."
        function generateArgumentListForIndirectInvocation(ArgumentList argumentList)
            =>  [[],
                DartArgumentList {
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

        function pList(FunctionModel | ClassModel | ConstructorModel declarationModel)
            =>  switch(declarationModel)
                case (is FunctionModel) declarationModel.firstParameterList
                // FIXME parameterList may be null here...
                case (is ClassModel) declarationModel.parameterList
                // FIXME parameterList may be null here...
                case (is ConstructorModel) declarationModel.parameterList;

        switch (arguments)
        case (is PositionalArguments) {
            if (is FunctionModel declarationModel,
                    dartTypes.isCallableValue(declarationModel)) {
                return generateArgumentListForIndirectInvocation(arguments.argumentList);
            }

            if (is ValueModel | Null declarationModel) {
                // surely a Callable (or perhaps just a regular value with no-args that
                // got caught up in this mess...)
                return generateArgumentListForIndirectInvocation(arguments.argumentList);
            }

            value [argsSetup, argExpressions]
                =   generateArgumentsFromPositionalArguments {
                        arguments;
                        signature;
                        pList(declarationModel);
                    };

            return [argsSetup, DartArgumentList(argExpressions),
                    arguments.argumentList.sequenceArgument exists];
        }
        case (is NamedArguments) {
            "A non-value declaration must exist for named argument invocations; named
             argument lists are not supported for indirect invocations."
            assert (is FunctionModel | ClassModel | ConstructorModel declarationModel);

            value [argsSetup, argExpressions]
                =   generateArgumentsFromNamedArguments {
                        arguments;
                        signature;
                        pList(declarationModel);
                    };

            return [argsSetup, DartArgumentList(argExpressions), false];
        }
    }

    shared
    [[DartStatement*], [DartExpression*]] generateArgumentsFromNamedArguments(
            NamedArguments namedArguments,
            List<TypeModel | TypeDetails> signature,
            ParameterListModel parameterList) {

        value scope = nodeInfo(namedArguments);

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
                                    lhsIsParameter = true;
                                };
                    }
                    case (is SpecifiedArgumentInfo) {
                        // If the lazySpecification defines a function, generate and
                        // pass a callable
                        if (is LazySpecification lazySpecification
                                    =   argumentInfo.node.specification,
                                nonempty parameterLists
                                    =   lazySpecification.parameterLists) {

                            value lazySpecificationInfo
                                =   LazySpecificationInfo(lazySpecification);

                            "It has a parameter list, so it must be a function."
                            assert (is FunctionModel declarationModel
                                =   lazySpecificationInfo.declaration);

                            dartExpression
                                =   withLhs {
                                        typeModel;
                                        parameterModelModel;
                                        () => generateNewCallable {
                                            argumentInfo;
                                            declarationModel;
                                            generateFunctionExpressionRaw {
                                                lazySpecificationInfo;
                                                declarationModel;
                                                parameterLists;
                                                lazySpecification.specifier;
                                            };
                                        };
                                        lhsIsParameter = true;
                                    };
                        }
                        else {
                            // For values, treating ValueSpecification and
                            // LazySpecification identically. A lazy function would just
                            // be evaluated right away anyway.
                            dartExpression
                                =   withLhs {
                                        typeModel;
                                        parameterModelModel;
                                        () => argumentInfo.node.specification.specifier
                                                .expression.transform {
                                            expressionTransformer;
                                        };
                                        lhsIsParameter = true;
                                    };
                        }
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
                                        lhsIsParameter = true;
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
                                    parameterModelModel;
                                    () => generateNewCallable {
                                        argumentInfo;
                                        argumentInfo.declarationModel;
                                        generateFunctionExpression(argumentInfo.node);
                                    };
                                    lhsIsParameter = true;
                                };
                    }
                    case (is ObjectArgumentInfo) {
                        argumentInfo.node.visit(topLevelVisitor);

                        dartExpression
                            =   withLhs {
                                    typeModel;
                                    parameterModelModel;
                                    () => generateObjectInstantiation {
                                        argumentInfo;
                                        argumentInfo.anonymousClass;
                                    };
                                    lhsIsParameter = true;
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

        function assertedParameterModel(ParameterModel? m) {
            assert (exists m);
            return m;
        }

        value definedParameters
            =   set {
                    concatenate {
                        if (nonempty iterableArgument)
                        then [assertedParameterModel(iterableInfo.parameter)]
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

    "Generate an assignment expression.

     This function is basically a setter version of
     [[ExpressionTransformer.transformInvocation]] and [[generateInvocation]] combined.
     But, simpler since less can be done with setters."
    shared
    DartExpression
    generateAssignment(
            DScope scope,
            BaseExpression | QualifiedExpression target,
            DartExpression() rhsExpression) {

        // TODO Make sure setters return the new value, or handle that here when there
        //      is a lhs type.

        TypeModel valueType;
        ValueModel valueDeclaration;
        DartQualifiedInvocable invocable;

        switch (target)
        case (is BaseExpression) {
            value info = BaseExpressionInfo(target);
            assert (is ValueModel d = info.declaration);
            valueDeclaration = d;
            valueType = info.typeModel;

            if (!valueDeclaration.shared,
                is InterfaceModel targetContainer = container(valueDeclaration)) {
                // Special case: invoking private interface member using a BaseExpression.

                // Find the receiver (the $this argument) starting from the scope's
                // container and searching ancestors until an exact match for the
                // target's interface is found. (dartTypes.expressionToOuter() does this)

                "The scope of a BaseExpression to a function or value member of a class
                 or interface will have a containing class or interface."
                assert (exists scopeContainer
                    =   getContainingClassOrInterface(scope));

                value dartFunctionOrValue
                    =   DartInvocable {
                            DartPropertyAccess {
                                dartTypes.dartIdentifierForClassOrInterface {
                                    scope;
                                    targetContainer;
                                };
                                dartTypes.getStaticInterfaceMethodIdentifier {
                                    valueDeclaration;
                                    isSetter = true;
                                };
                            };
                            dartFunction; // Static interface functions are... functions
                            false;
                        };

                invocable
                    =   DartQualifiedInvocable {
                            dartTypes.expressionToOuter(scope, targetContainer);
                            dartFunctionOrValue;
                        };
            }
            else {
                invocable
                    =   dartTypes.invocableForBaseExpression {
                            scope;
                            valueDeclaration;
                            true;
                        };
            }
        }
        case (is QualifiedExpression) {
            value info = QualifiedExpressionInfo(target);
            assert (is ValueModel d = info.declaration);
            valueDeclaration = d;
            valueType = info.typeModel;

            assert (is ClassOrInterfaceModel targetContainer
                =   valueDeclaration.container);

            if (exists superType = dartTypes.denotableSuperType(
                    target.receiverExpression)) {

                // super receiver

                if (superType.declaration is ClassModel) {
                    // super refers to the superclass

                    invocable
                        =   DartQualifiedInvocable {
                                DartSimpleIdentifier("super");
                                dartTypes.dartInvocable {
                                    scope; valueDeclaration; true;
                                };
                            };
                }
                else {
                    // super referes to an interface; call static interface method

                    // Abandon polymorphism and invoke the Dart static method directly.
                    // This also works when `super` is used to invoke private interface
                    // methods, which must *always* use the static methods.

                    // Note: It's nice that we have the declaration pointed to by
                    //       referenced by `super`, but it's also completely useless.
                    //
                    //       Instead, we'll ues the interface that is the container of
                    //       memberDeclaration, which will be a supertype of `super` if
                    //       `super` doesn't refine the member. (Since we're calling a
                    //       static method, we need the interface that actually provides
                    //       the definition.)

                    invocable
                        =   DartQualifiedInvocable {
                                dartTypes.expressionForThis(scope);
                                DartInvocable {
                                    DartPropertyAccess {
                                        dartTypes.dartIdentifierForClassOrInterface {
                                            scope;
                                            targetContainer;
                                        };
                                        dartTypes.getStaticInterfaceMethodIdentifier {
                                            valueDeclaration;
                                            isSetter = true;
                                        };
                                    };
                                    dartFunction; // Static interface functions are functions
                                    false;
                                };

                            };
                }
            }
            else {
                // receiver is not super, evaluate expression for receiver

                invocable
                    =   DartQualifiedInvocable {
                            withLhsDenotable {
                                targetContainer;
                                () => target.receiverExpression.transform {
                                    expressionTransformer;
                                };
                            };
                            dartTypes.dartInvocable {
                                scope; valueDeclaration; true;
                            };
                        };
            }
        }

        // TODO use the rhs type, since that's what Dart uses for the expression type
        //      (and so does Ceylon). So we'll need 1) the rhs type, and 2) to calculate
        //      erasure on our own. The only symptom is unnecessary casts.
        return withBoxing {
            scope;
            valueType;
            valueDeclaration;
            invocable.expressionForInvocation {
                [withLhs {
                    valueType;
                    valueDeclaration;
                    rhsExpression;
                }];
            };
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
        =>  let (argumentInfo = expressionInfo(that.argument))
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

    "Generate a Dart field declaration for the Ceylon function or value member. This
     may be:

        - just a regular field for Ceylon value, or

        - a synthetic field for mapped members, such as 'string', which will also need a
          'toString()' getter, or

        - a field to hold the Callable for a non-shared callable parameter

     For `default` `Value`s, a synthetic field name will be used."
    shared
    DartFieldDeclaration generateFieldDeclaration
            (DScope scope, FunctionOrValueModel functionOrValueModel)
        =>  DartFieldDeclaration {
                false;
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartTypeNameForDeclaration {
                        scope;
                        functionOrValueModel;
                    };
                    [DartVariableDeclaration {
                        // The field for the Callable or the possibly synthetic field for
                        // the value
                        dartTypes.identifierForField(functionOrValueModel);
                    }];
                };
            };

    "Generate a getter method for a Ceylon value that maps to a Dart method, such as
     `toString()`."
    shared
    DartMethodDeclaration generateMethodToReferenceForwarder
            (DScope scope, ValueModel valueModel) {

        "The invocable for the *getter* the Ceylon value maps to."
        value invocableGetter
            =   dartTypes.dartInvocable {
                    scope;
                    valueModel;
                    false;
                };

        "Don't generate bridge methods for values that can be implemented as values."
        assert (invocableGetter.elementType != dartValue);

        "ClassOrInterface members always have simple identifiers."
        assert (is DartSimpleIdentifier getterIdentifier
            =   invocableGetter.reference);

        return DartMethodDeclaration {
            false;
            null;
            generateFunctionReturnType {
                scope;
                valueModel;
            };
            null;
            invocableGetter.elementType is DartOperator;
            getterIdentifier;
            dartFormalParameterListEmpty;
            DartExpressionFunctionBody {
                false;
                // boxing and casting should never be required...
                // The field may be synthetic
                dartTypes.identifierForField(valueModel);
            };
        };
    }

    "Generate a getter (and setter if necessary) to a synthetic field used to store the
     value. Synthetic fields are necessary for non-transient (reference) values that are
     `default`, since we need to assign to them in the Dart constructor in order to
     perform initialization associated with Ceylon declarations *without* unintentionally
     assigning to a refinement in a subclass.

     Having a synthetic field is *just* to help with the value assignment associated with
     the declaration. All other access to the value honors refinements. If the Value is
     overriden, the only way to access the synthetic field in Ceylon code after
     initialization will be through the use of `super.val` by the subclass, which will
     provide access to the methods generated by this function."
    shared
    [DartClassMember*] generateBridgesToSyntheticField
            (DScope scope, ValueModel valueModel)
        =>  let (syntheticFieldIdentifier
                    =   dartTypes.identifierForSyntheticField(valueModel))
            [// Don't generate a getter bridge if this is a mapped member that will
             // already have a bridge.
             !dartTypes.valueMappedToNonField(valueModel) then
             DartMethodDeclaration {
                false; null;
                generateFunctionReturnType(scope, valueModel);
                "get";
                // Never an operator; if the member is mapped to an operator there
                // will be a forwarding method to this getter
                operator = false;
                DartSimpleIdentifier {
                    dartTypes.getName(valueModel);
                };
                null;
                DartExpressionFunctionBody {
                    false;
                    syntheticFieldIdentifier;
                };
            },
            valueModel.variable then
            DartMethodDeclaration {
                false; null;
                returnType = null;
                "set";
                operator = false;
                DartSimpleIdentifier {
                    dartTypes.getName(valueModel);
                };
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false; false;
                        generateFunctionReturnType(scope, valueModel);
                        DartSimpleIdentifier("$v");
                    }];
                };
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        [DartExpressionStatement {
                            DartAssignmentExpression {
                                syntheticFieldIdentifier;
                                DartAssignmentOperator.equal;
                                DartSimpleIdentifier("$v");
                            };
                        }];
                    };
                };
            }].coalesced.sequence();

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
