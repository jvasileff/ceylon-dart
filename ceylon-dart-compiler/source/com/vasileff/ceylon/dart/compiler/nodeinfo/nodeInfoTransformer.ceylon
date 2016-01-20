import ceylon.ast.core {
    Node,
    ModuleCompilationUnit,
    ExtendedType,
    VoidModifier,
    Package,
    TypeList,
    Annotation,
    SpreadArgument,
    TupleType,
    ClassSpecifier,
    GroupedExpression,
    Annotations,
    PatternList,
    FunctionDefinition,
    DefaultedType,
    UnspecifiedVariable,
    ImportFunctionValueElement,
    PackageDescriptor,
    MemberNameWithTypeArguments,
    InOperation,
    CompilationUnit,
    ComplementAssignmentOperation,
    UnionOperation,
    OutModifier,
    GivenDec,
    SpanSubscript,
    AssignmentStatement,
    SpanOperation,
    InterfaceDec,
    IntersectionType,
    IsOperation,
    MatchCase,
    NonemptyCondition,
    QuotientOperation,
    Invocation,
    VariadicVariable,
    DynamicValue,
    TypeNameWithTypeArguments,
    KeySubscript,
    VariablePattern,
    While,
    UnionAssignmentOperation,
    ImportFunctionValueAlias,
    InterfaceDefinition,
    NonemptyOperation,
    IsCondition,
    FunctionShortcutDefinition,
    ClassDec,
    ExpressionComprehensionClause,
    BaseMeta,
    BaseType,
    PackageQualifier,
    TypeParameters,
    TypeSpecifier,
    DynamicInterfaceDefinition,
    DefaultedValueParameter,
    ComplementOperation,
    Construction,
    StringLiteral,
    TypeConstraint,
    SpecifiedArgument,
    ValueModifier,
    ValueParameter,
    ImportTypeElement,
    PrefixIncrementOperation,
    ValueSetterDefinition,
    IterableType,
    LetExpression,
    IdentityOperation,
    DivideAssignmentOperation,
    PostfixDecrementOperation,
    QualifiedExpression,
    Extension,
    InModifier,
    This,
    BaseExpression,
    ValueArgument,
    SafeMemberOperator,
    InvocationStatement,
    VariadicType,
    CallableType,
    SatisfiedTypes,
    InterfaceBody,
    TypeParameter,
    IsCase,
    OpenBound,
    SequentialType,
    ModuleDec,
    OptionalType,
    OrAssignmentOperation,
    ClassAliasDefinition,
    ElementOrSubrangeExpression,
    EntryPattern,
    LazySpecification,
    GroupedType,
    SmallAsOperation,
    SwitchCaseElseExpression,
    ExistsOperation,
    SmallerOperation,
    Specifier,
    CallableParameter,
    ConstructorDec,
    ExponentiationOperation,
    IntegerLiteral,
    CaseExpression,
    IntersectionOperation,
    IfClause,
    CatchClause,
    Tuple,
    Throw,
    Assertion,
    VariadicParameter,
    FunctionArgument,
    CaseTypes,
    NotOperation,
    ThenOperation,
    CompareOperation,
    IfElseExpression,
    UnionType,
    ScaleOperation,
    MultiplyAssignmentOperation,
    TryCatchFinally,
    RemainderAssignmentOperation,
    SpanToSubscript,
    AssignOperation,
    Conditions,
    EqualOperation,
    ArgumentList,
    ClassBody,
    DefaultedCallableParameter,
    Block,
    IntersectAssignmentOperation,
    SpreadType,
    FinallyClause,
    ElseClause,
    FunctionModifier,
    Destructure,
    DynamicBlock,
    PackageCompilationUnit,
    MemberMeta,
    ParameterReference,
    TuplePattern,
    AndOperation,
    MeasureOperation,
    FloatLiteral,
    MeasureSubscript,
    AnonymousArgument,
    EntryType,
    LazySpecifier,
    Outer,
    ForComprehensionClause,
    DecQualifier,
    ObjectExpression,
    UIdentifier,
    Resource,
    ValueDeclaration,
    DifferenceOperation,
    Iterable,
    PrefixDecrementOperation,
    WithinOperation,
    FunctionExpression,
    SpreadMemberOperator,
    AddAssignmentOperation,
    IfComprehensionClause,
    FullPackageName,
    Import,
    CallableConstructorDefinition,
    SwitchCases,
    LIdentifier,
    OrOperation,
    ImportTypeAlias,
    InterfaceAliasDefinition,
    IdenticalOperation,
    StringTemplate,
    QualifiedType,
    CharacterLiteral,
    ValueConstructorDefinition,
    DynamicModifier,
    SubtractAssignmentOperation,
    NotEqualOperation,
    Break,
    EntryOperation,
    AliasDec,
    SpecifiedPattern,
    ForClause,
    FunctionDeclaration,
    ModuleDescriptor,
    PositionalArguments,
    Continue,
    AndAssignmentOperation,
    Comprehension,
    NamedArguments,
    SumOperation,
    OfOperation,
    ClassDefinition,
    ImportWildcard,
    LargeAsOperation,
    SpecifiedVariable,
    ClosedBound,
    SwitchClause,
    ValueGetterDefinition,
    TypedVariable,
    ElseOperation,
    ImportElements,
    CaseClause,
    ExistsCondition,
    IfElse,
    MemberOperator,
    ModuleBody,
    ObjectArgument,
    FunctionDec,
    RemainderOperation,
    Resources,
    ProductOperation,
    ForFail,
    DefaultedParameterReference,
    NegationOperation,
    PostfixIncrementOperation,
    ValueDec,
    PackageDec,
    TypeMeta,
    TryClause,
    ValueSpecification,
    Super,
    Parameters,
    BooleanCondition,
    ObjectDefinition,
    TypeArguments,
    ValueDefinition,
    TypeAliasDefinition,
    FailClause,
    SwitchCaseElse,
    ModuleImport,
    PrefixPostfixStatement,
    ForIterator,
    Return,
    LargerOperation,
    SpanFromSubscript,
    TypeArgument,
    ImmediateNarrowingTransformer
}

