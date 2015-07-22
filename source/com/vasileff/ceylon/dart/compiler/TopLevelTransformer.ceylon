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
    ValueGetterDefinition
}
import ceylon.interop.java {
    CeylonList
}

"For Dart TopLevel declarations, which are distinct from
 declarations made within blocks."
class TopLevelTransformer(CompilationContext ctx)
        extends BaseTransformer<[DartCompilationUnitMember*]>(ctx) {

    shared actual
    [DartCompilationUnitMember*]
    transformValueDeclaration(ValueDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return super.transformValueDeclaration(that);
    }

    shared actual
    [DartTopLevelVariableDeclaration|DartFunctionDeclaration+]|[] transformValueDefinition
            (ValueDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return [DartTopLevelVariableDeclaration(
                    miscTransformer.transformValueDefinition(that)),
                *generateForwardingGetterSetter(that)];
    }

    shared actual
    [DartCompilationUnitMember*] transformValueGetterDefinition
            (ValueGetterDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }
        return super.transformValueGetterDefinition(that);
    }

    shared actual
    [DartCompilationUnitMember*]
    transformFunctionDeclaration(FunctionDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return super.transformFunctionDeclaration(that);
    }


    shared actual
    [DartCompilationUnitMember*] transformClassDefinition(ClassDefinition that) {
        value info = AnyClassInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return [];
        }

        return super.transformClassDefinition(that);
    }

    shared actual
    [DartFunctionDeclaration+]|[] transformFunctionDefinition(FunctionDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }
        return [generateFunctionDefinition(that),
                generateForwardingFunction(that)];
    }

    shared actual
    [DartFunctionDeclaration+]|[] transformFunctionShortcutDefinition
            (FunctionShortcutDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return [generateFunctionDefinition(that),
                generateForwardingFunction(that)];
    }

    shared actual
    [DartClassDeclaration]|[] transformInterfaceDefinition
            (InterfaceDefinition that) {

        value info = AnyInterfaceInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info)) {
            return [];
        }

        value name = DartSimpleIdentifier(ctx.dartTypes.getName(info.declarationModel));

        value implementsTypes = sequence(CeylonList(
                    info.declarationModel.satisfiedTypes).map((satisfiedType)
            =>  ctx.dartTypes.dartTypeName(that, satisfiedType, false)
        ));

        value members = expand(that.body.transformChildren(
                ctx.classMemberTransformer)).sequence();

        return
        [DartClassDeclaration {
            abstract = true;
            name = name;
            extendsClause = null;
            implementsClause =
                if (exists implementsTypes)
                then DartImplementsClause(implementsTypes)
                else null;
            members = members;
        }];
    }

    shared actual
    DartCompilationUnitMember[] transformObjectDefinition(ObjectDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        return super.transformObjectDefinition(that);
    }

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition that) {

        value info = ValueDefinitionInfo(that);

        value getter =
        DartFunctionDeclaration {
            external = false;
            returnType = ctx.dartTypes.dartTypeNameForDeclaration(
                that, info.declarationModel);
            propertyKeyword = "get";
            DartSimpleIdentifier {
                ctx.dartTypes.getName(info.declarationModel);
            };
            DartFunctionExpression {
                null;
                DartExpressionFunctionBody {
                    async = false;
                    DartSimpleIdentifier {
                        "$package$" + ctx.dartTypes.getName(info.declarationModel);
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
                    ctx.dartTypes.getName(info.declarationModel);
                };
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            final = false;
                            var = false;
                            type = ctx.dartTypes.dartTypeNameForDeclaration(
                                that, info.declarationModel);
                            identifier = DartSimpleIdentifier("value");
                        }];
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        DartAssignmentExpression {
                            DartSimpleIdentifier {
                                "$package$"
                                    + ctx.dartTypes.getName(info.declarationModel);
                            };
                            DartAssignmentOperator.equal;
                            DartSimpleIdentifier("value");
                        };
                    };
                };
            };

        return
            if (exists setter)
            then [getter, setter]
            else [getter];
    }

    DartFunctionDeclaration generateForwardingFunction(AnyFunction that)
        =>  let (info = AnyFunctionInfo(that),
                functionName = ctx.dartTypes.getName(info.declarationModel),
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
                                        ctx.dartTypes.getName(parameterModel);
                                    };
                                };
                            };
                        };
                    };
                };
            };
}
