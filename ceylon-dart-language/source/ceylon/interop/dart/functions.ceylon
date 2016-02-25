import dart.core {
    DString = String,
    DInteger = \Iint,
    DNum = \Inum,
    DBoolean = \Ibool,
    DDouble = \Idouble,
    DType = Type
}
import dart.async {
    DFuture = Future
}

shared native
DString dartString(String string);

shared native("jvm", "js")
DString dartString(String string) => nothing;

shared native
DInteger dartInt(Integer integer);

shared native("jvm", "js")
DInteger dartInt(Integer integer) => nothing;

shared native
DDouble dartDouble(Float float);

shared native("jvm", "js")
DDouble dartDouble(Float float) => nothing;

shared native
DNum dartNumFromInteger(Integer number);

shared native
DNum dartNumFromFloat(Float number);

shared native
DBoolean dartBool(Boolean boolean);

shared native("jvm", "js")
DBoolean dartBool(Boolean boolean) => nothing;

shared native
Boolean ceylonBoolean(DBoolean boolean);

shared native("jvm", "js")
Boolean ceylonBoolean(DBoolean boolean) => nothing;

shared native
Element await<Element>(DFuture<Element> future);

shared native("jvm", "js")
Element await<Element>(DFuture<Element> future) => nothing;

shared
DFuture<Element> deFuture<Element>(DFuture<DFuture<Element>> future) {
    assert (is DFuture<Element> future);
    return future;
}

shared native
DType runtimeType(Object obj);