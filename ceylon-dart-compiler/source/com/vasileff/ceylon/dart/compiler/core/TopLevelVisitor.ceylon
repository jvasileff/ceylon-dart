import ceylon.ast.core {
    FunctionDefinition,
    ValueDefinition,
    FunctionShortcutDefinition,
    AnyFunction,
    InterfaceDefinition,
    FunctionDeclaration,
    ValueDeclaration,
    ClassDefinition,
    ObjectDefinition,
    ValueGetterDefinition,
    TypeAliasDefinition,
    CompilationUnit,
    Visitor,
    Node,
    Specifier,
    LazySpecifier,
    ValueSetterDefinition,
    Declaration,
    Specification,
    Assertion,
    ObjectExpression,
    ClassBody,
    Parameters,
    ExtendedType,
    ObjectArgument,
    DefaultedParameter,
    Parameter,
    ConstructorDefinition,
    Construction,
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    InterfaceModel=Interface,
    ClassModel=Class,
    ConstructorModel=Constructor,
    SetterModel=Setter,
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    ValueModel=Value,
    FunctionOrValueModel=FunctionOrValue
}
import com.vasileff.ceylon.dart.compiler {
    DScope
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartArgumentList,
    DartClassDeclaration,
    DartSimpleIdentifier,
    DartMethodInvocation,
    DartSimpleFormalParameter,
    DartTopLevelVariableDeclaration,
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartImplementsClause,
    DartFunctionExpression,
    DartExpressionFunctionBody,
    DartCompilationUnitMember,
    DartFormalParameterList,
    DartFunctionDeclaration,
    DartVariableDeclarationList,
    DartVariableDeclaration,
    DartFieldDeclaration,
    DartConstructorDeclaration,
    DartBlockFunctionBody,
    DartBlock,
    DartMethodDeclaration,
    DartExtendsClause,
    DartSuperConstructorInvocation,
    DartExpressionStatement,
    DartPrefixedIdentifier,
    DartDefaultFormalParameter,
    DartRedirectingConstructorInvocation,
    DartIntegerLiteral,
    DartIndexExpression,
    DartListLiteral,
    createExpressionEvaluationWithSetup
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    AnyInterfaceInfo,
    ValueDefinitionInfo,
    AnyFunctionInfo,
    AnyClassInfo,
    ValueGetterDefinitionInfo,
    ObjectDefinitionInfo,
    ObjectExpressionInfo,
    NodeInfo,
    ObjectArgumentInfo,
    ParameterInfo,
    ConstructorInfo,
    ExtensionOrConstructionInfo
}

