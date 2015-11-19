"Invert a [[Map]], producing a map from items to sequences 
 of keys. Since various keys in the [[original map|map]] may 
 map to the same item, the resulting map contains a sequence 
 of keys for each distinct item."
Map<Item,[Key+]> invert<Key,Item>(Map<Key,Item> map) 
        given Key satisfies Object
        given Item satisfies Object {
    
    value result = HashMap<Item,ArrayList<Key>>();
// FIXME Dart workaround
//    for (key->item in map) {
    for (entry in map) {
        if (exists sb = result[entry.item]) {
            sb.add(entry.key);
        }
        else {
            value list = ArrayList<Key>();
            list.add(entry.key);
            result.put(entry.item, list);
        }
    }
    [Key+] mapping(Item item, ArrayList<Key> sa) {
        assert(is [Key+] result = sa.sequence());
        return result;
    }
    return result.mapItems(mapping);
}
