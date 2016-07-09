import ceylon.collection {
    MutableSet,
    HashMap,
    linked,
    HashSet,
    Stability,
    ArrayList,
    MutableList
}
import ceylon.language {
    createMap=map
}

"Implementation of [[Multimap]] that uses an [[ArrayList]] to store
 the items for a given key. A [[HashMap]] associates each key with an
 [[ArrayList]] of items.

 When iterating through the collections supplied by this class, the
 ordering of items for a given key agrees with the order in which the items
 were added.

 This multimap allows duplicate key-item pairs. After adding a new
 key-item pair equal to an existing key-item pair, the `ArrayListMultimap`
 will contain entries for both the new item and the old item."
shared
class ArrayListMultimap<Key, Item>
        satisfies MutableListMultimap<Key, Item>
        given Key satisfies Object {

    Stability keyStability;

    // variable for now so we can set to null to save memory on backends that don't
    // optimize class captures.
    variable {<Key->Item>*}? initialEntries;

    shared new (
            "Determines whether a linked hash map with a stable iteration order will be
             used for this multimap's keys, defaulting to [[linked]] (stable)."
            Stability keyStability = linked,
            {<Key->Item>*} entries = []) {
        this.keyStability = keyStability;
        this.initialEntries = entries;
    }

    value backingMap = HashMap<Key, MutableList<Item>> { stability = keyStability; };

    variable value totalSize = 0;

    size => totalSize;

    function createCollection({Item*} items = [])
        =>  ArrayList<Item> { elements = items; };

    shared actual
    Boolean put(Key key, Item item) {
        if (exists m = backingMap.get(key)) {
            m.add(item);
            totalSize++;
            return true;
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
        backingMap.items.each(MutableList.clear);
        backingMap.clear();
        totalSize = 0;
    }

    shared actual
    List<Item> removeAll(Key key) {
        if (exists removed = backingMap.remove(key)) {
            value result = removed.sequence();
            removed.clear();
            totalSize -= removed.size;
            return result;
        }
        return [];
    }

    shared actual
    List<Item> replaceItems(Key key, {Item*} items) {
        value l = get(key);
        value oldItems = l.sequence();
        l.clear();
        l.addAll(items);
        return oldItems;
    }

    shared actual
    MutableList<Item> get(Key key) => object satisfies MutableList<Item> {

        "The delegate, that if empty is detached from the backingMap."
        variable MutableList<Item> delegate
            =   backingMap.get(key) else createCollection();

        "Replace the delegate with a more current non-empty map, if one exists."
        void refreshIfEmpty() {
            if (delegate.empty, exists newDelegate = outer.backingMap[key]) {
                delegate = newDelegate;
            }
        }

        "Convenience method to call refreshIfEmpty() for operations that may mutate the
         size of the list."
        Integer beforeMutation()
            =>  size; // calls refreshIfEmpty

        "Convenience method to update the [[totalSize]] and call add or remove the
         delegate from the backing map as necessary for operations that may mutate the
         size of the list."
        void afterMutation(Integer oldSize) {
            value newSize = delegate.size;
            totalSize += newSize - oldSize;
            if (oldSize == 0 && newSize != 0) {
                backingMap.put(key, delegate);
            }
            if (oldSize !=0 && newSize == 0) {
                backingMap.remove(key);
            }
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
            value oldSize = beforeMutation();
            delegate.add(element);
            afterMutation(oldSize);
            return true;
        }

        shared actual
        void clear() {
            value oldSize = beforeMutation();
            delegate.clear();
            afterMutation(oldSize);
        }

        shared actual
        Integer remove(Item & Object element) {
            value oldSize = beforeMutation();
            value result = delegate.remove(element);
            afterMutation(oldSize);
            return result;
        }

        shared actual
        Integer removeAll({Item & Object*} elements) {
            value oldSize = beforeMutation();
            value count = delegate.removeAll(elements);
            afterMutation(oldSize);
            return count;
        }

        shared actual
        MutableList<Item> clone() {
            refreshIfEmpty();
            return createCollection { *this };
        }

        shared actual
        Item? delete(Integer index) {
            value oldSize = beforeMutation();
            value result = delegate.delete(index);
            afterMutation(oldSize);
            return result;
        }

        shared actual
        void deleteMeasure(Integer from, Integer length) {
            value oldSize = beforeMutation();
            delegate.deleteMeasure(from, length);
            afterMutation(oldSize);
        }

        shared actual
        void deleteSpan(Integer from, Integer to) {
            value oldSize = beforeMutation();
            delegate.deleteSpan(from, to);
            afterMutation(oldSize);
        }

        shared actual
        Item? getFromFirst(Integer index) {
            refreshIfEmpty();
            return delegate.getFromFirst(index);
        }

        shared actual
        void infill(Item replacement) {
            refreshIfEmpty();
            delegate.infill(replacement);
        }

        shared actual
        void insert(Integer index, Item element) {
            value oldSize = beforeMutation();
            delegate.insert(index, element);
            afterMutation(oldSize);
        }

        shared actual
        Integer? lastIndex {
            refreshIfEmpty();
            return delegate.lastIndex;
        }

        shared actual
        void prune() {
            value oldSize = beforeMutation();
            delegate.prune();
            afterMutation(oldSize);
        }

        shared actual
        Boolean removeFirst(Item & Object element) {
            value oldSize = beforeMutation();
            value result = delegate.removeFirst(element);
            afterMutation(oldSize);
            return result;
        }

        shared actual
        Boolean removeLast(Item & Object element) {
            value oldSize = beforeMutation();
            value result = delegate.removeLast(element);
            afterMutation(oldSize);
            return result;
        }

        shared actual
        void replace(Item & Object element, Item replacement) {
            refreshIfEmpty();
            delegate.replace(element, replacement);
        }

        shared actual
        Boolean replaceFirst(Item & Object element, Item replacement) {
            refreshIfEmpty();
            return delegate.replaceFirst(element, replacement);
        }

        shared actual
        Boolean replaceLast(Item & Object element, Item replacement) {
            refreshIfEmpty();
            return delegate.replaceLast(element, replacement);
        }

        shared actual
        void set(Integer index, Item element) {
            refreshIfEmpty();
            delegate.set(index, element);
        }

        shared actual
        void truncate(Integer size) {
            value oldSize = beforeMutation();
            truncate(size);
            afterMutation(oldSize);
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
    Map<Key, MutableList<Item>> asMap => object extends Object()
            satisfies Map<Key, MutableList<Item>> {

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

    iterator() => { for (key -> s in backingMap) for (i in s) key -> i }.iterator();

    clone() => ArrayListMultimap { keyStability = keyStability; *this };

    defines(Key key) => backingMap.defines(key);

    hash => (super of Multimap<Key, Item>).hash;

    equals(Object that) => (super of Multimap<Key, Item>).equals(that);
}
