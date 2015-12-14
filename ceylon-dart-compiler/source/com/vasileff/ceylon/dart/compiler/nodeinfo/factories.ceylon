import ceylon.ast.core {
    ExistsOrNonemptyCondition,
    ExtensionOrConstruction,
    NamedArgument,
    ArgumentList,
    BooleanCondition,
    IfElse,
    SwitchCaseElse,
    TryCatchFinally,
    CompilationUnit,
    Comprehension,
    ComprehensionClause,
    ElseClause,
    ForClause,
    ForIterator,
    ForFail,
    IsCase,
    IsCondition,
    SpreadArgument,
    TypeNameWithTypeArguments,
    Variable,
    Node,
    Expression,
    Declaration,
    DynamicBlock,
    Statement,
    Parameter,
    Type,
    SpecifiedArgument,
    FunctionArgument,
    AnonymousArgument,
    ValueArgument,
    ObjectArgument,
    LazySpecification,
    FunctionDeclaration,
    FunctionDefinition,
    AnyFunction,
    FunctionShortcutDefinition,
    NonemptyCondition,
    ExistsCondition,
    SpecifiedVariable,
    UnspecifiedVariable,
    TypedVariable,
    VariadicVariable,
    Extension,
    Construction,
    AnyClass,
    TypeDeclaration,
    TypeAliasDefinition,
    AnyInterface,
    BaseExpression,
    FunctionExpression,
    IfElseExpression,
    Invocation,
    ObjectExpression,
    Outer,
    QualifiedExpression,
    Super,
    This,
    ConstructorDefinition,
    ObjectDefinition,
    TypedDeclaration,
    ValueSetterDefinition,
    AnyValue,
    ValueDeclaration,
    ValueDefinition,
    ValueGetterDefinition,
    ValueSpecification,
    Condition,
    While,
    ExpressionStatement,
    Assertion,
    Directive,
    Destructure
}

shared
NodeInfo nodeInfo(Node astNode)
    =>  switch (astNode)
        case (is Expression) expressionInfo(astNode)
        case (is Declaration) declarationInfo(astNode)
        case (is Statement) statementInfo(astNode)
        case (is ExtensionOrConstruction) extensionOrConstructionInfo(astNode)
        case (is NamedArgument) namedArgumentInfo(astNode)
        case (is Condition) conditionInfo(astNode)
        case (is Variable) variableInfo(astNode)
        case (is ArgumentList) ArgumentListInfo(astNode)
        case (is CompilationUnit) CompilationUnitInfo(astNode)
        case (is Comprehension) ComprehensionInfo(astNode)
        case (is ComprehensionClause) ComprehensionClauseInfo(astNode)
        case (is ElseClause) ElseClauseInfo(astNode)
        case (is ForClause) ForClauseInfo(astNode)
        case (is ForIterator) ForIteratorInfo(astNode)
        case (is IsCase) IsCaseInfo(astNode)
        case (is Parameter) ParameterInfo(astNode)
        case (is SpreadArgument) SpreadArgumentInfo(astNode)
        case (is Type) TypeInfo(astNode)
        case (is TypeNameWithTypeArguments) TypeNameWithTypeArgumentsInfo(astNode)
        case (is ControlClauseNodeType) ControlClauseInfo(astNode)
        else DefaultNodeInfo(astNode);

shared
ConditionInfo conditionInfo(Condition astNode)
    =>  switch (astNode)
        case (is BooleanCondition) BooleanConditionInfo(astNode)
        case (is ExistsCondition) ExistsConditionInfo(astNode)
        case (is NonemptyCondition) NonemptyConditionInfo(astNode)
        case (is IsCondition) IsConditionInfo(astNode);

shared
ExpressionInfo expressionInfo(Expression astNode)
    =>  switch (astNode)
        case (is BaseExpression) BaseExpressionInfo(astNode)
        case (is FunctionExpression) FunctionExpressionInfo(astNode)
        case (is IfElseExpression) IfElseExpressionInfo(astNode)
        case (is Invocation) InvocationInfo(astNode)
        case (is ObjectExpression) ObjectExpressionInfo(astNode)
        case (is Outer) OuterInfo(astNode)
        case (is QualifiedExpression) QualifiedExpressionInfo(astNode)
        case (is Super) SuperInfo(astNode)
        case (is This) ThisInfo(astNode)
        else DefaultExpressionInfo(astNode);

