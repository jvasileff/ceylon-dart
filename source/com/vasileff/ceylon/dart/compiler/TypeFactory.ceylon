import com.redhat.ceylon.model.typechecker.model {
    Type,
    Unit,
    ModelUtil
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

class TypeFactory(Unit unit) {

    /////////////////////////////////////////////
    // common types
    /////////////////////////////////////////////

    shared
    Type anythingType => unit.anythingType;

    shared
    Type nullType => unit.nullType;

    shared
    Type objectType => unit.objectType;

    shared
    Type booleanType => unit.booleanType;

    shared
    Type byteType => unit.byteType;

    shared
    Type characterType => unit.characterType;

    shared
    Type floatType => unit.floatType;

    shared
    Type integerType => unit.integerType;

    shared
    Type stringType => unit.stringType;

    /////////////////////////////////////////////
    // Boolean isCeylonX(type)
    /////////////////////////////////////////////

    shared
    Boolean isCeylonNull(Type type)
        // Null, \Inull, but not Nothing
        =>  !type.nothing && type.isSubtypeOf(nullType);

    shared
    Boolean isCeylonObject(Type type)
        =>  type.isExactly(objectType);

    shared
    Boolean isCeylonBoolean(Type type)
        // Boolean, \Itrue, \Ifalse
        =>  !type.nothing && type.isSubtypeOf(booleanType);

    shared
    Boolean isCeylonByte(Type type)
        =>  type.isExactly(byteType);

    shared
    Boolean isCeylonCharacter(Type type)
        =>  type.isExactly(characterType);

    shared
    Boolean isCeylonFloat(Type type)
        =>  type.isExactly(floatType);

    shared
    Boolean isCeylonInteger(Type type)
        =>  type.isExactly(integerType);

    shared
    Boolean isCeylonString(Type type)
        =>  type.isExactly(stringType);

    /////////////////////////////////////////////
    // utilities
    /////////////////////////////////////////////

    shared
    Type intersection(Type *types)
        =>  ModelUtil.intersection(javaList(types), unit);

    shared
    Type union(Type *types)
        =>  ModelUtil.union(javaList(types), unit);

    /////////////////////////////////////////////
    // boxing
    /////////////////////////////////////////////

    shared
    BoxingConversion? boxingConversionFor(
            Type lhs, Type rhs) {

        // NOTE: we are assuming from and to are not any of the
        // exceptional cases, such as type parameters or actual
        // refinements of formal methods and attributes

        // assigments to or from null don't need conversion
        // (they will be the null value)
        if (isCeylonNull(rhs) || isCeylonNull(lhs)) {
            return null;
        }

        value intersectedLhs = intersection(
                objectType, lhs);

        value intersectedRhs = intersection(
                objectType, rhs);

        // obvious case
        if (intersectedLhs.isExactly(intersectedRhs)) {
            return null;
        }

        // for cases below that are final classes, we don't
        // need to re-check the "other" type; we already know
        // "lhs" and "rhs" are not exactly the same

        // to Ceylon conversions
        if (isCeylonBoolean(intersectedLhs)) {
            return !isCeylonBoolean(intersectedRhs)
                    then nativeToCeylonBoolean;
        }
        else if (isCeylonFloat(intersectedLhs)) {
            return nativeToCeylonFloat;
        }
        else if (isCeylonInteger(intersectedLhs)) {
            return nativeToCeylonInteger;
        }
        else if (isCeylonString(intersectedLhs)) {
            return nativeToCeylonString;
        }

        // to native conversions
        if (isCeylonBoolean(intersectedRhs)) {
            return !isCeylonBoolean(intersectedLhs)
                    then ceylonBooleanToNative;
        }
        else if (isCeylonFloat(intersectedRhs)) {
            return ceylonFloatToNative;
        }
        else if (isCeylonInteger(intersectedRhs)) {
            return ceylonIntegerToNative;
        }
        else if (isCeylonString(intersectedRhs)) {
            return ceylonStringToNative;
        }
        return null;
    }
}
