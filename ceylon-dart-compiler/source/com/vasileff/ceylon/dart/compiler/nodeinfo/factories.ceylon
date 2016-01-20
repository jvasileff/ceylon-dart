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
    DefaultedParameter,
    VariadicParameter,
    ValueParameter,
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
    Destructure,
    Parameters,
    CallableParameter,
    ParameterReference,
    CallableConstructorDefinition,
    ValueConstructorDefinition,
    AddAssignmentOperation,
    ModuleCompilationUnit,
    ConditionalExpression,
    AnyMemberOperator,
    ExtendedType,
    VoidModifier,
    Identifier,
    Package,
    TypeList,
    Bound,
    Annotation,
    TupleType,
    NameWithTypeArguments,
    ClassSpecifier,
    GroupedExpression,
    Annotations,
    PatternList,
    UnionableType,
    DefaultedType,
    RequiredParameter,
    ImportFunctionValueElement,
    InlineDefinitionArgument,
    PackageDescriptor,
    MemberNameWithTypeArguments,
    InOperation,
    ComplementAssignmentOperation,
    UnionOperation,
    OutModifier,
    AnySpecifier,
    GivenDec,
    SpanSubscript,
    AssignmentStatement,
    BinaryOperation,
    SpanOperation,
    InterfaceDec,
    IntersectionType,
    IsOperation,
    MatchCase,
    Modifier,
    QuotientOperation,
    SimpleType,
    ClassOrInterface,
    DynamicValue,
    UnaryIshOperation,
    KeySubscript,
    VariablePattern,
    UnionAssignmentOperation,
    ImportFunctionValueAlias,
    InterfaceDefinition,
    NonemptyOperation,
    Subscript,
    CaseItem,
    ClassDec,
    ExpressionComprehensionClause,
    PostfixOperation,
    BaseMeta,
    BaseType,
    Operation,
    PackageQualifier,
    AnyCompilationUnit,
    TypeDec,
    TypeParameters,
    TypeSpecifier,
    DynamicInterfaceDefinition,
    DefaultedValueParameter,
    ComplementOperation,
    TypeIsh,
    StringLiteral,
    Variance,
    TypeConstraint,
    ValueModifier,
    ImportTypeElement,
    PrefixIncrementOperation,
    IterableType,
    LetExpression,
    IdentityOperation,
    DivideAssignmentOperation,
    PostfixDecrementOperation,
    InModifier,
    Primary,
    SafeMemberOperator,
    InvocationStatement,
    SetAssignmentOperation,
    VariadicType,
    Meta,
    ImportElement,
    EqualityOperation,
    CallableType,
    SatisfiedTypes,
    InterfaceBody,
    TypeParameter,
    OpenBound,
    SequentialType,
    ModuleDec,
    OptionalType,
    OrAssignmentOperation,
    ClassAliasDefinition,
    ElementOrSubrangeExpression,
    EntryPattern,
    GroupedType,
    SmallAsOperation,
    SwitchCaseElseExpression,
    ExistsOperation,
    SmallerOperation,
    Specifier,
    MainType,
    ArithmeticOperation,
    ConstructorDec,
    ExponentiationOperation,
    IntegerLiteral,
    CaseExpression,
    IntersectionOperation,
    IfClause,
    CatchClause,
    Tuple,
    Literal,
    Throw,
    SetOperation,
    CaseTypes,
    NotOperation,
    ThenOperation,
    CompareOperation,
    UnionType,
    ScaleOperation,
    MultiplyAssignmentOperation,
    RemainderAssignmentOperation,
    SpanToSubscript,
    AssignOperation,
    Conditions,
    EqualOperation,
    ClassBody,
    DefaultedCallableParameter,
    Block,
    IntersectAssignmentOperation,
    SpreadType,
    FinallyClause,
    ArithmeticAssignmentOperation,
    FunctionModifier,
    PackageCompilationUnit,
    MemberMeta,
    TuplePattern,
    AndOperation,
    MeasureOperation,
    FloatLiteral,
    MeasureSubscript,
    UnaryArithmeticOperation,
    EntryType,
    Dec,
    LazySpecifier,
    Atom,
    ConstructorDefinition,
    ForComprehensionClause,
    DecQualifier,
    UIdentifier,
    Resource,
    DifferenceOperation,
    Iterable,
    PrefixDecrementOperation,
    WithinOperation,
    MemberDec,
    SpreadMemberOperator,
    IfComprehensionClause,
    FullPackageName,
    Import,
    SwitchCases,
    LIdentifier,
    OrOperation,
    ImportTypeAlias,
    AnyInterfaceDefinition,
    InterfaceAliasDefinition,
    IdenticalOperation,
    LogicalOperation,
    StringTemplate,
    Arguments,
    QualifiedType,
    CharacterLiteral,
    DynamicModifier,
    ValueExpression,
    SubtractAssignmentOperation,
    NotEqualOperation,
    Break,
    EntryOperation,
    AliasDec,
    SpecifiedPattern,
    Pattern,
    ModuleDescriptor,
    PositionalArguments,
    Continue,
    TypeModifier,
    AndAssignmentOperation,
    NamedArguments,
    SumOperation,
    OfOperation,
    ClassDefinition,
    ImportWildcard,
    LargeAsOperation,
    SelfReference,
    ImportAlias,
    PrefixOperation,
    ClosedBound,
    SwitchClause,
    ControlStructure,
    ElseOperation,
    AssignmentOperation,
    ImportElements,
    CaseClause,
    UnaryOperation,
    RangeSubscript,
    LocalModifier,
    MemberOperator,
    ModuleBody,
    ComparisonOperation,
    FunctionDec,
    RemainderOperation,
    Resources,
    ProductOperation,
    DefaultedParameterReference,
    Body,
    NegationOperation,
    PostfixIncrementOperation,
    ValueDec,
    PackageDec,
    TypeMeta,
    InitialComprehensionClause,
    TryClause,
    Specification,
    LogicalAssignmentOperation,
    TypeArguments,
    FailClause,
    ModuleImport,
    PrefixPostfixStatement,
    Return,
    LargerOperation,
    SpanFromSubscript,
    TypeArgument,
    PrimaryType,
    UnaryTypeOperation
}

