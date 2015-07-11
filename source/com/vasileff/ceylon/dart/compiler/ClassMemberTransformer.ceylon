import ceylon.ast.core {
    ValueDeclaration,
    ValueDefinition,
    FunctionDeclaration
}

class ClassMemberTransformer
        (CompilationContext ctx)
        extends BaseTransformer<[DartClassMember*]>(ctx) {

    shared actual
    [DartClassMember*] transformValueDeclaration(ValueDeclaration that) {
        return
        [DartFieldDeclaration {
            static = false;
            fieldList = ctx.miscTransformer.transformValueDeclaration(that);
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
            fieldList = ctx.miscTransformer.transformValueDefinition(that);
        }];
    }

    shared actual [DartMethodDeclaration] transformFunctionDeclaration
            (FunctionDeclaration that) {

        value info = FunctionDeclarationInfo(that);
        value functionName = ctx.dartTypes.getName(info.declarationModel);

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
}
