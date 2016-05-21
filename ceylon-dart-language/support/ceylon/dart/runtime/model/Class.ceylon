shared abstract
class Class()
        of ClassDefinition | ClassAlias
        extends ClassOrInterface()
        satisfies Functional {

    shared formal Boolean isAbstract;

    shared actual default Class refinedDeclaration {
        assert(is Class f = super.refinedDeclaration);
        return f;
    }

    shared actual
    String string
        =>  "class ``partiallyQualifiedNameWithTypeParameters````valueParametersAsString``";
}
