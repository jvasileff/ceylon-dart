import interop.dart.core {
    DString = String
}

shared native
DString dartString(String string);

shared native("jvm", "js")
DString dartString(String string) => nothing;