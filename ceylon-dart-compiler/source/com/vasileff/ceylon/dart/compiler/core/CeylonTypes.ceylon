import ceylon.interop.java {
    CeylonIterable,
    JavaList
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
    Function,
    Package
}
import com.vasileff.ceylon.dart.compiler {
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
    Type callableAnythingType => ModelUtil.appliedType(
            callableDeclaration, nothingType, sequentialAnythingType);

    shared
    Type characterType => unit.characterType;

    shared
    Type destroyableType => unit.destroyableType;

    shared
    Type entryAnythingType => ModelUtil.appliedType(
            entryDeclaration, anythingType, anythingType);

    shared
    Type exceptionType => unit.exceptionType;

    shared
    Type emptyType => unit.emptyType;

    shared
    Type floatType => unit.floatType;

    shared
    Type integerType => unit.integerType;

    shared
    Type identifiableType => unit.identifiableType;

    shared
    Type iterableAnythingType => ModelUtil.appliedType(
            iterableDeclaration, anythingType, nullType);

    shared
    Type iterableNothingType => ModelUtil.appliedType(
            iterableDeclaration, nothingType, nullType);

    shared
    Type listAnythingType => ModelUtil.appliedType(
            listDeclaration, anythingType);

    shared
    Type obtainableType => unit.obtainableType;

    shared
    Type sequenceAnythingType => ModelUtil.appliedType(
            sequenceDeclaration, anythingType);

    shared
    Type sequentialAnythingType => ModelUtil.appliedType(
            sequentialDeclaration, anythingType);

    shared
    Type throwableType => unit.throwableType;

    shared
    Type tupleAnythingType => ModelUtil.appliedType(
            tupleDeclaration, anythingType, anythingType, sequentialAnythingType);

    shared
    Type stringType => unit.stringType;

    shared
    Type nothingType => unit.nothingType;

    /////////////////////////////////////////////
    // Dart Specific Types and Declarations
    /////////////////////////////////////////////

    Package interopPackage
        // Hack: this unit's module may not import ceylon.interop.dart, even though it
        // will always be available (it's imported by the language module, and force
        // imported within all generated dart files). So, use the language module to
        // find it.
        =>  unit.\ipackage.\imodule.languageModule.getPackage("ceylon.interop.dart");

    Package modelPackage
        // use the language module to find the package; see interopPackage notes
        =>  unit.\ipackage.\imodule.languageModule.getPackage(
                "ceylon.dart.runtime.model");

    Package modelRuntimePackage
        // use the language module to find the package; see interopPackage notes
        =>  unit.\ipackage.\imodule.languageModule.getPackage(
                "ceylon.dart.runtime.model.runtime");

    Package implMetaPackage
        =>  unit.\ipackage.\imodule.getPackage("ceylon.language.impl.meta");

    shared
    Class asyncDeclaration {
        assert (is Class async
            =   interopPackage
                .getDirectMember("AsyncAnnotation", null, false));
        return async;
    }

    shared
    Class ceylonIterable {
        assert (is Class c
            =   interopPackage
                .getDirectMember("CeylonIterable", null, false));
        return c;
    }

    shared
    Boolean isAsyncDeclaration(TypeDeclaration declaration)
        =>  declaration.qualifiedNameString == "ceylon.interop.dart::AsyncAnnotation";

    shared
    Function awaitDeclaration {
        assert (is Function await
            =   interopPackage
                .getDirectMember("await", null, false));
        return await;
    }

    shared
    Class jsonObjectDeclaration
        =>  assertClass(interopPackage.getDirectMember("JsonObject", null, false));

    shared
    Class moduleDeclaration
        =>  assertClass(modelPackage.getDirectMember("Module", null, false));

    shared
    Class moduleImplDeclaration
        =>  assertClass(implMetaPackage.getDirectMember("ModuleImpl", null, false));

    shared
    Function newTypeImplDeclaration
        =>  assertFunction(implMetaPackage.getDirectMember("newClass", null, false));

    shared
    Boolean isAwaitDeclaration(Function declaration)
        =>  declaration == awaitDeclaration;

    shared
    Class typeDescriptorDeclaration {
        assert (is Class c
            =   modelRuntimePackage
                .getDirectMember("TypeDescriptor", null, false));
        return c;
    }

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
    Boolean isCeylonIdentifiable(Type type)
        =>  type.isExactly(identifiableType);

    shared
    Boolean isCeylonInteger(Type type)
        =>  type.isExactly(integerType);

    "True if [[type]] is a subtype of Iterable<Anything>"
    shared
    Boolean isCeylonIterable(Type type)
        =>  unit.isIterableType(type);

    "True if [[type]] is a subtype of Sequential<Anything>"
    shared
    Boolean isCeylonSequential(Type type)
        =>  unit.isSequentialType(type);

    "True if [[type]] is a subtype of Sequence<Anything>"
    shared
    Boolean isCeylonSequence(Type type)
        =>  unit.isSequenceType(type);

    "True if [[type]] is a subtype of List<Anything>"
    shared
    Boolean isCeylonList(Type type)
        =>  type.isSubtypeOf(listAnythingType);

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
    Class anythingDeclaration
        =>  unit.anythingDeclaration;

    shared
    Class basicDeclaration
        =>  unit.basicDeclaration;

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
    Package ceylonLanguageDartPackage
        =>  unit.\ipackage.\imodule.getPackage("ceylon.language.dart");

    shared
    Interface comparableDeclaration
        =>  unit.comparableDeclaration;

    shared
    Function dartWrapThrownObjectDeclaration
        =>  assertFunction(ceylonLanguageDartPackage
                .getMember("wrapThrownObject", null, false));

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
    Value falseValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("false"));

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
    Interface indexedCorrespondenceMutatorDeclaration
        =>  unit.indexedCorrespondenceMutatorDeclaration;

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
    Function iterableMapDeclaration
        =>  assertFunction(iterableDeclaration.getMember("map", null, false));

    shared
    Function iterableSequenceDeclaration
        =>  assertFunction(iterableDeclaration.getMember("sequence", null, false));

    shared
    Interface iteratorDeclaration
        =>  unit.iteratorDeclaration;

    shared
    Interface listDeclaration
        =>  unit.listDeclaration;

    shared
    Interface keyedCorrespondenceMutatorDeclaration
        =>  unit.keyedCorrespondenceMutatorDeclaration;

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
    Value trueValueDeclaration
        =>  assertValue(getLanguageModuleDeclaration("true"));

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
    Boolean isIterableDeclaration(Declaration declaration)
        =>  equalDeclarations(declaration, iterableDeclaration);

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
    Type union({Type*} types)
        =>  ModelUtil.union(javaList(types), unit);

    "Form the union of the given types, without
     eliminating duplicates."
    shared
    Type unionType(Type first, Type second)
        =>  ModelUtil.unionType(first, second, unit);

    "The canonicalized intersection of the given type and Object"
    shared
    Type definiteType(Type type)
        =>  unit.getDefiniteType(type);

    shared
    Type getTupleType([Type*] elementTypes,
                        Integer? firstDefaulted = null,
                        "- `true` for a non-empty variadic Rest
                         - `false` for a possibly-empty variadic Rest
                         - a [[Type]] for an explicitly specified Rest
                         - `null` if not variadic"
                        Boolean | Type | Null restType = null)
        =>  let (typeList = JavaList(elementTypes)) (
            switch (restType)
            case (is Type)
                unit.getTupleType(typeList, restType, firstDefaulted else -1)
            case (is Boolean)
                unit.getTupleType(typeList, true, restType, firstDefaulted else -1)
            case (is Null)
                unit.getTupleType(typeList, false, false, firstDefaulted else -1));

    shared
    Type getCallableType(Type returnType, Type* argumentTypes)
        =>  ModelUtil.appliedType(
                callableDeclaration,
                returnType,
                getTupleType(argumentTypes));

    shared
    Type getSequentialTypeForIterable(Type iterableType) {
        if (isCeylonSequential(iterableType)) {
            return iterableType;
        }

        value iteratedType = getIteratedType(iterableType);
        if (unit.isNonemptyIterableType(iterableType)) {
            return unit.getSequenceType(iteratedType);
        }
        else {
            return unit.getSequentialType(iteratedType);
        }
    }

    shared
    Type getIteratedType(Type iterableType)
        =>  unit.getIteratedType(iterableType);

    shared
    Type getSetElementType(Type setType)
        =>  unit.getSetElementType(setType);

    shared
    Type getCallableReturnType(Type callableType)
        =>  unit.getCallableReturnType(callableType);

    shared
    Type? getCallableTuple(Type callableType)
        =>  unit.getCallableTuple(callableType) else null;

    shared
    [Type, Type]? getCallableReturnAndTuple(Type callableType) {
        if (exists ct = callableType.getSupertype(callableDeclaration)) {
            value typeArgs = ct.typeArgumentList;
            return [typeArgs.get(0), typeArgs.get(1)];
        }
        return null;
    }

    shared
    Boolean equalDeclarations(Declaration first, Declaration second)
        =>  ModelUtil.equal(first, second);

    "True if the definite type of [[first]] is exactly the
     definite type of [[second]]."
    shared
    Boolean equalDefiniteTypes(Type first, Type second)
        =>  definiteType(first).isExactly(definiteType(second));

    "Returns the minimum length of the given Sequential type."
    shared
    Integer sequentialMinimumLength(Type args)
        =>  unit.getTupleMinimumLength(args);

    "Returns the smaller of [[upTo]] and the largest possible size of the given
     Sequential type."
    shared
    Integer sequentialMaximumLength(Type args, Integer upTo) {
        if (args.union) {
            assert (exists result
                =   max(CeylonIterable(args.caseTypes).map((t)
                    =>  sequentialMaximumLength(t, upTo))));
            return result;
        }

        if (args.isSubtypeOf(emptyType)) {
            return 0;
        }

        if (exists tuple = args.getSupertype(tupleDeclaration)) {
            return 1 + sequentialMaximumLength(tuple.typeArgumentList.get(2), upTo - 1);
        }

        // Must be a non-Tuple Sequential or Nothing
        return upTo;
    }

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
        =>  t.typeArgumentList.size() > 0
            then t.typeArgumentList.get(0);
}
