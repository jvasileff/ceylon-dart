"A closed union type."
native shared sealed interface UnionType<out Union=Anything>
        satisfies Type<Union> {
    
    "The list of closed case types of this union."
    shared formal List<Type<>> caseTypes;
}
