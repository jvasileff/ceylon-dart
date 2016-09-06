import ceylon.collection {
    MutableList,
    MutableSet
}

shared
interface MutableListMultimap<Key, Item>
        satisfies ListMultimap<Key, Item>
                & MutableMultimap<Key, Item>
                & ListMultimapMutator<Key, Item>
                & Correspondence<Key, MutableList<Item>>
        given Key satisfies Object {

    shared actual formal
    MutableList<Item> get(Key key);

    shared actual formal
    List<Item> removeAll(Key key);

    shared actual formal
    List<Item> replaceItems(Key key, {Item*} items);

    shared actual formal
    MutableSet<Key> keys;

    shared actual formal
    Map<Key, MutableList<Item>> asMap;

    shared actual default
    Boolean remove(Key key, Item item) {
        if (defines(key)) {
            value list = get(key);
            if (exists item) {
                return list.remove(item) != 0;
            }
            return list.prune() != 0;
        }
        return false;
    }
}