shared
SpreadArgumentInfo | ComprehensionInfo sequenceArgumentInfo
        (SpreadArgument | Comprehension astNode)
    =>  switch (astNode)
        case (is SpreadArgument) spreadArgumentInfo(astNode)
        case (is Comprehension) comprehensionInfo(astNode);

shared
AddAssignmentOperationInfo addAssignmentOperationInfo(AddAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AddAssignmentOperationInfo result);
    return result;
}

shared
AliasDecInfo aliasDecInfo(AliasDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AliasDecInfo result);
    return result;
}

shared
AndAssignmentOperationInfo andAssignmentOperationInfo(AndAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AndAssignmentOperationInfo result);
    return result;
}

shared
AndOperationInfo andOperationInfo(AndOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AndOperationInfo result);
    return result;
}

shared
AnnotationInfo annotationInfo(Annotation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnnotationInfo result);
    return result;
}

shared
AnnotationsInfo annotationsInfo(Annotations node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnnotationsInfo result);
    return result;
}

shared
AnonymousArgumentInfo anonymousArgumentInfo(AnonymousArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnonymousArgumentInfo result);
    return result;
}

shared
AnyClassInfo anyClassInfo(AnyClass node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyClassInfo result);
    return result;
}

shared
AnyCompilationUnitInfo anyCompilationUnitInfo(AnyCompilationUnit node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyCompilationUnitInfo result);
    return result;
}

shared
AnyFunctionInfo anyFunctionInfo(AnyFunction node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyFunctionInfo result);
    return result;
}

shared
AnyInterfaceInfo anyInterfaceInfo(AnyInterface node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyInterfaceInfo result);
    return result;
}

shared
AnyInterfaceDefinitionInfo anyInterfaceDefinitionInfo(AnyInterfaceDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyInterfaceDefinitionInfo result);
    return result;
}

shared
AnyMemberOperatorInfo anyMemberOperatorInfo(AnyMemberOperator node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyMemberOperatorInfo result);
    return result;
}

shared
AnySpecifierInfo anySpecifierInfo(AnySpecifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnySpecifierInfo result);
    return result;
}

shared
AnyValueInfo anyValueInfo(AnyValue node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AnyValueInfo result);
    return result;
}

shared
ArgumentListInfo argumentListInfo(ArgumentList node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ArgumentListInfo result);
    return result;
}

shared
ArgumentsInfo argumentsInfo(Arguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ArgumentsInfo result);
    return result;
}

shared
ArithmeticAssignmentOperationInfo arithmeticAssignmentOperationInfo(ArithmeticAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ArithmeticAssignmentOperationInfo result);
    return result;
}

shared
ArithmeticOperationInfo arithmeticOperationInfo(ArithmeticOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ArithmeticOperationInfo result);
    return result;
}

shared
AssertionInfo assertionInfo(Assertion node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AssertionInfo result);
    return result;
}

shared
AssignOperationInfo assignOperationInfo(AssignOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AssignOperationInfo result);
    return result;
}

shared
AssignmentOperationInfo assignmentOperationInfo(AssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AssignmentOperationInfo result);
    return result;
}

shared
AssignmentStatementInfo assignmentStatementInfo(AssignmentStatement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AssignmentStatementInfo result);
    return result;
}

shared
AtomInfo atomInfo(Atom node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is AtomInfo result);
    return result;
}

shared
BaseExpressionInfo baseExpressionInfo(BaseExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BaseExpressionInfo result);
    return result;
}

shared
BaseMetaInfo baseMetaInfo(BaseMeta node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BaseMetaInfo result);
    return result;
}

shared
BaseTypeInfo baseTypeInfo(BaseType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BaseTypeInfo result);
    return result;
}

shared
BinaryOperationInfo binaryOperationInfo(BinaryOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BinaryOperationInfo result);
    return result;
}

shared
BlockInfo blockInfo(Block node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BlockInfo result);
    return result;
}

shared
BodyInfo bodyInfo(Body node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BodyInfo result);
    return result;
}

shared
BooleanConditionInfo booleanConditionInfo(BooleanCondition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BooleanConditionInfo result);
    return result;
}

shared
BoundInfo boundInfo(Bound node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BoundInfo result);
    return result;
}

shared
BreakInfo breakInfo(Break node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is BreakInfo result);
    return result;
}

shared
CallableConstructorDefinitionInfo callableConstructorDefinitionInfo(CallableConstructorDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CallableConstructorDefinitionInfo result);
    return result;
}

shared
CallableParameterInfo callableParameterInfo(CallableParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CallableParameterInfo result);
    return result;
}

shared
CallableTypeInfo callableTypeInfo(CallableType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CallableTypeInfo result);
    return result;
}

shared
CaseClauseInfo caseClauseInfo(CaseClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CaseClauseInfo result);
    return result;
}

shared
CaseExpressionInfo caseExpressionInfo(CaseExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CaseExpressionInfo result);
    return result;
}

shared
CaseItemInfo caseItemInfo(CaseItem node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CaseItemInfo result);
    return result;
}

shared
CaseTypesInfo caseTypesInfo(CaseTypes node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CaseTypesInfo result);
    return result;
}

shared
CatchClauseInfo catchClauseInfo(CatchClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CatchClauseInfo result);
    return result;
}

shared
CharacterLiteralInfo characterLiteralInfo(CharacterLiteral node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CharacterLiteralInfo result);
    return result;
}

