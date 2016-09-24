import ceylon.dart.runtime.nativecollection {
    MutableSet
}

shared
interface MutableMultimap<Key, Item>
        satisfies Multimap<Key, Item> &
                  MultimapMutator<Key, Item>
        given Key satisfies Object {

    shared actual formal
    MutableSet<Key> keys;

    shared actual formal
    Boolean remove(Key key, Item item);

    shared actual formal
    Collection<Item> removeAll(Key key);

    shared actual formal
    Collection<Item> replaceItems(Key key, {Item*} items);

    shared actual formal
    void clear();

    shared actual formal
    Boolean put(Key key, Item item);
}