NodeInfo wrapNode(Node node)
    =>  node.transform(nodeInfoTransformer);

object nodeInfoTransformer satisfies ImmediateNarrowingTransformer<NodeInfo> {

    shared actual NodeInfo transformAddAssignmentOperation(AddAssignmentOperation that) => AddAssignmentOperationInfo(that);

    shared actual NodeInfo transformAliasDec(AliasDec that) => AliasDecInfo(that);

    shared actual NodeInfo transformAndAssignmentOperation(AndAssignmentOperation that) => AndAssignmentOperationInfo(that);

    shared actual NodeInfo transformAndOperation(AndOperation that) => AndOperationInfo(that);

    shared actual NodeInfo transformAnnotation(Annotation that) => AnnotationInfo(that);

    shared actual NodeInfo transformAnnotations(Annotations that) => AnnotationsInfo(that);

    shared actual NodeInfo transformAnonymousArgument(AnonymousArgument that) => AnonymousArgumentInfo(that);

    shared actual NodeInfo transformArgumentList(ArgumentList that) => ArgumentListInfo(that);

    shared actual NodeInfo transformAssertion(Assertion that) => AssertionInfo(that);

    shared actual NodeInfo transformAssignOperation(AssignOperation that) => AssignOperationInfo(that);

    shared actual NodeInfo transformAssignmentStatement(AssignmentStatement that) => AssignmentStatementInfo(that);

    shared actual NodeInfo transformBaseExpression(BaseExpression that) => BaseExpressionInfo(that);

    shared actual NodeInfo transformBaseMeta(BaseMeta that) => BaseMetaInfo(that);

    shared actual NodeInfo transformBaseType(BaseType that) => BaseTypeInfo(that);

    shared actual NodeInfo transformBlock(Block that) => BlockInfo(that);

    shared actual NodeInfo transformBooleanCondition(BooleanCondition that) => BooleanConditionInfo(that);

    shared actual NodeInfo transformBreak(Break that) => BreakInfo(that);

    shared actual NodeInfo transformCallableConstructorDefinition(CallableConstructorDefinition that) => CallableConstructorDefinitionInfo(that);