shared
ClassAliasDefinitionInfo classAliasDefinitionInfo(ClassAliasDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassAliasDefinitionInfo result);
    return result;
}

shared
ClassBodyInfo classBodyInfo(ClassBody node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassBodyInfo result);
    return result;
}

shared
ClassDecInfo classDecInfo(ClassDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassDecInfo result);
    return result;
}

shared
ClassDefinitionInfo classDefinitionInfo(ClassDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassDefinitionInfo result);
    return result;
}

shared
ClassOrInterfaceInfo classOrInterfaceInfo(ClassOrInterface node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassOrInterfaceInfo result);
    return result;
}

shared
ClassSpecifierInfo classSpecifierInfo(ClassSpecifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClassSpecifierInfo result);
    return result;
}

shared
ClosedBoundInfo closedBoundInfo(ClosedBound node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ClosedBoundInfo result);
    return result;
}

shared
CompareOperationInfo compareOperationInfo(CompareOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CompareOperationInfo result);
    return result;
}

shared
ComparisonOperationInfo comparisonOperationInfo(ComparisonOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ComparisonOperationInfo result);
    return result;
}

shared
CompilationUnitInfo compilationUnitInfo(CompilationUnit node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is CompilationUnitInfo result);
    return result;
}

shared
ComplementAssignmentOperationInfo complementAssignmentOperationInfo(ComplementAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ComplementAssignmentOperationInfo result);
    return result;
}

shared
ComplementOperationInfo complementOperationInfo(ComplementOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ComplementOperationInfo result);
    return result;
}

shared
ComprehensionInfo comprehensionInfo(Comprehension node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ComprehensionInfo result);
    return result;
}

shared
ComprehensionClauseInfo comprehensionClauseInfo(ComprehensionClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ComprehensionClauseInfo result);
    return result;
}

shared
ConditionInfo conditionInfo(Condition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConditionInfo result);
    return result;
}

shared
ConditionalExpressionInfo conditionalExpressionInfo(ConditionalExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConditionalExpressionInfo result);
    return result;
}

shared
ConditionsInfo conditionsInfo(Conditions node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConditionsInfo result);
    return result;
}

shared
ConstructionInfo constructionInfo(Construction node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConstructionInfo result);
    return result;
}

shared
ConstructorDecInfo constructorDecInfo(ConstructorDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConstructorDecInfo result);
    return result;
}

shared
ConstructorDefinitionInfo constructorDefinitionInfo(ConstructorDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ConstructorDefinitionInfo result);
    return result;
}

shared
ContinueInfo continueInfo(Continue node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ContinueInfo result);
    return result;
}

shared
ControlStructureInfo controlStructureInfo(ControlStructure node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ControlStructureInfo result);
    return result;
}

shared
DecInfo decInfo(Dec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DecInfo result);
    return result;
}

shared
DecQualifierInfo decQualifierInfo(DecQualifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DecQualifierInfo result);
    return result;
}

shared
DeclarationInfo declarationInfo(Declaration node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DeclarationInfo result);
    return result;
}

shared
DefaultedCallableParameterInfo defaultedCallableParameterInfo(DefaultedCallableParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DefaultedCallableParameterInfo result);
    return result;
}

shared
DefaultedParameterInfo defaultedParameterInfo(DefaultedParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DefaultedParameterInfo result);
    return result;
}

shared
DefaultedParameterReferenceInfo defaultedParameterReferenceInfo(DefaultedParameterReference node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DefaultedParameterReferenceInfo result);
    return result;
}

shared
DefaultedTypeInfo defaultedTypeInfo(DefaultedType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DefaultedTypeInfo result);
    return result;
}

shared
DefaultedValueParameterInfo defaultedValueParameterInfo(DefaultedValueParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DefaultedValueParameterInfo result);
    return result;
}

shared
DestructureInfo destructureInfo(Destructure node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DestructureInfo result);
    return result;
}

shared
DifferenceOperationInfo differenceOperationInfo(DifferenceOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DifferenceOperationInfo result);
    return result;
}

shared
DirectiveInfo directiveInfo(Directive node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DirectiveInfo result);
    return result;
}

shared
DivideAssignmentOperationInfo divideAssignmentOperationInfo(DivideAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DivideAssignmentOperationInfo result);
    return result;
}

shared
DynamicBlockInfo dynamicBlockInfo(DynamicBlock node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DynamicBlockInfo result);
    return result;
}

shared
DynamicInterfaceDefinitionInfo dynamicInterfaceDefinitionInfo(DynamicInterfaceDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DynamicInterfaceDefinitionInfo result);
    return result;
}

shared
DynamicModifierInfo dynamicModifierInfo(DynamicModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DynamicModifierInfo result);
    return result;
}

shared
DynamicValueInfo dynamicValueInfo(DynamicValue node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is DynamicValueInfo result);
    return result;
}

shared
ElementOrSubrangeExpressionInfo elementOrSubrangeExpressionInfo(ElementOrSubrangeExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ElementOrSubrangeExpressionInfo result);
    return result;
}

shared
ElseClauseInfo elseClauseInfo(ElseClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ElseClauseInfo result);
    return result;
}

shared
ElseOperationInfo elseOperationInfo(ElseOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ElseOperationInfo result);
    return result;
}

shared
EntryOperationInfo entryOperationInfo(EntryOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is EntryOperationInfo result);
    return result;
}

shared
EntryPatternInfo entryPatternInfo(EntryPattern node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is EntryPatternInfo result);
    return result;
}

shared
EntryTypeInfo entryTypeInfo(EntryType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is EntryTypeInfo result);
    return result;
}

shared
EqualOperationInfo equalOperationInfo(EqualOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is EqualOperationInfo result);
    return result;
}

shared
EqualityOperationInfo equalityOperationInfo(EqualityOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is EqualityOperationInfo result);
    return result;
}