"For Dart TopLevel declarations."
shared
class TopLevelVisitor(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies Visitor {

    void add(DartCompilationUnitMember member)
        =>  ctx.compilationUnitMembers.add(member);

    void addAll({DartCompilationUnitMember*} members)
        =>  ctx.compilationUnitMembers.addAll(members);

    shared actual
    void visitValueDeclaration(ValueDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        super.visitValueDeclaration(that);
    }

    shared actual
    void visitValueDefinition(ValueDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        switch(specifier = that.definition)
        case (is LazySpecifier) {
            addAll {
                generateForValueDefinitionGetter(that),
                *generateForwardingGetterSetter(that)
            };
        }
        case (is Specifier) {
            addAll {
                DartTopLevelVariableDeclaration {
                    generateForValueDefinition(that);
                },
                *generateForwardingGetterSetter(that)
            };
        }
    }

    shared actual
    void visitValueGetterDefinition(ValueGetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        addAll {
            generateForValueDefinitionGetter(that),
            *generateForwardingGetterSetter(that)
        };
    }

    shared actual
    void visitValueSetterDefinition(ValueSetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        // Forwarding setter was added by visitValue*()
        add(generateForValueSetterDefinition(that));
    }

    shared actual
    void visitFunctionDeclaration(FunctionDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        super.visitFunctionDeclaration(that);
    }

    shared actual
    void visitClassDefinition(ClassDefinition that) {
        value info = AnyClassInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        // skip erased types
        if (info.declarationModel in [
                ceylonTypes.anythingDeclaration,
                ceylonTypes.objectDeclaration,
                ceylonTypes.basicDeclaration,
                ceylonTypes.nullDeclaration]) {
            return;
        }

        add {
            generateClassDefinition {
                info;
                info.declarationModel;
                that.body;
                that.extendedType;
                that.parameters;
            };
        };
    }

    shared actual
    void visitFunctionDefinition(FunctionDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        addAll {
            generateFunctionDefinition(that),
            generateForwardingFunction(that)
        };
    }

    shared actual
    void visitFunctionShortcutDefinition
            (FunctionShortcutDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        addAll {
            generateFunctionDefinition(that),
            generateForwardingFunction(that)
        };
    }

    shared actual
    void visitInterfaceDefinition(InterfaceDefinition that) {
        value info = AnyInterfaceInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        // skip erased types
        if (info.declarationModel == ceylonTypes.identifiableDeclaration) {
            return;
        }

        value identifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(
                        info.declarationModel);

        value implementsTypes
            =   sequence(CeylonList(info.declarationModel.satisfiedTypes)
                        .filter(dartTypes.denotable)
                        .map((satisfiedType)
                =>  dartTypes.dartTypeName(info, satisfiedType, false)));


        "The containing class or interface, if one exists."
        value outerDeclaration
            =   getContainingClassOrInterface(info.scope.container);

        "An $outer getter declaration, if there is an outer class or interface."
        value outerField
            =   if (exists outerDeclaration) then
                    DartMethodDeclaration {
                        false;
                        null;
                        dartTypes.dartTypeName {
                            info;
                            outerDeclaration.type;
                            false; false;
                        };
                        "get";
                        false;
                        dartTypes.identifierForOuter(outerDeclaration);
                        null;
                        null;
                    }
                else
                    null;

        value members
            =   { outerField,
                  *expand(that.body.transformChildren(classMemberTransformer))
                }.coalesced;

        value declarationsForCaptures
            =   ctx.captures.get(info.declarationModel).map {
                    (capture) => DartFieldDeclaration {
                        false;
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartCaptureTypeNameForDeclaration {
                                info;
                                capture;
                            };
                            [DartVariableDeclaration {
                                dartTypes.identifierForCapture(capture);
                                null;
                            }];
                        };
                    };
                };

        add {
            DartClassDeclaration {
                abstract = true;
                name = identifier;
                extendsClause = null;
                implementsClause =
                    if (exists implementsTypes)
                    then DartImplementsClause(implementsTypes)
                    else null;
                concatenate {
                    members,
                    declarationsForCaptures
                };
            };
        };
    }

    shared actual
    void visitObjectExpression(ObjectExpression that) {
        value info = ObjectExpressionInfo(that);

        add {
            generateClassDefinition {
                info;
                info.anonymousClass;
                that.body;
                that.extendedType;
            };
        };
    }

    shared actual
    void visitObjectArgument(ObjectArgument that) {
        value info = ObjectArgumentInfo(that);

        add {
            generateClassDefinition {
                info;
                info.anonymousClass;
                that.body;
                that.extendedType;
            };
        };
    }

    shared actual
    void visitObjectDefinition(ObjectDefinition that) {
        value info = ObjectDefinitionInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        // skip erased types
        if (info.declarationModel == ceylonTypes.nullValueDeclaration) {
            return;
        }

        add {
            generateClassDefinition {
                info;
                info.anonymousClass;
                that.body;
                that.extendedType;
            };
        };

        if (isToplevel(info.declarationModel)) {
            // define toplevel value and forwarding function
            addAll {
                DartTopLevelVariableDeclaration {
                    generateForObjectDefinition(that);
                },
                *generateForwardingGetterSetter(that)
            };
        }
    }

    DartClassDeclaration generateClassDefinition(
            DScope scope, ClassModel classModel, ClassBody classBody,
            ExtendedType? extendedType, Parameters? parameters = null) {

        value identifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(classModel);

        value satisifesTypes
            =   sequence(CeylonList(classModel.satisfiedTypes)
                        .filter(dartTypes.denotable)
                        .map((satisfiedType)
                =>  dartTypes.dartTypeName(scope, satisfiedType, false)));

        value extendsClause
            =   if (exists et = classModel.extendedType,
                    !ceylonTypes.isCeylonBasic(classModel.extendedType)
                    && !ceylonTypes.isCeylonObject(classModel.extendedType))
                then  DartExtendsClause {
                    dartTypes.dartTypeName {
                        scope;
                        classModel.extendedType;
                        false;
                    };
                }
                else null;

        "Fields to capture initializer parameters. See also
         [[ClassMemberTransformer.transformValueDefinition]]."
        value fieldsForInitializerParameters
            =   (parameters?.parameters else []).collect {
                    (parameter) =>
                    let (model = ParameterInfo(parameter).parameterModel)
                    DartFieldDeclaration {
                        false;
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartTypeNameForDeclaration {
                                    scope;
                                    model.model;
                                };
                                [DartVariableDeclaration {
                                    DartSimpleIdentifier {
                                        dartTypes.getName(model);
                                    };
                                    initializer = null;
                                }];
                            };
                        };
                    };

        "Declarations for outer containers. We'll hold a reference to our immediate
         container, and access the rest through that."
        value outerDeclarations
            =   [*dartTypes.outerDeclarationsForClass(classModel)];

        "$outer field declaration, if any."
        value outerField
            =   outerDeclarations.take(1).map {
                    (outerDeclaration) =>
                    DartFieldDeclaration {
                        false;
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeName {
                                scope;
                                outerDeclaration.type;
                                false; false;
                            };
                            [DartVariableDeclaration {
                                dartTypes.identifierForOuter {
                                    outerDeclaration;
                                };
                                null;
                            }];
                        };
                    };
                };

        "$outer getters for $outers that may be required by satisfied interfaces.
         Access through *our* outer."
        value outerForwarders
            =   outerDeclarations.skip(1).map {
                    (outerDeclaration) =>
                    DartMethodDeclaration {
                        false;
                        null;
                        dartTypes.dartTypeName {
                            scope;
                            outerDeclaration.type;
                            false; false;
                        };
                        "get";
                        false;
                        dartTypes.identifierForOuter {
                            outerDeclaration;
                        };
                        null;
                        DartExpressionFunctionBody {
                            false;
                            assertExists {
                                dartTypes.expressionToThisOrOuterStripThis {
                                    dartTypes.ancestorChainToOuterInheritingDeclaration {
                                        classModel;
                                        outerDeclaration;
                                    };
                                };
                            };
                        };
                    };
                };

        "declarations for captures we must hold references to."
        value captureDeclarations
            =   [*dartTypes.captureDeclarationsForClass(classModel)];

        "$capture field declarations, if any."
        value captureFields
            =   captureDeclarations.map {
                    (capture) => DartFieldDeclaration {
                        false;
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartCaptureTypeNameForDeclaration {
                                scope;
                                capture;
                            };
                            [DartVariableDeclaration {
                                dartTypes.identifierForCapture(capture);
                                null;
                            }];
                        };
                    };
                };

        value constructors
            =   if (!classModel.hasConstructors())
                then generateDartConstructors {
                    scope;
                    classModel;
                    classBody;
                    extendedType;
                    parameters?.parameters else [];
                }
                else classBody.content.narrow<ConstructorDefinition>().flatMap {
                    (constructor) => generateDartConstructors {
                        scope;
                        classModel;
                        classBody;
                        constructor.extendedType;
                        constructor.parameters.parameters;
                        constructor;
                    };
                }.sequence();

        "Class members. Statements (aside from Specification and Assertion statements) do
         not introduce members and are therefore not supported by
         [[ClassMemberTransformer]]."
        value members
            =   classBody.children
                    .narrow<Declaration|Specification|Assertion>()
                    .flatMap((d)
                        =>  d.transform(classMemberTransformer));

        "Functions and values for which the most refined member is contained by
         an Interface."
        value declarationsToBridge
            // Shouldn't there be a better way?
            =   supertypeDeclarations(classModel)
                    .flatMap((d) => CeylonList(d.members))
                    .narrow<FunctionOrValueModel>()
                    .filter(FunctionOrValueModel.shared)
                    .map(curry(mostRefined)(classModel))
                    .distinct
                    .map((m) => assertExists(m,
                        "Surely a most-refined implementation exists."))
                    .filter((m) => container(m) is InterfaceModel)
                    .filter((m) => container(m) != ceylonTypes.identifiableDeclaration)
                    .map((m) => asserted<FunctionOrValueModel>(m,
                        "Most refined function or value should be a function or value."))
                    .filter(not(FunctionOrValueModel.formal))
                    .sequence();

        value bridgeFunctions
            =   declarationsToBridge.map((f)
                =>  generateBridgeMethodOrField(scope, f));

        return
        DartClassDeclaration {
            classModel.abstract;
            identifier;
            extendsClause;
            implementsClause =
                if (exists satisifesTypes)
                then DartImplementsClause(satisifesTypes)
                else null;
            concatenate {
                outerField,
                outerForwarders,
                captureFields,
                constructors,
                fieldsForInitializerParameters,
                members,
                bridgeFunctions
            };
        };
    }

    [DartConstructorDeclaration*] generateDartConstructors(
            DScope scope, ClassModel classModel, ClassBody classBody,
            ExtendedType? extendedType, [Parameter*] parameters,
            ConstructorDefinition? constructor = null) {

        value classIdentifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(classModel);

        value constructorInfo
            =   if (exists constructor)
                then ConstructorInfo(constructor)
                else null;

        value constructorModel
            =   constructorInfo?.constructorModel;

        "Initializer parameters."
        value standardParameters
            =   if (!parameters.empty)
                then generateFormalParameterList(
                        true, false, scope, parameters).parameters
                else [];

        value hasDefaultedParameter
            =   standardParameters.any((p) => p is DartDefaultFormalParameter);

        "Non-defaulted class initializer parameters."
        value standardParametersNonDefaulted
            =   hasDefaultedParameter then (
                if (!parameters.empty)
                then generateFormalParameterList(
                        true, false, scope, parameters, true).parameters
                else []);


        "Explicit super call with arguments."
        value superInvocation
            =   generateSuperInvocation(extendedType);

        "Dart identifiers for each parameter."
        value parameterIdentifiers
            =   parameters.collect {
                    (p) => DartSimpleIdentifier {
                        dartTypes.getName {
                            ParameterInfo(p).parameterModel;
                        };
                    };
                };

        "Declarations for outer containers. We'll hold a reference to our immediate
         container, and access the rest through that."
        value outerDeclarations
            =   [*dartTypes.outerDeclarationsForClass(classModel)];

        "An $outer parameter, if there is an outer class or interface"
        value outerFieldConstructorParameter
            =   outerDeclarations.take(1).map {
                    (declaration) =>
                    DartSimpleFormalParameter {
                        false; false;
                        dartTypes.dartTypeName {
                            scope;
                            declaration.type;
                            false; false;
                        };
                        dartTypes.identifierForOuter {
                            declaration;
                        };
                    };
                };

        "declarations for captures we must hold references to."
        value captureDeclarations
            =   [*dartTypes.captureDeclarationsForClass(classModel)];

        value captureConstructorParameters
            =   captureDeclarations.map {
                    (declaration) =>
                    DartSimpleFormalParameter {
                        false; false;
                        dartTypes.dartCaptureTypeNameForDeclaration {
                            scope;
                            declaration;
                        };
                        dartTypes.identifierForCapture {
                            declaration;
                        };
                    };
                };

        value constructorPrefix
            =   if (exists constructorModel)
                then dartTypes.getName(constructorModel)
                else "";

        value constructorName
            // default constructors will have name of ""
            =   !constructorPrefix.empty
                then DartSimpleIdentifier(constructorPrefix);

        value argsIdentifier
            =   DartSimpleIdentifier("a");

        value spreadConstructorName
            =   DartSimpleIdentifier(constructorPrefix + "$s");

        value workerConstructorName
            =   if (hasDefaultedParameter)
                then DartSimpleIdentifier(constructorPrefix + "$w")
                else constructorName;

        "Resolves arguments against default value expressions, redirects to 'spread'
         constructor."
        value defaultsConstructor
            =   hasDefaultedParameter then (
                withInConstructorDefaults {
                    classModel;
                    () => DartConstructorDeclaration {
                        const = false;
                        factory = false;
                        returnType = classIdentifier;
                        // Defaults constructors are always public facing
                        constructorName;
                        DartFormalParameterList {
                            true; false;
                            concatenate {
                                outerFieldConstructorParameter,
                                captureConstructorParameters,
                                standardParameters
                            };
                        };
                        [DartRedirectingConstructorInvocation {
                            spreadConstructorName;
                            DartArgumentList {
                                [createExpressionEvaluationWithSetup {
                                    generateDefaultValueAssignments {
                                        scope;
                                        parameters.narrow<DefaultedParameter>();
                                    };
                                    DartListLiteral {
                                        false;
                                        concatenate {
                                            outerFieldConstructorParameter.map {
                                                DartSimpleFormalParameter.identifier;
                                            },
                                            captureConstructorParameters.map {
                                                DartSimpleFormalParameter.identifier;
                                            },
                                            parameterIdentifiers
                                        };
                                    };
                                }];
                            };
                        }];
                        null;
                        null;
                    };
                });

        "'Spread' constructor. Simply takes a dart Object[], and delegates to
         the 'worker' constructor"
        value spreadConstructor
            =   hasDefaultedParameter then (
                DartConstructorDeclaration {
                    const = false;
                    factory = false;
                    returnType = classIdentifier;
                    spreadConstructorName;
                    DartFormalParameterList {
                        true; false;
                        [DartSimpleFormalParameter {
                            false; false;
                            dartTypes.dartList;
                            argsIdentifier;
                        }];
                    };
                    [DartRedirectingConstructorInvocation {
                        workerConstructorName;
                        DartArgumentList {
                            [ for (i in 0:(outerFieldConstructorParameter.size +
                                            captureConstructorParameters.size +
                                            standardParameters.size))
                                DartIndexExpression {
                                    argsIdentifier;
                                    DartIntegerLiteral(i);
                                }
                            ];
                        };
                    }];
                    null;
                    null;
                });

        value outerAndCaptureMemberInitializers
            =   outerFieldConstructorParameter
                    .chain(captureConstructorParameters)
                    .map { DartSimpleFormalParameter.identifier; }
                    .map {
                        (id) => DartExpressionStatement {
                            DartAssignmentExpression {
                                DartPrefixedIdentifier {
                                    DartSimpleIdentifier("this");
                                    id;
                                };
                                DartAssignmentOperator.equal;
                                id;
                            };
                        };
                    };

        value constructorBody
            =   if (exists constructor) then
                    DartBlock {
                        concatenate {
                            outerAndCaptureMemberInitializers,
                            classBody.children.takeWhile(not(constructor.equals))
                                .flatMap((s) => s.transform(classStatementTransformer)),
                            constructor.block.children
                                .flatMap((s) => s.transform(statementTransformer)),
                            classBody.children.skipWhile(not(constructor.equals))
                                .flatMap((s) => s.transform(classStatementTransformer))
                        };
                    }
                else
                    DartBlock {
                        concatenate {
                            outerAndCaptureMemberInitializers,
                            // Assign parameters to corresponding 'this.' members.
                            // Eventually, we'll just do this for the ones we want to
                            // capture. Not supporting defaulted parameters yet.
                            parameterIdentifiers.map {
                                // This might get ugly with replacements like
                                // string/toString().
                                (id) => DartExpressionStatement {
                                    DartAssignmentExpression {
                                        DartPrefixedIdentifier {
                                            DartSimpleIdentifier("this");
                                            id;
                                        };
                                        DartAssignmentOperator.equal;
                                        id;
                                    };
                                };
                            },
                            *withInConstructor {
                                classModel;
                                () => classBody.transformChildren {
                                    classStatementTransformer;
                                };
                            }
                        };
                    };

        "Constructor that does all the work. This constructor will have a private name if
         there are defaulted parameters."
        value workerConstructor
            =   DartConstructorDeclaration {
                    const = false;
                    factory = false;
                    returnType = classIdentifier;
                    workerConstructorName;
                    DartFormalParameterList {
                        true; false;
                        concatenate {
                            outerFieldConstructorParameter,
                            captureConstructorParameters,
                            // this constructor never handles defaulted parameters
                            standardParametersNonDefaulted else standardParameters
                        };
                    };
                    if (exists superInvocation)
                        then [superInvocation]
                        else [];
                    null;
                    DartBlockFunctionBody {
                        null; false;
                        constructorBody;
                    };
                };

        return
        [defaultsConstructor, spreadConstructor, workerConstructor].coalesced.sequence();
    }

    "Explicit super call with arguments."
    DartSuperConstructorInvocation? generateSuperInvocation(ExtendedType? extendedType) {
        if (exists extendedType) {
            value extensionOrConstruction = extendedType.target;

            if (is Construction extensionOrConstruction) {
                addError(extendedType, "Extending constructors not yet supported.");
                return null;
            }

            "Arguments must exist for constructor or ininitializer extends"
            assert (exists arguments = extensionOrConstruction.arguments);

            value extensionOrConstructionInfo
                =   ExtensionOrConstructionInfo(extensionOrConstruction);

            value outerAndCaptureArguments
                =   switch (extendedClass = extensionOrConstructionInfo.declaration)
                    case (is ClassModel)
                        generateArgumentsForOuterAndCaptures {
                            NodeInfo(extendedType);
                            extendedClass;
                        }
                    case (is ConstructorModel | Null) []; // TODO

            if (!arguments.argumentList.children.empty) {

                assert (exists parameterList
                    =   extensionOrConstructionInfo.declaration?.firstParameterList);

                assert (exists callableType
                    =   extensionOrConstructionInfo.typeModel);

                value signature
                    =   CeylonList {
                            ctx.unit.getCallableArgumentTypes(callableType.fullType);
                        };

                return
                DartSuperConstructorInvocation {
                    null;
                    DartArgumentList {
                        concatenate {
                            outerAndCaptureArguments,
                            generateArgumentListFromArguments {
                                extensionOrConstructionInfo;
                                arguments;
                                signature;
                                parameterList;
                            }[1].arguments
                        };
                    };
                };
            }
        }
        return null;
    }

    shared actual
    void visitTypeAliasDefinition(TypeAliasDefinition that) {}

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition | ValueGetterDefinition | ObjectDefinition that) {

        value info = NodeInfo(that);

        value declarationModel =
            switch (that)
            case (is ValueDefinition)
                ValueDefinitionInfo(that).declarationModel
            case (is ValueGetterDefinition)
                ValueGetterDefinitionInfo(that).declarationModel
            case (is ObjectDefinition)
                ObjectDefinitionInfo(that).declarationModel;

        value getter =
        DartFunctionDeclaration {
            external = false;
            returnType = dartTypes.dartTypeNameForDeclaration(
                info, declarationModel);
            propertyKeyword = "get";
            DartSimpleIdentifier {
                dartTypes.getName(declarationModel);
            };
            DartFunctionExpression {
                null;
                DartExpressionFunctionBody {
                    async = false;
                    DartSimpleIdentifier {
                        dartTypes.getPackagePrefixedName(declarationModel);
                    };
                };
            };
        };

        value setter = declarationModel.variable then
            DartFunctionDeclaration {
                external = false;
                returnType = null;
                propertyKeyword = "set";
                DartSimpleIdentifier {
                    dartTypes.getName(declarationModel);
                };
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            final = false;
                            var = false;
                            type = dartTypes.dartTypeNameForDeclaration(
                                info, declarationModel);
                            identifier = DartSimpleIdentifier("value");
                        }];
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        DartAssignmentExpression {
                            DartSimpleIdentifier {
                                dartTypes.getPackagePrefixedName(declarationModel);
                            };
                            DartAssignmentOperator.equal;
                            DartSimpleIdentifier("value");
                        };
                    };
                };
            };

        addAll {
            if (exists setter)
            then [getter, setter]
            else [getter];
        };

        return [];
    }

    "Transforms the declarations of the [[CompilationUnit]]. **Note:**
     imports are ignored."
    shared actual
    void visitCompilationUnit(CompilationUnit that)
        =>  that.declarations.each((d) => d.visit(this));

    shared actual default
    void visitNode(Node that) {
        if (that is DynamicBlock | DynamicInterfaceDefinition
                | DynamicModifier | DynamicValue) {
            addError(that, "dynamic is not supported on the Dart VM");
        }
        addError(that,
            "Node type not yet supported (TopLevelVisitor): ``className(that)``");
    }

    DartFunctionDeclaration generateForwardingFunction(AnyFunction that)
        =>  let (info = AnyFunctionInfo(that),
                functionName = dartTypes.getName(info.declarationModel),
                functionPPName = dartTypes.getPackagePrefixedName(info.declarationModel),
                parameterModels = CeylonList(
                        info.declarationModel.firstParameterList.parameters))
            DartFunctionDeclaration {
                external = false;
                generateFunctionReturnType(info, info.declarationModel);
                propertyKeyword = null;
                DartSimpleIdentifier(functionName);
                DartFunctionExpression {
                    generateFormalParameterList {
                        true; false;
                        info;
                        that.parameterLists.first;
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        expression = DartMethodInvocation {
                            target = null;
                            DartSimpleIdentifier(functionPPName);
                            DartArgumentList {
                                parameterModels.collect { (parameterModel) =>
                                    DartSimpleIdentifier {
                                        dartTypes.getName(parameterModel);
                                    };
                                };
                            };
                        };
                    };
                };
            };

    DartMethodDeclaration generateBridgeMethodOrField
            (DScope scope, FunctionOrValueModel declaration) {

        assert (is FunctionModel|ValueModel|SetterModel declaration);

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    scope;
                    declaration;
                }.oldPairSimple;

        value parameterModels
            =   switch (declaration)
                case (is FunctionModel)
                    CeylonList(declaration.firstParameterList.parameters)
                case (is SetterModel)
                    [declaration.parameter]
                case (is ValueModel)
                    [];

        value interfaceModel
            =   (declaration of TypedDeclarationModel).container;

        "The container of the target of a bridge method is surely an Interface."
        assert (is InterfaceModel interfaceModel);

        return
        DartMethodDeclaration {
            false; null;
            generateFunctionReturnType(scope, declaration);
            dartElementType == dartValue then (
                if (declaration is SetterModel)
                then "set"
                else "get"
            );
            dartElementType is DartOperator;
            identifier;
            dartElementType != dartValue then generateFormalParameterList {
                !dartElementType is DartOperator; false;
                scope;
                parameterModels;
            };
            DartExpressionFunctionBody {
                false;
                DartMethodInvocation {
                    dartTypes.dartIdentifierForClassOrInterface {
                        scope;
                        interfaceModel;
                    };
                    dartTypes.getStaticInterfaceMethodIdentifier {
                        declaration;
                    };
                    DartArgumentList {
                        [DartSimpleIdentifier("this"),
                         *parameterModels.collect { (parameterModel) =>
                            DartSimpleIdentifier {
                                dartTypes.getName(parameterModel);
                            };
                        }];
                    };
                };
            };
        };
    }
}
