import ceylon.dart.runtime.structures.internal {
    eq
}


"A collection that maps keys to values, similar to [[Map]], but in which each
 key may be associated with multiple values. You can visualize the contents
 of a multimap either as a map from keys to nonempty collections of values:

 - a → 1, 2
 - b → 3

 ... or as a single \"flattened\" collection of key-value pairs:

 - a → 1
 - a → 2
 - b → 3

 *Important:* although the first interpretation resembles how most multimaps
 are *implemented*, the design of the [[Multimap]] API is based on the
 *second* form. So, using the multimap shown above as an example, the
 [[size]] is `3`, not `2`, and the [[items]] collection is `{ 1, 2, 3 }`,
 not `{ {1, 2}, {3} }`. For those times when the first style is more useful,
 use the multimap's [[asMap]] view (or create a `Map<K, Collection<I>>` in
 the first place)."
shared
interface Multimap<Key, out Item>
        satisfies Collection<Key->Item>
                & Correspondence<Key, Collection<Item>>
        given Key satisfies Object {

    "Returns a view of this multimap as a [[Map]] from each distinct key to the
     nonempty collection of that key's associated values. Note that
     `this.asMap.get(k)` is equivalent to `this.get(k)` only when `k` is a key
     contained in the multimap; otherwise it returns `null` as opposed to an empty
     collection.

     The returned map is a view of the underlying multimap."
    shared formal
    Map<Key, {Item*}> asMap;

    "Returns `true` if this multimap contains at least one entry with the key `key` and
     the item `item`."
    shared actual default
    Boolean contains(Object entry)
        =>  if (is Object->Anything entry)
            then (asMap[entry.key]?.any((i) => eq(i, entry.item)) else false)
            else false;

    "Returns `true` if this multimap contains at least one entry with the key `key`."
    shared actual formal
    Boolean defines(Key key);

    "Returns `true` if this multimap contains at least one entry with the item `item`."
    shared default
    Boolean containsItem(Object item) => items.contains(item);

    "Returns a view collection of the values associated with [[key]] in this
     multimap, if any. Note that when `containsKey(key)` is false, this returns an
     empty collection, not `null`.

     Changes to the returned collection will update the underlying multimap, and
     vice versa."
    shared actual formal
    Collection<Item> get(Key key);

    shared actual default
    Boolean empty => size == 0;

    "Returns a view collection of all *distinct* keys contained in this multimap.
     Note that the key set contains a key if and only if this multimap maps that key
     to at least one value.

     Changes to the returned set will update the underlying multimap, and
     vice versa. However, *adding* to the returned set is a no-op."
    shared actual formal
    Set<Key> keys;

    //"Returns a view collection containing the key from each key-value pair in
    // this multimap, *without* collapsing duplicates. This collection has the same
    // size as this multimap, and `keys.count(k) == get(k).size` for all `k`.
    //
    // Changes to the returned multiset will update the underlying multimap, and vice
    // versa. However, *adding* to the returned collection is a no-op."
    //shared formal
    //Multiset<Key> keyMultiset;

    "Returns a view collection containing the *item* from each key-item pair
     contained in this multimap, without collapsing duplicates (so
     `items.size == size`)."
    shared formal
    Collection<Item> items;

    shared actual formal
    Iterator<Key->Item> iterator();

    "Returns the number of key->item pairs in this multimap.

     *Note:* this method does not return the number of *distinct keys* in the
     multimap, which is given by `keys.size` or `asMap.size`. See the opening
     section of the [[Multimap]] class documentation for clarification."
    shared actual formal
    Integer size;

    shared actual default
    Boolean equals(Object that)
        =>  if (is Multimap<out Anything, Anything> that)
            then asMap.equals(that.asMap)
            else false;

    shared actual default
    Integer hash => asMap.hash;
}