shared
ExistsConditionInfo existsConditionInfo(ExistsCondition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExistsConditionInfo result);
    return result;
}

shared
ExistsOperationInfo existsOperationInfo(ExistsOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExistsOperationInfo result);
    return result;
}

shared
ExistsOrNonemptyConditionInfo existsOrNonemptyConditionInfo(ExistsOrNonemptyCondition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExistsOrNonemptyConditionInfo result);
    return result;
}

shared
ExponentiationOperationInfo exponentiationOperationInfo(ExponentiationOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExponentiationOperationInfo result);
    return result;
}

shared
ExpressionInfo expressionInfo(Expression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExpressionInfo result);
    return result;
}

shared
ExpressionComprehensionClauseInfo expressionComprehensionClauseInfo(ExpressionComprehensionClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExpressionComprehensionClauseInfo result);
    return result;
}

shared
ExpressionStatementInfo expressionStatementInfo(ExpressionStatement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExpressionStatementInfo result);
    return result;
}

shared
ExtendedTypeInfo extendedTypeInfo(ExtendedType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExtendedTypeInfo result);
    return result;
}

shared
ExtensionInfo extensionInfo(Extension node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExtensionInfo result);
    return result;
}

shared
ExtensionOrConstructionInfo extensionOrConstructionInfo(ExtensionOrConstruction node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ExtensionOrConstructionInfo result);
    return result;
}

shared
FailClauseInfo failClauseInfo(FailClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FailClauseInfo result);
    return result;
}

shared
FinallyClauseInfo finallyClauseInfo(FinallyClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FinallyClauseInfo result);
    return result;
}

shared
FloatLiteralInfo floatLiteralInfo(FloatLiteral node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FloatLiteralInfo result);
    return result;
}

shared
ForClauseInfo forClauseInfo(ForClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ForClauseInfo result);
    return result;
}

shared
ForComprehensionClauseInfo forComprehensionClauseInfo(ForComprehensionClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ForComprehensionClauseInfo result);
    return result;
}

shared
ForFailInfo forFailInfo(ForFail node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ForFailInfo result);
    return result;
}

shared
ForIteratorInfo forIteratorInfo(ForIterator node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ForIteratorInfo result);
    return result;
}

shared
FullPackageNameInfo fullPackageNameInfo(FullPackageName node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FullPackageNameInfo result);
    return result;
}

shared
FunctionArgumentInfo functionArgumentInfo(FunctionArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionArgumentInfo result);
    return result;
}

shared
FunctionDecInfo functionDecInfo(FunctionDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionDecInfo result);
    return result;
}

shared
FunctionDeclarationInfo functionDeclarationInfo(FunctionDeclaration node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionDeclarationInfo result);
    return result;
}

shared
FunctionDefinitionInfo functionDefinitionInfo(FunctionDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionDefinitionInfo result);
    return result;
}

shared
FunctionExpressionInfo functionExpressionInfo(FunctionExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionExpressionInfo result);
    return result;
}

shared
FunctionModifierInfo functionModifierInfo(FunctionModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionModifierInfo result);
    return result;
}

shared
FunctionShortcutDefinitionInfo functionShortcutDefinitionInfo(FunctionShortcutDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is FunctionShortcutDefinitionInfo result);
    return result;
}

shared
GivenDecInfo givenDecInfo(GivenDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is GivenDecInfo result);
    return result;
}

shared
GroupedExpressionInfo groupedExpressionInfo(GroupedExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is GroupedExpressionInfo result);
    return result;
}

shared
GroupedTypeInfo groupedTypeInfo(GroupedType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is GroupedTypeInfo result);
    return result;
}

shared
IdenticalOperationInfo identicalOperationInfo(IdenticalOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IdenticalOperationInfo result);
    return result;
}

shared
IdentifierInfo identifierInfo(Identifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IdentifierInfo result);
    return result;
}

shared
IdentityOperationInfo identityOperationInfo(IdentityOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IdentityOperationInfo result);
    return result;
}

shared
IfClauseInfo ifClauseInfo(IfClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IfClauseInfo result);
    return result;
}

shared
IfComprehensionClauseInfo ifComprehensionClauseInfo(IfComprehensionClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IfComprehensionClauseInfo result);
    return result;
}

shared
IfElseInfo ifElseInfo(IfElse node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IfElseInfo result);
    return result;
}

shared
IfElseExpressionInfo ifElseExpressionInfo(IfElseExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IfElseExpressionInfo result);
    return result;
}

shared
ImportInfo importInfo(Import node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportInfo result);
    return result;
}

shared
ImportAliasInfo importAliasInfo(ImportAlias node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportAliasInfo result);
    return result;
}

shared
ImportElementInfo importElementInfo(ImportElement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportElementInfo result);
    return result;
}

shared
ImportElementsInfo importElementsInfo(ImportElements node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportElementsInfo result);
    return result;
}

shared
ImportFunctionValueAliasInfo importFunctionValueAliasInfo(ImportFunctionValueAlias node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportFunctionValueAliasInfo result);
    return result;
}

shared
ImportFunctionValueElementInfo importFunctionValueElementInfo(ImportFunctionValueElement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportFunctionValueElementInfo result);
    return result;
}

shared
ImportTypeAliasInfo importTypeAliasInfo(ImportTypeAlias node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportTypeAliasInfo result);
    return result;
}

shared
ImportTypeElementInfo importTypeElementInfo(ImportTypeElement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportTypeElementInfo result);
    return result;
}

shared
ImportWildcardInfo importWildcardInfo(ImportWildcard node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ImportWildcardInfo result);
    return result;
}

shared
InModifierInfo inModifierInfo(InModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InModifierInfo result);
    return result;
}

