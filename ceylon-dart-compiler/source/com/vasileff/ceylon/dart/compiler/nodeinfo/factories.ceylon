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
    ImportElement,
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
    ImportAlias,
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
import com.vasileff.ceylon.dart.compiler.core {
    NodeData
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node
}

TcNode getTcNode(Node astNode) {
    assert (is NodeData data = astNode.data);
    return data.tcNode;
}

shared
SpreadArgumentInfo | ComprehensionInfo sequenceArgumentInfo
        (SpreadArgument | Comprehension astNode)
    =>  switch (astNode)
        case (is SpreadArgument) spreadArgumentInfo(astNode)
        case (is Comprehension) comprehensionInfo(astNode);

shared
NodeInfo nodeInfo(Node node) {
    assert (is NodeData data = node.data);
    if (exists info = data.info) {
        return info;
    }
    value info = wrapNode(node);
    node.data = NodeData(info, data.tcNode);
    return info;
}

shared
AddAssignmentOperationInfo addAssignmentOperationInfo(AddAssignmentOperation node) {
    assert (is AddAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
AliasDecInfo aliasDecInfo(AliasDec node) {
    assert (is AliasDecInfo result = nodeInfo(node));
    return result;
}

shared
AndAssignmentOperationInfo andAssignmentOperationInfo(AndAssignmentOperation node) {
    assert (is AndAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
AndOperationInfo andOperationInfo(AndOperation node) {
    assert (is AndOperationInfo result = nodeInfo(node));
    return result;
}

shared
AnnotationInfo annotationInfo(Annotation node) {
    assert (is AnnotationInfo result = nodeInfo(node));
    return result;
}

shared
AnnotationsInfo annotationsInfo(Annotations node) {
    assert (is AnnotationsInfo result = nodeInfo(node));
    return result;
}

shared
AnonymousArgumentInfo anonymousArgumentInfo(AnonymousArgument node) {
    assert (is AnonymousArgumentInfo result = nodeInfo(node));
    return result;
}

shared
AnyClassInfo anyClassInfo(AnyClass node) {
    assert (is AnyClassInfo result = nodeInfo(node));
    return result;
}

shared
AnyCompilationUnitInfo anyCompilationUnitInfo(AnyCompilationUnit node) {
    assert (is AnyCompilationUnitInfo result = nodeInfo(node));
    return result;
}

shared
AnyFunctionInfo anyFunctionInfo(AnyFunction node) {
    assert (is AnyFunctionInfo result = nodeInfo(node));
    return result;
}

shared
AnyInterfaceInfo anyInterfaceInfo(AnyInterface node) {
    assert (is AnyInterfaceInfo result = nodeInfo(node));
    return result;
}

shared
AnyInterfaceDefinitionInfo anyInterfaceDefinitionInfo(AnyInterfaceDefinition node) {
    assert (is AnyInterfaceDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
AnyMemberOperatorInfo anyMemberOperatorInfo(AnyMemberOperator node) {
    assert (is AnyMemberOperatorInfo result = nodeInfo(node));
    return result;
}

shared
AnySpecifierInfo anySpecifierInfo(AnySpecifier node) {
    assert (is AnySpecifierInfo result = nodeInfo(node));
    return result;
}

shared
AnyValueInfo anyValueInfo(AnyValue node) {
    assert (is AnyValueInfo result = nodeInfo(node));
    return result;
}

shared
ArgumentListInfo argumentListInfo(ArgumentList node) {
    assert (is ArgumentListInfo result = nodeInfo(node));
    return result;
}

shared
ArgumentsInfo argumentsInfo(Arguments node) {
    assert (is ArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
ArithmeticAssignmentOperationInfo arithmeticAssignmentOperationInfo(ArithmeticAssignmentOperation node) {
    assert (is ArithmeticAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
ArithmeticOperationInfo arithmeticOperationInfo(ArithmeticOperation node) {
    assert (is ArithmeticOperationInfo result = nodeInfo(node));
    return result;
}

shared
AssertionInfo assertionInfo(Assertion node) {
    assert (is AssertionInfo result = nodeInfo(node));
    return result;
}

shared
AssignOperationInfo assignOperationInfo(AssignOperation node) {
    assert (is AssignOperationInfo result = nodeInfo(node));
    return result;
}

shared
AssignmentOperationInfo assignmentOperationInfo(AssignmentOperation node) {
    assert (is AssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
AssignmentStatementInfo assignmentStatementInfo(AssignmentStatement node) {
    assert (is AssignmentStatementInfo result = nodeInfo(node));
    return result;
}

shared
AtomInfo atomInfo(Atom node) {
    assert (is AtomInfo result = nodeInfo(node));
    return result;
}

shared
BaseExpressionInfo baseExpressionInfo(BaseExpression node) {
    assert (is BaseExpressionInfo result = nodeInfo(node));
    return result;
}

shared
BaseMetaInfo baseMetaInfo(BaseMeta node) {
    assert (is BaseMetaInfo result = nodeInfo(node));
    return result;
}

shared
BaseTypeInfo baseTypeInfo(BaseType node) {
    assert (is BaseTypeInfo result = nodeInfo(node));
    return result;
}

shared
BinaryOperationInfo binaryOperationInfo(BinaryOperation node) {
    assert (is BinaryOperationInfo result = nodeInfo(node));
    return result;
}

shared
BlockInfo blockInfo(Block node) {
    assert (is BlockInfo result = nodeInfo(node));
    return result;
}

shared
BodyInfo bodyInfo(Body node) {
    assert (is BodyInfo result = nodeInfo(node));
    return result;
}

shared
BooleanConditionInfo booleanConditionInfo(BooleanCondition node) {
    assert (is BooleanConditionInfo result = nodeInfo(node));
    return result;
}

shared
BoundInfo boundInfo(Bound node) {
    assert (is BoundInfo result = nodeInfo(node));
    return result;
}

shared
BreakInfo breakInfo(Break node) {
    assert (is BreakInfo result = nodeInfo(node));
    return result;
}

shared
CallableConstructorDefinitionInfo callableConstructorDefinitionInfo(CallableConstructorDefinition node) {
    assert (is CallableConstructorDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
CallableParameterInfo callableParameterInfo(CallableParameter node) {
    assert (is CallableParameterInfo result = nodeInfo(node));
    return result;
}

shared
CallableTypeInfo callableTypeInfo(CallableType node) {
    assert (is CallableTypeInfo result = nodeInfo(node));
    return result;
}

shared
CaseClauseInfo caseClauseInfo(CaseClause node) {
    assert (is CaseClauseInfo result = nodeInfo(node));
    return result;
}

shared
CaseExpressionInfo caseExpressionInfo(CaseExpression node) {
    assert (is CaseExpressionInfo result = nodeInfo(node));
    return result;
}

shared
CaseItemInfo caseItemInfo(CaseItem node) {
    assert (is CaseItemInfo result = nodeInfo(node));
    return result;
}

shared
CaseTypesInfo caseTypesInfo(CaseTypes node) {
    assert (is CaseTypesInfo result = nodeInfo(node));
    return result;
}

shared
CatchClauseInfo catchClauseInfo(CatchClause node) {
    assert (is CatchClauseInfo result = nodeInfo(node));
    return result;
}

shared
CharacterLiteralInfo characterLiteralInfo(CharacterLiteral node) {
    assert (is CharacterLiteralInfo result = nodeInfo(node));
    return result;
}

shared
ClassAliasDefinitionInfo classAliasDefinitionInfo(ClassAliasDefinition node) {
    assert (is ClassAliasDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ClassBodyInfo classBodyInfo(ClassBody node) {
    assert (is ClassBodyInfo result = nodeInfo(node));
    return result;
}

shared
ClassDecInfo classDecInfo(ClassDec node) {
    assert (is ClassDecInfo result = nodeInfo(node));
    return result;
}

shared
ClassDefinitionInfo classDefinitionInfo(ClassDefinition node) {
    assert (is ClassDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ClassOrInterfaceInfo classOrInterfaceInfo(ClassOrInterface node) {
    assert (is ClassOrInterfaceInfo result = nodeInfo(node));
    return result;
}

shared
ClassSpecifierInfo classSpecifierInfo(ClassSpecifier node) {
    assert (is ClassSpecifierInfo result = nodeInfo(node));
    return result;
}

shared
ClosedBoundInfo closedBoundInfo(ClosedBound node) {
    assert (is ClosedBoundInfo result = nodeInfo(node));
    return result;
}

shared
CompareOperationInfo compareOperationInfo(CompareOperation node) {
    assert (is CompareOperationInfo result = nodeInfo(node));
    return result;
}

shared
ComparisonOperationInfo comparisonOperationInfo(ComparisonOperation node) {
    assert (is ComparisonOperationInfo result = nodeInfo(node));
    return result;
}

shared
CompilationUnitInfo compilationUnitInfo(CompilationUnit node) {
    assert (is CompilationUnitInfo result = nodeInfo(node));
    return result;
}

shared
ComplementAssignmentOperationInfo complementAssignmentOperationInfo(ComplementAssignmentOperation node) {
    assert (is ComplementAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
ComplementOperationInfo complementOperationInfo(ComplementOperation node) {
    assert (is ComplementOperationInfo result = nodeInfo(node));
    return result;
}

shared
ComprehensionInfo comprehensionInfo(Comprehension node) {
    assert (is ComprehensionInfo result = nodeInfo(node));
    return result;
}

shared
ComprehensionClauseInfo comprehensionClauseInfo(ComprehensionClause node) {
    assert (is ComprehensionClauseInfo result = nodeInfo(node));
    return result;
}

shared
ConditionInfo conditionInfo(Condition node) {
    assert (is ConditionInfo result = nodeInfo(node));
    return result;
}

shared
ConditionalExpressionInfo conditionalExpressionInfo(ConditionalExpression node) {
    assert (is ConditionalExpressionInfo result = nodeInfo(node));
    return result;
}

shared
ConditionsInfo conditionsInfo(Conditions node) {
    assert (is ConditionsInfo result = nodeInfo(node));
    return result;
}

shared
ConstructionInfo constructionInfo(Construction node) {
    assert (is ConstructionInfo result = nodeInfo(node));
    return result;
}

shared
ConstructorDecInfo constructorDecInfo(ConstructorDec node) {
    assert (is ConstructorDecInfo result = nodeInfo(node));
    return result;
}

shared
ConstructorDefinitionInfo constructorDefinitionInfo(ConstructorDefinition node) {
    assert (is ConstructorDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ContinueInfo continueInfo(Continue node) {
    assert (is ContinueInfo result = nodeInfo(node));
    return result;
}

shared
ControlStructureInfo controlStructureInfo(ControlStructure node) {
    assert (is ControlStructureInfo result = nodeInfo(node));
    return result;
}

shared
DecInfo decInfo(Dec node) {
    assert (is DecInfo result = nodeInfo(node));
    return result;
}

shared
DecQualifierInfo decQualifierInfo(DecQualifier node) {
    assert (is DecQualifierInfo result = nodeInfo(node));
    return result;
}

shared
DeclarationInfo declarationInfo(Declaration node) {
    assert (is DeclarationInfo result = nodeInfo(node));
    return result;
}

shared
DefaultedCallableParameterInfo defaultedCallableParameterInfo(DefaultedCallableParameter node) {
    assert (is DefaultedCallableParameterInfo result = nodeInfo(node));
    return result;
}

shared
DefaultedParameterInfo defaultedParameterInfo(DefaultedParameter node) {
    assert (is DefaultedParameterInfo result = nodeInfo(node));
    return result;
}

shared
DefaultedParameterReferenceInfo defaultedParameterReferenceInfo(DefaultedParameterReference node) {
    assert (is DefaultedParameterReferenceInfo result = nodeInfo(node));
    return result;
}

shared
DefaultedTypeInfo defaultedTypeInfo(DefaultedType node) {
    assert (is DefaultedTypeInfo result = nodeInfo(node));
    return result;
}

shared
DefaultedValueParameterInfo defaultedValueParameterInfo(DefaultedValueParameter node) {
    assert (is DefaultedValueParameterInfo result = nodeInfo(node));
    return result;
}

shared
DestructureInfo destructureInfo(Destructure node) {
    assert (is DestructureInfo result = nodeInfo(node));
    return result;
}

shared
DifferenceOperationInfo differenceOperationInfo(DifferenceOperation node) {
    assert (is DifferenceOperationInfo result = nodeInfo(node));
    return result;
}

shared
DirectiveInfo directiveInfo(Directive node) {
    assert (is DirectiveInfo result = nodeInfo(node));
    return result;
}

shared
DivideAssignmentOperationInfo divideAssignmentOperationInfo(DivideAssignmentOperation node) {
    assert (is DivideAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
DynamicBlockInfo dynamicBlockInfo(DynamicBlock node) {
    assert (is DynamicBlockInfo result = nodeInfo(node));
    return result;
}

shared
DynamicInterfaceDefinitionInfo dynamicInterfaceDefinitionInfo(DynamicInterfaceDefinition node) {
    assert (is DynamicInterfaceDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
DynamicModifierInfo dynamicModifierInfo(DynamicModifier node) {
    assert (is DynamicModifierInfo result = nodeInfo(node));
    return result;
}

shared
DynamicValueInfo dynamicValueInfo(DynamicValue node) {
    assert (is DynamicValueInfo result = nodeInfo(node));
    return result;
}

shared
ElementOrSubrangeExpressionInfo elementOrSubrangeExpressionInfo(ElementOrSubrangeExpression node) {
    assert (is ElementOrSubrangeExpressionInfo result = nodeInfo(node));
    return result;
}

shared
ElseClauseInfo elseClauseInfo(ElseClause node) {
    assert (is ElseClauseInfo result = nodeInfo(node));
    return result;
}

shared
ElseOperationInfo elseOperationInfo(ElseOperation node) {
    assert (is ElseOperationInfo result = nodeInfo(node));
    return result;
}

shared
EntryOperationInfo entryOperationInfo(EntryOperation node) {
    assert (is EntryOperationInfo result = nodeInfo(node));
    return result;
}

shared
EntryPatternInfo entryPatternInfo(EntryPattern node) {
    assert (is EntryPatternInfo result = nodeInfo(node));
    return result;
}

shared
EntryTypeInfo entryTypeInfo(EntryType node) {
    assert (is EntryTypeInfo result = nodeInfo(node));
    return result;
}

shared
EqualOperationInfo equalOperationInfo(EqualOperation node) {
    assert (is EqualOperationInfo result = nodeInfo(node));
    return result;
}

shared
EqualityOperationInfo equalityOperationInfo(EqualityOperation node) {
    assert (is EqualityOperationInfo result = nodeInfo(node));
    return result;
}

shared
ExistsConditionInfo existsConditionInfo(ExistsCondition node) {
    assert (is ExistsConditionInfo result = nodeInfo(node));
    return result;
}

shared
ExistsOperationInfo existsOperationInfo(ExistsOperation node) {
    assert (is ExistsOperationInfo result = nodeInfo(node));
    return result;
}

shared
ExistsOrNonemptyConditionInfo existsOrNonemptyConditionInfo(ExistsOrNonemptyCondition node) {
    assert (is ExistsOrNonemptyConditionInfo result = nodeInfo(node));
    return result;
}

shared
ExponentiationOperationInfo exponentiationOperationInfo(ExponentiationOperation node) {
    assert (is ExponentiationOperationInfo result = nodeInfo(node));
    return result;
}

shared
ExpressionInfo expressionInfo(Expression node) {
    assert (is ExpressionInfo result = nodeInfo(node));
    return result;
}

shared
ExpressionComprehensionClauseInfo expressionComprehensionClauseInfo(ExpressionComprehensionClause node) {
    assert (is ExpressionComprehensionClauseInfo result = nodeInfo(node));
    return result;
}

shared
ExpressionStatementInfo expressionStatementInfo(ExpressionStatement node) {
    assert (is ExpressionStatementInfo result = nodeInfo(node));
    return result;
}

shared
ExtendedTypeInfo extendedTypeInfo(ExtendedType node) {
    assert (is ExtendedTypeInfo result = nodeInfo(node));
    return result;
}

shared
ExtensionInfo extensionInfo(Extension node) {
    assert (is ExtensionInfo result = nodeInfo(node));
    return result;
}

shared
ExtensionOrConstructionInfo extensionOrConstructionInfo(ExtensionOrConstruction node) {
    assert (is ExtensionOrConstructionInfo result = nodeInfo(node));
    return result;
}

shared
FailClauseInfo failClauseInfo(FailClause node) {
    assert (is FailClauseInfo result = nodeInfo(node));
    return result;
}

shared
FinallyClauseInfo finallyClauseInfo(FinallyClause node) {
    assert (is FinallyClauseInfo result = nodeInfo(node));
    return result;
}

shared
FloatLiteralInfo floatLiteralInfo(FloatLiteral node) {
    assert (is FloatLiteralInfo result = nodeInfo(node));
    return result;
}

shared
ForClauseInfo forClauseInfo(ForClause node) {
    assert (is ForClauseInfo result = nodeInfo(node));
    return result;
}

shared
ForComprehensionClauseInfo forComprehensionClauseInfo(ForComprehensionClause node) {
    assert (is ForComprehensionClauseInfo result = nodeInfo(node));
    return result;
}

shared
ForFailInfo forFailInfo(ForFail node) {
    assert (is ForFailInfo result = nodeInfo(node));
    return result;
}

shared
ForIteratorInfo forIteratorInfo(ForIterator node) {
    assert (is ForIteratorInfo result = nodeInfo(node));
    return result;
}

shared
FullPackageNameInfo fullPackageNameInfo(FullPackageName node) {
    assert (is FullPackageNameInfo result = nodeInfo(node));
    return result;
}

shared
FunctionArgumentInfo functionArgumentInfo(FunctionArgument node) {
    assert (is FunctionArgumentInfo result = nodeInfo(node));
    return result;
}

shared
FunctionDecInfo functionDecInfo(FunctionDec node) {
    assert (is FunctionDecInfo result = nodeInfo(node));
    return result;
}

shared
FunctionDeclarationInfo functionDeclarationInfo(FunctionDeclaration node) {
    assert (is FunctionDeclarationInfo result = nodeInfo(node));
    return result;
}

shared
FunctionDefinitionInfo functionDefinitionInfo(FunctionDefinition node) {
    assert (is FunctionDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
FunctionExpressionInfo functionExpressionInfo(FunctionExpression node) {
    assert (is FunctionExpressionInfo result = nodeInfo(node));
    return result;
}

shared
FunctionModifierInfo functionModifierInfo(FunctionModifier node) {
    assert (is FunctionModifierInfo result = nodeInfo(node));
    return result;
}

shared
FunctionShortcutDefinitionInfo functionShortcutDefinitionInfo(FunctionShortcutDefinition node) {
    assert (is FunctionShortcutDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
GivenDecInfo givenDecInfo(GivenDec node) {
    assert (is GivenDecInfo result = nodeInfo(node));
    return result;
}

shared
GroupedExpressionInfo groupedExpressionInfo(GroupedExpression node) {
    assert (is GroupedExpressionInfo result = nodeInfo(node));
    return result;
}

shared
GroupedTypeInfo groupedTypeInfo(GroupedType node) {
    assert (is GroupedTypeInfo result = nodeInfo(node));
    return result;
}

shared
IdenticalOperationInfo identicalOperationInfo(IdenticalOperation node) {
    assert (is IdenticalOperationInfo result = nodeInfo(node));
    return result;
}

shared
IdentifierInfo identifierInfo(Identifier node) {
    assert (is IdentifierInfo result = nodeInfo(node));
    return result;
}

shared
IdentityOperationInfo identityOperationInfo(IdentityOperation node) {
    assert (is IdentityOperationInfo result = nodeInfo(node));
    return result;
}

shared
IfClauseInfo ifClauseInfo(IfClause node) {
    assert (is IfClauseInfo result = nodeInfo(node));
    return result;
}

shared
IfComprehensionClauseInfo ifComprehensionClauseInfo(IfComprehensionClause node) {
    assert (is IfComprehensionClauseInfo result = nodeInfo(node));
    return result;
}

shared
IfElseInfo ifElseInfo(IfElse node) {
    assert (is IfElseInfo result = nodeInfo(node));
    return result;
}

shared
IfElseExpressionInfo ifElseExpressionInfo(IfElseExpression node) {
    assert (is IfElseExpressionInfo result = nodeInfo(node));
    return result;
}

shared
ImportInfo importInfo(Import node) {
    assert (is ImportInfo result = nodeInfo(node));
    return result;
}

shared
ImportAliasInfo importAliasInfo(ImportAlias node) {
    assert (is ImportAliasInfo result = nodeInfo(node));
    return result;
}

shared
ImportElementInfo importElementInfo(ImportElement node) {
    assert (is ImportElementInfo result = nodeInfo(node));
    return result;
}

shared
ImportElementsInfo importElementsInfo(ImportElements node) {
    assert (is ImportElementsInfo result = nodeInfo(node));
    return result;
}

shared
ImportWildcardInfo importWildcardInfo(ImportWildcard node) {
    assert (is ImportWildcardInfo result = nodeInfo(node));
    return result;
}

shared
InModifierInfo inModifierInfo(InModifier node) {
    assert (is InModifierInfo result = nodeInfo(node));
    return result;
}

shared
InOperationInfo inOperationInfo(InOperation node) {
    assert (is InOperationInfo result = nodeInfo(node));
    return result;
}

shared
InitialComprehensionClauseInfo initialComprehensionClauseInfo(InitialComprehensionClause node) {
    assert (is InitialComprehensionClauseInfo result = nodeInfo(node));
    return result;
}

shared
InlineDefinitionArgumentInfo inlineDefinitionArgumentInfo(InlineDefinitionArgument node) {
    assert (is InlineDefinitionArgumentInfo result = nodeInfo(node));
    return result;
}

shared
IntegerLiteralInfo integerLiteralInfo(IntegerLiteral node) {
    assert (is IntegerLiteralInfo result = nodeInfo(node));
    return result;
}

shared
InterfaceAliasDefinitionInfo interfaceAliasDefinitionInfo(InterfaceAliasDefinition node) {
    assert (is InterfaceAliasDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
InterfaceBodyInfo interfaceBodyInfo(InterfaceBody node) {
    assert (is InterfaceBodyInfo result = nodeInfo(node));
    return result;
}

shared
InterfaceDecInfo interfaceDecInfo(InterfaceDec node) {
    assert (is InterfaceDecInfo result = nodeInfo(node));
    return result;
}

shared
InterfaceDefinitionInfo interfaceDefinitionInfo(InterfaceDefinition node) {
    assert (is InterfaceDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
IntersectAssignmentOperationInfo intersectAssignmentOperationInfo(IntersectAssignmentOperation node) {
    assert (is IntersectAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
IntersectionOperationInfo intersectionOperationInfo(IntersectionOperation node) {
    assert (is IntersectionOperationInfo result = nodeInfo(node));
    return result;
}

shared
IntersectionTypeInfo intersectionTypeInfo(IntersectionType node) {
    assert (is IntersectionTypeInfo result = nodeInfo(node));
    return result;
}

shared
InvocationInfo invocationInfo(Invocation node) {
    assert (is InvocationInfo result = nodeInfo(node));
    return result;
}

shared
InvocationStatementInfo invocationStatementInfo(InvocationStatement node) {
    assert (is InvocationStatementInfo result = nodeInfo(node));
    return result;
}

shared
IsCaseInfo isCaseInfo(IsCase node) {
    assert (is IsCaseInfo result = nodeInfo(node));
    return result;
}

shared
IsConditionInfo isConditionInfo(IsCondition node) {
    assert (is IsConditionInfo result = nodeInfo(node));
    return result;
}

shared
IsOperationInfo isOperationInfo(IsOperation node) {
    assert (is IsOperationInfo result = nodeInfo(node));
    return result;
}

shared
IterableInfo iterableInfo(Iterable node) {
    assert (is IterableInfo result = nodeInfo(node));
    return result;
}

shared
IterableTypeInfo iterableTypeInfo(IterableType node) {
    assert (is IterableTypeInfo result = nodeInfo(node));
    return result;
}

shared
KeySubscriptInfo keySubscriptInfo(KeySubscript node) {
    assert (is KeySubscriptInfo result = nodeInfo(node));
    return result;
}

shared
LIdentifierInfo lIdentifierInfo(LIdentifier node) {
    assert (is LIdentifierInfo result = nodeInfo(node));
    return result;
}

shared
LargeAsOperationInfo largeAsOperationInfo(LargeAsOperation node) {
    assert (is LargeAsOperationInfo result = nodeInfo(node));
    return result;
}

shared
LargerOperationInfo largerOperationInfo(LargerOperation node) {
    assert (is LargerOperationInfo result = nodeInfo(node));
    return result;
}

shared
LazySpecificationInfo lazySpecificationInfo(LazySpecification node) {
    assert (is LazySpecificationInfo result = nodeInfo(node));
    return result;
}

shared
LazySpecifierInfo lazySpecifierInfo(LazySpecifier node) {
    assert (is LazySpecifierInfo result = nodeInfo(node));
    return result;
}

shared
LetExpressionInfo letExpressionInfo(LetExpression node) {
    assert (is LetExpressionInfo result = nodeInfo(node));
    return result;
}

shared
LiteralInfo literalInfo(Literal node) {
    assert (is LiteralInfo result = nodeInfo(node));
    return result;
}

shared
LocalModifierInfo localModifierInfo(LocalModifier node) {
    assert (is LocalModifierInfo result = nodeInfo(node));
    return result;
}

shared
LogicalAssignmentOperationInfo logicalAssignmentOperationInfo(LogicalAssignmentOperation node) {
    assert (is LogicalAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
LogicalOperationInfo logicalOperationInfo(LogicalOperation node) {
    assert (is LogicalOperationInfo result = nodeInfo(node));
    return result;
}

shared
MainTypeInfo mainTypeInfo(MainType node) {
    assert (is MainTypeInfo result = nodeInfo(node));
    return result;
}

shared
MatchCaseInfo matchCaseInfo(MatchCase node) {
    assert (is MatchCaseInfo result = nodeInfo(node));
    return result;
}

shared
MeasureOperationInfo measureOperationInfo(MeasureOperation node) {
    assert (is MeasureOperationInfo result = nodeInfo(node));
    return result;
}

shared
MeasureSubscriptInfo measureSubscriptInfo(MeasureSubscript node) {
    assert (is MeasureSubscriptInfo result = nodeInfo(node));
    return result;
}

shared
MemberDecInfo memberDecInfo(MemberDec node) {
    assert (is MemberDecInfo result = nodeInfo(node));
    return result;
}

shared
MemberMetaInfo memberMetaInfo(MemberMeta node) {
    assert (is MemberMetaInfo result = nodeInfo(node));
    return result;
}

shared
MemberNameWithTypeArgumentsInfo memberNameWithTypeArgumentsInfo(MemberNameWithTypeArguments node) {
    assert (is MemberNameWithTypeArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
MemberOperatorInfo memberOperatorInfo(MemberOperator node) {
    assert (is MemberOperatorInfo result = nodeInfo(node));
    return result;
}

shared
MetaInfo metaInfo(Meta node) {
    assert (is MetaInfo result = nodeInfo(node));
    return result;
}

shared
ModifierInfo modifierInfo(Modifier node) {
    assert (is ModifierInfo result = nodeInfo(node));
    return result;
}

shared
ModuleBodyInfo moduleBodyInfo(ModuleBody node) {
    assert (is ModuleBodyInfo result = nodeInfo(node));
    return result;
}

shared
ModuleCompilationUnitInfo moduleCompilationUnitInfo(ModuleCompilationUnit node) {
    assert (is ModuleCompilationUnitInfo result = nodeInfo(node));
    return result;
}

shared
ModuleDecInfo moduleDecInfo(ModuleDec node) {
    assert (is ModuleDecInfo result = nodeInfo(node));
    return result;
}

shared
ModuleDescriptorInfo moduleDescriptorInfo(ModuleDescriptor node) {
    assert (is ModuleDescriptorInfo result = nodeInfo(node));
    return result;
}

shared
ModuleImportInfo moduleImportInfo(ModuleImport node) {
    assert (is ModuleImportInfo result = nodeInfo(node));
    return result;
}

shared
MultiplyAssignmentOperationInfo multiplyAssignmentOperationInfo(MultiplyAssignmentOperation node) {
    assert (is MultiplyAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
NameWithTypeArgumentsInfo nameWithTypeArgumentsInfo(NameWithTypeArguments node) {
    assert (is NameWithTypeArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
NamedArgumentInfo namedArgumentInfo(NamedArgument node) {
    assert (is NamedArgumentInfo result = nodeInfo(node));
    return result;
}

shared
NamedArgumentsInfo namedArgumentsInfo(NamedArguments node) {
    assert (is NamedArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
NegationOperationInfo negationOperationInfo(NegationOperation node) {
    assert (is NegationOperationInfo result = nodeInfo(node));
    return result;
}

shared
NonemptyConditionInfo nonemptyConditionInfo(NonemptyCondition node) {
    assert (is NonemptyConditionInfo result = nodeInfo(node));
    return result;
}

shared
NonemptyOperationInfo nonemptyOperationInfo(NonemptyOperation node) {
    assert (is NonemptyOperationInfo result = nodeInfo(node));
    return result;
}

shared
NotEqualOperationInfo notEqualOperationInfo(NotEqualOperation node) {
    assert (is NotEqualOperationInfo result = nodeInfo(node));
    return result;
}

shared
NotOperationInfo notOperationInfo(NotOperation node) {
    assert (is NotOperationInfo result = nodeInfo(node));
    return result;
}

shared
ObjectArgumentInfo objectArgumentInfo(ObjectArgument node) {
    assert (is ObjectArgumentInfo result = nodeInfo(node));
    return result;
}

shared
ObjectDefinitionInfo objectDefinitionInfo(ObjectDefinition node) {
    assert (is ObjectDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ObjectExpressionInfo objectExpressionInfo(ObjectExpression node) {
    assert (is ObjectExpressionInfo result = nodeInfo(node));
    return result;
}

shared
OfOperationInfo ofOperationInfo(OfOperation node) {
    assert (is OfOperationInfo result = nodeInfo(node));
    return result;
}

shared
OpenBoundInfo openBoundInfo(OpenBound node) {
    assert (is OpenBoundInfo result = nodeInfo(node));
    return result;
}

shared
OperationInfo operationInfo(Operation node) {
    assert (is OperationInfo result = nodeInfo(node));
    return result;
}

shared
OptionalTypeInfo optionalTypeInfo(OptionalType node) {
    assert (is OptionalTypeInfo result = nodeInfo(node));
    return result;
}

shared
OrAssignmentOperationInfo orAssignmentOperationInfo(OrAssignmentOperation node) {
    assert (is OrAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
OrOperationInfo orOperationInfo(OrOperation node) {
    assert (is OrOperationInfo result = nodeInfo(node));
    return result;
}

shared
OutModifierInfo outModifierInfo(OutModifier node) {
    assert (is OutModifierInfo result = nodeInfo(node));
    return result;
}

shared
OuterInfo outerInfo(Outer node) {
    assert (is OuterInfo result = nodeInfo(node));
    return result;
}

shared
PackageInfo packageInfo(Package node) {
    assert (is PackageInfo result = nodeInfo(node));
    return result;
}

shared
PackageCompilationUnitInfo packageCompilationUnitInfo(PackageCompilationUnit node) {
    assert (is PackageCompilationUnitInfo result = nodeInfo(node));
    return result;
}

shared
PackageDecInfo packageDecInfo(PackageDec node) {
    assert (is PackageDecInfo result = nodeInfo(node));
    return result;
}

shared
PackageDescriptorInfo packageDescriptorInfo(PackageDescriptor node) {
    assert (is PackageDescriptorInfo result = nodeInfo(node));
    return result;
}

shared
PackageQualifierInfo packageQualifierInfo(PackageQualifier node) {
    assert (is PackageQualifierInfo result = nodeInfo(node));
    return result;
}

shared
ParameterInfo parameterInfo(Parameter node) {
    assert (is ParameterInfo result = nodeInfo(node));
    return result;
}

shared
ParameterReferenceInfo parameterReferenceInfo(ParameterReference node) {
    assert (is ParameterReferenceInfo result = nodeInfo(node));
    return result;
}

shared
ParametersInfo parametersInfo(Parameters node) {
    assert (is ParametersInfo result = nodeInfo(node));
    return result;
}

shared
PatternInfo patternInfo(Pattern node) {
    assert (is PatternInfo result = nodeInfo(node));
    return result;
}

shared
PatternListInfo patternListInfo(PatternList node) {
    assert (is PatternListInfo result = nodeInfo(node));
    return result;
}

shared
PositionalArgumentsInfo positionalArgumentsInfo(PositionalArguments node) {
    assert (is PositionalArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
PostfixDecrementOperationInfo postfixDecrementOperationInfo(PostfixDecrementOperation node) {
    assert (is PostfixDecrementOperationInfo result = nodeInfo(node));
    return result;
}

shared
PostfixIncrementOperationInfo postfixIncrementOperationInfo(PostfixIncrementOperation node) {
    assert (is PostfixIncrementOperationInfo result = nodeInfo(node));
    return result;
}

shared
PostfixOperationInfo postfixOperationInfo(PostfixOperation node) {
    assert (is PostfixOperationInfo result = nodeInfo(node));
    return result;
}

shared
PrefixDecrementOperationInfo prefixDecrementOperationInfo(PrefixDecrementOperation node) {
    assert (is PrefixDecrementOperationInfo result = nodeInfo(node));
    return result;
}

shared
PrefixIncrementOperationInfo prefixIncrementOperationInfo(PrefixIncrementOperation node) {
    assert (is PrefixIncrementOperationInfo result = nodeInfo(node));
    return result;
}

shared
PrefixOperationInfo prefixOperationInfo(PrefixOperation node) {
    assert (is PrefixOperationInfo result = nodeInfo(node));
    return result;
}

shared
PrefixPostfixStatementInfo prefixPostfixStatementInfo(PrefixPostfixStatement node) {
    assert (is PrefixPostfixStatementInfo result = nodeInfo(node));
    return result;
}

shared
PrimaryInfo primaryInfo(Primary node) {
    assert (is PrimaryInfo result = nodeInfo(node));
    return result;
}

shared
PrimaryTypeInfo primaryTypeInfo(PrimaryType node) {
    assert (is PrimaryTypeInfo result = nodeInfo(node));
    return result;
}

shared
ProductOperationInfo productOperationInfo(ProductOperation node) {
    assert (is ProductOperationInfo result = nodeInfo(node));
    return result;
}

shared
QualifiedExpressionInfo qualifiedExpressionInfo(QualifiedExpression node) {
    assert (is QualifiedExpressionInfo result = nodeInfo(node));
    return result;
}

shared
QualifiedTypeInfo qualifiedTypeInfo(QualifiedType node) {
    assert (is QualifiedTypeInfo result = nodeInfo(node));
    return result;
}

shared
QuotientOperationInfo quotientOperationInfo(QuotientOperation node) {
    assert (is QuotientOperationInfo result = nodeInfo(node));
    return result;
}

shared
RangeSubscriptInfo rangeSubscriptInfo(RangeSubscript node) {
    assert (is RangeSubscriptInfo result = nodeInfo(node));
    return result;
}

shared
RemainderAssignmentOperationInfo remainderAssignmentOperationInfo(RemainderAssignmentOperation node) {
    assert (is RemainderAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
RemainderOperationInfo remainderOperationInfo(RemainderOperation node) {
    assert (is RemainderOperationInfo result = nodeInfo(node));
    return result;
}

shared
RequiredParameterInfo requiredParameterInfo(RequiredParameter node) {
    assert (is RequiredParameterInfo result = nodeInfo(node));
    return result;
}

shared
ResourceInfo resourceInfo(Resource node) {
    assert (is ResourceInfo result = nodeInfo(node));
    return result;
}

shared
ResourcesInfo resourcesInfo(Resources node) {
    assert (is ResourcesInfo result = nodeInfo(node));
    return result;
}

shared
ReturnInfo returnInfo(Return node) {
    assert (is ReturnInfo result = nodeInfo(node));
    return result;
}

shared
SafeMemberOperatorInfo safeMemberOperatorInfo(SafeMemberOperator node) {
    assert (is SafeMemberOperatorInfo result = nodeInfo(node));
    return result;
}

shared
SatisfiedTypesInfo satisfiedTypesInfo(SatisfiedTypes node) {
    assert (is SatisfiedTypesInfo result = nodeInfo(node));
    return result;
}

shared
ScaleOperationInfo scaleOperationInfo(ScaleOperation node) {
    assert (is ScaleOperationInfo result = nodeInfo(node));
    return result;
}

shared
SelfReferenceInfo selfReferenceInfo(SelfReference node) {
    assert (is SelfReferenceInfo result = nodeInfo(node));
    return result;
}

shared
SequentialTypeInfo sequentialTypeInfo(SequentialType node) {
    assert (is SequentialTypeInfo result = nodeInfo(node));
    return result;
}

shared
SetAssignmentOperationInfo setAssignmentOperationInfo(SetAssignmentOperation node) {
    assert (is SetAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
SetOperationInfo setOperationInfo(SetOperation node) {
    assert (is SetOperationInfo result = nodeInfo(node));
    return result;
}

shared
SimpleTypeInfo simpleTypeInfo(SimpleType node) {
    assert (is SimpleTypeInfo result = nodeInfo(node));
    return result;
}

shared
SmallAsOperationInfo smallAsOperationInfo(SmallAsOperation node) {
    assert (is SmallAsOperationInfo result = nodeInfo(node));
    return result;
}

shared
SmallerOperationInfo smallerOperationInfo(SmallerOperation node) {
    assert (is SmallerOperationInfo result = nodeInfo(node));
    return result;
}

shared
SpanFromSubscriptInfo spanFromSubscriptInfo(SpanFromSubscript node) {
    assert (is SpanFromSubscriptInfo result = nodeInfo(node));
    return result;
}

shared
SpanOperationInfo spanOperationInfo(SpanOperation node) {
    assert (is SpanOperationInfo result = nodeInfo(node));
    return result;
}

shared
SpanSubscriptInfo spanSubscriptInfo(SpanSubscript node) {
    assert (is SpanSubscriptInfo result = nodeInfo(node));
    return result;
}

shared
SpanToSubscriptInfo spanToSubscriptInfo(SpanToSubscript node) {
    assert (is SpanToSubscriptInfo result = nodeInfo(node));
    return result;
}

shared
SpecificationInfo specificationInfo(Specification node) {
    assert (is SpecificationInfo result = nodeInfo(node));
    return result;
}

shared
SpecifiedArgumentInfo specifiedArgumentInfo(SpecifiedArgument node) {
    assert (is SpecifiedArgumentInfo result = nodeInfo(node));
    return result;
}

shared
SpecifiedPatternInfo specifiedPatternInfo(SpecifiedPattern node) {
    assert (is SpecifiedPatternInfo result = nodeInfo(node));
    return result;
}

shared
SpecifiedVariableInfo specifiedVariableInfo(SpecifiedVariable node) {
    assert (is SpecifiedVariableInfo result = nodeInfo(node));
    return result;
}

shared
SpecifierInfo specifierInfo(Specifier node) {
    assert (is SpecifierInfo result = nodeInfo(node));
    return result;
}

shared
SpreadArgumentInfo spreadArgumentInfo(SpreadArgument node) {
    assert (is SpreadArgumentInfo result = nodeInfo(node));
    return result;
}

shared
SpreadMemberOperatorInfo spreadMemberOperatorInfo(SpreadMemberOperator node) {
    assert (is SpreadMemberOperatorInfo result = nodeInfo(node));
    return result;
}

shared
SpreadTypeInfo spreadTypeInfo(SpreadType node) {
    assert (is SpreadTypeInfo result = nodeInfo(node));
    return result;
}

shared
StatementInfo statementInfo(Statement node) {
    assert (is StatementInfo result = nodeInfo(node));
    return result;
}

shared
StringLiteralInfo stringLiteralInfo(StringLiteral node) {
    assert (is StringLiteralInfo result = nodeInfo(node));
    return result;
}

shared
StringTemplateInfo stringTemplateInfo(StringTemplate node) {
    assert (is StringTemplateInfo result = nodeInfo(node));
    return result;
}

shared
SubscriptInfo subscriptInfo(Subscript node) {
    assert (is SubscriptInfo result = nodeInfo(node));
    return result;
}

shared
SubtractAssignmentOperationInfo subtractAssignmentOperationInfo(SubtractAssignmentOperation node) {
    assert (is SubtractAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
SumOperationInfo sumOperationInfo(SumOperation node) {
    assert (is SumOperationInfo result = nodeInfo(node));
    return result;
}

shared
SuperInfo superInfo(Super node) {
    assert (is SuperInfo result = nodeInfo(node));
    return result;
}

shared
SwitchCaseElseInfo switchCaseElseInfo(SwitchCaseElse node) {
    assert (is SwitchCaseElseInfo result = nodeInfo(node));
    return result;
}

shared
SwitchCaseElseExpressionInfo switchCaseElseExpressionInfo(SwitchCaseElseExpression node) {
    assert (is SwitchCaseElseExpressionInfo result = nodeInfo(node));
    return result;
}

shared
SwitchCasesInfo switchCasesInfo(SwitchCases node) {
    assert (is SwitchCasesInfo result = nodeInfo(node));
    return result;
}

shared
SwitchClauseInfo switchClauseInfo(SwitchClause node) {
    assert (is SwitchClauseInfo result = nodeInfo(node));
    return result;
}

shared
ThenOperationInfo thenOperationInfo(ThenOperation node) {
    assert (is ThenOperationInfo result = nodeInfo(node));
    return result;
}

shared
ThisInfo thisInfo(This node) {
    assert (is ThisInfo result = nodeInfo(node));
    return result;
}

shared
ThrowInfo throwInfo(Throw node) {
    assert (is ThrowInfo result = nodeInfo(node));
    return result;
}

shared
TryCatchFinallyInfo tryCatchFinallyInfo(TryCatchFinally node) {
    assert (is TryCatchFinallyInfo result = nodeInfo(node));
    return result;
}

shared
TryClauseInfo tryClauseInfo(TryClause node) {
    assert (is TryClauseInfo result = nodeInfo(node));
    return result;
}

shared
TupleInfo tupleInfo(Tuple node) {
    assert (is TupleInfo result = nodeInfo(node));
    return result;
}

shared
TuplePatternInfo tuplePatternInfo(TuplePattern node) {
    assert (is TuplePatternInfo result = nodeInfo(node));
    return result;
}

shared
TupleTypeInfo tupleTypeInfo(TupleType node) {
    assert (is TupleTypeInfo result = nodeInfo(node));
    return result;
}

shared
TypeInfo typeInfo(Type node) {
    assert (is TypeInfo result = nodeInfo(node));
    return result;
}

shared
TypeAliasDefinitionInfo typeAliasDefinitionInfo(TypeAliasDefinition node) {
    assert (is TypeAliasDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
TypeArgumentInfo typeArgumentInfo(TypeArgument node) {
    assert (is TypeArgumentInfo result = nodeInfo(node));
    return result;
}

shared
TypeArgumentsInfo typeArgumentsInfo(TypeArguments node) {
    assert (is TypeArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
TypeConstraintInfo typeConstraintInfo(TypeConstraint node) {
    assert (is TypeConstraintInfo result = nodeInfo(node));
    return result;
}

shared
TypeDecInfo typeDecInfo(TypeDec node) {
    assert (is TypeDecInfo result = nodeInfo(node));
    return result;
}

shared
TypeDeclarationInfo typeDeclarationInfo(TypeDeclaration node) {
    assert (is TypeDeclarationInfo result = nodeInfo(node));
    return result;
}

shared
TypeIshInfo typeIshInfo(TypeIsh node) {
    assert (is TypeIshInfo result = nodeInfo(node));
    return result;
}

shared
TypeListInfo typeListInfo(TypeList node) {
    assert (is TypeListInfo result = nodeInfo(node));
    return result;
}

shared
TypeMetaInfo typeMetaInfo(TypeMeta node) {
    assert (is TypeMetaInfo result = nodeInfo(node));
    return result;
}

shared
TypeModifierInfo typeModifierInfo(TypeModifier node) {
    assert (is TypeModifierInfo result = nodeInfo(node));
    return result;
}

shared
TypeNameWithTypeArgumentsInfo typeNameWithTypeArgumentsInfo(TypeNameWithTypeArguments node) {
    assert (is TypeNameWithTypeArgumentsInfo result = nodeInfo(node));
    return result;
}

shared
TypeParameterInfo typeParameterInfo(TypeParameter node) {
    assert (is TypeParameterInfo result = nodeInfo(node));
    return result;
}

shared
TypeParametersInfo typeParametersInfo(TypeParameters node) {
    assert (is TypeParametersInfo result = nodeInfo(node));
    return result;
}

shared
TypeSpecifierInfo typeSpecifierInfo(TypeSpecifier node) {
    assert (is TypeSpecifierInfo result = nodeInfo(node));
    return result;
}

shared
TypedDeclarationInfo typedDeclarationInfo(TypedDeclaration node) {
    assert (is TypedDeclarationInfo result = nodeInfo(node));
    return result;
}

shared
TypedVariableInfo typedVariableInfo(TypedVariable node) {
    assert (is TypedVariableInfo result = nodeInfo(node));
    return result;
}

shared
UIdentifierInfo uIdentifierInfo(UIdentifier node) {
    assert (is UIdentifierInfo result = nodeInfo(node));
    return result;
}

shared
UnaryArithmeticOperationInfo unaryArithmeticOperationInfo(UnaryArithmeticOperation node) {
    assert (is UnaryArithmeticOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnaryIshOperationInfo unaryIshOperationInfo(UnaryIshOperation node) {
    assert (is UnaryIshOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnaryOperationInfo unaryOperationInfo(UnaryOperation node) {
    assert (is UnaryOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnaryTypeOperationInfo unaryTypeOperationInfo(UnaryTypeOperation node) {
    assert (is UnaryTypeOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnionAssignmentOperationInfo unionAssignmentOperationInfo(UnionAssignmentOperation node) {
    assert (is UnionAssignmentOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnionOperationInfo unionOperationInfo(UnionOperation node) {
    assert (is UnionOperationInfo result = nodeInfo(node));
    return result;
}

shared
UnionTypeInfo unionTypeInfo(UnionType node) {
    assert (is UnionTypeInfo result = nodeInfo(node));
    return result;
}

shared
UnionableTypeInfo unionableTypeInfo(UnionableType node) {
    assert (is UnionableTypeInfo result = nodeInfo(node));
    return result;
}

shared
UnspecifiedVariableInfo unspecifiedVariableInfo(UnspecifiedVariable node) {
    assert (is UnspecifiedVariableInfo result = nodeInfo(node));
    return result;
}

shared
ValueArgumentInfo valueArgumentInfo(ValueArgument node) {
    assert (is ValueArgumentInfo result = nodeInfo(node));
    return result;
}

shared
ValueConstructorDefinitionInfo valueConstructorDefinitionInfo(ValueConstructorDefinition node) {
    assert (is ValueConstructorDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ValueDecInfo valueDecInfo(ValueDec node) {
    assert (is ValueDecInfo result = nodeInfo(node));
    return result;
}

shared
ValueDeclarationInfo valueDeclarationInfo(ValueDeclaration node) {
    assert (is ValueDeclarationInfo result = nodeInfo(node));
    return result;
}

shared
ValueDefinitionInfo valueDefinitionInfo(ValueDefinition node) {
    assert (is ValueDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ValueExpressionInfo valueExpressionInfo(ValueExpression node) {
    assert (is ValueExpressionInfo result = nodeInfo(node));
    return result;
}

shared
ValueGetterDefinitionInfo valueGetterDefinitionInfo(ValueGetterDefinition node) {
    assert (is ValueGetterDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ValueModifierInfo valueModifierInfo(ValueModifier node) {
    assert (is ValueModifierInfo result = nodeInfo(node));
    return result;
}

shared
ValueParameterInfo valueParameterInfo(ValueParameter node) {
    assert (is ValueParameterInfo result = nodeInfo(node));
    return result;
}

shared
ValueSetterDefinitionInfo valueSetterDefinitionInfo(ValueSetterDefinition node) {
    assert (is ValueSetterDefinitionInfo result = nodeInfo(node));
    return result;
}

shared
ValueSpecificationInfo valueSpecificationInfo(ValueSpecification node) {
    assert (is ValueSpecificationInfo result = nodeInfo(node));
    return result;
}

shared
VariableInfo variableInfo(Variable node) {
    assert (is VariableInfo result = nodeInfo(node));
    return result;
}

shared
VariablePatternInfo variablePatternInfo(VariablePattern node) {
    assert (is VariablePatternInfo result = nodeInfo(node));
    return result;
}

shared
VariadicParameterInfo variadicParameterInfo(VariadicParameter node) {
    assert (is VariadicParameterInfo result = nodeInfo(node));
    return result;
}

shared
VariadicTypeInfo variadicTypeInfo(VariadicType node) {
    assert (is VariadicTypeInfo result = nodeInfo(node));
    return result;
}

shared
VariadicVariableInfo variadicVariableInfo(VariadicVariable node) {
    assert (is VariadicVariableInfo result = nodeInfo(node));
    return result;
}

shared
VarianceInfo varianceInfo(Variance node) {
    assert (is VarianceInfo result = nodeInfo(node));
    return result;
}

shared
VoidModifierInfo voidModifierInfo(VoidModifier node) {
    assert (is VoidModifierInfo result = nodeInfo(node));
    return result;
}

shared
WhileInfo whileInfo(While node) {
    assert (is WhileInfo result = nodeInfo(node));
    return result;
}

shared
WithinOperationInfo withinOperationInfo(WithinOperation node) {
    assert (is WithinOperationInfo result = nodeInfo(node));
    return result;
}
