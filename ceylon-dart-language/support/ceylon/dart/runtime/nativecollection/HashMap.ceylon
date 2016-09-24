import ceylon.interop.dart {
    CeylonIterable
}
import dart.core {
    DMap = Map
}
import dart.collection {
    DHashMap = HashMap,
    DLinkedHashMap = LinkedHashMap
}

shared class HashMap<Key, Item>
        satisfies MutableMap<Key, Item>
        given Key satisfies Object {

    Stability stability;

    DMap<Key, Item> delegate;

    shared new(Stability stability = linked, {<Key -> Item>*} entries = []) {
        this.stability = stability;

        this.delegate
            =   switch (stability)
                case (linked) DLinkedHashMap.Class<Key, Item>()
                case (unlinked) DHashMap.Class<Key, Item>();

        for (entry in entries) {
            delegate.set_(entry.key, entry.item);
        }
    }

    new newClone(Stability stability, DMap<Key, Item> delegate) {
        this.stability = stability;

        this.delegate
            =   switch (stability)
                case (linked) DLinkedHashMap.Class.from(delegate)
                case (unlinked) DHashMap.Class.from(delegate);
    }

    iterator()
        =>  CeylonIterable(delegate.keys).map(
                (k) => k -> delegate.get_(k)).iterator();

    keys => object satisfies Set<Key> {
        contains(Object key) => delegate.containsKey(key);
        iterator() => CeylonIterable(delegate.keys).iterator();
        size => outer.size;
        empty => outer.empty;
        clone() => set(this);
        hash => (super of Set<Key>).hash;
        equals(Object that) => (super of Set<Key>).equals(that);
    };

    items => object satisfies Collection<Item> {
        contains(Object item) => delegate.containsValue(item);
        iterator() => CeylonIterable(delegate.values).iterator();
        size => outer.size;
        empty => outer.empty;
        clone() => [*this];
        //implement hash and equals for bag semantics​
        hash => frequencies().hash;
        equals(Object that)
            // this is suspect...
            =>  if (is Collection<Item> that) 
                then frequencies() == that.frequencies() 
                else false;
    };

    defines(Object key) => delegate.containsKey(key);

    shared actual Item? put(Key key, Item item) {
        value previous = delegate.get_(key);
        delegate.set_(key, item);
        return previous;
    }

    size => delegate.length;

    empty => delegate.isEmpty;

    remove(Key key) => delegate.remove(key);

    get(Object key) => delegate.get_(key);

    clone() => newClone(stability, delegate);

    clear() => delegate.clear(); 

    equals(Object other) => (super of MutableMap<Key, Item>).equals(other);

    hash => (super of MutableMap<Key, Item>).hash;
}
