shared
class NothingDeclaration(unit) extends TypeDeclaration() {

    "The unit, which must be for the 'ceylon.language' package."
    shared actual Unit unit;

    "The NothingDeclaration must be defined by the ceylon.language package."
    assert(unit.pkg.qualifiedName == "ceylon.language");

    shared actual [Annotation*] annotations => [];
    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Package container => pkg;
    shared actual Type extendedType => unit.anythingDeclaration.type;
    shared actual Boolean inherits(ClassOrInterface | TypeParameter that) => true;
    shared actual String name => "Nothing";
    shared actual Null qualifier => null;
    shared actual NothingDeclaration refinedDeclaration => this;
    shared actual [] satisfiedTypes => [];
    shared actual Null selfType => null;
    shared actual [] typeParameters => [];

    shared actual Boolean isActual => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isSealed => false;
    shared actual Boolean isShared => true;
    shared actual Boolean isStatic => false;

    shared actual
    Boolean canEqual(Object other)
        =>  other is NothingDeclaration;

    shared actual
    Boolean equals(Object other)
        =>  other is NothingDeclaration;

    shared actual
    Integer hash
        =>  100927;

    shared actual
    String string
        =>  "class ``partiallyQualifiedNameWithTypeParameters``";
}