    shared actual NodeInfo transformCallableParameter(CallableParameter that) => CallableParameterInfo(that);

    shared actual NodeInfo transformCallableType(CallableType that) => CallableTypeInfo(that);

    shared actual NodeInfo transformCaseClause(CaseClause that) => CaseClauseInfo(that);

    shared actual NodeInfo transformCaseExpression(CaseExpression that) => CaseExpressionInfo(that);

    shared actual NodeInfo transformCaseTypes(CaseTypes that) => CaseTypesInfo(that);

    shared actual NodeInfo transformCatchClause(CatchClause that) => CatchClauseInfo(that);

    shared actual NodeInfo transformCharacterLiteral(CharacterLiteral that) => CharacterLiteralInfo(that);

    shared actual NodeInfo transformClassAliasDefinition(ClassAliasDefinition that) => ClassAliasDefinitionInfo(that);

    shared actual NodeInfo transformClassBody(ClassBody that) => ClassBodyInfo(that);

    shared actual NodeInfo transformClassDec(ClassDec that) => ClassDecInfo(that);

    shared actual NodeInfo transformClassDefinition(ClassDefinition that) => ClassDefinitionInfo(that);

    shared actual NodeInfo transformClassSpecifier(ClassSpecifier that) => ClassSpecifierInfo(that);

    shared actual NodeInfo transformClosedBound(ClosedBound that) => ClosedBoundInfo(that);

    shared actual NodeInfo transformCompareOperation(CompareOperation that) => CompareOperationInfo(that);

    shared actual NodeInfo transformCompilationUnit(CompilationUnit that) => CompilationUnitInfo(that);

    shared actual NodeInfo transformComplementAssignmentOperation(ComplementAssignmentOperation that) => ComplementAssignmentOperationInfo(that);

    shared actual NodeInfo transformComplementOperation(ComplementOperation that) => ComplementOperationInfo(that);

    shared actual NodeInfo transformComprehension(Comprehension that) => ComprehensionInfo(that);

    shared actual NodeInfo transformConditions(Conditions that) => ConditionsInfo(that);

    shared actual NodeInfo transformConstruction(Construction that) => ConstructionInfo(that);

    shared actual NodeInfo transformConstructorDec(ConstructorDec that) => ConstructorDecInfo(that);

    shared actual NodeInfo transformContinue(Continue that) => ContinueInfo(that);

    shared actual NodeInfo transformDecQualifier(DecQualifier that) => DecQualifierInfo(that);

    shared actual NodeInfo transformDefaultedCallableParameter(DefaultedCallableParameter that) => DefaultedCallableParameterInfo(that);

    shared actual NodeInfo transformDefaultedParameterReference(DefaultedParameterReference that) => DefaultedParameterReferenceInfo(that);

    shared actual NodeInfo transformDefaultedType(DefaultedType that) => DefaultedTypeInfo(that);

    shared actual NodeInfo transformDefaultedValueParameter(DefaultedValueParameter that) => DefaultedValueParameterInfo(that);

    shared actual NodeInfo transformDestructure(Destructure that) => DestructureInfo(that);

    shared actual NodeInfo transformDifferenceOperation(DifferenceOperation that) => DifferenceOperationInfo(that);

    shared actual NodeInfo transformDivideAssignmentOperation(DivideAssignmentOperation that) => DivideAssignmentOperationInfo(that);

    shared actual NodeInfo transformDynamicBlock(DynamicBlock that) => DynamicBlockInfo(that);

    shared actual NodeInfo transformDynamicInterfaceDefinition(DynamicInterfaceDefinition that) => DynamicInterfaceDefinitionInfo(that);

    shared actual NodeInfo transformDynamicModifier(DynamicModifier that) => DynamicModifierInfo(that);

    shared actual NodeInfo transformDynamicValue(DynamicValue that) => DynamicValueInfo(that);

    shared actual NodeInfo transformElementOrSubrangeExpression(ElementOrSubrangeExpression that) => ElementOrSubrangeExpressionInfo(that);

    shared actual NodeInfo transformElseClause(ElseClause that) => ElseClauseInfo(that);

