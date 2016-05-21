import ceylon.collection {
    MutableSet,
    SetMutator
}

shared
interface SetMultimapMutator<Key, in Item>
        satisfies SetMultimap<Key, Object>
                & MultimapMutator<Key, Item>
                & Correspondence<Key, SetMutator<Item>>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    SetMutator<Item> get(Key key);

    shared actual formal
    MutableSet<Key> keys;

    shared actual formal
    Set<Object> removeAll(Key key);

    shared actual formal
    Set<Object> replaceItems(Key key, {Item*} items);
}
