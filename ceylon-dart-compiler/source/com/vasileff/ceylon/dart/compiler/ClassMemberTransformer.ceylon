import ceylon.ast.core {
    ValueDeclaration,
    ValueDefinition,
    FunctionDeclaration,
    TypeAliasDefinition,
    WideningTransformer,
    Node,
    FunctionDefinition,
    InterfaceDefinition
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
    DartSimpleFormalParameter
}
import com.vasileff.ceylon.dart.nodeinfo {
    FunctionDeclarationInfo,
    FunctionDefinitionInfo
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
        // TODO for interfaces, need to output a declaration plus
        //      a static getter method. Need support for lazy specifiers
        //      and getters.

        return
        [DartFieldDeclaration {
            static = false;
            fieldList = generateForValueDefinition(that);
        }];
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
    [DartMethodDeclaration*] transformFunctionDefinition(FunctionDefinition that) {
        value info = FunctionDefinitionInfo(that);

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