    shared actual NodeInfo transformElseOperation(ElseOperation that) => ElseOperationInfo(that);

    shared actual NodeInfo transformEntryOperation(EntryOperation that) => EntryOperationInfo(that);

    shared actual NodeInfo transformEntryPattern(EntryPattern that) => EntryPatternInfo(that);

    shared actual NodeInfo transformEntryType(EntryType that) => EntryTypeInfo(that);

    shared actual NodeInfo transformEqualOperation(EqualOperation that) => EqualOperationInfo(that);

    shared actual NodeInfo transformExistsCondition(ExistsCondition that) => ExistsConditionInfo(that);

    shared actual NodeInfo transformExistsOperation(ExistsOperation that) => ExistsOperationInfo(that);

    shared actual NodeInfo transformExponentiationOperation(ExponentiationOperation that) => ExponentiationOperationInfo(that);

    shared actual NodeInfo transformExpressionComprehensionClause(ExpressionComprehensionClause that) => ExpressionComprehensionClauseInfo(that);

    shared actual NodeInfo transformExtendedType(ExtendedType that) => ExtendedTypeInfo(that);

    shared actual NodeInfo transformExtension(Extension that) => ExtensionInfo(that);

    shared actual NodeInfo transformFailClause(FailClause that) => FailClauseInfo(that);

    shared actual NodeInfo transformFinallyClause(FinallyClause that) => FinallyClauseInfo(that);

    shared actual NodeInfo transformFloatLiteral(FloatLiteral that) => FloatLiteralInfo(that);

    shared actual NodeInfo transformForClause(ForClause that) => ForClauseInfo(that);

    shared actual NodeInfo transformForComprehensionClause(ForComprehensionClause that) => ForComprehensionClauseInfo(that);

    shared actual NodeInfo transformForFail(ForFail that) => ForFailInfo(that);

    shared actual NodeInfo transformForIterator(ForIterator that) => ForIteratorInfo(that);

    shared actual NodeInfo transformFullPackageName(FullPackageName that) => FullPackageNameInfo(that);

    shared actual NodeInfo transformFunctionArgument(FunctionArgument that) => FunctionArgumentInfo(that);

    shared actual NodeInfo transformFunctionDec(FunctionDec that) => FunctionDecInfo(that);

    shared actual NodeInfo transformFunctionDeclaration(FunctionDeclaration that) => FunctionDeclarationInfo(that);

    shared actual NodeInfo transformFunctionDefinition(FunctionDefinition that) => FunctionDefinitionInfo(that);

    shared actual NodeInfo transformFunctionExpression(FunctionExpression that) => FunctionExpressionInfo(that);

    shared actual NodeInfo transformFunctionModifier(FunctionModifier that) => FunctionModifierInfo(that);

    shared actual NodeInfo transformFunctionShortcutDefinition(FunctionShortcutDefinition that) => FunctionShortcutDefinitionInfo(that);

    shared actual NodeInfo transformGivenDec(GivenDec that) => GivenDecInfo(that);

    shared actual NodeInfo transformGroupedExpression(GroupedExpression that) => GroupedExpressionInfo(that);

    shared actual NodeInfo transformGroupedType(GroupedType that) => GroupedTypeInfo(that);

    shared actual NodeInfo transformIdenticalOperation(IdenticalOperation that) => IdenticalOperationInfo(that);

    shared actual NodeInfo transformIdentityOperation(IdentityOperation that) => IdentityOperationInfo(that);

    shared actual NodeInfo transformIfClause(IfClause that) => IfClauseInfo(that);

    shared actual NodeInfo transformIfComprehensionClause(IfComprehensionClause that) => IfComprehensionClauseInfo(that);

    shared actual NodeInfo transformIfElse(IfElse that) => IfElseInfo(that);

    shared actual NodeInfo transformIfElseExpression(IfElseExpression that) => IfElseExpressionInfo(that);

    shared actual NodeInfo transformImport(Import that) => ImportInfo(that);

    shared actual NodeInfo transformImportElements(ImportElements that) => ImportElementsInfo(that);

    shared actual NodeInfo transformImportFunctionValueAlias(ImportFunctionValueAlias that) => ImportFunctionValueAliasInfo(that);