shared
InOperationInfo inOperationInfo(InOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InOperationInfo result);
    return result;
}

shared
InitialComprehensionClauseInfo initialComprehensionClauseInfo(InitialComprehensionClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InitialComprehensionClauseInfo result);
    return result;
}

shared
InlineDefinitionArgumentInfo inlineDefinitionArgumentInfo(InlineDefinitionArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InlineDefinitionArgumentInfo result);
    return result;
}

shared
IntegerLiteralInfo integerLiteralInfo(IntegerLiteral node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IntegerLiteralInfo result);
    return result;
}

shared
InterfaceAliasDefinitionInfo interfaceAliasDefinitionInfo(InterfaceAliasDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InterfaceAliasDefinitionInfo result);
    return result;
}

shared
InterfaceBodyInfo interfaceBodyInfo(InterfaceBody node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InterfaceBodyInfo result);
    return result;
}

shared
InterfaceDecInfo interfaceDecInfo(InterfaceDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InterfaceDecInfo result);
    return result;
}

shared
InterfaceDefinitionInfo interfaceDefinitionInfo(InterfaceDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InterfaceDefinitionInfo result);
    return result;
}

shared
IntersectAssignmentOperationInfo intersectAssignmentOperationInfo(IntersectAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IntersectAssignmentOperationInfo result);
    return result;
}

shared
IntersectionOperationInfo intersectionOperationInfo(IntersectionOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IntersectionOperationInfo result);
    return result;
}

shared
IntersectionTypeInfo intersectionTypeInfo(IntersectionType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IntersectionTypeInfo result);
    return result;
}

shared
InvocationInfo invocationInfo(Invocation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InvocationInfo result);
    return result;
}

shared
InvocationStatementInfo invocationStatementInfo(InvocationStatement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is InvocationStatementInfo result);
    return result;
}

shared
IsCaseInfo isCaseInfo(IsCase node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IsCaseInfo result);
    return result;
}

shared
IsConditionInfo isConditionInfo(IsCondition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IsConditionInfo result);
    return result;
}

shared
IsOperationInfo isOperationInfo(IsOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IsOperationInfo result);
    return result;
}

shared
IterableInfo iterableInfo(Iterable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IterableInfo result);
    return result;
}

shared
IterableTypeInfo iterableTypeInfo(IterableType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is IterableTypeInfo result);
    return result;
}

shared
KeySubscriptInfo keySubscriptInfo(KeySubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is KeySubscriptInfo result);
    return result;
}

shared
LIdentifierInfo lIdentifierInfo(LIdentifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LIdentifierInfo result);
    return result;
}

shared
LargeAsOperationInfo largeAsOperationInfo(LargeAsOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LargeAsOperationInfo result);
    return result;
}

shared
LargerOperationInfo largerOperationInfo(LargerOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LargerOperationInfo result);
    return result;
}

shared
LazySpecificationInfo lazySpecificationInfo(LazySpecification node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LazySpecificationInfo result);
    return result;
}

shared
LazySpecifierInfo lazySpecifierInfo(LazySpecifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LazySpecifierInfo result);
    return result;
}

shared
LetExpressionInfo letExpressionInfo(LetExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LetExpressionInfo result);
    return result;
}

shared
LiteralInfo literalInfo(Literal node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LiteralInfo result);
    return result;
}

shared
LocalModifierInfo localModifierInfo(LocalModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LocalModifierInfo result);
    return result;
}

shared
LogicalAssignmentOperationInfo logicalAssignmentOperationInfo(LogicalAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LogicalAssignmentOperationInfo result);
    return result;
}

shared
LogicalOperationInfo logicalOperationInfo(LogicalOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is LogicalOperationInfo result);
    return result;
}

shared
MainTypeInfo mainTypeInfo(MainType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MainTypeInfo result);
    return result;
}

shared
MatchCaseInfo matchCaseInfo(MatchCase node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MatchCaseInfo result);
    return result;
}

shared
MeasureOperationInfo measureOperationInfo(MeasureOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MeasureOperationInfo result);
    return result;
}

shared
MeasureSubscriptInfo measureSubscriptInfo(MeasureSubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MeasureSubscriptInfo result);
    return result;
}

shared
MemberDecInfo memberDecInfo(MemberDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MemberDecInfo result);
    return result;
}

shared
MemberMetaInfo memberMetaInfo(MemberMeta node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MemberMetaInfo result);
    return result;
}

shared
MemberNameWithTypeArgumentsInfo memberNameWithTypeArgumentsInfo(MemberNameWithTypeArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MemberNameWithTypeArgumentsInfo result);
    return result;
}

shared
MemberOperatorInfo memberOperatorInfo(MemberOperator node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MemberOperatorInfo result);
    return result;
}

shared
MetaInfo metaInfo(Meta node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MetaInfo result);
    return result;
}

shared
ModifierInfo modifierInfo(Modifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModifierInfo result);
    return result;
}

shared
ModuleBodyInfo moduleBodyInfo(ModuleBody node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModuleBodyInfo result);
    return result;
}

shared
ModuleCompilationUnitInfo moduleCompilationUnitInfo(ModuleCompilationUnit node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModuleCompilationUnitInfo result);
    return result;
}

shared
ModuleDecInfo moduleDecInfo(ModuleDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModuleDecInfo result);
    return result;
}

shared
ModuleDescriptorInfo moduleDescriptorInfo(ModuleDescriptor node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModuleDescriptorInfo result);
    return result;
}

shared
ModuleImportInfo moduleImportInfo(ModuleImport node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ModuleImportInfo result);
    return result;
}

shared
MultiplyAssignmentOperationInfo multiplyAssignmentOperationInfo(MultiplyAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is MultiplyAssignmentOperationInfo result);
    return result;
}

