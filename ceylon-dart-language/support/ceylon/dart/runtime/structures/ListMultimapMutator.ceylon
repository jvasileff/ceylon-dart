import ceylon.collection {
    ListMutator,
    MutableSet
}

shared
interface ListMultimapMutator<Key, in Item>
        satisfies ListMultimap<Key, Anything>
                & MultimapMutator<Key, Item>
                & Correspondence<Key, ListMutator<Item>>
        given Key satisfies Object {

    shared actual formal
    ListMutator<Item> get(Key key);

    shared actual formal
    MutableSet<Key> keys;

    shared actual formal
    List<Anything> removeAll(Key key);

    shared actual formal
    List<Anything> replaceItems(Key key, {Item*} items);
}