    shared actual NodeInfo transformImportFunctionValueElement(ImportFunctionValueElement that) => ImportFunctionValueElementInfo(that);

    shared actual NodeInfo transformImportTypeAlias(ImportTypeAlias that) => ImportTypeAliasInfo(that);

    shared actual NodeInfo transformImportTypeElement(ImportTypeElement that) => ImportTypeElementInfo(that);

    shared actual NodeInfo transformImportWildcard(ImportWildcard that) => ImportWildcardInfo(that);

    shared actual NodeInfo transformInModifier(InModifier that) => InModifierInfo(that);

    shared actual NodeInfo transformInOperation(InOperation that) => InOperationInfo(that);

    shared actual NodeInfo transformIntegerLiteral(IntegerLiteral that) => IntegerLiteralInfo(that);

    shared actual NodeInfo transformInterfaceAliasDefinition(InterfaceAliasDefinition that) => InterfaceAliasDefinitionInfo(that);

    shared actual NodeInfo transformInterfaceBody(InterfaceBody that) => InterfaceBodyInfo(that);

    shared actual NodeInfo transformInterfaceDec(InterfaceDec that) => InterfaceDecInfo(that);

    shared actual NodeInfo transformInterfaceDefinition(InterfaceDefinition that) => InterfaceDefinitionInfo(that);

    shared actual NodeInfo transformIntersectAssignmentOperation(IntersectAssignmentOperation that) => IntersectAssignmentOperationInfo(that);

    shared actual NodeInfo transformIntersectionOperation(IntersectionOperation that) => IntersectionOperationInfo(that);

    shared actual NodeInfo transformIntersectionType(IntersectionType that) => IntersectionTypeInfo(that);

    shared actual NodeInfo transformInvocation(Invocation that) => InvocationInfo(that);

    shared actual NodeInfo transformInvocationStatement(InvocationStatement that) => InvocationStatementInfo(that);

    shared actual NodeInfo transformIsCase(IsCase that) => IsCaseInfo(that);

    shared actual NodeInfo transformIsCondition(IsCondition that) => IsConditionInfo(that);

    shared actual NodeInfo transformIsOperation(IsOperation that) => IsOperationInfo(that);

    shared actual NodeInfo transformIterable(Iterable that) => IterableInfo(that);

    shared actual NodeInfo transformIterableType(IterableType that) => IterableTypeInfo(that);

    shared actual NodeInfo transformKeySubscript(KeySubscript that) => KeySubscriptInfo(that);

    shared actual NodeInfo transformLIdentifier(LIdentifier that) => LIdentifierInfo(that);

    shared actual NodeInfo transformLargeAsOperation(LargeAsOperation that) => LargeAsOperationInfo(that);

    shared actual NodeInfo transformLargerOperation(LargerOperation that) => LargerOperationInfo(that);

    shared actual NodeInfo transformLazySpecification(LazySpecification that) => LazySpecificationInfo(that);

    shared actual NodeInfo transformLazySpecifier(LazySpecifier that) => LazySpecifierInfo(that);

    shared actual NodeInfo transformLetExpression(LetExpression that) => LetExpressionInfo(that);

    shared actual NodeInfo transformMatchCase(MatchCase that) => MatchCaseInfo(that);

    shared actual NodeInfo transformMeasureOperation(MeasureOperation that) => MeasureOperationInfo(that);

    shared actual NodeInfo transformMeasureSubscript(MeasureSubscript that) => MeasureSubscriptInfo(that);

    shared actual NodeInfo transformMemberMeta(MemberMeta that) => MemberMetaInfo(that);

    shared actual NodeInfo transformMemberNameWithTypeArguments(MemberNameWithTypeArguments that) => MemberNameWithTypeArgumentsInfo(that);

    shared actual NodeInfo transformMemberOperator(MemberOperator that) => MemberOperatorInfo(that);

    shared actual NodeInfo transformModuleBody(ModuleBody that) => ModuleBodyInfo(that);

    shared actual NodeInfo transformModuleCompilationUnit(ModuleCompilationUnit that) => ModuleCompilationUnitInfo(that);

