shared
interface ListMultimap<Key, out Item>
        satisfies Multimap<Key, Item>
                & Correspondence<Key, List<Item>>
        given Key satisfies Object {

    shared actual formal
    Set<Key> keys;

    // Ceylon bug? This is necessary for the return type to be non-null despite
    // Multimap already providing this guarantee.
    shared actual formal
    List<Item> get(Key key);

    shared actual formal
    Map<Key, List<Item>> asMap;

    shared actual formal
    ListMultimap<Key, Item> clone();
}
