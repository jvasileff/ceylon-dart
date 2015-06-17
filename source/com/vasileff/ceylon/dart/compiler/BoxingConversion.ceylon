see(`function TypeFactory.boxingConversionFor`)
abstract
class BoxingConversion(
        shared String prefix,
        shared String suffix) {}

object ceylonBooleanToNative extends BoxingConversion("dart$ceylonBooleanToNative(",")") {}
object ceylonFloatToNative extends BoxingConversion("dart$ceylonFloatToNative(",")") {}
object ceylonIntegerToNative extends BoxingConversion("dart$ceylonIntegerToNative(",")") {}
object ceylonStringToNative extends BoxingConversion("dart$ceylonStringToNative(",")") {}

object nativeToCeylonBoolean extends BoxingConversion("dart$nativeToCeylonBoolean(",")") {}
object nativeToCeylonFloat extends BoxingConversion("dart$nativeToCeylonFloat(",")") {}
object nativeToCeylonInteger extends BoxingConversion("dart$nativeToCeylonInteger(",")") {}
object nativeToCeylonString extends BoxingConversion("dart$nativeToCeylonString(",")") {}
