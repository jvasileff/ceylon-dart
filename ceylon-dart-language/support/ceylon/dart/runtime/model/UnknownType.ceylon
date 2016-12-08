"Used whenever the typechecker doesn't know the type of something. This might result
 from some error, or from use of dynamic typing."
shared
class UnknownType(unit) extends TypeDeclaration() {

    shared actual Unit unit;

    shared actual [Annotation*] annotations => [];
    shared actual Type[] caseTypes => [];
    shared actual Value[] caseValues => [];
    shared actual Package container => pkg;
    shared actual Type extendedType => unit.anythingDeclaration.type;
    shared actual Module mod => pkg.mod;
    shared actual String name => "unknown";
    shared actual Package pkg => unit.pkg;
    shared actual Null qualifier => null;
    shared actual UnknownType refinedDeclaration => this;
    shared actual Type[] satisfiedTypes => [];
    shared actual Null selfType => null;
    shared actual TypeParameter[] typeParameters => [];

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isShared => true;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isSealed => false;
    shared actual Boolean isStatic => false;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  false;

    shared actual
    Boolean canEqual(Object other)
        =>  other is UnknownType;

    shared actual
    Boolean equals(Object other)
        =>  if (is UnknownType other)
            then this === other
            else false;

    shared actual
    Integer hash
        => identityHash(this);

    shared actual
    String string
        =>  name;
}
