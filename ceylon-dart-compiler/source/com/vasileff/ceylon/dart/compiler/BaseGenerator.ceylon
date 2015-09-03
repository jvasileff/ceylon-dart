import ceylon.ast.core {
    Node,
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
    Conditions,
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
    ObjectDefinition
}
import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    PackageModel=Package,
    FunctionModel=Function,
    TypeModel=Type,
    FunctionOrValueModel=FunctionOrValue,
    ValueModel=Value,
    ClassModel=Class,
    ClassOrInterfaceModel=ClassOrInterface,
    ParameterModel=Parameter,
    DeclarationModel=Declaration,
    ScopeModel=Scope,
    SetterModel=Setter,
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
    DartStatement
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
    ObjectDefinitionInfo
}
import com.vasileff.jl4c.guava.collect {
    ImmutableMap
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

    shared
    DartFunctionDeclaration generateFunctionDefinition
            (FunctionShortcutDefinition | FunctionDefinition that) {

        value info = AnyFunctionInfo(that);
        value functionModel = info.declarationModel;
        value functionIdentifier = dartTypes.dartIdentifierForFunctionOrValueDeclaration(
                    that, functionModel, false)[0];

        return
        DartFunctionDeclaration {
            external = false;
            returnType = generateFunctionReturnType(that, functionModel);
            propertyKeyword = null;
            name = functionIdentifier;
            functionExpression = generateFunctionExpression(that);
        };
    }

    "For the Value, or the return type of the Function"
    shared
    DartTypeName generateFunctionReturnType
            (Node scope, FunctionOrValueModel declaration) {

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
            Node scope,
            TypeModel resultType,
            FunctionOrValueModel memberDeclaration,
            [TypeModel, [Expression*]|Arguments]? callableTypeAndArguments = null) {

        "Only toplevels are supported; declaration's container must be a package."
        assert (memberDeclaration.container is PackageModel);

        // TODO use this in transformInvocation, transformBaseExpression, etc.
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
        case (is NamedArguments) {
            throw CompilerBug(scope, "NamedArguments not supported");
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
            Node scope,
            TypeModel resultType,
            TypeModel receiverType,
            DartExpression() generateReceiver,
            FunctionOrValueModel memberDeclaration,
            [TypeModel, [Expression*]|Arguments]? callableTypeAndArguments = null,
            Boolean safeMemberOperator = false) {

        value [callableType, a] = callableTypeAndArguments else [null, []];

        [Expression*] arguments;
        switch (a)
        case (is [Expression*]) {
            arguments = a;
        }
        case (is PositionalArguments) {
            arguments = a.argumentList.listedArguments;
        }
        case (is NamedArguments) {
            throw CompilerBug(scope, "NamedArguments not supported");
        }

        // TODO WIP native optimizations
        if (exists optimization = nativeBinaryFunctions(memberDeclaration)) {
            assert (exists rightOperandExpression = arguments[0]);

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
                        () => rightOperandExpression.transform(expressionTransformer);
                    };
                };
            };
        }

        value [memberIdentifier, isFunction] =
                dartTypes.dartIdentifierForFunctionOrValueDeclaration(
                        scope, memberDeclaration, false);

        value resultDeclaration =
                if (is FunctionModel memberDeclaration,
                        memberDeclaration.parameterLists.size() > 1)
                // The function actually returns a Callable, not the
                // ultimate return type advertised by the declaration.
                then null
                else memberDeclaration;

        // Determine usable receiver type. `withLhsDenotable` would be simpler, but we
        // may need the type below.
        assert (is ClassOrInterfaceModel container = memberDeclaration.container);
        value receiverDenotableType = ceylonTypes.denotableType {
            receiverType;
            container;
        };

        value receiverDartType = dartTypes.dartTypeName {
            scope;
            receiverDenotableType;
            eraseToNative = false;
        };

        value boxedReceiver = withLhsCustom {
            receiverDenotableType;
            false; false;
            generateReceiver;
        };

        DartExpression invocation;
        if (arguments nonempty) {
            "If there are arguments, the member is surely a FunctionModel and must
             translate to a Dart function"
            assert (is FunctionModel memberDeclaration, isFunction);

            "If we have arguments, we'll have a callableType."
            assert (exists callableType);

            value argumentList {
                value argumentTypes = CeylonList(ctx.unit
                        .getCallableArgumentTypes(callableType.fullType));

                value parameterDeclarations = CeylonList(
                        memberDeclaration.firstParameterList.parameters)
                        .collect(ParameterModel.model);

                return
                DartArgumentList {
                    [for (i -> argument in arguments.indexed)
                        withLhs {
                            argumentTypes[i];
                            parameterDeclarations[i];
                            () => argument.transform(expressionTransformer);
                        }
                    ];
                };
            }

            if (safeMemberOperator) {
                invocation = createNullSafeExpression {
                    parameterIdentifier = DartSimpleIdentifier("$r$");
                    parameterType = receiverDartType;
                    maybeNullExpression = boxedReceiver;
                    ifNullExpression = DartNullLiteral();
                    ifNotNullExpression = DartFunctionExpressionInvocation {
                        DartPropertyAccess {
                            DartSimpleIdentifier("$r$");
                            memberIdentifier;
                        };
                        argumentList;
                    };
                };
            }
            else {
                invocation =
                DartMethodInvocation {
                    boxedReceiver;
                    memberIdentifier;
                    argumentList;
                };
            }
        }
        else {
            function valueAccess(DartExpression receiver)
                =>  if (!isFunction)
                    then DartPropertyAccess(receiver, memberIdentifier)
                    else DartMethodInvocation {
                        receiver;
                        memberIdentifier;
                        DartArgumentList();
                    };

            if (safeMemberOperator) {
                invocation = createNullSafeExpression {
                    parameterIdentifier = DartSimpleIdentifier("$r$");
                    parameterType = receiverDartType;
                    maybeNullExpression = boxedReceiver;
                    ifNullExpression = DartNullLiteral();
                    ifNotNullExpression = valueAccess {
                        DartSimpleIdentifier("$r$");
                    };
                };
            }
            else {
                invocation = valueAccess(boxedReceiver);
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
            Node scope,
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
            Node scope,
            Expression receiver,
            String memberName,
            [Expression*] arguments) {

        return
        generateInvocationDetailsSynthetic {
            scope;
            ExpressionInfo(receiver).typeModel;
            () => receiver.transform(expressionTransformer);
            memberName;
            arguments;
        };
    }

    """The same as [[generateInvocationFromName]], but with parameters that are more
       fundamental (i.e. `TypeModel` and `DartExpression()` rather than `ExpressionInfo`).
    """
    shared
    [TypeModel, FunctionOrValueModel?, DartExpression()]
    generateInvocationDetailsSynthetic(
            Node scope,
            TypeModel receiverType,
            DartExpression generateReceiver(),
            String memberName,
            [Expression*] arguments) {

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
                    [typedReference.fullType, arguments];
                false;
            }
        ];
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
    [[]|[DartVariableDeclarationStatement], DartVariableDeclarationStatement?,
     DartExpression, []|[DartStatement]]
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

        []|[DartVariableDeclarationStatement] replacementDeclaration;
        DartVariableDeclarationStatement? tempDefinition;
        DartExpression conditionExpression;
        []|[DartStatement] replacementDefinition;

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
            replacementDeclaration =
            [DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    dartTypes.dartTypeNameForDeclaration {
                        that;
                        variableDeclaration;
                    };
                    [DartVariableDeclaration {
                        variableIdentifier;
                    }];
                };
            }];

            // 2. evaluate to tmp variable
            tempDefinition =
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    dartTypes.dartTypeName(that, expressionType, true);
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
                    that, tempIdentifier, isType);

            // 4. set replacement variable
            replacementDefinition =
            [DartExpressionStatement {
                DartAssignmentExpression {
                    variableIdentifier;
                    DartAssignmentOperator.equal;
                    withLhs {
                        null;
                        variableDeclaration;
                        () => withBoxing {
                            that;
                            // as noted above, tmpVariable may be erased. Maybe
                            // when narrowing optionals like String?.
                            expressionType;
                            null;
                            tempIdentifier;
                        };
                    };
                };
            }];
        }
        else {
            tempDefinition = null;
            replacementDeclaration = [];

            // check type of the original variable,
            // possibly declare new variable with a narrowed type
            assert(is FunctionOrValueModel originalDeclaration =
                    variableDeclaration.originalDeclaration);

            value originalIdentifier = DartSimpleIdentifier(
                    dartTypes.getName(originalDeclaration));

            conditionExpression
                =   generateIsExpression(that, originalIdentifier, isType);

            replacementDefinition
                =   if (exists r = generateReplacementVariableDefinition(
                            that, variableDeclaration))
                    then [r]
                    else [];
        }

        return [replacementDeclaration,
                tempDefinition,
                if (that.negated != negate)
                    then DartPrefixExpression("!", conditionExpression)
                    else conditionExpression,
                replacementDefinition];
    }

    "Generate a replacement variable declaration for a narrowing operation *iff* the
     dart type changed. If a non-null value is returned, a replacement name will have
     been generated by [[DartTypes.createReplacementName]]."
    shared
    DartVariableDeclarationStatement? generateReplacementVariableDefinition(
            Node scope, ValueModel variableDeclaration) {

        assert(is ValueModel originalDeclaration =
                variableDeclaration.originalDeclaration);

        // erasure to native may have changed
        // erasure to object may have changed
        // type may have narrowed
        value dartTypeChanged =
            dartTypes.dartTypeModelForDeclaration(originalDeclaration) !=
            dartTypes.dartTypeModelForDeclaration(variableDeclaration);

        return dartTypeChanged then
        DartVariableDeclarationStatement {
            DartVariableDeclarationList {
                keyword = null;
                dartTypes.dartTypeNameForDeclaration {
                    scope;
                    variableDeclaration;
                };
                [DartVariableDeclaration {
                    DartSimpleIdentifier {
                        dartTypes.createReplacementName {
                            variableDeclaration;
                        };
                    };
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
                }];
            };
        };
    }

    shared
    ConditionCodeTuple generateConditionExpression(Condition condition) {
        switch (condition)
        case (is BooleanCondition) {
            value conditionExpression=withLhsNative {
                ceylonTypes.booleanType;
                () => condition.condition.transform(expressionTransformer);
            };
            return [[], null, conditionExpression, []];
        }
        case (is IsCondition) {
            return generateIsConditionExpression(condition);
        }
        case (is ExistsOrNonemptyCondition) {
            return generateExistsOrNonemptyConditionExpression(condition);
        }
    }

    shared
    ConditionCodeTuple generateExistsOrNonemptyConditionExpression(
            ExistsOrNonemptyCondition that, Boolean negate = false) {

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
                            dartTypes.dartTypeName(that, expressionType, true);
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
                            that;
                            tempIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            that;
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
                                    that;
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
                                        that;
                                        expressionType;
                                        null;
                                        tempIdentifier;
                                    };
                                };
                            };
                        };

                return [[replacementDeclaration],
                        tempVariableDeclaration,
                        conditionExpression,
                        [replacementDefinition]];
            }
            else {
                throw CompilerBug(that, "destructure not yet supported");
            }
        }
        else {
            value info = ExistsOrNonemptyConditionInfo(that);

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
                            that;
                            originalIdentifier;
                            that.negated != negate;
                        }
                    case (is NonemptyCondition)
                        generateNonemptyExpression {
                            that;
                            originalIdentifier;
                            that.negated != negate;
                        };

            // We could *almost* just delete this for "exists". On dart, intersecting
            // with Object never changes the type since numbers, etc. can be null.
            // But... the type *does* change on `!exists`, since null erases to object!
            value replacementDefinition
                =   if (exists r = generateReplacementVariableDefinition(
                            that, variableDeclaration))
                    then [r]
                    else [];

            return [[],
                    null,
                    conditionExpression,
                    replacementDefinition];
        }
    }

    shared
    DartExpression generateExistsExpression(
            Node scope,
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
            Node scope,
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

    shared
    DartExpression generateIsExpression(
            Node scope,
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
            // This isn't good! But no alternative w/o reified generics
            return DartBooleanLiteral(true);
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
            (ValueDeclaration | ValueDefinition that) {

        value info = AnyValueInfo(that);

        value packagePrefix =
                if (info.declarationModel.container is PackageModel)
                then "$package$"
                else "";

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                that;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + dartTypes.getName(info.declarationModel);
                };
                initializer = null;
            }];
        };
    }

    shared
    DartVariableDeclarationList generateForObjectDefinition(ObjectDefinition that) {
        value info = ObjectDefinitionInfo(that);

        value packagePrefix =
                if (info.declarationModel.container is PackageModel)
                then "$package$"
                else "";

        return
        DartVariableDeclarationList {
            "final"; // TODO const for toplevels
            dartTypes.dartTypeNameForDeclaration {
                that;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + dartTypes.getName(info.declarationModel);
                };
                withLhs {
                    null;
                    info.declarationModel;
                    () => withBoxingNonNative {
                        that;
                        info.anonymousClass.type;
                        DartInstanceCreationExpression {
                            const = false; // TODO const for toplevels
                            dartTypes.dartConstructorName {
                                that;
                                info.anonymousClass;
                            };
                            DartArgumentList {
                                generateArgumentsForOutersAndCaptures {
                                    // scope must be the value's scope, not the scope
                                    // of the object definition!
                                    scope = info.declarationModel;
                                    ObjectDefinitionInfo(that).anonymousClass;
                                };
                            };
                        };
                    };
                };
            }];
        };
    }

    shared
    DartVariableDeclarationList generateForValueDefinition(ValueDefinition that) {
        if (!that.definition is Specifier) {
            throw CompilerBug(that, "LazySpecifier not supported");
        }

        value info = ValueDefinitionInfo(that);

        value packagePrefix =
                if (info.declarationModel.container is PackageModel)
                then "$package$"
                else "";

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                that;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + dartTypes.getName(info.declarationModel);
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
            that;
            declarationModel;
            definition;
        };
    }

    shared
    DartFunctionDeclaration generateDefinitionForValueModelGetter(
            Node scope,
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
                    that;
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
                                that;
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
                | DefaultedCallableParameter that) {

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

        return generateFunctionExpressionRaw {
            that;
            functionModel;
            parameterLists;
            definition;
        };
    }

    shared
    DartFunctionExpression generateFunctionExpressionRaw(
            Node scope,
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

                                        // withLhs() doesn't know about Callable
                                        // parameters.
                                        withLhsNonNative {
                                            parameterModelModel.typedReference.fullType;
                                            () => generateNewCallable {
                                                scope;
                                                parameterModelModel;
                                                generateFunctionExpression(param);
                                                0; false; false;
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
            (Node scope, Parameters|{ParameterModel*} parameters) {

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
            value variadic = parameterModel.sequenced;

            if (variadic) {
                throw CompilerBug(scope, "Variadic parameters not yet supported");
            }
            else {
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
            }
        });
        return DartFormalParameterList {
            positional = true;
            parameters = dartParameters;
        };
    }

    shared
    [DartExpression*] generateArgumentsForOutersAndCaptures
            (Node|ScopeModel scope, ClassModel declaration) {

        // FIXME setters?
        value captureExpressions
            =   dartTypes.captureDeclarationsForClass(declaration)
                    .map((capture)
                        =>  dartTypes.expressionForBaseExpression(scope, capture, false))
                    // Workaround https://github.com/ceylon/ceylon-compiler/issues/2293
                    .map((tuple) => tuple.first);

        value outerExpressions
            =   if (exists container = getContainingClassOrInterface(scope))
                then dartTypes.outerDeclarationsForClass(declaration).map((capture)
                        =>  dartTypes.expressionToOuter(container, capture))
                else []; // No outers if no containing class or interface.

        return concatenate(outerExpressions, captureExpressions);
    }

    shared
    DartInstanceCreationExpression generateNewCallable(
            Node that,
            FunctionModel functionModel,
            DartExpression delegateFunction,
            Integer parameterListNumber = 0,
            "Handle null delegates produces with the null safe member operator"
            Boolean delegateMayBeNull = false,
            Boolean delegateReturnsCallable =
                    parameterListNumber <
                    functionModel.parameterLists.size() - 1) {

        // TODO take the Callable's TypeModel as an argument in order to have
        //      correct (non-erased-to-Object) parameter and return types for
        //      generic functions

        DartExpression outerFunction;

        TypeModel returnType;
        FunctionOrValueModel? returnDeclaration;
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

        // determine if return or arguments need boxing
        value boxingRequired =
                (!delegateReturnsCallable
                    && dartTypes.erasedToNative(functionModel))
                || parameters.any((parameterModel)
                    =>  dartTypes.erasedToNative(parameterModel.model));

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
                            dartTypes.dartObject;
                            DartSimpleIdentifier {
                                dartTypes.getName(parameterModel);
                            };
                        };

                if (parameterModel.defaulted) {
                    return
                    DartDefaultFormalParameter {
                        dartSimpleParameter;
                        dartTypes.dartDefault(that);
                    };
                }
                else {
                    return dartSimpleParameter;
                }
            });

            value innerArguments = parameters.collect((parameterModel) {
                value parameterName = dartTypes.getName(parameterModel);
                value parameterIdentifier = DartSimpleIdentifier(parameterName);

                value unboxed = withLhs {
                    null;
                    // "lhs" is the inner function's parameter
                    lhsDeclaration = parameterModel.model;
                    () => withBoxing {
                        that;
                        // Parameters for Callables are always `core.Object`
                        rhsType = ceylonTypes.anythingType;
                        rhsDeclaration = null;
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
                                 dartTypes.dartDefault(that)];
                            };
                        };
                        // propagate defaulted
                        dartTypes.dartDefault(that);
                        // not default, unbox as necessary
                        unboxed;
                    };
                }
                else {
                    return
                    unboxed;
                }
            });

            // prepare the actual invocation expression, which
            // may need to protect against a null receiver.
            value invocation =
                DartFunctionExpressionInvocation {
                    delegateFunction;
                    DartArgumentList {
                        innerArguments;
                    };
                };

            value wrappedInvocation =
                if (!delegateMayBeNull) then
                    invocation
                else
                    DartConditionalExpression {
                        DartBinaryExpression {
                            delegateFunction;
                            "==";
                            DartNullLiteral();
                        };
                        DartNullLiteral();
                        invocation;
                    };

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
                            withLhsNonNative {
                                returnType;
                                () => withBoxing {
                                    that;
                                    returnType;
                                    returnDeclaration;
                                    wrappedInvocation;
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
            false;
            DartConstructorName {
                dartTypes.dartTypeNameForDartModel {
                    that;
                    dartTypes.dartCallableModel;
                };
                null;
            };
            DartArgumentList {
                [outerFunction];
            };
        };
    }

    "Only handles `BooleanCondition`s!!!"
    shared
    DartExpression generateBooleanDartCondition(Conditions that) {
        // TODO IsCondition & ExistsOrNonemptyCondition
        if (that.conditions.any((condition)
                =>  !condition is BooleanCondition)) {
            throw CompilerBug(that,
                "Only BooleanConditions are currently supported.");
        }

        value dartCondition = withLhsNative {
            ceylonTypes.booleanType;
            () => that.conditions
                    .reversed
                    .narrow<BooleanCondition>()
                    .map(generateBooleanConditionExpression)
                    .reduce((DartExpression partial, c)
                        =>  DartBinaryExpression(c, "&&", partial));
        };

        assert (exists dartCondition);
        return dartCondition;
    }

    shared
    DartArgumentList generateArgumentListFromArguments(
            Arguments that,
            TypeModel callableType,
            "True if the ArgumentList is for a Callable, even though ParameterModels
             are available. This is used for invocations on Callable Parameters"
            Boolean overrideNonCallable = false) {
        switch (that)
        case (is PositionalArguments) {
            return generateArgumentListFromArgumentList(
                    that.argumentList, callableType, overrideNonCallable);
        }
        case (is NamedArguments) {
            throw CompilerBug(that, "NamedArguments not supported");
        }
    }

    shared
    DartArgumentList generateArgumentListFromArgumentList(
            ArgumentList that,
            TypeModel callableType,
            "True if the ArgumentList is for a Callable, even though ParameterModels
             are available. This is used for invocations on Callable Parameters"
            Boolean overrideNonCallable = false) {

        if(!that.sequenceArgument is Null) {
            throw unimplementedError(that, "spread arguments not supported");
        }

        value info = ArgumentListInfo(that);
        value argumentTypes = CeylonList(ctx.unit.getCallableArgumentTypes(callableType));

        // NOTE info.listedArgumentModels[x][0] is the argument type model for argument x.
        //      But, this is actually the type of the expression for the callsite value.
        //      So, for the `lhs` type, we are instead using argument types obtained from
        //      callableType, which is what the function actually requires.

        value args = that.listedArguments.indexed.collect((e) {
            value i -> expression = e;

            assert (is ParameterModel? parameterModel =
                        if (!overrideNonCallable)
                        then info.listedArgumentModels.getFromFirst(i)?.get(1)
                        else null);

            TypeModel? lhsType;
            FunctionOrValueModel? lhsDeclaration;

            if (exists parameterModel) {
                // Invoking a real function (not a callable value)
                // Use the argument type, even though the parameter type should be
                // sufficient until we add support for generics
                assert (exists argumentType = argumentTypes[i]);

                lhsType = argumentType;
                lhsDeclaration = parameterModel.model;
            }
            else {
                // Invoking a generic callable; all parameters take `core.Object`
                lhsType = ceylonTypes.anythingType;
                lhsDeclaration = null;
            }

            return withLhs {
                lhsType;
                lhsDeclaration;
                () => expression.transform(expressionTransformer);
            };
        });
        return DartArgumentList(args);
    }

    shared
    DartExpression
    generateAssignmentExpression(
                Node that,
                ValueModel | BaseExpression | QualifiedExpression target,
                DartExpression() rhsExpression) {

        // TODO test with receivers (not even tried yet...)
        // TODO make sure setters return the new value, or do somthing here
        // TODO consider merging with generateInvocation()

        DeclarationModel targetDeclaration;
        DartExpression? dartTarget;
        Reference typedReference;

        switch (target)
        case (is ValueModel) {
            targetDeclaration = target;
            dartTarget = null;
            typedReference = target.typedReference;
        }
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
            Node scope,
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

    "Tuple containing
        - replacementDeclaration(s)
        - tempDefinition
        - conditionExpression
        - replacementDefinition(s)]"
    shared
    alias ConditionCodeTuple =>
            [[DartVariableDeclarationStatement*],
             DartVariableDeclarationStatement?,
             DartExpression,
             [DartStatement*]];
}
