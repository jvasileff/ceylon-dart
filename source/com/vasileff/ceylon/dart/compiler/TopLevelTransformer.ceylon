import ceylon.ast.core {
    FunctionDefinition,
    ValueDefinition,
    FunctionShortcutDefinition,
    AnyFunction,
    FunctionDeclaration
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.model.typechecker.model {
    ParameterModel=Parameter
}

"For Dart TopLevel declarations, which are distinct from
 declarations made within blocks."
class TopLevelTransformer
        (CompilationContext ctx)
        extends BaseTransformer<[DartCompilationUnitMember*]>(ctx) {

    shared actual
    [DartTopLevelVariableDeclaration+] transformValueDefinition
            (ValueDefinition that)
        =>  [DartTopLevelVariableDeclaration(dartTransformer
                .transformValueDefinition(that))];

    see(`function transformFunctionShortcutDefinition`)
    see(`function StatementTransformer.transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionShortcutDefinition`)
    shared actual
    [DartFunctionDeclaration+] transformFunctionDefinition
            (FunctionDefinition that) {
        value info = FunctionDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                info.declarationModel.type);

        return [DartFunctionDeclaration {
            external = false;
            returnType =
                // TODO seems like a hacky way to create a void keyword
                if (functionModel.declaredVoid)
                then DartTypeName(DartSimpleIdentifier("void"))
                else returnType;
            propertyKeyword = null;
            name = DartSimpleIdentifier("$package$" + functionName);
            functionExpression = expressionTransformer
                .generateFunctionExpression(that);
        }, generateForwardingFunction(that)];
    }

    see(`function transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionDefinition`)
    see(`function StatementTransformer.transformFunctionShortcutDefinition`)
    shared actual
    [DartFunctionDeclaration+] transformFunctionShortcutDefinition
                (FunctionShortcutDefinition that) {
        value info = FunctionShortcutDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                info.declarationModel.type);

        return [DartFunctionDeclaration {
            external = false;
            returnType =
                // TODO seems like a hacky way to create a void keyword
                if (functionModel.declaredVoid)
                then DartTypeName(DartSimpleIdentifier("void"))
                else returnType;
            propertyKeyword = null;
            name = DartSimpleIdentifier("$package$" + functionName);
            functionExpression = expressionTransformer
                    .generateFunctionExpression(that);
        }, generateForwardingFunction(that)];
    }

    DartFunctionDeclaration generateForwardingFunction
            (AnyFunction that) {

        value info =
            switch (that)
            case (is FunctionDeclaration) FunctionDeclarationInfo(that)
            case (is FunctionDefinition) FunctionDefinitionInfo(that)
            case (is FunctionShortcutDefinition) FunctionShortcutDefinitionInfo(that);

        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                info.declarationModel.type);

        value parameterList =expressionTransformer.generateFormalParameterList
                (that, that.parameterLists.first);

        return
        DartFunctionDeclaration {
            external = false;
            returnType =
                // TODO seems like a hacky way to create a void keyword
                if (functionModel.declaredVoid)
                then DartTypeName(DartSimpleIdentifier("void"))
                else returnType;
            propertyKeyword = null;
            DartSimpleIdentifier(functionName);
            DartFunctionExpression {
                parameterList;
                DartExpressionFunctionBody {
                    async = false;
                    expression = DartMethodInvocation {
                        target = null;
                        DartSimpleIdentifier("$package$" + functionName);
                        DartArgumentList {
                            CeylonList(functionModel.firstParameterList.parameters)
                                    .collect { (ParameterModel parameterModel) =>
                                DartSimpleIdentifier {
                                    ctx.naming.getName(parameterModel);
                                };
                            };
                        };
                    };
                };
            };
        };
    }
}