shared
NameWithTypeArgumentsInfo nameWithTypeArgumentsInfo(NameWithTypeArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NameWithTypeArgumentsInfo result);
    return result;
}

shared
NamedArgumentInfo namedArgumentInfo(NamedArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NamedArgumentInfo result);
    return result;
}

shared
NamedArgumentsInfo namedArgumentsInfo(NamedArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NamedArgumentsInfo result);
    return result;
}

shared
NegationOperationInfo negationOperationInfo(NegationOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NegationOperationInfo result);
    return result;
}

shared
NodeInfo nodeInfo(Node node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NodeInfo result);
    return result;
}

shared
NonemptyConditionInfo nonemptyConditionInfo(NonemptyCondition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NonemptyConditionInfo result);
    return result;
}

shared
NonemptyOperationInfo nonemptyOperationInfo(NonemptyOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NonemptyOperationInfo result);
    return result;
}

shared
NotEqualOperationInfo notEqualOperationInfo(NotEqualOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NotEqualOperationInfo result);
    return result;
}

shared
NotOperationInfo notOperationInfo(NotOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is NotOperationInfo result);
    return result;
}

shared
ObjectArgumentInfo objectArgumentInfo(ObjectArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ObjectArgumentInfo result);
    return result;
}

shared
ObjectDefinitionInfo objectDefinitionInfo(ObjectDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ObjectDefinitionInfo result);
    return result;
}

shared
ObjectExpressionInfo objectExpressionInfo(ObjectExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ObjectExpressionInfo result);
    return result;
}

shared
OfOperationInfo ofOperationInfo(OfOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OfOperationInfo result);
    return result;
}

shared
OpenBoundInfo openBoundInfo(OpenBound node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OpenBoundInfo result);
    return result;
}

shared
OperationInfo operationInfo(Operation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OperationInfo result);
    return result;
}

shared
OptionalTypeInfo optionalTypeInfo(OptionalType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OptionalTypeInfo result);
    return result;
}

shared
OrAssignmentOperationInfo orAssignmentOperationInfo(OrAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OrAssignmentOperationInfo result);
    return result;
}

shared
OrOperationInfo orOperationInfo(OrOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OrOperationInfo result);
    return result;
}

shared
OutModifierInfo outModifierInfo(OutModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OutModifierInfo result);
    return result;
}

shared
OuterInfo outerInfo(Outer node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is OuterInfo result);
    return result;
}

shared
PackageInfo packageInfo(Package node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PackageInfo result);
    return result;
}

shared
PackageCompilationUnitInfo packageCompilationUnitInfo(PackageCompilationUnit node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PackageCompilationUnitInfo result);
    return result;
}

shared
PackageDecInfo packageDecInfo(PackageDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PackageDecInfo result);
    return result;
}

shared
PackageDescriptorInfo packageDescriptorInfo(PackageDescriptor node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PackageDescriptorInfo result);
    return result;
}

shared
PackageQualifierInfo packageQualifierInfo(PackageQualifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PackageQualifierInfo result);
    return result;
}

shared
ParameterInfo parameterInfo(Parameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ParameterInfo result);
    return result;
}

shared
ParameterReferenceInfo parameterReferenceInfo(ParameterReference node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ParameterReferenceInfo result);
    return result;
}

shared
ParametersInfo parametersInfo(Parameters node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ParametersInfo result);
    return result;
}

shared
PatternInfo patternInfo(Pattern node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PatternInfo result);
    return result;
}

shared
PatternListInfo patternListInfo(PatternList node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PatternListInfo result);
    return result;
}

shared
PositionalArgumentsInfo positionalArgumentsInfo(PositionalArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PositionalArgumentsInfo result);
    return result;
}

shared
PostfixDecrementOperationInfo postfixDecrementOperationInfo(PostfixDecrementOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PostfixDecrementOperationInfo result);
    return result;
}

shared
PostfixIncrementOperationInfo postfixIncrementOperationInfo(PostfixIncrementOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PostfixIncrementOperationInfo result);
    return result;
}

shared
PostfixOperationInfo postfixOperationInfo(PostfixOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PostfixOperationInfo result);
    return result;
}

shared
PrefixDecrementOperationInfo prefixDecrementOperationInfo(PrefixDecrementOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrefixDecrementOperationInfo result);
    return result;
}

shared
PrefixIncrementOperationInfo prefixIncrementOperationInfo(PrefixIncrementOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrefixIncrementOperationInfo result);
    return result;
}

shared
PrefixOperationInfo prefixOperationInfo(PrefixOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrefixOperationInfo result);
    return result;
}

shared
PrefixPostfixStatementInfo prefixPostfixStatementInfo(PrefixPostfixStatement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrefixPostfixStatementInfo result);
    return result;
}

shared
PrimaryInfo primaryInfo(Primary node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrimaryInfo result);
    return result;
}

shared
PrimaryTypeInfo primaryTypeInfo(PrimaryType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is PrimaryTypeInfo result);
    return result;
}

shared
ProductOperationInfo productOperationInfo(ProductOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ProductOperationInfo result);
    return result;
}

shared
QualifiedExpressionInfo qualifiedExpressionInfo(QualifiedExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is QualifiedExpressionInfo result);
    return result;
}

shared
QualifiedTypeInfo qualifiedTypeInfo(QualifiedType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is QualifiedTypeInfo result);
    return result;
}

shared
QuotientOperationInfo quotientOperationInfo(QuotientOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is QuotientOperationInfo result);
    return result;
}

shared
RangeSubscriptInfo rangeSubscriptInfo(RangeSubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is RangeSubscriptInfo result);
    return result;
}

shared
RemainderAssignmentOperationInfo remainderAssignmentOperationInfo(RemainderAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is RemainderAssignmentOperationInfo result);
    return result;
}

