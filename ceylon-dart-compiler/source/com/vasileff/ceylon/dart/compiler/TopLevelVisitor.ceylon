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
    Node
}
import ceylon.interop.java {
    CeylonList
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
    DartFunctionDeclaration
}
import com.vasileff.ceylon.dart.nodeinfo {
    AnyInterfaceInfo,
    ValueDefinitionInfo,
    AnyFunctionInfo,
    AnyClassInfo
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
    void visitValueDefinition
            (ValueDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        addAll {
            DartTopLevelVariableDeclaration {
                generateForValueDefinition(that);
            },
            *generateForwardingGetterSetter(that)
        };
    }

    shared actual
    void visitValueGetterDefinition
            (ValueGetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        super.transformValueGetterDefinition(that);
    }

    shared actual
    void visitFunctionDeclaration(FunctionDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        super.transformFunctionDeclaration(that);
    }

    shared actual
    void visitClassDefinition(ClassDefinition that) {
        value info = AnyClassInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        super.transformClassDefinition(that);
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
    void visitInterfaceDefinition
            (InterfaceDefinition that) {

        value info = AnyInterfaceInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return;
        }

        value name = DartSimpleIdentifier(dartTypes.getName(info.declarationModel));

        value implementsTypes = sequence(CeylonList(
                    info.declarationModel.satisfiedTypes).map((satisfiedType)
            =>  dartTypes.dartTypeName(that, satisfiedType, false)
        ));

        value members = expand(that.body.transformChildren(
                ctx.classMemberTransformer)).sequence();

        add {
            DartClassDeclaration {
                abstract = true;
                name = name;
                extendsClause = null;
                implementsClause =
                    if (exists implementsTypes)
                    then DartImplementsClause(implementsTypes)
                    else null;
                members = members;
            };
        };
    }

    shared actual
    void visitObjectDefinition(ObjectDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return;
        }

        super.transformObjectDefinition(that);
    }

    shared actual
    void visitTypeAliasDefinition(TypeAliasDefinition that) {}

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition that) {

        value info = ValueDefinitionInfo(that);

        value getter =
        DartFunctionDeclaration {
            external = false;
            returnType = dartTypes.dartTypeNameForDeclaration(
                that, info.declarationModel);
            propertyKeyword = "get";
            DartSimpleIdentifier {
                dartTypes.getName(info.declarationModel);
            };
            DartFunctionExpression {
                null;
                DartExpressionFunctionBody {
                    async = false;
                    DartSimpleIdentifier {
                        "$package$" + dartTypes.getName(info.declarationModel);
                    };
                };
            };
        };

        value setter = info.declarationModel.variable then
            DartFunctionDeclaration {
                external = false;
                returnType = null;
                propertyKeyword = "set";
                DartSimpleIdentifier {
                    dartTypes.getName(info.declarationModel);
                };
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            final = false;
                            var = false;
                            type = dartTypes.dartTypeNameForDeclaration(
                                that, info.declarationModel);
                            identifier = DartSimpleIdentifier("value");
                        }];
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        DartAssignmentExpression {
                            DartSimpleIdentifier {
                                "$package$"
                                    + dartTypes.getName(info.declarationModel);
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
            "Unhandled node: '``className(that)``'");
    }

    DartFunctionDeclaration generateForwardingFunction(AnyFunction that)
        =>  let (info = AnyFunctionInfo(that),
                functionName = dartTypes.getName(info.declarationModel),
                parameterModels = CeylonList(
                        info.declarationModel.firstParameterList.parameters))
            DartFunctionDeclaration {
                external = false;
                generateFunctionReturnType(info);
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
}