    shared actual NodeInfo transformModuleDec(ModuleDec that) => ModuleDecInfo(that);

    shared actual NodeInfo transformModuleDescriptor(ModuleDescriptor that) => ModuleDescriptorInfo(that);

    shared actual NodeInfo transformModuleImport(ModuleImport that) => ModuleImportInfo(that);

    shared actual NodeInfo transformMultiplyAssignmentOperation(MultiplyAssignmentOperation that) => MultiplyAssignmentOperationInfo(that);

    shared actual NodeInfo transformNamedArguments(NamedArguments that) => NamedArgumentsInfo(that);

    shared actual NodeInfo transformNegationOperation(NegationOperation that) => NegationOperationInfo(that);

    shared actual NodeInfo transformNonemptyCondition(NonemptyCondition that) => NonemptyConditionInfo(that);

    shared actual NodeInfo transformNonemptyOperation(NonemptyOperation that) => NonemptyOperationInfo(that);

    shared actual NodeInfo transformNotEqualOperation(NotEqualOperation that) => NotEqualOperationInfo(that);

    shared actual NodeInfo transformNotOperation(NotOperation that) => NotOperationInfo(that);

    shared actual NodeInfo transformObjectArgument(ObjectArgument that) => ObjectArgumentInfo(that);

    shared actual NodeInfo transformObjectDefinition(ObjectDefinition that) => ObjectDefinitionInfo(that);

    shared actual NodeInfo transformObjectExpression(ObjectExpression that) => ObjectExpressionInfo(that);

    shared actual NodeInfo transformOfOperation(OfOperation that) => OfOperationInfo(that);

    shared actual NodeInfo transformOpenBound(OpenBound that) => OpenBoundInfo(that);

    shared actual NodeInfo transformOptionalType(OptionalType that) => OptionalTypeInfo(that);

    shared actual NodeInfo transformOrAssignmentOperation(OrAssignmentOperation that) => OrAssignmentOperationInfo(that);

    shared actual NodeInfo transformOrOperation(OrOperation that) => OrOperationInfo(that);

    shared actual NodeInfo transformOutModifier(OutModifier that) => OutModifierInfo(that);

    shared actual NodeInfo transformOuter(Outer that) => OuterInfo(that);

    shared actual NodeInfo transformPackage(Package that) => PackageInfo(that);

    shared actual NodeInfo transformPackageCompilationUnit(PackageCompilationUnit that) => PackageCompilationUnitInfo(that);

    shared actual NodeInfo transformPackageDec(PackageDec that) => PackageDecInfo(that);

    shared actual NodeInfo transformPackageDescriptor(PackageDescriptor that) => PackageDescriptorInfo(that);

    shared actual NodeInfo transformPackageQualifier(PackageQualifier that) => PackageQualifierInfo(that);

    shared actual NodeInfo transformParameterReference(ParameterReference that) => ParameterReferenceInfo(that);

    shared actual NodeInfo transformParameters(Parameters that) => ParametersInfo(that);

    shared actual NodeInfo transformPatternList(PatternList that) => PatternListInfo(that);

    shared actual NodeInfo transformPositionalArguments(PositionalArguments that) => PositionalArgumentsInfo(that);

    shared actual NodeInfo transformPostfixDecrementOperation(PostfixDecrementOperation that) => PostfixDecrementOperationInfo(that);

    shared actual NodeInfo transformPostfixIncrementOperation(PostfixIncrementOperation that) => PostfixIncrementOperationInfo(that);

    shared actual NodeInfo transformPrefixDecrementOperation(PrefixDecrementOperation that) => PrefixDecrementOperationInfo(that);

    shared actual NodeInfo transformPrefixIncrementOperation(PrefixIncrementOperation that) => PrefixIncrementOperationInfo(that);

    shared actual NodeInfo transformPrefixPostfixStatement(PrefixPostfixStatement that) => PrefixPostfixStatementInfo(that);

    shared actual NodeInfo transformProductOperation(ProductOperation that) => ProductOperationInfo(that);

    shared actual NodeInfo transformQualifiedExpression(QualifiedExpression that) => QualifiedExpressionInfo(that);