shared
RemainderOperationInfo remainderOperationInfo(RemainderOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is RemainderOperationInfo result);
    return result;
}

shared
RequiredParameterInfo requiredParameterInfo(RequiredParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is RequiredParameterInfo result);
    return result;
}

shared
ResourceInfo resourceInfo(Resource node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ResourceInfo result);
    return result;
}

shared
ResourcesInfo resourcesInfo(Resources node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ResourcesInfo result);
    return result;
}

shared
ReturnInfo returnInfo(Return node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ReturnInfo result);
    return result;
}

shared
SafeMemberOperatorInfo safeMemberOperatorInfo(SafeMemberOperator node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SafeMemberOperatorInfo result);
    return result;
}

shared
SatisfiedTypesInfo satisfiedTypesInfo(SatisfiedTypes node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SatisfiedTypesInfo result);
    return result;
}

shared
ScaleOperationInfo scaleOperationInfo(ScaleOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ScaleOperationInfo result);
    return result;
}

shared
SelfReferenceInfo selfReferenceInfo(SelfReference node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SelfReferenceInfo result);
    return result;
}

shared
SequentialTypeInfo sequentialTypeInfo(SequentialType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SequentialTypeInfo result);
    return result;
}

shared
SetAssignmentOperationInfo setAssignmentOperationInfo(SetAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SetAssignmentOperationInfo result);
    return result;
}

shared
SetOperationInfo setOperationInfo(SetOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SetOperationInfo result);
    return result;
}

shared
SimpleTypeInfo simpleTypeInfo(SimpleType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SimpleTypeInfo result);
    return result;
}

shared
SmallAsOperationInfo smallAsOperationInfo(SmallAsOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SmallAsOperationInfo result);
    return result;
}

shared
SmallerOperationInfo smallerOperationInfo(SmallerOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SmallerOperationInfo result);
    return result;
}

shared
SpanFromSubscriptInfo spanFromSubscriptInfo(SpanFromSubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpanFromSubscriptInfo result);
    return result;
}

shared
SpanOperationInfo spanOperationInfo(SpanOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpanOperationInfo result);
    return result;
}

shared
SpanSubscriptInfo spanSubscriptInfo(SpanSubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpanSubscriptInfo result);
    return result;
}

shared
SpanToSubscriptInfo spanToSubscriptInfo(SpanToSubscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpanToSubscriptInfo result);
    return result;
}

shared
SpecificationInfo specificationInfo(Specification node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpecificationInfo result);
    return result;
}

shared
SpecifiedArgumentInfo specifiedArgumentInfo(SpecifiedArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpecifiedArgumentInfo result);
    return result;
}

shared
SpecifiedPatternInfo specifiedPatternInfo(SpecifiedPattern node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpecifiedPatternInfo result);
    return result;
}

shared
SpecifiedVariableInfo specifiedVariableInfo(SpecifiedVariable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpecifiedVariableInfo result);
    return result;
}

shared
SpecifierInfo specifierInfo(Specifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpecifierInfo result);
    return result;
}

shared
SpreadArgumentInfo spreadArgumentInfo(SpreadArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpreadArgumentInfo result);
    return result;
}

shared
SpreadMemberOperatorInfo spreadMemberOperatorInfo(SpreadMemberOperator node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpreadMemberOperatorInfo result);
    return result;
}

shared
SpreadTypeInfo spreadTypeInfo(SpreadType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SpreadTypeInfo result);
    return result;
}

shared
StatementInfo statementInfo(Statement node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is StatementInfo result);
    return result;
}

shared
StringLiteralInfo stringLiteralInfo(StringLiteral node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is StringLiteralInfo result);
    return result;
}

shared
StringTemplateInfo stringTemplateInfo(StringTemplate node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is StringTemplateInfo result);
    return result;
}

shared
SubscriptInfo subscriptInfo(Subscript node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SubscriptInfo result);
    return result;
}

shared
SubtractAssignmentOperationInfo subtractAssignmentOperationInfo(SubtractAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SubtractAssignmentOperationInfo result);
    return result;
}

shared
SumOperationInfo sumOperationInfo(SumOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SumOperationInfo result);
    return result;
}

shared
SuperInfo superInfo(Super node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SuperInfo result);
    return result;
}

shared
SwitchCaseElseInfo switchCaseElseInfo(SwitchCaseElse node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SwitchCaseElseInfo result);
    return result;
}

shared
SwitchCaseElseExpressionInfo switchCaseElseExpressionInfo(SwitchCaseElseExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SwitchCaseElseExpressionInfo result);
    return result;
}

shared
SwitchCasesInfo switchCasesInfo(SwitchCases node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SwitchCasesInfo result);
    return result;
}

shared
SwitchClauseInfo switchClauseInfo(SwitchClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is SwitchClauseInfo result);
    return result;
}

shared
ThenOperationInfo thenOperationInfo(ThenOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ThenOperationInfo result);
    return result;
}

shared
ThisInfo thisInfo(This node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ThisInfo result);
    return result;
}

shared
ThrowInfo throwInfo(Throw node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ThrowInfo result);
    return result;
}

shared
TryCatchFinallyInfo tryCatchFinallyInfo(TryCatchFinally node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TryCatchFinallyInfo result);
    return result;
}

shared
TryClauseInfo tryClauseInfo(TryClause node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TryClauseInfo result);
    return result;
}

shared
TupleInfo tupleInfo(Tuple node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TupleInfo result);
    return result;
}

shared
TuplePatternInfo tuplePatternInfo(TuplePattern node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TuplePatternInfo result);
    return result;
}

shared
TupleTypeInfo tupleTypeInfo(TupleType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TupleTypeInfo result);
    return result;
}

shared
TypeInfo typeInfo(Type node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeInfo result);
    return result;
}

shared
TypeAliasDefinitionInfo typeAliasDefinitionInfo(TypeAliasDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeAliasDefinitionInfo result);
    return result;
}

