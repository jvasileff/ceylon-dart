import ceylon.ast.core {
    TypedDeclaration,
    Node
}

String name(TypedDeclaration that) {
    if (exists name = that.get(keys.identifierName)) {
        return name;
    }

    variable
    String name = that.name.name;

    // TODO when does this happen?
    if (name.startsWith("anonymous#")) {
        name = "anon$" + name[10...];
    }

    // TODO sanitize, etc.

    that.put(keys.identifierName, name);
    return name;
}

String location(Node that) {
    assert (exists location = that.get(keys.location));
    return location;
}
