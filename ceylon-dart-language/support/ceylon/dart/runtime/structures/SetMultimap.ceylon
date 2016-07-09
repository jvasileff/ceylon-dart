shared
interface SetMultimap<Key, out Item>
        satisfies Multimap<Key, Item>
                & Correspondence<Key, Set<Item>>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    Set<Key> keys;

    // Ceylon bug? This is necessary for the return type to be non-null despite
    // Multimap already providing this guarantee.
    shared actual formal
    Set<Item> get(Key key);

    shared formal
    Set<Key->Item> entries;

    shared actual formal
    Map<Key, Set<Item>> asMap;

    shared actual formal
    SetMultimap<Key, Item> clone();
}
