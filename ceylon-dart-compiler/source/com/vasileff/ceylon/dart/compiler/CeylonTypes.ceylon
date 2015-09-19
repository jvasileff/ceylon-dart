import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.model.typechecker.model {
    Type,
    Unit,
    ModelUtil,
    Declaration,
    Interface,
    TypeDeclaration,
    Value,
    Class,
    ClassOrInterface,
    Function
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

shared
class CeylonTypes(Unit unit) {

    /////////////////////////////////////////////
    // common types
    /////////////////////////////////////////////

    shared
    Type assertionErrorType => assertionErrorDeclaration.type;

    shared
    Type anythingType => unit.anythingType;

    shared
    Type finishedType => finishedDeclaration.type;

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
    Type emptyType => unit.emptyType;

    shared
    Type floatType => unit.floatType;

    shared
    Type integerType => unit.integerType;

    shared
    Type identifiableType => unit.identifiableType;

    shared
    Type sequenceAnythingType => ModelUtil.appliedType(
            sequenceDeclaration, anythingType);

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
        =>  type.isExactly(booleanType)
            || (let (declaration = type.declaration)
                isBooleanTrueTypeDeclaration(declaration)
                || isBooleanFalseTypeDeclaration(declaration)
                || type.union && CeylonIterable(type.caseTypes).every(isCeylonBoolean));

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
    Boolean isCeylonEmpty(Type type)
        =>  type.isExactly(emptyType) || type.emptyValue;

    shared
    Boolean isCeylonFloat(Type type)
        =>  type.isExactly(floatType);

    shared
    Boolean isCeylonInteger(Type type)
        =>  type.isExactly(integerType);

    "True if [[type]] is a subtype of Sequential<Anything>"
    shared
    Boolean isCeylonSequential(Type type)
        =>  unit.isSequentialType(type);

    "True if [[type]] is a subtype of Sequence<Anything>"
    shared
    Boolean isCeylonSequence(Type type)
        =>  unit.isSequenceType(type);

    shared
    Boolean isCeylonString(Type type)
        =>  type.isExactly(stringType);

    shared
    Boolean isCeylonTuple(Type type)
        =>  unit.isTupleType(type);

    shared
    Boolean isCeylonNothing(Type type)
        =>  type.isExactly(nothingType);

    /////////////////////////////////////////////
    // common declarations
    /////////////////////////////////////////////

    Class assertClass(Declaration declaration) {
        assert (is Class declaration);
        return declaration;
    }

    suppressWarnings("unusedDeclaration")
    Interface assertInterface(Declaration declaration) {
        assert (is Interface declaration);
        return declaration;
    }

    Value assertValue(Declaration declaration) {
        assert (is Value declaration);
        return declaration;
    }

    Function assertFunction(Declaration declaration) {
        assert (is Function declaration);
        return declaration;
    }

    shared
    Declaration getLanguageModuleDeclaration(String name)
        =>  unit.getLanguageModuleDeclaration(name);

    shared
    Class assertionErrorDeclaration
        =>  assertClass(getLanguageModuleDeclaration("AssertionError"));

    shared
    Class booleanDeclaration
        =>  assertClass(unit.booleanDeclaration);

    shared
    Value booleanTrueValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("true"));

    shared
    TypeDeclaration booleanTrueTypeDeclaration
        =>  booleanTrueValueDeclaration.typeDeclaration;

    shared
    Value booleanFalseValueDeclaration
        => assertValue(getLanguageModuleDeclaration("false"));

    shared
    TypeDeclaration booleanFalseTypeDeclaration
        =>  booleanFalseValueDeclaration.typeDeclaration;

    shared
    Interface callableDeclaration
        =>  unit.callableDeclaration;

    shared
    Interface comparableDeclaration
        =>  unit.comparableDeclaration;

    shared
    Class entryDeclaration
        =>  unit.entryDeclaration;

    shared
    Value emptyValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("empty"));

    shared
    Value emptyIteratorValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("emptyIterator"));

    shared
    Interface enumerableDeclaration
        =>  unit.enumerableDeclaration;

    shared
    Interface exponentiableDeclaration
        =>  unit.exponentiableDeclaration;

    shared
    Class finishedDeclaration
        =>  assertClass(getLanguageModuleDeclaration("Finished"));

    shared
    Value finishedValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("finished"));

    shared
    Class floatDeclaration
        =>  assertClass(unit.floatDeclaration);

    shared
    Interface identifiableDeclaration
        =>  unit.identifiableDeclaration;

    shared
    Class integerDeclaration
        =>  assertClass(unit.integerDeclaration);

    shared
    Interface integralDeclaration
        =>  unit.integralDeclaration;

    shared
    Interface invertibleDeclaration
        =>  unit.invertableDeclaration;

    shared
    Interface iterableDeclaration
        =>  unit.iterableDeclaration;

    shared
    Interface iteratorDeclaration
        =>  unit.iteratorDeclaration;

    shared
    Function measureFunctionDeclaration
        =>  assertFunction(getLanguageModuleDeclaration("measure"));

    shared
    Class nullDeclaration
        =>  unit.nullDeclaration;

    shared
    Value nullValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("null"));

    shared
    TypeDeclaration nullTypeDeclaration
        =>  nullValueDeclaration.typeDeclaration;

    shared
    Interface numericDeclaration
        =>  unit.numericDeclaration;

    shared
    Class tupleDeclaration
        =>  unit.tupleDeclaration;

    shared
    Class objectDeclaration
        =>  unit.objectDeclaration;

    shared
    Interface sequenceDeclaration
        =>  unit.sequenceDeclaration;

    shared
    Interface sequentialDeclaration
        =>  unit.sequentialDeclaration;

    shared
    Function spanFunctionDeclaration
        =>  assertFunction(getLanguageModuleDeclaration("span"));

    shared
    Class stringDeclaration
        =>  assertClass(unit.stringDeclaration);

    shared
    Interface summableDeclaration
        =>  unit.summableDeclaration;

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

    "Returns a type that should be denotable on platforms that do not support union and
     intersection types and that treat `null` as the bottom type. This is useful when
     accessing members of [[required]], since [[expressionType]] may translate to a top
     type, such as `Object`, on the target platform."
    shared
    Type denotableType(Type expressionType, ClassOrInterface required)
        // FIXME This returns null when Type is Nothing
        //       or when no suitable type exists
        // FIXME Really. Now just returning Object. If correct, only by very lucky chance.
        =>  definiteType(expressionType).getSupertype(required) else objectType;

    "Return the first type argument, or null if the type does not have type arguments."
    shared
    Type? typeArgument(Type t)
        =>  t.typeArgumentList.get(0);
}
