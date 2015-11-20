import ceylon.math.long.internal {
    LongImpl64
}
"The string representation of the given [[Long]] in the
 base given by [[radix]]. If the given value is negative,
 the string representation will begin with `-`. Digits
 consist of decimal digits `0` to `9`, together with and
 lowercase letters `a` to `z` for bases greater than 10."
throws (`class AssertionError`,
        "if [[radix]] is not between [[minRadix]] and
         [[maxRadix]]")
see (`function parseLong`)
shared
String formatLong(
        "The Long value to format."
        Long long,
        "The base, between [[minRadix]] and [[maxRadix]]
         inclusive."
        Integer radix = 10) {

    if (is LongImpl64 long) {
        return formatInteger(long.integer, radix);
    }

    assert (minRadix <= radix <= maxRadix);
    if (long.zero) {
        return "0";
    }
    value lRadix = longNumber(radix);
    variable {Character*} digits = {};
    variable Long i = if (long < zero)
                      then long
                      else -long;
    while (!i.zero) {
        Long dl = -(i % lRadix);
        Integer d = dl.integer;
        Character c;
        if (0 <= d < 10) {
            c = (d + zeroInt).character;
        }
        else if (10 <= d <36) {
            c = (d - 10 + aIntLower).character;
        }
        else {
            assert (false);
        }
        digits = digits.follow(c);
        i = (i + dl) / lRadix;
    }
    if (long.negative) {
        digits = digits.follow('-');
    }
    return String(digits);
}
