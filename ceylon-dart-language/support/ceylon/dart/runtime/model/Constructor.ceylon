shared abstract
class Constructor()
        of CallableConstructor | ValueConstructor
        extends TypeDeclaration() {

    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Null qualifier => null;
    shared actual formal Constructor refinedDeclaration;
    shared actual [] satisfiedTypes => [];
    shared actual Null selfType => null;

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => true;
    shared actual Boolean isDefault => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isStatic => false;

    shared actual formal Type extendedType;

    shared actual
    Declaration? getMember(String name, Unit? unit)
        // don't search supertypes (constructors don't have supertypes)
        =>  getDirectMember(name);

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);
}
