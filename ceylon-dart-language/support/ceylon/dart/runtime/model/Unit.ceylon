import ceylon.collection {
    MutableList,
    ArrayList
}

import ceylon.dart.runtime.model.internal {
    assertedInterface,
    assertedClass,
    assertedValue,
    eq
}

shared
class Unit(pkg) {

    "The [[Package]] this unit belongs to."
    shared Package pkg;

    "The [[Module]] this unit belongs to."
    shared Module mod => pkg.mod;

    "The memo for [[declarations]], which must be generated lazily so that we can use
     `outer` in is definition."
    variable MutableList<Declaration>? declarationsMemo = null;

    shared
    MutableList<Declaration> declarations =>
            declarationsMemo else (declarationsMemo = object
            satisfies MutableList<Declaration> {

        value delegate = ArrayList<Declaration>();

        shared actual
        void add(Declaration element) {
            "A declaration being added to a unit must be an immediate member of the
             unit's package."
            assert (eq(element.container, pkg));

            "A declaration being added to a unit must have the same unit as the unit it
             is being added to."
            assert (element.unit == outer);

            delegate.add(element);
            pkg.markMemberCacheDirty();
        }

        shared actual
        void clear() {
            if (!delegate.empty) {
                delegate.clear();
                pkg.markMemberCacheDirty();
            }
        }

        shared actual
        MutableList<Declaration> clone() => delegate.clone();

        shared actual
        Declaration? delete(Integer index) {
            value result = delegate.delete(index);
            if (result exists) {
                pkg.markMemberCacheDirty();
            }
            return result;
        }

        shared actual
        void deleteMeasure(Integer from, Integer length) {
            pkg.markMemberCacheDirty();
            delegate.deleteMeasure(from, length);
        }

        shared actual
        void deleteSpan(Integer from, Integer to) {
            pkg.markMemberCacheDirty();
            delegate.deleteSpan(from, to);
        }

        shared actual
        Declaration? getFromFirst(Integer index)
            =>  delegate.getFromFirst(index);

        shared actual
        void infill(Declaration replacement) {}

        shared actual
        void insert(Integer index, Declaration element) {
            pkg.markMemberCacheDirty();
            delegate.insert(index, element);
        }

        shared actual
        Integer? lastIndex
            =>  delegate.lastIndex;

        shared actual
        void prune() {}

        shared actual
        Integer remove(Declaration element) {
            value result = delegate.remove(element);
            if (result > 0) {
                pkg.markMemberCacheDirty();
            }
            return result;
        }

        shared actual
        Boolean removeFirst(Declaration element)
            =>  pkg.markMemberCacheDirty(delegate.removeFirst(element));

        shared actual
        Boolean removeLast(Declaration element)
            =>  pkg.markMemberCacheDirty(delegate.removeLast(element));

        shared actual
        Integer replace(Declaration element, Declaration replacement) {
            value result = delegate.replace(element, replacement);
            pkg.markMemberCacheDirty();
            return result;
        }

        shared actual
        Boolean replaceFirst(Declaration element, Declaration replacement)
            =>  pkg.markMemberCacheDirty(delegate.replaceFirst(element, replacement));

        shared actual
        Boolean replaceLast(Declaration element, Declaration replacement)
            =>  pkg.markMemberCacheDirty(delegate.replaceLast(element, replacement));

        shared actual
        void set(Integer index, Declaration element) {
            delegate.set(index, element);
            pkg.markMemberCacheDirty();
        }

        shared actual
        void truncate(Integer size) {
            delegate.truncate(size);
            pkg.markMemberCacheDirty();
        }

        hash => delegate.hash;

        equals(Object that) => delegate.equals(that);
    });

    shared
    void addDeclaration(Declaration d)
        =>  declarations.add(d);

    shared
    void addDeclarations({Declaration*} d)
        =>  declarations.addAll(d);

    shared
    Integer removeDeclaration(Declaration d)
        =>  declarations.remove(d);

    shared
    Declaration? getImportedDeclaration(String name)
        // TODO manage imports
        =>  null;

    shared
    Declaration? getImportedMember(TypeDeclaration type, String name)
        // TODO manage imports; search for nonambiguous import alias for 'type'
        =>  null;

    ///////////////////////////////////
    //
    // Utilities
    //
    ///////////////////////////////////

    shared
    Package ceylonLanguagePackage
        =>  mod.ceylonLanguagePackage;

    shared
    Package ceylonLanguageMetaPackage
        =>  mod.ceylonLanguageMetaPackage;

    shared
    Package ceylonLanguageMetaDeclarationPackage
        =>  mod.ceylonLanguageMetaDeclarationPackage;

    shared
    Package ceylonLanguageMetaModelPackage
        =>  mod.ceylonLanguageMetaDeclarationPackage;

    shared
    Package ceylonLanguageSerializationPackage
        =>  mod.ceylonLanguageSerializationPackage;

    shared
    Class anythingDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Anything"));

    shared
    Class basicDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Basic"));

    shared
    Class characterDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Character"));

    shared
    Interface callableDeclaration
        =>  assertedInterface(ceylonLanguagePackage.getMember("Callable"));

    shared
    Interface emptyDeclaration
        =>  assertedInterface(ceylonLanguagePackage.getMember("Empty"));

    shared
    Class entryDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Entry"));

    shared
    Interface iterableDeclaration
        =>  assertedInterface(ceylonLanguagePackage.getMember("Iterable"));

    shared
    Class objectDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Object"));

    shared
    Class stringDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("String"));

    shared
    NothingDeclaration nothingDeclaration {
        assert (is NothingDeclaration declaration
            =   ceylonLanguagePackage.getMember("Nothing"));
        return declaration;
    }

    shared
    Class nullDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Null"));

    shared
    Value nullValueDeclaration
        =>  assertedValue(ceylonLanguagePackage.getMember("null"));

    shared
    Interface sequenceDeclaration
        =>  assertedInterface(ceylonLanguagePackage.getMember("Sequence"));

    shared
    Interface sequentialDeclaration
        =>  assertedInterface(ceylonLanguagePackage.getMember("Sequential"));

    shared
    Class tupleDeclaration
        =>  assertedClass(ceylonLanguagePackage.getMember("Tuple"));

    shared
    Type unknownType
        =>  UnknownType(this).type;

    shared
    Type getIterableType(Type elementType, Boolean nonEmpty = false)
        =>  iterableDeclaration.appliedType {
                null;
                [
                    elementType,
                    if (nonEmpty)
                    then nothingDeclaration.type
                    else nullDeclaration.type
                ];
            };

    shared
    Type getSequentialType(Type elementType)
        =>  sequentialDeclaration.appliedType(null, [elementType]);

    shared
    Type getSequenceType(Type elementType)
        =>  sequenceDeclaration.appliedType(null, [elementType]);

    shared
    Type? getSequentialElementType(Type type) {
        if (exists st = type.getSupertype(sequentialDeclaration)) {
            assert (exists elementType = st.typeArgumentList.first);
            if (elementType.isTuple && elementType.isUnion) {
                // total hack to accommodate the fact that tuple types are created
                // with unsimplified unions
                return unionDeduped(elementType.caseTypes, type.declaration.unit);
            }
            return elementType;
        }
        return null;
    }
}
