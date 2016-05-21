import ceylon.dart.runtime.model {
    Scope,
    Type
}

shared
Type typeFromJson(JsonObject json, Scope scope)
    =>  jsonModelUtil.parseType(scope, json);

shared
Type typeFromJsonLG(JsonObject json)(Scope scope)
    =>  typeFromJson(json, scope);
