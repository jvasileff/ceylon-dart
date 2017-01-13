shared class Annotation(name, arguments) {
    shared String name;
    shared [String*] arguments;

    string => name
        + ( if (nonempty arguments)
            then "(``", ".join(arguments)``)"
            else "");
}
