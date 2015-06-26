import ceylon.interop.java {
    CeylonIterable
}
import ceylon.language.meta.declaration {
    ValueDeclaration
}

import com.redhat.ceylon.model.typechecker.model {
    Type,
    Unit,
    ModelUtil,
    Declaration,
    TypedDeclaration,
    TypeDeclaration,
    Value
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
    Type basicType => unit.basicType;

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

    shared
    Type nothingType => unit.nothingType;

    /////////////////////////////////////////////
    // Boolean isCeylonX(type)
    /////////////////////////////////////////////

    shared
    Boolean isCeylonNull(Type type)
        // Null, \Inull
        =>  type.isExactly(nullType) ||
            isNullTypeDeclaration(type.declaration);

    shared
    Boolean isCeylonAnything(Type type)
        =>  type.isExactly(anythingType);

    shared
    Boolean isCeylonObject(Type type)
        =>  type.isExactly(objectType);

    shared
    Boolean isCeylonBasic(Type type)
        =>  type.isExactly(basicType);

    shared
    Boolean isCeylonBoolean(Type type)
        // Boolean, \Itrue, \Ifalse, \Itrue|\Ifalse
        =>  type.isExactly(booleanType) || (
                let (declaration = type.declaration)
                isBooleanTrueTypeDeclaration(declaration) ||
                isBooleanFalseTypeDeclaration(declaration) ||
                type.union && CeylonIterable(type.caseTypes).every(isCeylonBoolean));

    shared
    Boolean isCeylonByte(Type type)
        =>  type.isExactly(byteType);

    "True iff the declaration for this type is `Callable`"
    shared
    Boolean isCeylonCallable(Type type)
        =>  isCallableDeclaration(type.declaration);

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

    shared
    Boolean isCeylonNothing(Type type)
        =>  type.isExactly(nothingType);

    /////////////////////////////////////////////
    // common declarations
    /////////////////////////////////////////////

    // not sure about the safety implications due
    // to duplicate instances re:
    // https://github.com/ceylon/ceylon-compiler/issues/1815

    TypeDeclaration booleanDeclaration {
        assert (is TypeDeclaration declaration =
            unit.getLanguageModuleDeclaration("Boolean"));
        return declaration;
    }

    Value booleanTrueValueDeclaration {
        assert (is Value declaration =
            unit.getLanguageModuleDeclaration("true"));
        return declaration;
    }

    TypeDeclaration booleanTrueTypeDeclaration
        =>  booleanTrueValueDeclaration.typeDeclaration;

    Value booleanFalseValueDeclaration {
        assert (is Value declaration =
            unit.getLanguageModuleDeclaration("false"));
        return declaration;
    }

    TypeDeclaration booleanFalseTypeDeclaration
        =>  booleanFalseValueDeclaration.typeDeclaration;

    Declaration callableDeclaration
        =>  unit.getLanguageModuleDeclaration("Callable");

    TypeDeclaration nullDeclaration {
        assert (is TypeDeclaration declaration =
            unit.getLanguageModuleDeclaration("Null"));
        return declaration;
    }

    Value nullValueDeclaration {
        assert (is Value declaration =
                unit.getLanguageModuleDeclaration("null"));
        return declaration;
    }

    TypeDeclaration nullTypeDeclaration
        =>  nullValueDeclaration.typeDeclaration;

    shared
    TypeDeclaration assertionErrorDeclaration {
        assert (is TypeDeclaration declaration =
            unit.getLanguageModuleDeclaration("AssertionError"));
        return declaration;
    }

    /////////////////////////////////////////////
    // declaration tests
    /////////////////////////////////////////////

    shared
    Boolean isBooleanDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, booleanDeclaration);

    shared
    Boolean isBooleanTrueValueDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, booleanTrueValueDeclaration);

    shared
    Boolean isBooleanTrueTypeDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, booleanTrueTypeDeclaration);

    shared
    Boolean isBooleanFalseValueDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, booleanFalseValueDeclaration);

    shared
    Boolean isBooleanFalseTypeDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, booleanFalseTypeDeclaration);

    shared
    Boolean isCallableDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, callableDeclaration);

    shared
    Boolean isNullDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, nullDeclaration);

    shared
    Boolean isNullValueDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, nullValueDeclaration);

    shared
    Boolean isNullTypeDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, nullTypeDeclaration);

    /////////////////////////////////////////////
    // utilities
    /////////////////////////////////////////////

    "Form the intersection of the given types, without
     eliminating duplicates nor canonicalizing."
    shared
    Type intersection(Type *types)
        =>  ModelUtil.intersection(javaList(types), unit);

    "Form the intersection of the given types,
     canonicalizing, and eliminating duplicates."
    shared
    Type intersectionType(Type first, Type second)
        =>  ModelUtil.intersectionType(first, second, unit);

    "Form the union of the given types, without
     eliminating duplicates."
    shared
    Type union(Type *types)
        =>  ModelUtil.union(javaList(types), unit);

    "Form the union of the given types, without
     eliminating duplicates."
    shared
    Type unionType(Type first, Type second)
        =>  ModelUtil.unionType(first, second, unit);

    "The canonicalized intersection of the given
     type and Object"
    shared
    Type definiteType(Type type)
        =>  unit.getDefiniteType(type);

    shared
    Boolean equalDeclarations(Declaration first, Declaration second)
        =>  ModelUtil.equal(first, second);

    "True if the definite type of [[first]] is exactly the
     definite type of [[second]]."
    shared
    Boolean equalDefiniteTypes(Type first, Type second)
        =>  definiteType(first).isExactly(definiteType(second));

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
        if (isCeylonBoolean(intersectedRhs)) {
            return !isCeylonBoolean(intersectedLhs)
                    then nativeToCeylonBoolean;
        }
        else if (isCeylonFloat(intersectedRhs)) {
            return nativeToCeylonFloat;
        }
        else if (isCeylonInteger(intersectedRhs)) {
            return nativeToCeylonInteger;
        }
        else if (isCeylonString(intersectedRhs)) {
            return nativeToCeylonString;
        }

        // to native conversions
        if (isCeylonBoolean(intersectedLhs)) {
            return !isCeylonBoolean(intersectedRhs)
                    then ceylonBooleanToNative;
        }
        else if (isCeylonFloat(intersectedLhs)) {
            return ceylonFloatToNative;
        }
        else if (isCeylonInteger(intersectedLhs)) {
            return ceylonIntegerToNative;
        }
        else if (isCeylonString(intersectedLhs)) {
            return ceylonStringToNative;
        }
        return null;
    }
}