shared
TypeArgumentInfo typeArgumentInfo(TypeArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeArgumentInfo result);
    return result;
}

shared
TypeArgumentsInfo typeArgumentsInfo(TypeArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeArgumentsInfo result);
    return result;
}

shared
TypeConstraintInfo typeConstraintInfo(TypeConstraint node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeConstraintInfo result);
    return result;
}

shared
TypeDecInfo typeDecInfo(TypeDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeDecInfo result);
    return result;
}

shared
TypeDeclarationInfo typeDeclarationInfo(TypeDeclaration node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeDeclarationInfo result);
    return result;
}

shared
TypeIshInfo typeIshInfo(TypeIsh node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeIshInfo result);
    return result;
}

shared
TypeListInfo typeListInfo(TypeList node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeListInfo result);
    return result;
}

shared
TypeMetaInfo typeMetaInfo(TypeMeta node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeMetaInfo result);
    return result;
}

shared
TypeModifierInfo typeModifierInfo(TypeModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeModifierInfo result);
    return result;
}

shared
TypeNameWithTypeArgumentsInfo typeNameWithTypeArgumentsInfo(TypeNameWithTypeArguments node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeNameWithTypeArgumentsInfo result);
    return result;
}

shared
TypeParameterInfo typeParameterInfo(TypeParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeParameterInfo result);
    return result;
}

shared
TypeParametersInfo typeParametersInfo(TypeParameters node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeParametersInfo result);
    return result;
}

shared
TypeSpecifierInfo typeSpecifierInfo(TypeSpecifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypeSpecifierInfo result);
    return result;
}

shared
TypedDeclarationInfo typedDeclarationInfo(TypedDeclaration node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypedDeclarationInfo result);
    return result;
}

shared
TypedVariableInfo typedVariableInfo(TypedVariable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is TypedVariableInfo result);
    return result;
}

shared
UIdentifierInfo uIdentifierInfo(UIdentifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UIdentifierInfo result);
    return result;
}

shared
UnaryArithmeticOperationInfo unaryArithmeticOperationInfo(UnaryArithmeticOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnaryArithmeticOperationInfo result);
    return result;
}

shared
UnaryIshOperationInfo unaryIshOperationInfo(UnaryIshOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnaryIshOperationInfo result);
    return result;
}

shared
UnaryOperationInfo unaryOperationInfo(UnaryOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnaryOperationInfo result);
    return result;
}

shared
UnaryTypeOperationInfo unaryTypeOperationInfo(UnaryTypeOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnaryTypeOperationInfo result);
    return result;
}

shared
UnionAssignmentOperationInfo unionAssignmentOperationInfo(UnionAssignmentOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnionAssignmentOperationInfo result);
    return result;
}

shared
UnionOperationInfo unionOperationInfo(UnionOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnionOperationInfo result);
    return result;
}

shared
UnionTypeInfo unionTypeInfo(UnionType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnionTypeInfo result);
    return result;
}

shared
UnionableTypeInfo unionableTypeInfo(UnionableType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnionableTypeInfo result);
    return result;
}

shared
UnspecifiedVariableInfo unspecifiedVariableInfo(UnspecifiedVariable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is UnspecifiedVariableInfo result);
    return result;
}

shared
ValueArgumentInfo valueArgumentInfo(ValueArgument node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueArgumentInfo result);
    return result;
}

shared
ValueConstructorDefinitionInfo valueConstructorDefinitionInfo(ValueConstructorDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueConstructorDefinitionInfo result);
    return result;
}

shared
ValueDecInfo valueDecInfo(ValueDec node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueDecInfo result);
    return result;
}

shared
ValueDeclarationInfo valueDeclarationInfo(ValueDeclaration node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueDeclarationInfo result);
    return result;
}

shared
ValueDefinitionInfo valueDefinitionInfo(ValueDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueDefinitionInfo result);
    return result;
}

shared
ValueExpressionInfo valueExpressionInfo(ValueExpression node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueExpressionInfo result);
    return result;
}

shared
ValueGetterDefinitionInfo valueGetterDefinitionInfo(ValueGetterDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueGetterDefinitionInfo result);
    return result;
}

shared
ValueModifierInfo valueModifierInfo(ValueModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueModifierInfo result);
    return result;
}

shared
ValueParameterInfo valueParameterInfo(ValueParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueParameterInfo result);
    return result;
}

shared
ValueSetterDefinitionInfo valueSetterDefinitionInfo(ValueSetterDefinition node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueSetterDefinitionInfo result);
    return result;
}

shared
ValueSpecificationInfo valueSpecificationInfo(ValueSpecification node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is ValueSpecificationInfo result);
    return result;
}

shared
VariableInfo variableInfo(Variable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VariableInfo result);
    return result;
}

shared
VariablePatternInfo variablePatternInfo(VariablePattern node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VariablePatternInfo result);
    return result;
}

shared
VariadicParameterInfo variadicParameterInfo(VariadicParameter node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VariadicParameterInfo result);
    return result;
}

shared
VariadicTypeInfo variadicTypeInfo(VariadicType node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VariadicTypeInfo result);
    return result;
}

shared
VariadicVariableInfo variadicVariableInfo(VariadicVariable node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VariadicVariableInfo result);
    return result;
}

shared
VarianceInfo varianceInfo(Variance node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VarianceInfo result);
    return result;
}

shared
VoidModifierInfo voidModifierInfo(VoidModifier node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is VoidModifierInfo result);
    return result;
}

shared
WhileInfo whileInfo(While node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is WhileInfo result);
    return result;
}

shared
WithinOperationInfo withinOperationInfo(WithinOperation node) {
    value result = node.data else (node.data = wrapNode(node));
    assert (is WithinOperationInfo result);
    return result;
}
