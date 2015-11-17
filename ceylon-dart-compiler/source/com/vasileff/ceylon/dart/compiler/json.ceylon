import ceylon.file {
    File
}
import ceylon.interop.java {
    javaString,
    CeylonIterable
}
import ceylon.language {
    immutableMap=map
}

import java.io {
    FileInputStream
}
import java.lang {
    JString=String,
    JDouble=Double,
    JInteger=Integer,
    JBoolean=Boolean
}

import net.minidev.json {
    MDJSONObject=JSONObject,
    MDJSONArray=JSONArray,
    MDJSONValue=JSONValue
}

shared
alias JsonValue
    =>  JsonObject | JsonArray | Null | String | Boolean | Integer | Float;

shared
alias SmartJsonValue
    =>  MDJSONObject | MDJSONArray | Null | JString | JBoolean | JInteger | JDouble;

shared
JsonValue parseJson(File | String | Null json) {
    switch (json)
    case (is String) {
        return forceWrap(MDJSONValue.parse(json));
    }
    case (is File) {
        return forceWrap(MDJSONValue.parse(FileInputStream(javaFile(json))));
    }
    case (is Null) {
        return null;
    }
}

shared
JsonValue wrapSmartJson(SmartJsonValue o)
    =>  switch (o)
        case (is JString) o.string
        case (is JBoolean) o.booleanValue()
        case (is JInteger) o.longValue()
        case (is JDouble) o.doubleValue()
        case (is MDJSONObject) JsonObject(o)
        case (is MDJSONArray) JsonArray(o)
        case (is Null) null;

JsonValue forceWrap(Anything o) {
    assert (is SmartJsonValue o);
    return wrapSmartJson(o);
}

shared
class JsonObject(MDJSONObject delegate) satisfies Map<String, JsonValue> {

    // watch out, delegate may have nulls!

    shared actual
    Map<String, JsonValue> clone()
        =>  immutableMap(this);

    shared actual
    Boolean defines(Object key)
        =>  if (is String key)
            then delegate.containsKey(javaString(key))
            else false;

    shared actual
    JsonValue get(Object key)
        =>  if (is String key)
            then forceWrap(delegate.get(javaString(key)))
            else null;

    shared actual
    Iterator<String->JsonValue> iterator()
        =>  CeylonIterable<JString>(delegate.keySet()).map((key)
            =>  key.string -> get(key.string)).iterator();

    shared actual
    Integer hash
        =>  (super of Map<>).hash;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<>).equals(that);
}

shared
class JsonArray(MDJSONArray delegate) satisfies List<JsonValue> {

    // watch out, delegate may have nulls!

    value iterable = CeylonIterable<Anything>(delegate);

    shared actual
    Iterator<JsonValue> iterator()
        =>  iterable.map(forceWrap).iterator();

    shared actual
    JsonValue? getFromFirst(Integer index)
        =>  if (exists sj = delegate.get(index))
            then forceWrap(sj)
            else null;

    shared actual
    Integer? lastIndex
        =>  delegate.size() - 1;

    shared actual
    Integer hash
        =>  (super of List<Anything>).hash;

    shared actual
    Boolean equals(Object that)
        =>  (super of List<Anything>).equals(that);
}