    shared actual NodeInfo transformQualifiedType(QualifiedType that) => QualifiedTypeInfo(that);

    shared actual NodeInfo transformQuotientOperation(QuotientOperation that) => QuotientOperationInfo(that);

    shared actual NodeInfo transformRemainderAssignmentOperation(RemainderAssignmentOperation that) => RemainderAssignmentOperationInfo(that);

    shared actual NodeInfo transformRemainderOperation(RemainderOperation that) => RemainderOperationInfo(that);

    shared actual NodeInfo transformResource(Resource that) => ResourceInfo(that);

    shared actual NodeInfo transformResources(Resources that) => ResourcesInfo(that);

    shared actual NodeInfo transformReturn(Return that) => ReturnInfo(that);

    shared actual NodeInfo transformSafeMemberOperator(SafeMemberOperator that) => SafeMemberOperatorInfo(that);

    shared actual NodeInfo transformSatisfiedTypes(SatisfiedTypes that) => SatisfiedTypesInfo(that);

    shared actual NodeInfo transformScaleOperation(ScaleOperation that) => ScaleOperationInfo(that);

    shared actual NodeInfo transformSequentialType(SequentialType that) => SequentialTypeInfo(that);

    shared actual NodeInfo transformSmallAsOperation(SmallAsOperation that) => SmallAsOperationInfo(that);

    shared actual NodeInfo transformSmallerOperation(SmallerOperation that) => SmallerOperationInfo(that);

    shared actual NodeInfo transformSpanFromSubscript(SpanFromSubscript that) => SpanFromSubscriptInfo(that);

    shared actual NodeInfo transformSpanOperation(SpanOperation that) => SpanOperationInfo(that);

    shared actual NodeInfo transformSpanSubscript(SpanSubscript that) => SpanSubscriptInfo(that);

    shared actual NodeInfo transformSpanToSubscript(SpanToSubscript that) => SpanToSubscriptInfo(that);

    shared actual NodeInfo transformSpecifiedArgument(SpecifiedArgument that) => SpecifiedArgumentInfo(that);

    shared actual NodeInfo transformSpecifiedPattern(SpecifiedPattern that) => SpecifiedPatternInfo(that);

    shared actual NodeInfo transformSpecifiedVariable(SpecifiedVariable that) => SpecifiedVariableInfo(that);

    shared actual NodeInfo transformSpecifier(Specifier that) => SpecifierInfo(that);

    shared actual NodeInfo transformSpreadArgument(SpreadArgument that) => SpreadArgumentInfo(that);

    shared actual NodeInfo transformSpreadMemberOperator(SpreadMemberOperator that) => SpreadMemberOperatorInfo(that);

    shared actual NodeInfo transformSpreadType(SpreadType that) => SpreadTypeInfo(that);

    shared actual NodeInfo transformStringLiteral(StringLiteral that) => StringLiteralInfo(that);

    shared actual NodeInfo transformStringTemplate(StringTemplate that) => StringTemplateInfo(that);

    shared actual NodeInfo transformSubtractAssignmentOperation(SubtractAssignmentOperation that) => SubtractAssignmentOperationInfo(that);

    shared actual NodeInfo transformSumOperation(SumOperation that) => SumOperationInfo(that);

    shared actual NodeInfo transformSuper(Super that) => SuperInfo(that);

    shared actual NodeInfo transformSwitchCaseElse(SwitchCaseElse that) => SwitchCaseElseInfo(that);

    shared actual NodeInfo transformSwitchCaseElseExpression(SwitchCaseElseExpression that) => SwitchCaseElseExpressionInfo(that);

    shared actual NodeInfo transformSwitchCases(SwitchCases that) => SwitchCasesInfo(that);

    shared actual NodeInfo transformSwitchClause(SwitchClause that) => SwitchClauseInfo(that);

    shared actual NodeInfo transformThenOperation(ThenOperation that) => ThenOperationInfo(that);

    shared actual NodeInfo transformThis(This that) => ThisInfo(that);

    shared actual NodeInfo transformThrow(Throw that) => ThrowInfo(that);

    shared actual NodeInfo transformTryCatchFinally(TryCatchFinally that) => TryCatchFinallyInfo(that);

