shared
class UnionType(caseTypes, unit) extends TypeDeclaration() {

    shared actual [Type+] caseTypes;
    shared actual Unit unit;

    shared actual [Annotation*] annotations => [];
    shared actual [] caseValues => [];
    shared actual Type extendedType => unit.anythingDeclaration.type;
    shared actual String name => type.formatted;
    shared actual Null qualifier => null;
    shared actual String qualifiedName => type.qualifiedNameWithTypeArguments;
    shared actual UnionType refinedDeclaration => this;
    shared actual [] satisfiedTypes => [];
    shared actual Null selfType => null;

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isSealed => false;
    shared actual Boolean isShared => false;
    shared actual Boolean isStatic => false;
    shared actual Boolean isDynamic => false;

    shared actual
    Nothing container {
        throw AssertionError("union types don't have containers.");
    }

    shared actual
    Boolean isToplevel
        =>  false;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  that.isAnything || caseTypes.every((ct) => ct.declaration.inherits(that));

    shared actual
    Type type
        =>  if (caseTypes.size == 1)
            then caseTypes[0]
            else super.type;

    shared actual
    Nothing canEqual(Object other) {
        throw AssertionError("union types don't have well-defined equality");
    }

    shared actual
    String string
        =>  name;
}
