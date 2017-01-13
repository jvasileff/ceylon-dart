String getString(JsonObject json, String key) {
    assert (is String result = json[key]);
    return result;
}

String? getStringOrNull(JsonObject json, String key) {
    assert (is String? result = json[key]);
    return result;
}

Integer getInteger(JsonObject json, String key) {
    assert (is Integer result = json[key]);
    return result;
}

Integer? getIntegerOrNull(JsonObject json, String key) {
    assert (is Integer? result = json[key]);
    return result;
}

JsonArray getArray(JsonObject json, String key) {
    assert (is JsonArray result = json[key]);
    return result;
}

JsonArray? getArrayOrNull(JsonObject json, String key) {
    assert (is JsonArray? result = json[key]);
    return result;
}

JsonArray getArrayOrEmpty(JsonObject json, String key) {
    assert (is JsonArray? result = json[key]);
    return result else [];
}

JsonObject getObject(JsonObject json, String key) {
    assert (is JsonObject result = json[key]);
    return result;
}

JsonObject? getObjectOrNull(JsonObject json, String key) {
    assert (is JsonObject? result = json[key]);
    return result;
}

JsonObject getObjectOrEmpty(JsonObject json, String key) {
    assert (is JsonObject? result = json[key]);
    return result else emptyMap;
}

JsonObject | JsonArray | Null getObjectOrArrayOrNull(JsonObject json, String key) {
    assert (is JsonObject | JsonArray | Null result = json[key]);
    return result;
}
