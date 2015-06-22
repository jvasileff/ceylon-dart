import ceylon.ast.core {
    ValueParameter,
    DefaultedValueParameter,
    Visitor,
    FunctionDefinition,
    Block,
    InvocationStatement,
    Invocation,
    BaseExpression,
    MemberNameWithTypeArguments,
    PositionalArguments,
    ArgumentList,
    IntegerLiteral,
    StringLiteral,
    CompilationUnit,
    ParameterReference,
    VariadicParameter,
    DefaultedCallableParameter,
    DefaultedParameterReference,
    CallableParameter,
    ValueDefinition,
    LazySpecifier,
    FunctionExpression,
    Parameters,
    Return,
    FunctionShortcutDefinition,
    FloatLiteral,
    Specifier,
    Node,
    Assertion,
    IsCondition,
    ValueSpecification
}

import com.redhat.ceylon.model.typechecker.model {
    ControlBlockModel=ControlBlock,
    FunctionOrValueModel=FunctionOrValue,
    ConstructorModel=Constructor,
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    ValueModel=Value,
    SetterModel=Setter,
    UnitModel=Unit,
    TypeModel=Type,
    PackageModel=Package,
    DeclarationModel=Declaration,
    ElementModel=Element,
    ScopeModel=Scope,
    ClassOrInterfaceModel=ClassOrInterface
}

import org.antlr.runtime {
    Token
}
import ceylon.language.meta.declaration {
    Package
}
import com.redhat.ceylon.model.loader.model {
    FunctionOrValueInterface
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

        return DartFunctionDeclaration {
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

        return DartFunctionDeclaration {
            name = DartSimpleIdentifier(functionName);
            functionExpression = expressionTransformer
                    .generateFunctionExpression(that);
        };
    }
}
