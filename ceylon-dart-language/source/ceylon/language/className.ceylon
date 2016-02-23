import ceylon.interop.dart {
    runtimeType
}

"Return the name of the concrete class of the given object, 
 in a format native to the virtual machine."
tagged("Metamodel")
shared native String className(Object obj);
shared native("dart")
String className(Object obj)
    // TODO use our own reified metadata when available
    //      Type.toString() includes only the name, not package
    =>  runtimeType(obj).string;
