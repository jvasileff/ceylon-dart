"Module for program elements required at runtime by the ceylon-dart compiler.
 Declarations in this Module cannot be placed in the langauge module since `shared`
 declarations in a cross platform module cannot be `native(...)`"
native("dart")
module ceylon.dart.runtime.native "1.3.2" {
    shared import dart.core "1.3.2";
}
