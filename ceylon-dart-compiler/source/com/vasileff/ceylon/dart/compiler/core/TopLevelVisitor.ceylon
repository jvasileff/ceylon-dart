import ceylon.ast.core {
    FunctionDefinition,
    ValueDefinition,
    FunctionShortcutDefinition,
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
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue,
    DefaultedCallableParameter,
    CallableParameter,
    ClassAliasDefinition,
    InterfaceAliasDefinition,
    PositionalArguments,
    CallableConstructorDefinition,
    ValueConstructorDefinition
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    InterfaceModel=Interface,
    ClassModel=Class,
    ConstructorModel=Constructor,
    DeclarationModel=Declaration,
    SetterModel=Setter,
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
    createExpressionEvaluationWithSetup,
    DartExpression,
    DartIfStatement,
    DartFormalParameter,
    DartConstructorInitializer,
    DartBinaryExpression,
    DartNullLiteral,
    DartFunctionExpressionInvocation
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    ConstructorDefinitionInfo,
    anyFunctionInfo,
    extensionOrConstructionInfo,
    nodeInfo,
    parameterInfo,
    classDefinitionInfo,
    interfaceDefinitionInfo,
    constructorDefinitionInfo,
    valueConstructorDefinitionInfo,
    objectExpressionInfo,
    objectArgumentInfo,
    objectDefinitionInfo,
    valueDefinitionInfo,
    valueGetterDefinitionInfo,
    callableParameterInfo
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
        value info = classDefinitionInfo(that);

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

        // for toplevel classes, generate synthetic toplevel variables and getter
        // functions for value constructors
        if (isToplevel(info.declarationModel)) {
            addAll {
                expand {
                    generateForValueConstructors(that).map { (pair) =>
                        [DartTopLevelVariableDeclaration {
                            pair[0];
                        },
                        pair[1]];
                    };
                };
            };

            value valueConstructors
                =   that.body.children
                    .map((node) => if (is ValueConstructorDefinition node)
                                   then node else null)
                    .coalesced;

            for (vc in valueConstructors) {
                value vcInfo = valueConstructorDefinitionInfo(vc);

                assert (exists constructorModel
                    =   getConstructor(vcInfo.declarationModel));

                value syntheticFunction
                    =   dartTypes.syntheticValueForValueConstructor(constructorModel);

                add {
                    generateForwardingGetter(info, syntheticFunction);
                };
            }
        }
    }

    shared actual
    void visitFunctionDefinition(FunctionDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        value info = anyFunctionInfo(that);

        addAll {
            generateFunctionDefinition(that),
            generateForwardingFunction(info, info.declarationModel)
        };
    }

    shared actual
    void visitFunctionShortcutDefinition
            (FunctionShortcutDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        value info = anyFunctionInfo(that);

        addAll {
            generateFunctionDefinition(that),
            generateForwardingFunction(info, info.declarationModel)
        };
    }

    shared actual
    void visitInterfaceDefinition(InterfaceDefinition that) {
        value info = interfaceDefinitionInfo(that);

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
            =   sequence {
                    CeylonList(info.declarationModel.satisfiedTypes)
                    .map {
                        (satisfiedType) =>
                            if (dartTypes.denotable(satisfiedType)) then
                                dartTypes.dartTypeName(info, satisfiedType, false)
                            else if (ceylonTypes.isCeylonIdentifiable(satisfiedType)) then
                                dartTypes.dartTypeNameForDartModel {
                                    info;
                                    dartTypes.dartCeylonIdentifiableModel;
                                }
                            else null;
                    }.coalesced;
                };

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
        value info = objectExpressionInfo(that);

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
        value info = objectArgumentInfo(that);

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
        value info = objectDefinitionInfo(that);

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

        // TODO satisfiesBasic should be true when extending
        //      Dart native types (when supported).

        value satisfiesBasic
            =   if (exists et = classModel.extendedType)
                then ceylonTypes.isCeylonBasic(et)
                else true;

        value satisfiesObject
            =   if (exists et = classModel.extendedType)
                then ceylonTypes.isCeylonObject(et)
                else false;

        value satisfiesTypes
            =   sequence {
                    CeylonList(classModel.satisfiedTypes)
                    .map {
                        (satisfiedType) =>
                            if (dartTypes.denotable(satisfiedType)) then
                                dartTypes.dartTypeName(scope, satisfiedType, false)
                            else if (ceylonTypes.isCeylonIdentifiable(satisfiedType),
                                    !satisfiesBasic) then
                                dartTypes.dartTypeNameForDartModel {
                                    scope;
                                    dartTypes.dartCeylonIdentifiableModel;
                                }
                            else null;
                    }
                    .follow {
                        satisfiesBasic then
                        dartTypes.dartTypeNameForDartModel {
                            scope;
                            dartTypes.dartCeylonBasicModel;
                        };
                    }
                    .follow {
                        satisfiesObject then
                        dartTypes.dartTypeNameForDartModel {
                            scope;
                            dartTypes.dartCeylonObjectModel;
                        };
                    }
                    .coalesced;
                };

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

        value parameterModelModels
            =   (parameters?.parameters else []).collect {
                    (p) => parameterInfo(p).parameterModel.model;
                };

        "Fields to capture initializer parameters. See also
         [[ClassMemberTransformer.transformValueDefinition]]."
        value fieldsForInitializerParameters
            =   parameterModelModels
                .filter {
                    // Don't generate fields for the Callable for *shared* Callable
                    // Parameters; they will have a synthetic name and are handled below.
                    (model) => !model is FunctionModel || !model.shared;
                }.collect {
                    (model) => generateFieldDeclaration(scope, model);
                };

        "If the Dart element type for the *getter* is not dartValue, we'll need to add
         a forwarding method or operator getter that returns the value of the dart
         property used to store the value."
        value getterMethodBridgesForCeylonValues
            =   {for (model in parameterModelModels) if (is ValueModel model) model}
                .filter(dartTypes.valueMappedToNonField)
                .collect((model) => generateMethodToReferenceForwarder(scope, model));

        "A getter and setter to a sythentic field, if necessary.
         See [[generateBridgesToSyntheticField]]"
        value bridgesToSyntheticFields
            =   {for (model in parameterModelModels)
                   if (is ValueModel model,
                        model.default
                        && !model.transient)
                     model}
                .flatMap((model) => generateBridgesToSyntheticField(scope, model))
                .sequence();


        "All shared callable parameters in the class initializer parameter list."
        value sharedCallableParameterInfos
            =   (parameters?.parameters else [])
                .map {
                    (p) => switch (p)
                    case (is DefaultedCallableParameter) p.parameter
                    case (is CallableParameter) p
                    else null;
                }.coalesced.map {
                    callableParameterInfo;
                }
                .filter {
                    (pInfo) => pInfo.functionModel.shared;
                };

        "Methods that forward to Callable values for shared Ceylon methods that are
         defined by callable parameters in the intializer parameter list."
        value callableParameterForwarders
            =   sharedCallableParameterInfos
                .collect {
                    (pInfo) {
                        value functionExpression
                            =   generateForwardDeclaredForwarder {
                                    pInfo;
                                    pInfo.functionModel;
                                    pInfo.node.parameterLists;
                                };

                        value [identifier, dartElementType]
                            =   dartTypes.dartInvocable {
                                    pInfo;
                                    pInfo.functionModel;
                                }.oldPairSimple;

                        assert (dartElementType is \IdartFunction | DartOperator);

                        return
                        DartMethodDeclaration {
                            false;
                            null;
                            generateFunctionReturnType {
                                pInfo;
                                pInfo.functionModel;
                            };
                            null;
                            dartElementType is DartOperator;
                            identifier;
                            functionExpression.parameters;
                            functionExpression.body;
                        };
                    };
                };

        "Fields to hold Callable values for shared callable parameters, which are
         synthetic."
        value fieldsForCallableValues
            =   sharedCallableParameterInfos
                .collect {
                    (pInfo) => DartFieldDeclaration {
                        false;
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartTypeName {
                                    scope;
                                    ceylonTypes.callableAnythingType;
                                };
                                [DartVariableDeclaration {
                                    DartSimpleIdentifier {
                                        // TODO consolidate naming logic
                                        "_" + dartTypes.getName(pInfo.functionModel) + "$c";
                                    };
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

        function assertedExpression(DartExpression? e) {
            assert (exists e);
            return e;
        }

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
                            assertedExpression {
                                dartTypes.expressionToThisOrOuterStripThis {
                                    scope;
                                    dartTypes.ancestorClassOrInterfacesToOuterInheritingDeclaration {
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
            =   if (!classModel.hasConstructors() && !classModel.hasEnumerated())
                then generateDartConstructorsInitializer {
                    scope;
                    classModel;
                    classBody;
                    extendedType;
                    parameters?.parameters else [];
                }
                else classBody.content
                    .map((node)
                        =>  if (is ConstructorDefinition node)
                            then node
                            else null)
                    .coalesced
                    .flatMap { (constructor)
                        =>  generateDartConstructors {
                                scope;
                                classModel;
                                classBody;
                                constructor;
                            };
                    }.follow {
                        generateConsolidatedInitializer {
                            scope;
                            classModel;
                            classBody;
                        };
                    }.sequence();

        "Class members. Statements (aside from Specification and Assertion statements) do
         not introduce members and are therefore not supported by
         [[ClassMemberTransformer]]."
        value members
            =   classBody.children
                    .map((node)
                        =>  if (is Declaration|Specification|Assertion node)
                            then node
                            else null)
                    .coalesced
                    .flatMap((d)
                        =>  d.transform(classMemberTransformer));

        "Functions, values, classes (or their constructors) for which the most refined
         member is contained by an Interface."
        value declarationsToBridge
            // Shouldn't there be a better way?
            =   supertypeDeclarations(classModel)
                    .flatMap((d) => CeylonList(d.members))
                    .map((declaration)
                        =>  if (is FunctionOrValueModel | ClassModel declaration)
                            then declaration
                            else null)
                    .coalesced
                    .filter(DeclarationModel.shared)
                    .filter(not(DeclarationModel.staticallyImportable))
                    .map(curry(mostRefined)(classModel))
                    .distinct
                    .map((m) {
                        "Surely a most-refined implementation exists."
                        assert (exists m);
                        return m;
                    })
                    .filter((m) => container(m) is InterfaceModel)
                    .filter((m) => container(m) != ceylonTypes.identifiableDeclaration)
                    .filter(not(DeclarationModel.formal))
                    // Don't bridge to a declaration made in a dart native library. Surely
                    // the member is available from the extended type, in some way.
                    .filter(not(nativeDart))
                    .flatMap(replaceClassWithSharedConstructors)
                    .sequence();

        value bridgeFunctions
            =   declarationsToBridge.map((member)
                =>  generateBridgeMethodOrField(scope, member));

        return
        DartClassDeclaration {
            classModel.abstract;
            identifier;
            extendsClause;
            implementsClause =
                if (exists satisfiesTypes)
                then DartImplementsClause(satisfiesTypes)
                else null;
            concatenate {
                outerField,
                outerForwarders,
                captureFields,
                constructors,
                fieldsForInitializerParameters,
                getterMethodBridgesForCeylonValues,
                bridgesToSyntheticFields,
                fieldsForCallableValues,
                members,
                callableParameterForwarders,
                bridgeFunctions
            };
        };
    }

    [DartConstructorDeclaration*] generateDartConstructorsInitializer(
            DScope scope, ClassModel classModel, ClassBody classBody,
            ExtendedType? extendedType, [Parameter*] parameters) {

        value classIdentifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(classModel);

        "Initializer parameters."
        value standardParameters
            =   if (!parameters.empty)
                then withInConstructorSignature {
                    classModel;
                    () => generateFormalParameterList {
                        true; false;
                        scope;
                        parameters;
                    }.parameters;
                }
                else [];

        value hasDefaultedParameter
            =   standardParameters.any((p) => p is DartDefaultFormalParameter);

        "Non-defaulted class initializer parameters."
        value standardParametersNonDefaulted
            =   if (hasDefaultedParameter)
                then withInConstructorSignature {
                    classModel;
                    () => generateFormalParameterList {
                        true; false;
                        scope;
                        parameters;
                        // don't use "$dart$core.Object"
                        noDefaults = true;
                    }.parameters;
                }
                else standardParameters;

        "Assign parameters to corresponding `this.` fields. Eventually, we'll just do
         this for the ones we want to capture."
        value memberParameterInitializers
            =   parameters
                .map {
                    (p) => parameterInfo(p).parameterModel.model;
                }.filter {
                    // Skip assignments for *shared* callable parameters; they will have
                    // a synthetic name and are handled below.
                    (model) => !model is FunctionModel || !model.shared;
                }.collect {
                    (model) => DartExpressionStatement {
                        DartAssignmentExpression {
                            DartPrefixedIdentifier {
                                DartSimpleIdentifier("this");
                                // The field for the Callable or the possibly synthetic
                                // field for the value
                                dartTypes.identifierForField(model);
                            };
                            DartAssignmentOperator.equal;
                            DartSimpleIdentifier(dartTypes.getName(model));
                        };
                    };
                };

        "Assign values *for `shared` callable parameters* to `this.` fields."
        value sharedCallableValueMemberParameterInitializers
            =   parameters
                .map {
                    (p) => parameterInfo(p).parameterModel.model;
                }.filter {
                    (model) => model is FunctionModel && model.shared;
                }.collect {
                    (model) => DartExpressionStatement {
                        DartAssignmentExpression {
                            DartPrefixedIdentifier {
                                DartSimpleIdentifier("this");
                                DartSimpleIdentifier(
                                    "_" + dartTypes.getName(model) + "$c");
                            };
                            DartAssignmentOperator.equal;
                            DartSimpleIdentifier(dartTypes.getName(model));
                        };
                    };
                };

        value outerAndCaptureParameters
            =   generateOuterAndCaptureParameters(scope, classModel);

        value argsIdentifier
            =   DartSimpleIdentifier("a");

        value spreadConstructorName
            =   DartSimpleIdentifier("$s");

        value workerConstructorName
            =   hasDefaultedParameter
                then DartSimpleIdentifier("$w");

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
                        name = null;
                        DartFormalParameterList {
                            true; false;
                            concatenate {
                                outerAndCaptureParameters,
                                standardParameters
                            };
                        };
                        [DartRedirectingConstructorInvocation {
                            spreadConstructorName;
                            DartArgumentList {
                                [createExpressionEvaluationWithSetup {
                                    generateDefaultValueAssignments {
                                        scope;
                                        parameters.map((parameter)
                                            =>  if (is DefaultedParameter parameter)
                                                then parameter
                                                else null).coalesced;
                                    };
                                    DartListLiteral {
                                        false;
                                        concatenate {
                                            outerAndCaptureParameters.map {
                                                DartSimpleFormalParameter.identifier;
                                            },
                                            parameters.map {
                                                (p) => DartSimpleIdentifier {
                                                    dartTypes.getName {
                                                        parameterInfo(p)
                                                                .parameterModel
                                                                .model;
                                                    };
                                                };
                                            }
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
                            [ for (i in 0:(outerAndCaptureParameters.size +
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
            =   outerAndCaptureParameters
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
            =   DartBlock {
                    concatenate {
                        outerAndCaptureMemberInitializers,
                        memberParameterInitializers,
                        sharedCallableValueMemberParameterInitializers,
                        *withInConstructorBody {
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
                            outerAndCaptureParameters,
                            // this constructor never handles defaulted parameters
                            standardParametersNonDefaulted
                        };
                    };
                    emptyOrSingleton {
                        generateSuperInvocation(scope, classModel, extendedType);
                    };
                    null;
                    DartBlockFunctionBody {
                        null; false;
                        constructorBody;
                    };
                };

        return [
            defaultsConstructor,
            spreadConstructor,
            workerConstructor
        ].coalesced.sequence();
    }

    [DartSimpleFormalParameter*] generateOuterAndCaptureParameters
            (DScope scope, ClassModel classModel)
        =>  concatenate {
                dartTypes.outerDeclarationsForClass(classModel).take(1).map {
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
                },
                dartTypes.captureDeclarationsForClass(classModel).map {
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
                }
            };

    [DartConstructorDeclaration*] generateDartConstructors(
            DScope scope, ClassModel classModel, ClassBody classBody,
            ConstructorDefinition constructor) {

        value parameters
            =   switch(constructor)
                case (is CallableConstructorDefinition) constructor.parameters.parameters
                case (is ValueConstructorDefinition) [];

        value classIdentifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(classModel);

        value constructorInfo
            =   constructorDefinitionInfo(constructor);

        value hasDefaultedParameter
            =   parameters.any((p) => p is DefaultedParameter);

        value dartParameters
            =   generateFormalParameterList {
                    true; false;
                    scope;
                    parameters;
                }.parameters;

        value dartArgs
            =   dartParameters.collect(DartFormalParameter.identifier);

        value mangledDartParameters
            =   withInConsolidatedConstructor {
                    classModel;
                    () => generateFormalParameterList {
                        true; false;
                        scope;
                        parameters;
                    }.parameters;
                };

        value mangledDartParamsNoDefault
            =   withInConsolidatedConstructor {
                    classModel;
                    () => generateFormalParameterList {
                        true; false;
                        scope;
                        parameters;
                        noDefaults = true;
                    }.parameters;
                };

        value mangledDartArgs
            =   mangledDartParameters.collect(DartFormalParameter.identifier);

        value outerAndCaptureParameters
            =   generateOuterAndCaptureParameters(scope, classModel);

        value outerAndCaptureArgs
            =   outerAndCaptureParameters.collect(DartFormalParameter.identifier);

        value bitmapParameter
            =   DartSimpleFormalParameter {
                    false; false;
                    dartTypes.dartInt;
                    DartSimpleIdentifier("$bitmap");
                };

        value argsParameterIdentifier
            =   DartSimpleIdentifier("a");

        "Constructor within this class we are delegating to."
        ConstructorModel | ClassModel | Null delegateConstructor;

        PositionalArguments? argumentList;

        ClassModel | ConstructorModel? resolvedExtendedDeclaration;

        String? extendedConstructorName;

        if (exists extendedType = constructor.extendedType) {
            value ecInfo
                =   extensionOrConstructionInfo(extendedType.target);

            assert (exists extendedDeclaration
                =   ecInfo.declaration);

            resolvedExtendedDeclaration
                =   resolveClassAliases(extendedDeclaration);

            assert (exists resolvedExtendedDeclaration);

            value resolvedExtendedClassModel
                =   getClassOfConstructor(resolvedExtendedDeclaration);

            value resolvedClassModel
                =   resolveClassAliases(classModel);

            value delegatesToSuper
                =   resolvedClassModel != resolvedExtendedClassModel;

            delegateConstructor
                =   !delegatesToSuper then resolvedExtendedDeclaration;

            extendedConstructorName
                =   switch (delegateConstructor)
                    case (is ConstructorModel) (delegateConstructor.name else "")
                    case (is ClassModel) ""
                    case (is Null) null;

            argumentList
                =   if (!delegatesToSuper)
                    then extendedType.target.arguments
                    else null;
        }
        else {
            delegateConstructor = null;
            argumentList = null;
            resolvedExtendedDeclaration = null;
            extendedConstructorName = null;
        }

        "Arguments for redirect clauses. Must be lazy to have expressions generated
         in correct context!"
        value delegateArguments {
            if (exists argumentList, !argumentList.argumentList.children.empty) {
                assert (exists delegateConstructor);
                assert (exists extendedType = constructor.extendedType?.target);
                value ecInfo = extensionOrConstructionInfo(extendedType);
                assert (exists callableType = ecInfo.typeModel);
                return generateArgumentListFromArguments {
                    scope;
                    argumentList;
                    CeylonList {
                        ctx.unit.getCallableArgumentTypes(callableType.fullType);
                    };
                    delegateConstructor;
                }[1].arguments;
            }
            return [];
        }

        function parametersFollowing(String constructorName)
            =>  classBody.children.reversed
                    .map((n) => if (is ConstructorDefinition n) then n else null)
                    .coalesced
                    .takeWhile((c)
                        // We have to use name since the typchecker gives us a
                        // ClassModel (not ConstructorModel) when extending the default
                        // constructor.
                        =>  (constructorDefinitionInfo(c)
                                .constructorModel.name else "") != constructorName)
                    .flatMap((c)
                        =>  if (is CallableConstructorDefinition c)
                            then c.parameters.parameters
                            else [])
                    .sequence();

        value followingConstructorParameters
            =   parametersFollowing(constructorInfo.constructorModel.name else "");

        value followingDelegateParameters
            =   if (exists extendedConstructorName)
                then parametersFollowing(extendedConstructorName)
                else [];

        value constructorIndex
            =   classBody.children.reversed
                    .map((n) => if (is ConstructorDefinition n) then n else null)
                    .coalesced
                    .map(constructorDefinitionInfo)
                    .map(ConstructorDefinitionInfo.constructorModel)
                    .takeWhile(not(constructorInfo.constructorModel.equals))
                    .size;

        value constructorPrefix
            =   dartTypes.getName(constructorInfo.constructorModel);

        value constructorIdentifier
            // default constructors will have name of ""
            =   !constructorPrefix.empty
                then DartSimpleIdentifier(constructorPrefix);

        "The identifier for the Dart constructor that evaluates default argument
         expressions, or null if there are no defaulted parameters."
        value defaultsConstructorIdentifier
            =   hasDefaultedParameter then
                DartSimpleIdentifier(constructorPrefix + "$d");

        "The identifier for the Dart constructor that spreads the argument list generated
         by the defaults constructor, or null."
        value spreadConstructorIdentifier
            =   DartSimpleIdentifier(constructorPrefix + "$s");

        "The identifier for the Dart constructor that delegates to super() or another
         Ceylon constructor in the same class."
        value workerConstructorIdentifier
            =   if (hasDefaultedParameter)
                then DartSimpleIdentifier(constructorPrefix + "$w")
                else DartSimpleIdentifier(constructorPrefix + "$d");

        "The identifier for the Dart constructor for some other Ceylon constructor in this
         class we are redirecting to, or null if extending super()."
        value delegateConstructorIdentifier
            =   switch (delegateConstructor)
                case (is ConstructorModel)
                    DartSimpleIdentifier(dartTypes.getName(delegateConstructor) + "$d")
                case (is ClassModel) // the default constructor
                    DartSimpleIdentifier("$d")
                case (is Null)
                    null;

        value constructorBitmapValue
            =   DartIntegerLiteral(1.leftLogicalShift(constructorIndex));

        value mangledFollowingConstructorDartParams
            =   withInConsolidatedConstructor {
                    classModel;
                    () => generateFormalParameterList {
                        false; false;
                        scope;
                        followingConstructorParameters;
                        noDefaults = true;
                    }.parameters;
                };

        value mangledFollowingConstructorDartArgs
            =   mangledFollowingConstructorDartParams.collect(
                        DartFormalParameter.identifier);

        "The first constructor in the chain, and for now, always redirects to a $d
         constructor (either the defaults constructor or the worker constructor)."
        value bridgeConstructor
            =   DartConstructorDeclaration {
                    false; false;
                    classIdentifier;
                    constructorIdentifier;
                    DartFormalParameterList {
                        true; false;
                        concatenate {
                            outerAndCaptureParameters,
                            dartParameters
                        };
                    };
                    // redirect to defaults or worker constructor
                    [DartRedirectingConstructorInvocation {
                        defaultsConstructorIdentifier else workerConstructorIdentifier;
                        DartArgumentList {
                            concatenate {
                                [constructorBitmapValue],
                                outerAndCaptureArgs,
                                [DartNullLiteral()].repeat {
                                    followingConstructorParameters.size;
                                },
                                dartArgs
                            };
                        };
                    }];
                    null;
                    null;
                };

        "A consructor that evaluates default argument expressions, as necessary."
        value defaultsConstructor
            =   defaultsConstructorIdentifier exists then
                withInConsolidatedConstructor {
                    classModel;
                    () => DartConstructorDeclaration {
                        false; false;
                        classIdentifier;
                        defaultsConstructorIdentifier;
                        DartFormalParameterList {
                            true; false;
                            concatenate {
                                [bitmapParameter],
                                outerAndCaptureParameters,
                                mangledFollowingConstructorDartParams,
                                mangledDartParameters
                            };
                        };
                        // redirect to spread constructor
                        [DartRedirectingConstructorInvocation {
                            spreadConstructorIdentifier;
                            DartArgumentList {
                                concatenate {
                                    // delegation bitmap
                                    [DartBinaryExpression {
                                        bitmapParameter.identifier;
                                        "|";
                                        constructorBitmapValue;
                                    }],
                                    outerAndCaptureArgs,
                                    mangledFollowingConstructorDartArgs,
                                    // calculated arguments passed in a Dart List
                                    [createExpressionEvaluationWithSetup {
                                        generateDefaultValueAssignments {
                                            scope;
                                            parameters.map((parameter)
                                                =>  if (is DefaultedParameter parameter)
                                                    then parameter
                                                    else null).coalesced;
                                        };
                                        DartListLiteral {
                                            false;
                                            concatenate {
                                                parameters.map {
                                                    (p) => DartSimpleIdentifier {
                                                        dartTypes.getName {
                                                            parameterInfo(p)
                                                                    .parameterModel
                                                                    .model;
                                                        };
                                                    };
                                                }
                                            };
                                        };
                                    }]
                                };
                            };
                        }];
                        null;
                        null;
                    };
                };

        "A constructor to 'spread' the arguments calculated by the defaults constructor,
         which are provided to this constructor as a Dart List."
        value spreadConstructor
            =   hasDefaultedParameter then
                withInConsolidatedConstructor {
                    classModel;
                    () => DartConstructorDeclaration {
                        const = false;
                        factory = false;
                        returnType = classIdentifier;
                        spreadConstructorIdentifier;
                        DartFormalParameterList {
                            true; false;
                            concatenate {
                                [bitmapParameter],
                                outerAndCaptureParameters,
                                mangledFollowingConstructorDartParams,
                                [DartSimpleFormalParameter {
                                    false; false;
                                    dartTypes.dartList;
                                    argsParameterIdentifier;
                                }]
                            };
                        };
                        [DartRedirectingConstructorInvocation {
                            workerConstructorIdentifier;
                            DartArgumentList {
                                concatenate {
                                    [bitmapParameter.identifier],
                                    outerAndCaptureArgs,
                                    mangledFollowingConstructorDartArgs,
                                    // spread List of arguments
                                    [ for (i in 0:parameters.size)
                                        DartIndexExpression {
                                            argsParameterIdentifier;
                                            DartIntegerLiteral(i);
                                        }
                                    ]
                                };
                            };
                        }];
                        null;
                        null;
                    };
                };

        "The last constructor in the chain, which will either be the $d or $w constructor.
         This constructor:

            - extends super() and invokes $init in its body, or
            - redirects to another $d Ceylon constructor in the same class."
        value workerConstructor
            =   withInConsolidatedConstructor {
                    classModel;
                    () => DartConstructorDeclaration {
                        false; false;
                        classIdentifier;
                        workerConstructorIdentifier;
                        DartFormalParameterList {
                            true; false;
                            concatenate {
                                [bitmapParameter],
                                outerAndCaptureParameters,
                                mangledFollowingConstructorDartParams,
                                mangledDartParamsNoDefault
                            };
                        };
                        // delegate to super()
                        if (!exists delegateConstructor)
                        then emptyOrSingleton {
                            generateSuperInvocation {
                                scope;
                                classModel;
                                constructor.extendedType;
                            };
                        }
                        // redirect to another Ceylon constructor in the same class
                        else [DartRedirectingConstructorInvocation {
                            delegateConstructorIdentifier;
                            DartArgumentList {
                                concatenate {
                                    // delegation bitmap
                                    [DartBinaryExpression {
                                        bitmapParameter.identifier;
                                        "|";
                                        constructorBitmapValue;
                                    }],
                                    outerAndCaptureArgs,
                                    mangledFollowingConstructorDartArgs,
                                    mangledDartArgs,
                                    [DartNullLiteral()].repeat {
                                        followingDelegateParameters.size
                                            - mangledFollowingConstructorDartArgs.size
                                            - mangledDartArgs.size;
                                    },
                                    delegateArguments
                                };
                            };
                        }];
                        null;
                        (!delegateConstructor exists) then
                        DartBlockFunctionBody {
                            null;
                            false;
                            DartBlock {
                                [DartExpressionStatement {
                                    DartFunctionExpressionInvocation {
                                        dartTypes.identifierForInitMethod(classModel);
                                        DartArgumentList {
                                            concatenate {
                                                // delegation bitmap
                                                [DartBinaryExpression {
                                                    bitmapParameter.identifier;
                                                    "|";
                                                    constructorBitmapValue;
                                                }],
                                                outerAndCaptureArgs,
                                                mangledFollowingConstructorDartArgs,
                                                mangledDartArgs
                                            };
                                        };
                                    };
                                }];
                            };
                        };
                    };
                };

        return [
            bridgeConstructor,
            defaultsConstructor,
            spreadConstructor,
            workerConstructor
        ].coalesced.sequence();
    }

    DartMethodDeclaration generateConsolidatedInitializer(
            DScope scope, ClassModel classModel, ClassBody classBody) {

        value constructorCount
            =   { for (n in classBody.children)
                  if (is ConstructorDefinition n) 1 }.size;

        if (constructorCount > 32) {
            addError(scope, "a maximum of 32 constructors is supported on Dart.");
        }

        value consolidatedParameterList
            =   withInConsolidatedConstructor {
                    classModel;
                    () => generateFormalParameterList {
                        false; false;
                        scope;
                        classBody.children.reversed.flatMap {
                            (node) => if (is CallableConstructorDefinition node)
                                then node.parameters.parameters
                                else [];
                        };
                        true;
                    };
                };

        value constructorIndexes
            =   map {
                    [ for (node in classBody.children)
                      if (is ConstructorDefinition node) node
                    ].reversed.indexed
                    .map { (entry)
                        =>  entry.item -> entry.key;
                    };
                };

        value bitmapIdentifier
            =   DartSimpleIdentifier("$bitmap");

        value outerAndCaptureParameters
            =   generateOuterAndCaptureParameters(scope, classModel);

        value outerAndCaptureMemberInitializers
            =   outerAndCaptureParameters
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

        return
        withInConsolidatedConstructor {
            classModel;
            () => DartMethodDeclaration {
                false; "void";
                null;
                null; false;
                dartTypes.identifierForInitMethod(classModel);
                DartFormalParameterList {
                    true; false;
                    concatenate {
                        [DartSimpleFormalParameter {
                            false; false;
                            dartTypes.dartInt;
                            bitmapIdentifier;
                        }],
                        outerAndCaptureParameters,
                        consolidatedParameterList.parameters
                    };
                };
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        classBody.children.flatMap((node) {
                            if (!is ConstructorDefinition node) {
                                return node.transform(classStatementTransformer);
                            }
                            return [DartIfStatement {
                                DartBinaryExpression {
                                    DartIntegerLiteral(0);
                                    "!=";
                                    DartBinaryExpression {
                                        bitmapIdentifier;
                                        "&";
                                        DartIntegerLiteral {
                                            1.leftLogicalShift(
                                                constructorIndexes[node] else 0);
                                        };
                                    };
                                };
                                DartBlock {
                                    concatenate {
                                        outerAndCaptureMemberInitializers,
                                        *node.block.transformChildren {
                                            statementTransformer;
                                        }
                                    };
                                };
                            }];
                        }).coalesced.sequence();
                    };
                };
            };
        };
    }

    "Explicit super call with arguments."
    DartConstructorInitializer? generateSuperInvocation(
            DScope scope, ClassModel classModel, ExtendedType? extendedType) {

        assert (is ClassModel extendedClassModel
            =   classModel.extendedType.declaration);

        value outerAndCaptureArguments
            =   generateArgumentsForOuterAndCaptures {
                    scope;
                    extendedClassModel;
                };

        [DartExpression*] dartArguments;

        ClassModel | ConstructorModel | Null resolvedExtendedDeclaration;

        if (exists extendedType) {
            value extensionOrConstruction
                =   extendedType.target;

            value ecInfo
                =   extensionOrConstructionInfo(extensionOrConstruction);

            "Arguments must exist for constructor or initializer extends"
            assert (exists arguments = extensionOrConstruction.arguments);

            assert (exists extendedDeclaration
                =   ecInfo.declaration);

            resolvedExtendedDeclaration
                =   resolveClassAliases(extendedDeclaration);

            assert (exists resolvedExtendedDeclaration);

            if (!arguments.argumentList.children.empty) {

                assert (exists callableType
                    =   ecInfo.typeModel);

                value signature
                    =   CeylonList {
                            ctx.unit.getCallableArgumentTypes(callableType.fullType);
                        };

                // Don't use "resolved" here, since class alias may use
                // different parameter names than the aliased class or
                // constructor.

                // Use 'withInConstructorSignature' since we may be passing
                // along callable parameters, which are actually Callable
                // values at this point.
                dartArguments
                    =   withInConstructorSignature {
                            classModel;
                            () => generateArgumentListFromArguments {
                                ecInfo;
                                arguments;
                                signature;
                                extendedDeclaration;
                            }[1].arguments;
                        };
            }
            else {
                dartArguments = [];
            }
        }
        else {
            dartArguments = [];
            resolvedExtendedDeclaration = null;
        }

        // Note: always include super invocation if we are extending a constructor

        if (!outerAndCaptureArguments.empty || !dartArguments.empty
                || resolvedExtendedDeclaration is ConstructorModel) {
            return
            DartSuperConstructorInvocation {
                if (is ConstructorModel resolvedExtendedDeclaration)
                then DartSimpleIdentifier {
                    dartTypes.getName(resolvedExtendedDeclaration);
                }
                else null;
                DartArgumentList {
                    concatenate {
                        outerAndCaptureArguments,
                        dartArguments
                    };
                };
            };
        }

        return null;
    }

    shared actual
    void visitTypeAliasDefinition(TypeAliasDefinition that) {
        // type aliases are not reified (at least until we have reified generics)
    }

    shared actual
    void visitClassAliasDefinition(ClassAliasDefinition that) {
        // toplevel class aliases are not reified
    }

    shared actual
    void visitInterfaceAliasDefinition(InterfaceAliasDefinition that) {
        // toplevel interface aliases are not reified
    }

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition | ValueGetterDefinition | ObjectDefinition that) {

        value info = nodeInfo(that);

        value declarationModel =
            switch (that)
            case (is ValueDefinition)
                valueDefinitionInfo(that).declarationModel
            case (is ValueGetterDefinition)
                valueGetterDefinitionInfo(that).declarationModel
            case (is ObjectDefinition)
                objectDefinitionInfo(that).declarationModel;

        value getter
            =   generateForwardingGetter {
                    info;
                    declarationModel;
                    that is ObjectDefinition;
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

    DartFunctionDeclaration generateForwardingGetter(
            DScope scope, ValueModel valueModel,
            "If `true`, use the non-erased type. Useful for the toplevel objects
             `true_` and `false_`. Should be `true` for ObjectDefinitions, which are
             never erased."
            Boolean disableErasure = false)
        =>  DartFunctionDeclaration {
                false;
                if (disableErasure) then
                    dartTypes.dartTypeName {
                        scope;
                        valueModel.type;
                        false; false;
                    }
                else
                    dartTypes.dartTypeNameForDeclaration {
                        scope; valueModel;
                    };
                "get";
                DartSimpleIdentifier {
                    dartTypes.getName(valueModel);
                };
                DartFunctionExpression {
                    null;
                    DartExpressionFunctionBody {
                        async = false;
                        DartSimpleIdentifier {
                            dartTypes.getPackagePrefixedName(valueModel);
                        };
                    };
                };
            };

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

    DartFunctionDeclaration generateForwardingFunction
            (DScope scope, FunctionModel declarationModel)
        =>  let (functionName = dartTypes.getName(declarationModel),
                functionPPName = dartTypes.getPackagePrefixedName(declarationModel),
                parameterModels = CeylonList(
                        declarationModel.firstParameterList.parameters))
            DartFunctionDeclaration {
                external = false;
                generateFunctionReturnType(scope, declarationModel);
                propertyKeyword = null;
                DartSimpleIdentifier(functionName);
                DartFunctionExpression {
                    generateFormalParameterList {
                        true; false;
                        scope;
                        parameterModels;
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
            (DScope scope,
            FunctionOrValueModel | ClassModel | ConstructorModel declaration) {

        assert (is FunctionModel | ValueModel | SetterModel
                    | ClassModel | ConstructorModel declaration);

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    scope;
                    declaration;
                }.oldPairSimple;

        value parameterModels
            =   switch (declaration)
                case (is FunctionModel)
                    CeylonList(declaration.firstParameterList.parameters)
                case (is ClassModel)
                    CeylonList(declaration.parameterList.parameters)
                case (is ConstructorModel)
                    CeylonList(declaration.parameterList.parameters)
                case (is SetterModel)
                    [declaration.parameter]
                case (is ValueModel)
                    [];

        value interfaceModel
            =   if (is ConstructorModel declaration)
                then declaration.container.container
                else (declaration of DeclarationModel).container;

        "The container of the target of a bridge method is surely an Interface."
        assert (is InterfaceModel interfaceModel);

        value isSetter
            =   declaration is SetterModel;

        value invocation
            =   DartMethodInvocation {
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
                                dartTypes.getName(parameterModel.model);
                            };
                        }];
                    };
                };

        return
        DartMethodDeclaration {
            false; null;
            generateFunctionReturnType(scope, declaration);
            dartElementType == dartValue then (
                if (isSetter)
                then "set"
                else "get"
            );
            dartElementType is DartOperator;
            identifier;
            (dartElementType != dartValue || isSetter)
                then generateFormalParameterList {
                    !dartElementType is DartOperator && !isSetter;
                    false;
                    scope;
                    parameterModels;
                };
            if (isSetter) then
                // Dart doesn't like expression bodies for void functions with non-void
                // expressions.
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        [DartExpressionStatement {
                            invocation;
                        }];
                    };
                }
            else
                DartExpressionFunctionBody {
                    false;
                    invocation;
                };
        };
    }
}
