"A type capable of representing the values [[true]] and
 [[false]] of Boolean logic."
see (`function parseBoolean`)
by ("Gavin")
tagged("Basic types")
shared native abstract class Boolean()
        of true | false {}

"A value representing truth in Boolean logic."
tagged("Basic types")
shared native object true
        extends Boolean() {
    string => "true";
    hash => 1231;
}

"A value representing falsity in Boolean logic."
tagged("Basic types")
shared native object false
        extends Boolean() {
    string => "false";
    hash => 1237;
}

shared abstract native("dart")
class Boolean() of true | false {}

shared native("dart")
object true extends Boolean() {
    shared actual native("dart") String string => "true";
    shared actual native("dart") Integer hash => 1231;
}

shared native("dart")
object false extends Boolean() {
    shared actual native("dart") String string => "false";
    shared actual native("dart") Integer hash => 1237;
}
