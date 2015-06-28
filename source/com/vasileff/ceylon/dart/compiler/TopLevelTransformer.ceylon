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
    [DartTopLevelVariableDeclaration|DartFunctionDeclaration+] transformValueDefinition
            (ValueDefinition that)
        =>  [DartTopLevelVariableDeclaration(dartTransformer
                .transformValueDefinition(that)),
            *generateForwardingGetterSetter(that)];

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

    [DartFunctionDeclaration*] generateForwardingGetterSetter
            (ValueDefinition that) {

        value info = ValueDefinitionInfo(that);

        value getter =
        DartFunctionDeclaration {
            external = false;
            returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                info.declarationModel.type);
            propertyKeyword = "get";
            DartSimpleIdentifier {
                ctx.naming.getName(info.declarationModel);
            };
            DartFunctionExpression {
                null;
                DartExpressionFunctionBody {
                    async = false;
                    DartSimpleIdentifier {
                        "$package$" + ctx.naming.getName(info.declarationModel);
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
                    ctx.naming.getName(info.declarationModel);
                };
                DartFunctionExpression {
                    DartFormalParameterList {
                        positional = false;
                        named = false;
                        [DartSimpleFormalParameter {
                            final = false;
                            var = false;
                            type = ctx.naming.dartTypeName(
                                info.declarationModel,
                                info.declarationModel.type);
                            identifier = DartSimpleIdentifier("value");
                        }];
                    };
                    DartExpressionFunctionBody {
                        async = false;
                        DartAssignmentExpression {
                            DartSimpleIdentifier {
                                "$package$" + ctx.naming.getName(info.declarationModel);
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
