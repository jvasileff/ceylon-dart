abstract
class BoxingConversion()
        of ceylonBooleanToNative | ceylonFloatToNative |
            ceylonIntegerToNative | ceylonStringToNative |
            nativeToCeylonBoolean | nativeToCeylonFloat |
            nativeToCeylonInteger | nativeToCeylonString {}

object ceylonBooleanToNative extends BoxingConversion() {}
object ceylonFloatToNative extends BoxingConversion() {}
object ceylonIntegerToNative extends BoxingConversion() {}
object ceylonStringToNative extends BoxingConversion() {}

object nativeToCeylonBoolean extends BoxingConversion() {}
object nativeToCeylonFloat extends BoxingConversion() {}
object nativeToCeylonInteger extends BoxingConversion() {}
object nativeToCeylonString extends BoxingConversion() {}
