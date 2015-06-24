import ceylon.ast.core {
    FunctionDefinition,
    ValueDefinition,
    FunctionShortcutDefinition
}
import com.redhat.ceylon.model.typechecker.model {
    TypedDeclaration
}

"For Dart TopLevel declarations, which are distinct from
 declarations made within blocks."
class TopLevelTransformer
        (CompilationContext ctx)
        extends BaseTransformer<DartCompilationUnitMember>(ctx) {

    shared actual
    DartTopLevelVariableDeclaration transformValueDefinition
            (ValueDefinition that)
        =>  DartTopLevelVariableDeclaration(dartTransformer
                .transformValueDefinition(that));

    see(`function transformFunctionShortcutDefinition`)
    see(`function StatementTransformer.transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionShortcutDefinition`)
    shared actual
    DartFunctionDeclaration transformFunctionDefinition
            (FunctionDefinition that) {
        value info = FunctionDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                (info.declarationModel of TypedDeclaration).type);

        return DartFunctionDeclaration {
            external = false;
            returnType = returnType;
            propertyKeyword = null;
            name = DartSimpleIdentifier(functionName);
            functionExpression = expressionTransformer
                .generateFunctionExpression(that);
        };
    }

    see(`function transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionShortcutDefinition`)
    shared actual
    DartFunctionDeclaration transformFunctionShortcutDefinition
                (FunctionShortcutDefinition that) {
        value info = FunctionShortcutDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                (info.declarationModel of TypedDeclaration).type);

        return DartFunctionDeclaration {
            external = false;
            returnType = returnType;
            propertyKeyword = null;
            name = DartSimpleIdentifier(functionName);
            functionExpression = expressionTransformer
                    .generateFunctionExpression(that);
        };
    }
}
