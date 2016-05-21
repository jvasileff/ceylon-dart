shared abstract
class InterfaceAlias(extendedType) extends Interface() {
    shared actual
    Type extendedType;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    Boolean canEqual(Object other) => other is InterfaceAlias;
}