shared
DeclarationInfo declarationInfo(Declaration astNode)
    =>  switch (astNode)
        case (is TypeDeclaration) typeDeclarationInfo(astNode)
        case (is TypedDeclaration) typedDeclarationInfo(astNode)
        case (is ConstructorDefinition) ConstructorDefinitionInfo(astNode)
        case (is ObjectDefinition) ObjectDefinitionInfo(astNode)
        case (is ValueSetterDefinition) ValueSetterDefinitionInfo(astNode);

shared
AnyValueInfo anyValueInfo(AnyValue astNode)
    =>  switch (astNode)
        case (is ValueDeclaration) ValueDeclarationInfo(astNode)
        case (is ValueDefinition) ValueDefinitionInfo(astNode)
        case (is ValueGetterDefinition) ValueGetterDefinitionInfo(astNode);

shared
NamedArgumentInfo namedArgumentInfo(NamedArgument astNode)
    =>  switch (astNode)
        case (is AnonymousArgument) AnonymousArgumentInfo(astNode)
        case (is SpecifiedArgument) SpecifiedArgumentInfo(astNode)
        case (is ValueArgument) ValueArgumentInfo(astNode)
        case (is FunctionArgument) FunctionArgumentInfo(astNode)
        case (is ObjectArgument) ObjectArgumentInfo(astNode);

shared
SpreadArgumentInfo | ComprehensionInfo sequenceArgumentInfo
        (SpreadArgument | Comprehension astNode)
    =>  switch (astNode)
        case (is SpreadArgument) SpreadArgumentInfo(astNode)
        case (is Comprehension) ComprehensionInfo(astNode);

shared
AnyFunctionInfo anyFunctionInfo(AnyFunction astNode)
    =>  switch (astNode)
        case (is FunctionDeclaration) FunctionDeclarationInfo(astNode)
        case (is FunctionDefinition) FunctionDefinitionInfo(astNode)
        case (is FunctionShortcutDefinition) FunctionShortcutDefinitionInfo(astNode);

shared
StatementInfo statementInfo(Statement astNode)
    =>  switch (astNode)
        case (is DynamicBlock) DynamicBlockInfo(astNode)
        case (is ForFail) ForFailInfo(astNode)
        case (is IfElse) IfElseInfo(astNode)
        case (is SwitchCaseElse) SwitchCaseElseInfo(astNode)
        case (is TryCatchFinally) TryCatchFinallyInfo(astNode)
        case (is ValueSpecification) ValueSpecificationInfo(astNode)
        case (is LazySpecification) LazySpecificationInfo(astNode)
        case (is While) WhileInfo(astNode)
        case (is ExpressionStatement | Assertion | Directive | Destructure)
                DefaultStatementInfo(astNode);

shared
VariableInfo variableInfo(Variable astNode)
    =>  switch (astNode)
        case (is SpecifiedVariable) SpecifiedVariableInfo(astNode)
        case (is UnspecifiedVariable) UnspecifiedVariableInfo(astNode)
        case (is TypedVariable) TypedVariableInfo(astNode)
        case (is VariadicVariable) VariadicVariableInfo(astNode);

shared
ExistsOrNonemptyConditionInfo existsOrNonemptyConditionInfo
        (ExistsOrNonemptyCondition astNode)
    =>  switch (astNode)
        case (is ExistsCondition) ExistsConditionInfo(astNode)
        case (is NonemptyCondition) NonemptyConditionInfo(astNode);

shared
TypeDeclarationInfo typeDeclarationInfo(TypeDeclaration astNode)
    =>  switch (astNode)
        case (is AnyClass) AnyClassInfo(astNode)
        case (is AnyInterface) AnyInterfaceInfo(astNode)
        case (is TypeAliasDefinition) TypeAliasDefinitionInfo(astNode);

shared
ExtensionOrConstructionInfo extensionOrConstructionInfo(ExtensionOrConstruction astNode)
    =>  switch (astNode)
        case (is Extension) ExtensionInfo(astNode)
        case (is Construction) ConstructionInfo(astNode);

shared
TypedDeclarationInfo typedDeclarationInfo(TypedDeclaration astNode)
    =>  switch (astNode)
        case (is AnyValue) anyValueInfo(astNode)
        case (is AnyFunction) anyFunctionInfo(astNode);
