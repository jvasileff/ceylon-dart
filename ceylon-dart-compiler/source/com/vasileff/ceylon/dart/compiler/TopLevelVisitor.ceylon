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
    ExtendedType
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    InterfaceModel=Interface,
    ClassModel=Class,
    SetterModel=Setter,
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    ValueModel=Value,
    FunctionOrValueModel=FunctionOrValue
}
import com.vasileff.ceylon.dart.ast {
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
    DartFieldFormalParameter,
    DartConstructorDeclaration,
    DartBlockFunctionBody,
    DartBlock,
    DartMethodDeclaration,
    DartExtendsClause
}
import com.vasileff.ceylon.dart.nodeinfo {
    AnyInterfaceInfo,
    ValueDefinitionInfo,
    AnyFunctionInfo,
    AnyClassInfo,
    ValueGetterDefinitionInfo,
    ObjectDefinitionInfo,
    ObjectExpressionInfo
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

        addClassDefinition {
            that;
            info.declarationModel;
            that.body;
            that.extendedType;
            that.parameters;
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

        value identifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(
                        info.declarationModel);

        value implementsTypes
            =   sequence(CeylonList(info.declarationModel.satisfiedTypes)
                        .map((satisfiedType)
                =>  dartTypes.dartTypeName(that, satisfiedType, false)));


        "The containing class or interface, if one exists."
        value outerDeclaration
            =   getContainingClassOrInterface(info.scope.container);

        "An $outer field declaration, if there is an outer class or interface"
        value outerField
            =   if (exists outerDeclaration) then
                    DartFieldDeclaration {
                        false;
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeName {
                                that;
                                outerDeclaration.type;
                                false; false;
                            };
                            [DartVariableDeclaration {
                                dartTypes.identifierForOuter(outerDeclaration);
                                null;
                            }];
                        };
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
                            dartTypes.dartTypeNameForDeclaration {
                                that;
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
        //super.visitObjectExpression(that);

        addClassDefinition {
            that;
            info.anonymousClass;
            that.body;
            that.extendedType;
        };
    }

    shared actual
    void visitObjectDefinition(ObjectDefinition that) {
        value info = ObjectDefinitionInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        addClassDefinition {
            that;
            info.anonymousClass;
            that.body;
            that.extendedType;
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

    void addClassDefinition(
            Node scope, ClassModel classModel, ClassBody classBody,
            ExtendedType? extendedTypeNode, Parameters? parameters = null) {

        value identifier
            =   dartTypes.dartIdentifierForClassOrInterfaceDeclaration(classModel);

        value satisifesTypes
            =   sequence(CeylonList(classModel.satisfiedTypes)
                        .map((satisfiedType)
                =>  dartTypes.dartTypeName(scope, satisfiedType, false)));

        // TODO extends clause with parameters
        if (exists extendedTypeNode,
                exists arguments = extendedTypeNode.target.arguments,
                !arguments.argumentList.children.empty) {
            throw CompilerBug(scope, "Classes with extended types with parameters not \
                                      yet supported.");
        }

        value extendedType
            =   if (exists et = classModel.extendedType,
                    !ceylonTypes.isCeylonBasic(classModel.extendedType)
                    && !ceylonTypes.isCeylonObject(classModel.extendedType))
                then dartTypes.dartTypeName(scope, classModel.extendedType, false)
                else null;

        value extendsClause
            =   if (exists extendedType) then
                    DartExtendsClause {
                        extendedType;
                    }
                else null;

        // TODO consolidate with very similar visitInterfaceDefinition code
        // TODO toplevels objects should be constants

        "Class initializer parameters."
        value standardParameters = (() {
            if (exists parameters, !parameters.children.empty) {
                value list = generateFormalParameterList(scope, parameters);
                if (!list.parameters.every((p) => p is DartSimpleFormalParameter)) {
                    throw CompilerBug(parameters,
                        "Initializer parameters with default values not yet supported.");
                }
                return list.parameters.narrow<DartSimpleFormalParameter>();
            }
            else {
                return [];
            }
        })();

        "Fields to capture initializer parameters. See also
         [[ClassMemberTransformer.transformValueDefinition]]."
        value fieldsForInitializerParameters
            =   (standardParameters).map {
                    (parameter) =>
                    DartFieldDeclaration {
                        false;
                            DartVariableDeclarationList {
                                null;
                                parameter.type;
                                [DartVariableDeclaration {
                                    parameter.identifier;
                                    initializer = null;
                                }];
                            };
                        };
                    };

        "declarations for containers we must hold references to."
        value outerDeclarations
            =   [*dartTypes.outerDeclarationsForClass(classModel)];

        "$outer field declarations, if any."
        value outerFields
            =   outerDeclarations.map {
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

        value outerFieldsConstructorParameters
            =   outerDeclarations.map {
                    (declaration) =>
                    DartFieldFormalParameter {
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

        "$capture field declarations, if any."
        value captureFields
            =   captureDeclarations.map {
                    (capture) => DartFieldDeclaration {
                        false;
                        DartVariableDeclarationList {
                            null;
                            dartTypes.dartTypeNameForDeclaration {
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

        value captureConstructorParameters
            =   captureDeclarations.map {
                    (declaration) =>
                    DartFieldFormalParameter {
                        false; false;
                        dartTypes.dartTypeNameForDeclaration {
                            scope;
                            declaration;
                        };
                        dartTypes.identifierForCapture {
                            declaration;
                        };
                    };
                };

        value constructors = [
            DartConstructorDeclaration {
                const = false;
                factory = false;
                returnType = identifier;
                null;
                DartFormalParameterList {
                    true; false;
                    concatenate {
                        outerFieldsConstructorParameters,
                        captureConstructorParameters,
                        standardParameters.map {
                            // Prepend with "this." for dart. Eventually, we'll
                            // just do this for the ones we want to capture.
                            // Not supporting defaulted parameters yet.
                            (p) => DartFieldFormalParameter {
                                final = false; // todo final for non-variables
                                const = false;
                                type = p.type;
                                p.identifier;
                            };
                        }
                    };
                };
                null;
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        concatenate {
                            classBody.transformChildren(classStatementTransformer);
                        };
                    };
                };
            }
        ];

        "Class members. Statements (aside from Specifiction and Assertion statements) do
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

        add {
            DartClassDeclaration {
                classModel.abstract;
                identifier;
                extendsClause;
                implementsClause =
                    if (exists satisifesTypes)
                    then DartImplementsClause(satisifesTypes)
                    else null;
                concatenate {
                    outerFields,
                    captureFields,
                    constructors,
                    fieldsForInitializerParameters,
                    members,
                    bridgeFunctions
                };
            };
        };
    }

    shared actual
    void visitTypeAliasDefinition(TypeAliasDefinition that) {}

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition | ValueGetterDefinition | ObjectDefinition that) {

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
                that, declarationModel);
            propertyKeyword = "get";
            DartSimpleIdentifier {
                dartTypes.getName(declarationModel);
            };
            DartFunctionExpression {
                null;
                DartExpressionFunctionBody {
                    async = false;
                    DartSimpleIdentifier {
                        "$package$" + dartTypes.getName(declarationModel);
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
                                that, declarationModel);
                            identifier = DartSimpleIdentifier("value");
                        }];
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        DartAssignmentExpression {
                            DartSimpleIdentifier {
                                "$package$"
                                    + dartTypes.getName(declarationModel);
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
        throw CompilerBug(that,
            "Unhandled node (TopLevelVisitor): '``className(that)``'");
    }

    DartFunctionDeclaration generateForwardingFunction(AnyFunction that)
        =>  let (info = AnyFunctionInfo(that),
                functionName = dartTypes.getName(info.declarationModel),
                parameterModels = CeylonList(
                        info.declarationModel.firstParameterList.parameters))
            DartFunctionDeclaration {
                external = false;
                generateFunctionReturnType(that, info.declarationModel);
                propertyKeyword = null;
                DartSimpleIdentifier(functionName);
                DartFunctionExpression {
                    generateFormalParameterList {
                        that;
                        that.parameterLists.first;
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        expression = DartMethodInvocation {
                            target = null;
                            DartSimpleIdentifier("$package$" + functionName);
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
            (Node scope, FunctionOrValueModel declaration) {

        assert (is FunctionModel|ValueModel|SetterModel declaration);

        value [identifier, isFunction]
            =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    scope;
                    declaration;
                };

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
            !isFunction then (
                if (declaration is SetterModel)
                then "set"
                else "get"
            );
            identifier;
            isFunction then generateFormalParameterList {
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