    shared actual NodeInfo transformTryClause(TryClause that) => TryClauseInfo(that);

    shared actual NodeInfo transformTuple(Tuple that) => TupleInfo(that);

    shared actual NodeInfo transformTuplePattern(TuplePattern that) => TuplePatternInfo(that);

    shared actual NodeInfo transformTupleType(TupleType that) => TupleTypeInfo(that);

    shared actual NodeInfo transformTypeAliasDefinition(TypeAliasDefinition that) => TypeAliasDefinitionInfo(that);

    shared actual NodeInfo transformTypeArgument(TypeArgument that) => TypeArgumentInfo(that);

    shared actual NodeInfo transformTypeArguments(TypeArguments that) => TypeArgumentsInfo(that);

    shared actual NodeInfo transformTypeConstraint(TypeConstraint that) => TypeConstraintInfo(that);

    shared actual NodeInfo transformTypeList(TypeList that) => TypeListInfo(that);

    shared actual NodeInfo transformTypeMeta(TypeMeta that) => TypeMetaInfo(that);

    shared actual NodeInfo transformTypeNameWithTypeArguments(TypeNameWithTypeArguments that) => TypeNameWithTypeArgumentsInfo(that);

    shared actual NodeInfo transformTypeParameter(TypeParameter that) => TypeParameterInfo(that);

    shared actual NodeInfo transformTypeParameters(TypeParameters that) => TypeParametersInfo(that);

    shared actual NodeInfo transformTypeSpecifier(TypeSpecifier that) => TypeSpecifierInfo(that);

    shared actual NodeInfo transformTypedVariable(TypedVariable that) => TypedVariableInfo(that);

    shared actual NodeInfo transformUIdentifier(UIdentifier that) => UIdentifierInfo(that);

    shared actual NodeInfo transformUnionAssignmentOperation(UnionAssignmentOperation that) => UnionAssignmentOperationInfo(that);

    shared actual NodeInfo transformUnionOperation(UnionOperation that) => UnionOperationInfo(that);

    shared actual NodeInfo transformUnionType(UnionType that) => UnionTypeInfo(that);

    shared actual NodeInfo transformUnspecifiedVariable(UnspecifiedVariable that) => UnspecifiedVariableInfo(that);

    shared actual NodeInfo transformValueArgument(ValueArgument that) => ValueArgumentInfo(that);

    shared actual NodeInfo transformValueConstructorDefinition(ValueConstructorDefinition that) => ValueConstructorDefinitionInfo(that);

    shared actual NodeInfo transformValueDec(ValueDec that) => ValueDecInfo(that);

    shared actual NodeInfo transformValueDeclaration(ValueDeclaration that) => ValueDeclarationInfo(that);

    shared actual NodeInfo transformValueDefinition(ValueDefinition that) => ValueDefinitionInfo(that);

    shared actual NodeInfo transformValueGetterDefinition(ValueGetterDefinition that) => ValueGetterDefinitionInfo(that);

    shared actual NodeInfo transformValueModifier(ValueModifier that) => ValueModifierInfo(that);

    shared actual NodeInfo transformValueParameter(ValueParameter that) => ValueParameterInfo(that);

    shared actual NodeInfo transformValueSetterDefinition(ValueSetterDefinition that) => ValueSetterDefinitionInfo(that);

    shared actual NodeInfo transformValueSpecification(ValueSpecification that) => ValueSpecificationInfo(that);

    shared actual NodeInfo transformVariablePattern(VariablePattern that) => VariablePatternInfo(that);

    shared actual NodeInfo transformVariadicParameter(VariadicParameter that) => VariadicParameterInfo(that);

    shared actual NodeInfo transformVariadicType(VariadicType that) => VariadicTypeInfo(that);

    shared actual NodeInfo transformVariadicVariable(VariadicVariable that) => VariadicVariableInfo(that);

    shared actual NodeInfo transformVoidModifier(VoidModifier that) => VoidModifierInfo(that);

    shared actual NodeInfo transformWhile(While that) => WhileInfo(that);

    shared actual NodeInfo transformWithinOperation(WithinOperation that) => WithinOperationInfo(that);
}
