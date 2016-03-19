import ceylon.language.serialization{ReachableReference}

"A native way to find out about the references an instance holds
 and to get an instance."
shared native object reach {
    shared native Iterator<ReachableReference> references(Anything instance);
    shared native Anything getAnything(Anything instance, ReachableReference ref);
    shared native Object getObject(Anything instance, ReachableReference ref);
    shared actual native String string => "reach";
}

shared native("dart") object reach {
    shared native("dart") Iterator<ReachableReference> references(Anything instance)
        =>  nothing;

    shared native("dart") Anything getAnything(Anything instance, ReachableReference ref)
        =>  nothing;

    shared native("dart") Object getObject(Anything instance, ReachableReference ref)
        =>  nothing;

    shared actual native("dart") String string
        =>  "reach";
}
