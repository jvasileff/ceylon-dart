shared abstract
class ClassOrInterface() of Class | Interface extends TypeDeclaration() {
    shared actual
    {ClassOrInterface*} extendedAndSatisfiedDeclarations {
        return extendedAndSatisfiedTypes.map((t) {
            assert (is ClassOrInterface d = t.declaration);
            return d;
        });
    }
}
