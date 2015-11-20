import ceylon.math.whole {
    Whole
}

shared sealed
interface Long
        satisfies Integral<Long> &
                  Binary<Long> &
                  Exponentiable<Long, Long> {

    "An [[Integer]] composed of the [[runtime.integerAddressableSize]]
     number of least significant bits of the two's complement
     representation of this `Long`.

     For JavaScript, the sign of the returned [[Integer]] may be
     different from the sign of the `Long`."
    shared formal
    Integer integer;

    "An [[Integer]] with the same value as this `Long` if this `Long`
     is greater than or equal to [[runtime.minIntegerValue]] and less
     than or equal to [[runtime.maxIntegerValue]]. Otherwise, an
     [[OverflowException]] is thrown."
    throws(`class OverflowException`,
           "if this number cannot be represented by
            an [[Integer]] without loss of precision")
    shared formal
    Integer preciseInteger;

    "The number, as an [[Integer]], possibly with loss of precision."
    shared formal
    Integer impreciseInteger;

    "True if this number is even.

     A number `n` is even if there exists an integer `k`
     such that:

         n == 2*k

     Thus, `n` is even if and only if `n%2 == 0`."
    shared formal
    Boolean even;

    "The number, as a [[Whole]]."
    shared formal
    Whole whole;

    "The UTF-32 character with this UCS code point."
    throws (`class OverflowException`,
            "if this integer is not in the range
             `0..#10FFFF` of legal Unicode code points")
    shared formal Character character;

    "The number, represented as a [[Float]], if such a
     representation is possible."
    throws (`class OverflowException`,
        "if the number cannot be represented as a `Float`
         without loss of precision")
    shared formal Float float;

    "A [[Byte]] whose [[signed|Byte.signed]] and
     [[unsigned|Byte.unsigned]] interpretations are
     congruent modulo 256 to this integer."
    shared formal Byte byte;
}
