shared
class Constructor(
        name, container, extendedType, isDeprecated = false, isSealed = false,
        isShared = false, unit = container.pkg.defaultUnit)
        extends TypeDeclaration()
        satisfies Functional {

    // TODO split Constructor into ValueConstructor and CallableConstructor
    shared actual [ParameterList+] parameterLists => [ParameterList.empty];

    shared actual Class container;
    shared actual String name;
    shared actual Type extendedType;
    shared actual Unit unit;

    shared actual Boolean isDeprecated;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;

    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Boolean declaredVoid => false;
    shared actual Null qualifier => null;
    shared actual Constructor refinedDeclaration => this;
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

    shared actual default
    Declaration? getMember(String name, Unit? unit)
        // don't search supertypes (constructor's don't have supertypes)
        =>  getDirectMember(name);

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    Boolean canEqual(Object other)
        =>  other is Constructor;

    shared actual
    String string
        =>  "new ``partiallyQualifiedNameWithTypeParameters````valueParametersAsString``";
}
