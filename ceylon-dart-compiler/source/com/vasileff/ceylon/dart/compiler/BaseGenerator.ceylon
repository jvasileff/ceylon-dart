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
    FunctionArgument
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
    DartMethodInvocation,
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
    DartPrefixedIdentifier,
    DartBlockFunctionBody,
    DartBooleanLiteral,
    DartExpressionStatement,
    DartConditionalExpression,
    DartFunctionBody,
    DartStatement,
    DartSwitchCase,
    DartIntegerLiteral,
    DartSwitchStatement,
    DartListLiteral
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
    nativeBinaryFunctions = (() {
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
    DartFunctionExpressionInvocation createInlineDartStatements(
            "Zero or more statements, followed by a Return"
            [DartStatement*] statements)
        =>  DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    dartFormalParameterListEmpty;
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock(statements);
                    };
                };
                DartArgumentList([]);
            };

    "Note: technically callers should cast the returned DartExpression to the desired
     lhs type, since Dart appears to treat the result of anonymous function invocations
     as `var`. So type information is lost. But lets not get too pedantic."
    shared
    DartExpression createNullSafeExpression(
            "Identifier for result of [[maybeNullExpression]]"
            DartSimpleIdentifier parameterIdentifier,
            "The type of the [[maybeNullExpression]] that will be exposed as
             [[parameterIdentifier]]"
            DartTypeName parameterType,
            "Evaluate, test for null, and make available as [[parameterIdentifier]].
             Must be of [[parameterType]]."
            DartExpression maybeNullExpression,
            "Only evaluate if maybeNullExpression is null"
            DartExpression ifNullExpression,
            "Only evaluate if maybeNullExpression is not null"
            DartExpression ifNotNullExpression)
        =>  DartFunctionExpressionInvocation {
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            false;
                            false;
                            parameterType;
                            parameterIdentifier;
                        }];
                    };
                    body = DartExpressionFunctionBody {
                        async = false;
                        DartConditionalExpression {
                            DartBinaryExpression {
                                parameterIdentifier;
                                "==";
                                DartNullLiteral();
                            };
                            ifNullExpression;
                            ifNotNullExpression;
                        };
                    };
                };
                DartArgumentList {
                    [maybeNullExpression];
                };
            };

    "Returns an invoked function that executes [[setup]] and returns [[expression]] if
     [[setup]] is nonempty. Returns [[expression]] otherwise."
    shared
    DartExpression createExpressionEvaluationWithSetup(
            [DartStatement*] setup, DartExpression expression)
        =>  if (!nonempty setup) then
                expression
            else
                DartFunctionExpressionInvocation {
                    DartFunctionExpression {
                        dartFormalParameterListEmpty;
                        DartBlockFunctionBody {
                            null;
                            false;
                            DartBlock  {
                                concatenate {
                                    setup,
                                    [DartReturnStatement {
                                        expression;
                                    }]
                                };
                            };
                        };
                    };
                    DartArgumentList { []; };
                };

    shared
    DartFunctionDeclaration generateFunctionDefinition
            (FunctionShortcutDefinition | FunctionDefinition that) {

        value info = AnyFunctionInfo(that);
        value functionModel = info.declarationModel;
        value functionIdentifier = dartTypes.dartIdentifierForFunctionOrValueDeclaration(
                    info, functionModel, false)[0];

        return
        DartFunctionDeclaration {
            external = false;
            returnType = generateFunctionReturnType(info, functionModel);
            propertyKeyword = null;
            name = functionIdentifier;
            functionExpression = generateFunctionExpression(that);
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
            [TypeModel, [Expression*] | PositionalArguments]?
                    callableTypeAndArguments = null) {

        "Only toplevels are supported; declaration's container must be a package."
        assert (memberDeclaration.container is PackageModel);

        // TODO Use this in transformInvocation, transformBaseExpression, etc.
        //      Which will also require support for NamedArguments
        //
        // NOTE not yet used for values

        value [callableType, a] = callableTypeAndArguments else [null, []];

        [Expression*] arguments;
        switch (a)
        case (is [Expression*]) {
            arguments = a;
        }
        case (is PositionalArguments) {
            arguments = a.argumentList.listedArguments;
        }

        value [functionOrValueIdentifier, isFunction] = dartTypes
                    .dartIdentifierForFunctionOrValue(scope, memberDeclaration, false);

        value resultDeclaration =
                if (is FunctionModel memberDeclaration,
                        memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        DartExpression invocation;
        if (arguments nonempty) {
            "If there are arguments, the member is surely a FunctionModel and must
             translate to a Dart function"
            assert (is FunctionModel memberDeclaration, isFunction);

            "If we have arguments, we'll have a callableType."
            assert (exists callableType);

            value argumentTypes = CeylonList(ctx.unit
                    .getCallableArgumentTypes(callableType.fullType));

            value parameterDeclarations = CeylonList(
                    memberDeclaration.firstParameterList.parameters)
                    .collect(ParameterModel.model);

            invocation =
            DartFunctionExpressionInvocation {
                functionOrValueIdentifier;
                DartArgumentList {
                    [for (i -> argument in arguments.indexed)
                        withLhs {
                            argumentTypes[i];
                            parameterDeclarations[i];
                            () => argument.transform(expressionTransformer);
                        }
                    ];
                };
            };
        }
        else {
            invocation =
                if (!isFunction)
                then functionOrValueIdentifier
                else DartFunctionExpressionInvocation {
                    functionOrValueIdentifier;
                    DartArgumentList();
                };
        }

        return
        withBoxing {
            scope;
            resultType;
            resultDeclaration;
            invocation;
        };
    }

    "Generate an invocation or propery access expression."
    shared
    DartExpression generateInvocation(
            DScope scope,
            "The return type of the invocation. If [[callableTypeAndArguments]]
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
            FunctionOrValueModel | ClassModel memberDeclaration,
            [TypeModel,   [DartExpression()*]
                        | [Expression*]
                        | Arguments]? callableTypeAndArguments = null,
            AnyMemberOperator? memberOperator = null) {

        "By definition."
        assert (is FunctionModel | ValueModel | SetterModel | ClassModel
                memberDeclaration);

        "SpreadMemberOperator not yet supported."
        assert (is Null | MemberOperator | SafeMemberOperator memberOperator);
        value safeMemberOperator = memberOperator is SafeMemberOperator;

        value [callableType, a] = callableTypeAndArguments else [null, []];

        [DartExpression()*] arguments;

        [DartStatement*] argsSetup;

        if (is [DartExpression()*] a) {
            argsSetup = [];
            arguments = a;
        }
        else if (is [Expression*] a) {
            argsSetup = [];
            arguments = a.collect((a) => ()
                    => a.transform(expressionTransformer));
        }
        else if (is PositionalArguments a) {
            argsSetup = [];
            arguments = a.argumentList.listedArguments.collect((a) => ()
                    => a.transform(expressionTransformer));
        }
        else { // is NamedArguments
            "If we have arguments, we'll have a callableType."
            assert (exists callableType);

            "If we have arguments, we'll have a function or class."
            assert (is FunctionModel | ClassModel memberDeclaration);

            value [x, y]
                =   generateFromNamedArguments {
                        scope;
                        a;
                        callableType;
                        memberDeclaration.firstParameterList;
                    };

            argsSetup = x;
            arguments = y;
        }

        // TODO WIP native optimizations
        if (exists generateReceiver, // No optimizations for `super` receiver
            exists optimization = nativeBinaryFunctions(memberDeclaration)) {
            assert (exists rightOperandArgument = arguments[0]);

            value [type, leftOperandType, operand, rightOperandType] = optimization;

            return withBoxingCustom {
                scope;
                type;
                true; false;
                DartBinaryExpression {
                    leftOperand = withLhsNative {
                        leftOperandType;
                        generateReceiver;
                    };
                    operator = operand;
                    rightOperand = withLhsNative {
                        rightOperandType;
                        rightOperandArgument;
                    };
                };
            };
        }

        "An optional `$this` argument, for use with static invocations and constructors."
        [DartExpression]|[] thisArgument;

        "Will either be an Interface or an expression for the Ceylon receiver. A dummy
         value is used for constructors, d'oh!"
        DartExpression dartBoxedReceiver;

        "Are we invoking a Dart function or constructor? (As opposed to a Dart value)"
        Boolean isFunction;

        "The Dart identifier for the function, value, or constructor"
        DartSimpleIdentifier | DartConstructorName memberIdentifier;

        "The Dart type of what Ceylon thinks is the receiver! They differ when Dart needs
         the receiver to be an interface for a static method invocation."
        DartTypeName? ceylonReceiverDartType;

        if (is ClassModel memberDeclaration) {
            if (!exists generateReceiver) {
                throw CompilerBug(scope,
                        "Member class invocations on super not supported.");
            }

            // Invoking a member class; must call the statically known Dart constructor,
            // passing the receiver (outer) as the first argument.

            "The container of a member class invoked with a receiver must be a class
             or interface."
            assert (is ClassOrInterfaceModel memberContainer
                 =  getContainingClassOrInterface(memberDeclaration.container));

            thisArgument
                =   [withLhsDenotable {
                        memberContainer;
                        generateReceiver;
                    }];

            isFunction
                =   true; // Constructor, really

            dartBoxedReceiver // Very ugly. But won't be used.
                =   DartNullLiteral();

            memberIdentifier
                =   dartTypes.dartConstructorName {
                        scope;
                        memberDeclaration;
                    };

            // The Dart type of what Ceylon thinks is the receiver!
            ceylonReceiverDartType
                =   dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.denotableType {
                            receiverType;
                            memberContainer;
                        };
                        eraseToNative = false;
                    };
        }
        else if (!exists generateReceiver) {
            // Receiver is `super`

            // Only used for null safe operator, and `super` is never null
            ceylonReceiverDartType = null;

            if (receiverType.declaration is InterfaceModel) {
                // Invoking a specific interface's implementation. Abandon polymorphism
                // and invoke the Dart static method directly. This also works when
                // `super` is used to invoke private interface methods, which must
                // *always* use the static methods.

                "A `super` reference is surely contained within a class or interface."
                assert (exists scopeContainer = getContainingClassOrInterface(scope));

                thisArgument = [dartTypes.expressionForThis(scopeContainer)];

                isFunction = true; // Static interface functions are... functions

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

                dartBoxedReceiver
                    =   dartTypes.dartIdentifierForClassOrInterface {
                            scope;
                            implementingContainer;
                        };

                memberIdentifier
                    =   dartTypes.getStaticInterfaceMethodIdentifier {
                            memberDeclaration;
                            false;
                        };
            }
            else {
                // super refers to the superclass
                thisArgument = [];
                dartBoxedReceiver = DartSimpleIdentifier("super");
                value [m, f] = dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    scope;
                    memberDeclaration;
                    false;
                };
                memberIdentifier = m;
                isFunction = f;
            }
        }
        else if (!memberDeclaration.shared,
                 is InterfaceModel memberContainer
                         =  getContainingClassOrInterface(memberDeclaration)) {
            // Invoking private interface member; must call static implementation method.
            thisArgument
                =   [withLhsDenotable {
                        memberContainer;
                        generateReceiver;
                    }];

            isFunction
                =   true; // Static interface functions are... functions

            dartBoxedReceiver
                =   dartTypes.dartIdentifierForClassOrInterface {
                        scope;
                        memberContainer;
                    };

            memberIdentifier
                =   dartTypes.getStaticInterfaceMethodIdentifier {
                        memberDeclaration;
                        false;
                    };

            // The Dart type of what Ceylon thinks is the receiver!
            ceylonReceiverDartType
                =   dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.denotableType {
                            receiverType;
                            memberContainer;
                        };
                        eraseToNative = false;
                    };
        }
        else {
            // receiver is not `super`

            thisArgument = [];
            value [m, f] = dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                scope;
                memberDeclaration;
                false;
            };
            memberIdentifier = m;
            isFunction = f;

            // Determine usable receiver type. `withLhsDenotable` would be simpler, but
            // we may need the type (for safeMemberOperator code)
            assert (is ClassOrInterfaceModel container
                =   container(memberDeclaration));

            value receiverDenotableType
                =   ceylonTypes.denotableType {
                        receiverType;
                        container;
                    };

            ceylonReceiverDartType
                =   dartTypes.dartTypeName {
                        scope;
                        receiverDenotableType;
                        eraseToNative = false;
                    };

            dartBoxedReceiver
                =   withLhsCustom {
                        receiverDenotableType;
                        false; false;
                        generateReceiver;
                    };
        }

        value resultDeclaration
            =   if (is FunctionModel memberDeclaration,
                    memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        DartExpression invocation;
        if (arguments nonempty || memberIdentifier is DartConstructorName) {
            "If there are arguments, the member is a FunctionModel and will translate
             to a Dart function, or it's a ClassModel, and will translate to a Dart
             constructor."
            assert (is FunctionModel | ClassModel memberDeclaration, isFunction);

            "If we have arguments, we'll have a callableType."
            assert (exists callableType);

            value argumentList {
                value argumentTypes = CeylonList(ctx.unit
                        .getCallableArgumentTypes(callableType.fullType));

                value parameterDeclarations = CeylonList(
                        memberDeclaration.firstParameterList.parameters)
                        .collect(ParameterModel.model);

                "Actual `$this` argument which may be the parameter to an anonymous
                 function for the null safe operator."
                value dartThisArgument
                    =   if (thisArgument nonempty // Dart receiver is a static function
                                && safeMemberOperator) // Ceylon receiver may be null
                        then [DartSimpleIdentifier("$r$")]
                        else thisArgument;

                return
                DartArgumentList {
                    concatenate {
                        dartThisArgument,
                        [for (i -> argument in arguments.indexed)
                            withLhs {
                                argumentTypes[i];
                                parameterDeclarations[i];
                                argument;
                            }
                        ]
                    };
                };
            }

            if (safeMemberOperator) {
                // FIXME what about argsSetup???

                "Must exist since receiver is never `super` when the safe member
                 operator is used."
                assert (exists ceylonReceiverDartType);

                invocation
                    =   createNullSafeExpression {
                            parameterIdentifier = DartSimpleIdentifier("$r$");
                            parameterType = ceylonReceiverDartType;
                            // For static invocations, the possibly null value is the
                            // $this argument
                            maybeNullExpression
                                =   if (nonempty thisArgument)
                                    then thisArgument.first
                                    else dartBoxedReceiver;
                            ifNullExpression = DartNullLiteral();
                            ifNotNullExpression =
                                if (is DartConstructorName memberIdentifier) then
                                    DartInstanceCreationExpression {
                                        false;
                                        memberIdentifier;
                                        argumentList;
                                    }
                                else
                                    DartFunctionExpressionInvocation {
                                        DartPropertyAccess {
                                            // For static invocations, the dart receiver
                                            // is the static methods containing interface,
                                            // which is represented by `dartBoxedReceiver`
                                            // (`dartBoxedReceiver` is not the expression
                                            // that might be null in this case)
                                            if (thisArgument nonempty)
                                            then dartBoxedReceiver
                                            else DartSimpleIdentifier("$r$");
                                            memberIdentifier;
                                        };
                                        argumentList;
                                    };
                        };
            }
            else {
                invocation
                    =   createExpressionEvaluationWithSetup {
                            argsSetup;
                            if (is DartConstructorName memberIdentifier) then
                                DartInstanceCreationExpression {
                                    false;
                                    memberIdentifier;
                                    argumentList;
                                }
                            else
                                DartMethodInvocation {
                                    dartBoxedReceiver;
                                    memberIdentifier;
                                    argumentList;
                                };
                        };
            }
        }
        else {
            "If statement covered this condition."
            assert (!is DartConstructorName memberIdentifier);

            function valueAccess(DartExpression receiver)
                =>  if (!isFunction)
                    then DartPropertyAccess(receiver, memberIdentifier)
                    else DartMethodInvocation {
                        receiver;
                        memberIdentifier;
                        DartArgumentList {
                            thisArgument; // possibly empty
                        };
                    };

            if (safeMemberOperator) {
                "Must exist since receiver is never `super` when the safe member
                 operator is used."
                assert (exists ceylonReceiverDartType);

                invocation
                    =   createNullSafeExpression {
                            parameterIdentifier = DartSimpleIdentifier("$r$");
                            parameterType = ceylonReceiverDartType;
                            maybeNullExpression = dartBoxedReceiver;
                            ifNullExpression = DartNullLiteral();
                            ifNotNullExpression = valueAccess {
                                DartSimpleIdentifier("$r$");
                            };
                        };
            }
            else {
                invocation
                    =   valueAccess(dartBoxedReceiver);
            }
        }

        return
        withBoxing {
            scope;
            resultType;
            resultDeclaration;
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

        assert (is FunctionOrValueModel memberDeclaration =
                    receiverType.declaration.getMember(memberName, null, false));

        value typedReference = receiverType.getTypedMember(memberDeclaration, null);

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
                    [typedReference.fullType, arguments];
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
                dartTypes.dartIdentifierForFunctionOrValue {
                    scope;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }[0];
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
                dartTypes.dartIdentifierForFunctionOrValue {
                    scope;
                    ceylonTypes.emptyValueDeclaration;
                    false;
                }[0];
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
            conditionExpression = generateIsExpression(
                    info, tempIdentifier, isType);

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
            assert(is FunctionOrValueModel originalDeclaration
                =   variableDeclaration.originalDeclaration);

            value originalIdentifier
                =   DartSimpleIdentifier(dartTypes.getName(originalDeclaration));

            conditionExpression
                =   generateIsExpression(info, originalIdentifier, isType);

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
                            tempIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            info;
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
            assert (is FunctionOrValueModel originalDeclaration
                =   variableDeclaration.originalDeclaration);

            value originalIdentifier
                =   DartSimpleIdentifier(dartTypes.getName(originalDeclaration));

            value conditionExpression
                =   switch (that)
                    case (is ExistsCondition)
                        generateExistsExpression {
                            info;
                            originalIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            info;
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
            DartExpression expressionToCheck,
            Boolean negated = false)
        =>  let (expression = generateIsExpression {
                    scope;
                    expressionToCheck;
                    ctx.ceylonTypes.nullType;
                })
            if (!negated)
            then DartPrefixExpression("!", expression)
            else expression;

    shared
    DartExpression generateNonemptyExpression(
            DScope scope,
            DartExpression expressionToCheck,
            Boolean negated = false)
        =>  let (expression = generateIsExpression {
                    scope;
                    expressionToCheck;
                    ctx.ceylonTypes.sequenceAnythingType;
                })
            if (negated)
            then DartPrefixExpression("!", expression)
            else expression;

// FIXME Document that the expression must not be of a native type, check usage
//       Likely problem would be `is Integer` for an `Integer|Null`.
//       Best may be to take a `DartExpression()` that boxes...
//       Another idea: if we knew the *current* type, we could optimize the
//       is check for `primitive|Null`s. We need this info anyway for other optimzns.
    shared
    DartExpression generateIsExpression(
            DScope scope,
            DartExpression expressionToCheck,
            TypeModel isType) {

        // TODO warn if non-denotable (for which we are currently returning true!)
        //      - take the type we are narrowing, and warn if non-reified checks are not
        //        sufficient
        //      - reified generics...

        if (isType.union) {
            value result = CeylonList(isType.caseTypes).reversed
                .map((t)
                    => generateIsExpression(scope, expressionToCheck, t))
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "||", partial));

            assert (exists result);
            return result;
        }
        else if (isType.intersection) {
            value result = CeylonList(isType.satisfiedTypes).reversed
                .map((t)
                    => generateIsExpression(scope, expressionToCheck, t))
                .reduce((DartExpression partial, c)
                    =>  DartBinaryExpression(c, "&&", partial));

            assert (exists result);
            return result;
        }
        else if (ceylonTypes.isCeylonNothing(isType)) {
            return DartBooleanLiteral(false);
        }
        else if (!dartTypes.denotable(isType)) {
            // FIXME we should at least check for null/not-null
            // This isn't good! But no alternative w/o reified generics
            return DartBooleanLiteral(true);
        }
        else if (ceylonTypes.isCeylonIdentifiable(isType)) {
            // TODO don't be so generous!!!
            return
            DartBinaryExpression {
                expressionToCheck;
                "!=";
                DartNullLiteral();
            };
        }
        else if (ceylonTypes.isCeylonObject(isType)
                  || ceylonTypes.isCeylonBasic(isType)) {
            return
            DartBinaryExpression {
                expressionToCheck;
                "!=";
                DartNullLiteral();
            };
        }
        else if (ceylonTypes.isCeylonNull(isType)) {
            return
            DartBinaryExpression {
                expressionToCheck;
                "==";
                DartNullLiteral();
            };
        }
        else {
            // we'll assume eraseToNative is false; otherwise, test should not compile
            value dartType = dartTypes.dartTypeName(scope, isType, false);

            return
            DartIsExpression {
                expressionToCheck;
                dartType;
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

    shared
    DartFunctionDeclaration generateForValueDefinitionGetter(
            ValueDefinition|ValueGetterDefinition that) {

        value definition = that.definition;

        if (definition is Specifier) {
            throw CompilerBug(that, "Specifier not supported");
        }
        assert (is LazySpecifier|Block definition);

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

        value [identifier, isFunction]
            =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    scope;
                    declarationModel;
                };

        return
        DartFunctionDeclaration {
            false;
            dartTypes.dartTypeNameForDeclaration {
                scope;
                declarationModel;
            };
            !isFunction then "get";
            identifier;
            DartFunctionExpression {
                isFunction then dartFormalParameterListEmpty;
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

        value [identifier, isFunction]
            =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    info;
                    declarationModel;
                };

        return
        DartFunctionDeclaration {
            false;
            DartTypeName {
                DartSimpleIdentifier {
                    "void";
                };
            };
            !isFunction then "set";
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
                            null,
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

                for (param in defaultedParameters) {
                    value parameterInfo = ParameterInfo(param);
                    value parameterModelModel = parameterInfo.parameterModel.model;
                    value paramName = DartSimpleIdentifier(
                            dartTypes.getName(parameterInfo.parameterModel));

                    statements.add {
                        DartIfStatement {
                            // if (parm === default)
                            DartFunctionExpressionInvocation {
                                DartPrefixedIdentifier {
                                    DartSimpleIdentifier("$dart$core");
                                    DartSimpleIdentifier("identical");
                                };
                                DartArgumentList {
                                    [paramName,
                                     dartTypes.dartDefault(scope)];
                                };
                            };
                            // then set to default expression
                            DartExpressionStatement {
                                DartAssignmentExpression {
                                    paramName;
                                    DartAssignmentOperator.equal;
                                    if (is DefaultedCallableParameter param,
                                        is FunctionModel parameterModelModel) then
                                        // Generate a Callable for the default function
                                        // value
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
                    };
                }
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
    DartFormalParameterList generateFormalParameterList
            (DScope scope, Parameters|{ParameterModel*} parameters) {

        value parameterList
            =   if (is Parameters parameters)
                then parameters.parameters.map(
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
                if (defaulted)
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

            if (defaulted) {
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
            (DScope scope, ClassModel declaration) {

        // FIXME setters?
        value captureExpressions
            =   dartTypes.captureDeclarationsForClass(declaration)
                    .map((capture)
                        =>  dartTypes.expressionForBaseExpression(scope, capture, false))
                    // Workaround https://github.com/ceylon/ceylon-compiler/issues/2293
                    .map((tuple) => tuple.first);

        value outerExpression
            =   if (exists container = getContainingClassOrInterface(scope),
                    exists outerCI = getContainingClassOrInterface(declaration.container))
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
    [TypeModel, DartSimpleIdentifier, DartVariableDeclarationStatement]
    generateForSwitchClause(SwitchClause that) {
        value info = NodeInfo(that);

        TypeModel switchedType;
        DartSimpleIdentifier switchedVariable;
        DartVariableDeclarationStatement variableDeclaration;

        switch (switched = that.switched)
        case (is Expression) {
            switchedType
                =   ExpressionInfo(switched).typeModel;

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
            value declaration
                =   SpecifiedVariableInfo(switched).declarationModel;

            switchedType
                =   declaration.type;

            switchedVariable
                =   DartSimpleIdentifier {
                        dartTypes.getName(declaration);
                    };

            // declare the specified variable
            variableDeclaration
                =   DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
                                info;
                                declaration;
                            };
                            [DartVariableDeclaration {
                                DartSimpleIdentifier {
                                    dartTypes.getName(declaration);
                                };
                                withLhs {
                                    null;
                                    declaration;
                                    () => switched.specifier.expression.transform {
                                        expressionTransformer;
                                    };
                                };
                            }];
                        };
                    };
        }
        return [switchedType, switchedVariable, variableDeclaration];
    }

    shared see(`function generateInvocation`)
    DartInstanceCreationExpression generateNewCallableForQualifiedExpression(
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
            FunctionModel | ClassModel memberDeclaration,
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

        "Dart parameters for the *outer* function–the one with the public facing
         signature."
        value outerParameters = parameters.collect((parameterModel) {
            value dartSimpleParameter
                =   DartSimpleFormalParameter {
                        false; false;
                        // $dart$core.Object for the type of all parameters since
                        // `Callable` is generic
                        dartTypes.dartObject;
                        DartSimpleIdentifier {
                            dartTypes.getName(parameterModel);
                        };
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
            value parameterName = dartTypes.getName(parameterModel);
            value parameterIdentifier = DartSimpleIdentifier(parameterName);
            return () {
                "The caller is responsible for `withLhs`."
                value boxed
                    =   withBoxing {
                            scope;
                            // Parameters for Callables are always `core.Object`
                            rhsType = ceylonTypes.anythingType;
                            rhsDeclaration = null;
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

        "The invocation wrapped by the `Callable`, returning a boxed result."
        value invocation
            =   withLhsNonNative {
                    lhsType = resultType;
                    () => generateInvocation {
                        scope;
                        resultType;
                        receiverType;
                        generateReceiver;
                        memberDeclaration;
                        [callableType, innerArguments];
                        memberOperator;
                    };
                };

        "The outer function, serving as the delegate for the `Callable`. This function
         accepts and returns non-erased types."
        DartFunctionExpression outerFunction
            =   DartFunctionExpression {
                    DartFormalParameterList {
                        true; false;
                        outerParameters;
                    };
                    DartExpressionFunctionBody {
                        false;
                        invocation;
                    };
                };

        value variadicParameterIndex
            =   (parameters.getFromLast(0)?.sequenced else false)
                then parameters.size - 1;

        // The Callable
        return createCallable(scope, outerFunction, variadicParameterIndex);
    }

    shared
    DartInstanceCreationExpression generateNewCallable(
            DScope scope,
            FunctionModel | ClassModel functionModel,
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
        FunctionOrValueModel | ClassModel? returnDeclaration;
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
                functionModel is ClassModel
                || (!delegateReturnsCallable
                    && dartTypes.erasedToNative(functionModel))
                || parameters.any((parameterModel)
                    =>  dartTypes.erasedToNative(parameterModel.model));

        if (!needsWrapperFunction) {
            "A bit ugly, but we do know it's a FunctionModel."
            assert (is FunctionModel functionModel);
            outerFunction
                =   delegateFunction else
                    dartTypes.expressionForBaseExpression {
                        scope;
                        functionModel;
                    }[0];
        }
        else {
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
                            DartSimpleIdentifier {
                                dartTypes.getName(parameterModel);
                            };
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
                =   if (is ClassModel functionModel) then
                        generateArgumentsForOuterAndCaptures {
                            scope;
                            functionModel;
                        }
                    else [];

            "Arguments that are part of the public signature for the class or function.
             They have corresponding parameters in the generated Callable."
            value innerArguments = parameters.collect((parameterModel) {
                value parameterName = dartTypes.getName(parameterModel);
                value parameterIdentifier = DartSimpleIdentifier(parameterName);

                value unboxed = withLhs {
                    null;
                    // "lhs" is the inner function's parameter
                    lhsDeclaration = parameterModel.model;
                    // As noted above, Callables are generic, so params are never erased
                    // to native (iow, expect non-natives to be passed in).
                    () => withBoxingNonNative {
                        scope;
                        rhsType = parameterModel.type;
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
                            // ugliness: we have the same exact expression above!
                            delegateFunction else
                            dartTypes.expressionForBaseExpression {
                                scope;
                                functionModel;
                            }[0];
                            DartArgumentList {
                                innerArguments;
                            };
                        };
            }
            case (is ClassModel) {
                invocation
                    =   DartInstanceCreationExpression {
                            false;
                            // no need to transform the base expression:
                            dartTypes.dartConstructorName {
                                scope;
                                functionModel;
                            };
                            DartArgumentList {
                                concatenate {
                                    outerAndCaptureArguments,
                                    innerArguments
                                };
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
    [[DartStatement*], DartArgumentList] generateArgumentListFromArgumentList(
            ArgumentList argumentList,
            TypeModel callableType,
            ParameterListModel parameterList) {

        value scope
            =   dScope(argumentList);

        value parameterTypes
            =   CeylonList(ctx.unit.getCallableArgumentTypes(callableType));

        value listedArguments
            =   argumentList.listedArguments;

        value sequenceArg
            =   argumentList.sequenceArgument;

        value sequenceArgInfo
            =   sequenceArgumentInfo(sequenceArg);

        value sequenceArgType
            =   switch (sequenceArgInfo)
                case (is SpreadArgumentInfo) sequenceArgInfo.typeModel
                case (is ComprehensionInfo) sequenceArgInfo.typeModel
                case (is Null) null;

        value listedParameterCount
            =   parameterList.parameters.size()
                    - (if(parameterList.hasSequencedParameter())
                       then 1 else 0);

        value sequenceArgIsNullOrEmpty
            =   if (!exists sequenceArgType)
                then true
                else ceylonTypes.isCeylonEmpty(sequenceArgType);

        // Handle the easy case where the spread argument, if present, is *not* used for
        // listed parameters. All arguments can be evaluated inline.
        if (listedArguments.size >= listedParameterCount || sequenceArgIsNullOrEmpty) {
            value dartArguments = LinkedList<DartExpression>();

            for (i -> parameter in CeylonIterable(parameterList.parameters).indexed) {
                assert (exists parameterType = parameterTypes[i]); // the *lhs* type
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
                    assert (sequenceArgIsNullOrEmpty);

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
            return [[], DartArgumentList(dartArguments.sequence())];
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
            assert (exists parameterType = parameterTypes[i]);

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

        // Evaluate the sequence argument and assign to `tmpIdentifierSequence`
        dartStatements.add {
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartTypeName {
                        scope;
                        sequenceArgType;
                        false;
                        false;
                    };
                    [DartVariableDeclaration {
                        tmpIdentifierSequence;
                        withLhsNonNative {
                            sequenceArgType;
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
                                    ceylonTypes.sequentialAnythingType;
                                    () => withBoxing {
                                        scope;
                                        sequenceArgType;
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

            assert (exists parameterType = parameterTypes[i]);

            if (parameter.sequenced && !variadicDefinitelyEmpty) {
                // Use spanFrom to generate an argument for the variadic
                dartArguments.add {
                    withLhs {
                        parameterType;
                        parameter.model;
                        () => generateInvocationSynthetic {
                            scope;
                            ceylonTypes.sequentialAnythingType;
                            () => withBoxing {
                                scope;
                                sequenceArgType;
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
                            dartTypes.dartIdentifierForFunctionOrValue {
                                scope;
                                ceylonTypes.emptyValueDeclaration;
                                false;
                            }[0];
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
                                ceylonTypes.sequentialAnythingType;
                                () => withBoxing {
                                    scope;
                                    sequenceArgType;
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

        return [dartStatements.sequence(), DartArgumentList(dartArguments.sequence())];
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
            TypeModel callableType,
            ParameterListModel | FunctionModel | ValueModel
                    | ClassModel | ConstructorModel declarationOrparameterList) {


        if (is ValueModel declarationOrparameterList) {
            // Values won't have arguments.
            return [[], DartArgumentList()];
        }

        value pList
            =   switch(declarationOrparameterList)
                case (is ParameterListModel) declarationOrparameterList
                case (is FunctionModel) declarationOrparameterList.firstParameterList
                case (is ClassModel) declarationOrparameterList.parameterList
                case (is ConstructorModel) declarationOrparameterList.parameterList;

        switch (arguments)
        case (is PositionalArguments) {
            return
            generateArgumentListFromArgumentList {
                arguments.argumentList;
                callableType;
                pList;
            };
        }
        case (is NamedArguments) {
            value [argsSetup, argGenerators]
                =   generateFromNamedArguments {
                        scope;
                        arguments;
                        callableType;
                        pList;
                    };

            value argumentTypes
                =   CeylonList(ctx.unit.getCallableArgumentTypes(callableType.fullType));

            value parameterDeclarations
                =   CeylonList(pList.parameters).collect(ParameterModel.model);

            value argumentList
                =   DartArgumentList {
                        [for (i -> argument in argGenerators.indexed)
                            withLhs {
                                argumentTypes[i];
                                parameterDeclarations[i];
                                argument;
                            }
                        ];
                    };

            return [argsSetup, argumentList];
        }
    }

    shared
    [[DartStatement*], [DartExpression()*]] generateFromNamedArguments(
            DScope scope,
            NamedArguments namedArguments,
            TypeModel callableType,
            ParameterListModel parameterList) {

        variable String? tmpVariableMemo = null;

        // Lazily create the tmpVariable to avoid wasting ids!
        value tmpVariable
            =>  tmpVariableMemo else
                (tmpVariableMemo = dartTypes.createTempNameCustom("arg"));

        value argumentTypes
            =   CeylonList {
                    ctx.unit.getCallableArgumentTypes(callableType.fullType);
                };

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
                    for (i->[p,a] in zipPairs(parameters, argumentTypes).indexed)
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
                    () => withBoxing {
                        scope;
                        type;
                        declaration;
                        //dartIdentifier;
                        if (definedParameters.contains(parameter)) then
                            dartIdentifier
                        else if (parameter.sequenced) then
                            // Per spec 4.3.6: A variadic parameter may not have a
                            // default argument.
                            dartTypes.dartIdentifierForFunctionOrValue {
                                scope;
                                ceylonTypes.emptyValueDeclaration;
                                false;
                            }[0]
                        else if (parameter.defaulted) then
                            dartTypes.dartDefault(scope)
                        else
                            ((){
                                "If not defaulted and not variadic, it must be an
                                 Iterable."
                                assert (ceylonTypes.isCeylonIterable(type));
                                return
                                dartTypes.dartIdentifierForFunctionOrValue {
                                    scope;
                                    ceylonTypes.emptyValueDeclaration;
                                    false;
                                }[0];
                            })();
                    }));

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
        value [targetIdentifier, targetIsFunction] =
                dartTypes.dartIdentifierForFunctionOrValue(
                    that, targetDeclaration, true);

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
            if (targetIsFunction) then
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
