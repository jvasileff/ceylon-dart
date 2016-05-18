import ceylon.language {
    immutableMap = map
}

import dart.core {
    DList = List,
    DMap = Map,
    DString = String,
    DDouble = \Idouble,
    DInt = \Iint,
    DBool = \Ibool
}

shared
alias JsonValue
    =>  JsonObject | JsonArray
            | Null | String | Boolean | Integer | Float;

shared
alias DartJsonValue
    =>  DMap<DString, Anything> | DList<Anything>
            | Null | DString | DBool | DInt | DDouble;

shared
JsonValue wrapDartJson(DartJsonValue o)
    =>  if (is DString o) then o.string
        else if (is DBool o) then ceylonBoolean(o)
        else if (is DInt o) then o.toInt()
        else if (is DDouble o) then o.toDouble()
        else if (is DMap<DString, Anything> o) then JsonObject(o)
        else if (is DList<Anything> o) then JsonArray(o)
        else null;

JsonValue forceWrap(Anything o) {
    assert (is DartJsonValue o);
    return wrapDartJson(o);
}

shared
class JsonObject(DMap<DString, Anything> delegate) satisfies Map<String, JsonValue> {

    shared actual
    Map<String, JsonValue> clone()
        =>  immutableMap(this);

    shared actual
    Boolean defines(Object key)
        =>  if (is String key)
            then delegate.containsKey(dartString(key))
            else false;

    shared actual
    JsonValue get(Object key)
        =>  if (is String key)
            then forceWrap(delegate.get_(dartString(key)))
            else null;

    shared actual
    Iterator<String -> JsonValue> iterator()
        =>  CeylonIterable<DString>(delegate.keys).map((key)
            =>  key.string -> get(key.string)).iterator();

    shared actual
    Integer hash
        =>  (super of Map<>).hash;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<>).equals(that);
}

shared
class JsonArray(DList<Anything> delegate) satisfies List<JsonValue> {

    value iterable = CeylonIterable<Anything>(delegate).map(forceWrap);

    shared actual
    Iterator<JsonValue> iterator()
        =>  iterable.iterator();

    shared actual
    JsonValue? getFromFirst(Integer index)
        =>  if (exists sj = delegate.get_(index))
            then forceWrap(sj)
            else null;

    shared actual
    Integer? lastIndex
        =>  delegate.length - 1;

    shared actual
    Integer hash
        =>  (super of List<Anything>).hash;

    shared actual
    Boolean equals(Object that)
        =>  (super of List<Anything>).equals(that);
}
