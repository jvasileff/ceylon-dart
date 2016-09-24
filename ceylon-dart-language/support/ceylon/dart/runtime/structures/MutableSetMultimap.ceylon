import ceylon.dart.runtime.nativecollection {
    MutableSet
}

shared
interface MutableSetMultimap<Key, Item>
        satisfies SetMultimap<Key, Item>
                & MutableMultimap<Key, Item>
                & SetMultimapMutator<Key, Item>
                & Correspondence<Key, MutableSet<Item>>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    MutableSet<Item> get(Key key);

    shared actual formal
    Set<Item> removeAll(Key key);

    shared actual formal
    Set<Item> replaceItems(Key key, {Item*} items);

    shared actual formal
    MutableSet<Key> keys;

    shared actual formal
    Map<Key, MutableSet<Item>> asMap;

    shared actual formal
    MutableSet<Key->Item> entries;

    shared actual default
    Boolean put(Key key, Item item)
        =>  get(key).add(item);

    shared actual default
    Boolean remove(Key key, Item item)
        =>  defines(key) && get(key).remove(item);
}
