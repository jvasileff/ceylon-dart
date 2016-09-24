import ceylon.interop.dart {
    CeylonIterable,
    DartIterable
}
import dart.core {
    DSet = Set
}
import dart.collection {
    DHashSet = HashSet,
    DLinkedHashSet = LinkedHashSet
}

shared class HashSet<Element>
        satisfies MutableSet<Element>
        given Element satisfies Object {

    Stability stability;

    DSet<Element> delegate;

    shared new (Stability stability = linked, {Element*} elements = []) {
        this.stability = stability;

        this.delegate
            =   switch (stability)
                case (linked) DLinkedHashSet.Class.from(DartIterable(elements))
                case (unlinked) DHashSet.Class.from(DartIterable(elements));
    }

    new newClone(Stability stability, DSet<Element> delegate) {
        this.stability = stability;

        this.delegate
            =   switch (stability)
                case (linked) DLinkedHashSet.Class.from(delegate)
                case (unlinked) DHashSet.Class.from(delegate);
    }

    iterator() => CeylonIterable(delegate).iterator();

    size => delegate.length;

    empty => delegate.isEmpty;

    add(Element element) => delegate.add(element);

    remove(Element element) => delegate.remove(element);

    shared actual
    HashSet<Element> clone() => newClone(stability, delegate);

    clear() => delegate.clear(); 

    equals(Object other) => (super of MutableSet<Element>).equals(other);

    hash => (super of MutableSet<Element>).hash;
}
