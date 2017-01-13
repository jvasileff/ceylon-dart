import ceylon.dart.runtime.model.internal {
    toType, toValue
}

shared abstract
class ClassDefinition(
        extendedTypeLG, satisfiedTypesLG, caseTypesLG, caseValuesLG)
        of ClassWithInitializer | ClassWithConstructors
        extends Class(extendedTypeLG, satisfiedTypesLG) {

    {Type | Type(Scope)*} satisfiedTypesLG;
    {Type | Type(Scope)*} caseTypesLG;
    {Value | Value(Scope)*} caseValuesLG;
    Type | Type(Scope) | Null extendedTypeLG;

    variable [Type*]? caseTypesMemo = null;
    variable [Value*]? caseValuesMemo = null;

    shared actual
    Type[] caseTypes
        // FIXME remove types with declarations == this; see ceylon-model
        =>  caseTypesMemo else (caseTypesMemo
            =   caseTypesLG.collect(toType(this)));

    shared actual
    Value[] caseValues
        =>  caseValuesMemo else (caseValuesMemo
            =   caseValuesLG.collect(toValue(this)));

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that) {
        if (that.isAnything) {
            return true;
        }

        if (that.isObject) {
            return !isAnything && !isNull && !isNullValue;
        }

        if (that.isNull) {
            return isNull || isNullValue;
        }

        if (this == that) {
            return true;
        }

        if (that.isFinal) {
            // cannot possibly be true, since that is nonequal
            return false;
        }

        // Copied todo: optimize this to avoid walking the same supertypes multiple times
        if (exists et = extendedType, et.declaration.inherits(that)) {
            return true;
        }
        if (is Interface that) {
            return satisfiedTypes.any((t) => t.declaration.inherits(that));
        }

        return false;
    }

    shared actual
    Boolean canEqual(Object other)
        =>  other is ClassDefinition;
}
