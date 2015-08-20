import ceylon.ast.core {
    ValueDeclaration,
    ValueDefinition,
    FunctionDeclaration,
    TypeAliasDefinition,
    WideningTransformer,
    Node,
    FunctionDefinition,
    InterfaceDefinition,
    FunctionShortcutDefinition,
    ValueGetterDefinition,
    LazySpecifier
}

import com.redhat.ceylon.model.typechecker.model {
    ClassOrInterfaceModel=ClassOrInterface,
    InterfaceModel=Interface
}
import com.vasileff.ceylon.dart.ast {
    DartFieldDeclaration,
    DartSimpleIdentifier,
    DartMethodDeclaration,
    DartClassMember,
    DartFormalParameterList,
    DartSimpleFormalParameter,
    dartFormalParameterListEmpty
}
import com.vasileff.ceylon.dart.nodeinfo {
    FunctionDeclarationInfo,
    AnyFunctionInfo,
    ValueDefinitionInfo,
    ValueGetterDefinitionInfo
}

shared
class ClassMemberTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<[DartClassMember*]> {

    shared actual
    [DartClassMember*] transformValueDeclaration(ValueDeclaration that) {
        return
        [DartFieldDeclaration {
            static = false;
            fieldList = generateForValueDeclaration(that);
        }];
    }

    shared actual
    [DartClassMember*] transformValueDefinition(ValueDefinition that) {
        value info = ValueDefinitionInfo(that);

        "The container of a class or interface member is surely a ClassOrInterface"
        assert (is ClassOrInterfaceModel container = info.declarationModel.container);

        if (!container is InterfaceModel) {
            // TODO support classes; assuming interface code below
            throw CompilerBug(that, "classes not yet supported");
        }

        value specifier = that.definition;

        "Interfaces don't have fields"
        assert(is LazySpecifier specifier);

        return generateGetter(that);
    }

    shared actual
    [DartClassMember*] transformValueGetterDefinition(ValueGetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }
        return generateGetter(that);
    }

    shared actual
    [DartMethodDeclaration] transformFunctionDeclaration(FunctionDeclaration that) {

        value info = FunctionDeclarationInfo(that);
        value functionName = dartTypes.getName(info.declarationModel);

        // TODO where do we put the parameter default values?
        return [
            DartMethodDeclaration {
                external = false;
                modifierKeyword = null;
                returnType = generateFunctionReturnType(info);
                propertyKeyword = null;
                name = DartSimpleIdentifier(functionName);
                parameters = ctx.expressionTransformer
                    .generateFormalParameterList(that, that.parameterLists.first);
                body = null;
            }
        ];
    }

    shared actual
    [DartMethodDeclaration*] transformFunctionShortcutDefinition
            (FunctionShortcutDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return generateInterfaceFunctionDefinition(that);
    }

    shared actual
    [DartMethodDeclaration*] transformFunctionDefinition(FunctionDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return generateInterfaceFunctionDefinition(that);
    }

    [DartMethodDeclaration*] generateGetter
            (ValueDefinition | ValueGetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        value declarationModel =
            switch (that)
            case (is ValueDefinition)
                ValueDefinitionInfo(that).declarationModel
            case (is ValueGetterDefinition)
                ValueGetterDefinitionInfo(that).declarationModel;

        "The container of a class or interface member is surely a ClassOrInterface"
        assert (is ClassOrInterfaceModel container = declarationModel.container);

        if (!container is InterfaceModel) {
            // TODO support classes; assuming interface code below
            throw CompilerBug(that, "classes not yet supported");
        }

        // Member functions of interfaces need a $this parameter.
        DartSimpleFormalParameter? thisParameter;
        if (is InterfaceModel container) {
            thisParameter = DartSimpleFormalParameter {
                true; false;
                dartTypes.dartTypeName {
                    that;
                    container.type;
                    false; false;
                };
                DartSimpleIdentifier("$this");
            };
        }
        else {
            thisParameter = null;
        }

        // Generate a DartFunctionExpression, then scrap it for parts
        value functionExpression =
                generateForValueDefinitionGetter(that).functionExpression;

        DartFormalParameterList standardParameters = dartFormalParameterListEmpty;

        // generate the abstract interface declaration and
        // a static method definition for the actual implementation
        return [
            DartMethodDeclaration {
                false;
                null;
                dartTypes.dartReturnTypeNameForDeclaration {
                    that;
                    declarationModel;
                };
                "get";
                DartSimpleIdentifier {
                    dartTypes.getName {
                        declarationModel;
                    };
                };
                parameters = null;
                body = null;
            },
            DartMethodDeclaration {
                false;
                "static";
                dartTypes.dartReturnTypeNameForDeclaration {
                    that;
                    declarationModel;
                };
                null;
                DartSimpleIdentifier {
                    dartTypes.getStaticInterfaceMethodName {
                        declarationModel;
                    };
                };
                DartFormalParameterList {
                    true; false;
                    [
                        thisParameter,
                        *standardParameters.parameters
                    ].coalesced.sequence();
                };
                functionExpression.body;
            }
        ];
    }

    [DartMethodDeclaration*] generateInterfaceFunctionDefinition
            (FunctionDefinition | FunctionShortcutDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        value info = AnyFunctionInfo(that);

        "The container of a class or interface member is surely a ClassOrInterface"
        assert (is ClassOrInterfaceModel container = info.declarationModel.container);

        if (!container is InterfaceModel) {
            // TODO support classes; assuming interface code below
            throw CompilerBug(that, "classes not yet supported");
        }

        // Member functions of interfaces need a $this parameter.
        DartSimpleFormalParameter? thisParameter;
        if (is InterfaceModel container) {
            thisParameter = DartSimpleFormalParameter {
                true; false;
                dartTypes.dartTypeName {
                    that;
                    container.type;
                    false; false;
                };
                DartSimpleIdentifier("$this");
            };
        }
        else {
            thisParameter = null;
        }

        // Generate a DartFunctionExpression, then scrap it for parts
        value functionExpression = generateFunctionExpression(that);
        assert (exists standardParameters = functionExpression.parameters);

        // TODO defaulted parameters! (see also transformFunctionDefinition)

        // generate the abstract interface declaration and
        // a static method definition for the actual implementation
        return [
            DartMethodDeclaration {
                false; null;
                generateFunctionReturnType(info);
                null;
                DartSimpleIdentifier {
                    dartTypes.getName {
                        info.declarationModel;
                    };
                };
                DartFormalParameterList {
                    true; false;
                    standardParameters.parameters;
                };
                body = null;
            },
            DartMethodDeclaration {
                false;
                "static";
                generateFunctionReturnType(info);
                null;
                DartSimpleIdentifier {
                    dartTypes.getStaticInterfaceMethodName {
                        info.declarationModel;
                    };
                };
                DartFormalParameterList {
                    true; false;
                    [
                        thisParameter,
                        *standardParameters.parameters
                    ].coalesced.sequence();
                };
                functionExpression.body;
            }
        ];
    }

    shared actual
    [] transformTypeAliasDefinition(TypeAliasDefinition that)
        =>  [];

    shared actual
    [] transformInterfaceDefinition(InterfaceDefinition that) {
        that.visit(topLevelVisitor);
        return [];
    }

    shared actual default
    [] transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node: '``className(that)``'");
    }
}
