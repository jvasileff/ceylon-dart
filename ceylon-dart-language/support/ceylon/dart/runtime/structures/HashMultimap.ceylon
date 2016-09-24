import ceylon.dart.runtime.nativecollection {
    MutableSet,
    HashMap,
    linked,
    HashSet,
    unlinked,
    Stability
}
import ceylon.language {
    createMap=map
}

"Implementation of [[Multimap]] using hash tables.

 The multimap does not store duplicate key->item pairs. Adding a new
 key->item pair equal to an existing key->item pair has no effect.

 Keys and items may be null."
shared
class HashMultimap<Key, Item>
        satisfies MutableSetMultimap<Key, Item>
        given Key satisfies Object given Item satisfies Object {

    Stability keyStability;

    Stability itemStability;

    // variable for now so we can set to null to save memory on backends that don't
    // optimize class captures.
    variable {<Key->Item>*}? initialEntries;

    shared new (
            "Determines whether a linked hash map with a stable iteration order will be used
             for this multimap's keys, defaulting to [[linked]] (stable)."
            Stability keyStability = linked,
            "Determines whether a linked hash set with a stable iteration order will be used
             for the items for each of this multimap's keys, defaulting to [[linked]]
             (stable)."
            Stability itemStability = linked,
            {<Key->Item>*} entries = []) {
        this.keyStability = keyStability;
        this.itemStability = itemStability;
        this.initialEntries = entries;
    }

    value backingMap = HashMap<Key, MutableSet<Item>> { stability = keyStability; };

    variable value totalSize = 0;

    size => totalSize;

    function createCollection({Item*} items = [])
        =>  HashSet<Item> { stability = itemStability; elements = items; };

    shared actual
    Boolean put(Key key, Item item) {
        if (exists m = backingMap.get(key)) {
            if (m.add(item)) {
                totalSize++;
                return true;
            }
            return false;
        }
        backingMap.put(key, createCollection([item]));
        totalSize++;
        return true;
    }

    if (exists e = initialEntries) {
        for (key->item in e) {
            put(key, item);
        }
        initialEntries = null;
    }

    shared actual
    void clear() {
        backingMap.items.each(MutableSet.clear);
        backingMap.clear();
        totalSize = 0;
    }

    shared actual
    Set<Item> removeAll(Key key) {
        if (exists removed = backingMap.remove(key)) {
            value result = set(removed);
            removed.clear();
            totalSize -= removed.size;
            return result;
        }
        return emptySet;
    }

    shared actual
    Set<Item> replaceItems(Key key, {Item*} items) {
        value s = get(key);
        value oldItems = set(s);
        s.clear();
        s.addAll(items);
        return oldItems;
    }

    shared actual
    MutableSet<Item> get(Key key) => object satisfies MutableSet<Item> {

        "The delegate, that if empty is detached from the backingMap."
        variable MutableSet<Item> delegate
            =   backingMap.get(key) else createCollection();

        "Replace the delegate with a more current non-empty map, if one exists."
        void refreshIfEmpty() {
            if (delegate.empty, exists newDelegate = outer.backingMap[key]) {
                delegate = newDelegate;
            }
        }

        "Detach the delegate from the backingMap if now empty."
        void removeIfEmpty() {
            if (delegate.empty) {
                backingMap.remove(key);
            }
        }

        "Put the delegate into the backing map. This must *only* be called when the
         delegate is non-empty!"
        void addToBackingMap() {
            // assert(!delegate.empty);
            backingMap.put(key, delegate);
        }

        shared actual
        Integer size {
            refreshIfEmpty();
            return delegate.size;
        }

        shared actual
        Boolean equals(Object that) {
            refreshIfEmpty();
            return delegate.equals(that);
        }

        shared actual
        Integer hash {
            refreshIfEmpty();
            return delegate.hash;
        }

        shared actual
        String string {
            refreshIfEmpty();
            return delegate.string;
        }

        shared actual
        Iterator<Item> iterator() {
            refreshIfEmpty();
            return delegate.iterator();
        }

        shared actual
        Boolean add(Item element) {
            refreshIfEmpty();
            value wasEmpty = delegate.empty;
            value changed = delegate.add(element);
            if (changed) {
                totalSize++;
                if (wasEmpty) {
                    addToBackingMap();
                }
            }
            return changed;
        }

        shared actual
        void clear() {
            value oldSize = size; // calls refreshIfEmpty
            if (oldSize == 0) {
                return;
            }
            delegate.clear();
            totalSize -= oldSize;
            removeIfEmpty();
        }

        shared actual
        Boolean remove(Item element) {
            refreshIfEmpty();
            value changed = delegate.remove(element);
            if (changed) {
                totalSize--;
                removeIfEmpty();
            }
            return changed;
        }

        shared actual
        Boolean removeAll({Item*} elements) {
            value oldSize = size; // calls refreshIfEmpty
            value changed = delegate.removeAll(elements);
            if (changed) {
                value newSize = delegate.size;
                totalSize += newSize - oldSize;
                removeIfEmpty();
            }
            return changed;
        }

        shared actual
        MutableSet<Item> clone() {
            refreshIfEmpty();
            return createCollection { *this };
        }
    };

    shared actual
    Collection<Item> items => object satisfies Collection<Item> {

        clone() => [*this];

        iterator() => { for (key -> s in backingMap) for (i in s) i }.iterator();

        size => outer.size;
    };

    shared actual
    MutableSet<Key> keys => object satisfies MutableSet<Key> {

        clone() => HashSet { stability = keyStability; *this };

        contains(Object key) => backingMap.defines(key);

        iterator() => backingMap.keys.iterator();

        size => backingMap.size;

        empty => backingMap.empty;

        add(Key element) => false;

        clear() => outer.clear();

        remove(Key element) => !outer.removeAll(element).empty;

        hash => (super of Set<Key>).hash;

        equals(Object that) => (super of Set<Key>).equals(that);
    };

    shared actual
    Map<Key, MutableSet<Item>> asMap => object extends Object()
            satisfies Map<Key, MutableSet<Item>> {

        // Note: we could return a MutableMap, but the semantics for put would be a
        // bit screwy.

        // clone the items too, since they are live views into the multimap
        // TODO stability?
        clone() => createMap(this.map((entry) => entry.key -> entry.item.clone()));

        defines(Object key) => backingMap.defines(key);

        keys => outer.keys;

        size => backingMap.size;

        iterator() => keys.map((k) => k -> outer.get(k)).iterator();

        get(Object key) => if (defines(key), is Key key) then outer.get(key) else null;
    };

    shared actual
    MutableSet<Key->Item> entries => object satisfies MutableSet<Key->Item> {

        clone() => HashSet {
            stability = if (keyStability == linked
                            || itemStability == linked)
                        then linked
                        else unlinked;
            *this
        };

        contains(Object element) => asMap.contains(element);

        iterator() => { for (key -> s in backingMap) for (i in s) key -> i }.iterator();

        size => outer.size;

        empty => outer.empty;

        add(Key->Item element) => outer.putEntry(element);

        clear() => outer.clear();

        remove(Key->Item element) => outer.removeEntry(element);

        hash => (super of Set<Key->Item>).hash;

        equals(Object that) => (super of Set<Key->Item>).equals(that);
    };

    iterator() => { for (key -> s in backingMap) for (i in s) key -> i }.iterator();

    clone() => HashMultimap { *this };

    defines(Key key) => backingMap.defines(key);

    hash => (super of Multimap<Key, Item>).hash;

    equals(Object that) => (super of Multimap<Key, Item>).equals(that);
}
