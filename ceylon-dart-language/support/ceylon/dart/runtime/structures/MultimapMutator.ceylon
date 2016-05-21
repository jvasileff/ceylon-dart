import ceylon.collection {
    MutableSet
}

shared
interface MultimapMutator<Key, in Item>
        satisfies Multimap<Key, Anything>
        given Key satisfies Object {

    shared actual formal
    MutableSet<Key> keys;


    "Removes all key->item pairs from the multimap, leaving it [[empty]]."
    shared formal
    void clear();

    "Stores a key->item pair in this multimap.

     Some multimap implementations allow duplicate key->item pairs, in which
     case `put` always adds a new key->item pair and increases the
     multimap size by 1. Other implementations prohibit duplicates, and storing
     a key->item pair that's already in the multimap has no effect.

     Returns `true` if the method increased the size of the multimap, or `false` if
     the multimap already contained the key->item pair and doesn't allow duplicates"
    shared formal
    Boolean put(Key key, Item item);

    shared default see(`function put`)
    Boolean putEntry(Key -> Item entry)
        =>  put(entry.key, entry.item);

    "Store all [[entries]] in this multimap.

     Returns `true` if the multimap changed"
    shared default
    Boolean putEntries({<Key -> Item>*} entries) {
        variable value result = false;
        for (key -> item in entries) {
            result = put(key, item) || result;
        }
        return result;
    }

    "Stores a key->item pair in this multimap for each of [[items]], all
     using the same key, [[key]].

     Returns `true` if the multimap changed"
    shared default
    Boolean putMultiple(Key key, {Item*} items) {
        variable value result = false;
        for (item in items) {
            result = put(key, item) || result;
        }
        return result;
    }

    "Removes a single key->item pair with the key [[key]] and the item
     [[item]] from this multimap, if such exists. If multiple key->item
     pairs in the multimap fit this description, which one is removed is
     unspecified.

     Returns `true` if the multimap changed"
    shared formal
    Boolean remove(Key key, Item item);

    "Removes all items associated with the key [[key]].

     Once this method returns, `key` will not be mapped to any items, so it will
     not appear in `keys`, `asMap`, or any other views.

     Returns the items that were removed (possibly empty). The returned collection
     *may* be modifiable, but updating it will have no effect on the multimap."
    shared formal
    Collection<Anything> removeAll(Key key);

    shared default see(`function remove`)
    Boolean removeEntry(Key -> Item entry)
        =>  remove(entry.key, entry.item);

    "Remove all [[entries]] from this multimap.

     Returns `true` if the multimap changed"
    shared default
    Boolean removeEntries({<Key -> Item>*} entries) {
        variable value result = false;
        for (key->item in entries) {
            result = remove(key, item) || result;
        }
        return result;
    }

    "Stores a collection of items with the same key, replacing any existing
     items for that key.

     If [[items]] is empty, this is equivalent to `removeAll(key)`.

     Returns the collection of replaced items, or an empty collection if no items
     were previously associated with the key. The collection *may* be modifiable,
     but updating it will have no effect on the multimap."
    shared formal
    Collection<Anything> replaceItems(Key key, {Item*} items);
}
