import ceylon.math.long {
    Long,
    lzero=zero
}
import ceylon.math.whole {
    Whole,
    wholeNumber
}

shared
class LongImpl64 satisfies Long {

    shared actual
    Integer integer;

    shared
    new ofInteger(Integer integer) {
        this.integer = integer;
    }

    shared
    new ofWords(Integer w3, Integer w2, Integer w1, Integer w0) {
        integer = w0.or(w1.leftLogicalShift(16))
                    .or(w2.leftLogicalShift(32))
                    .or(w3.leftLogicalShift(48));
    }

    shared actual
    Long and(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.and(other.integer));
    }

    shared actual
    Comparison compare(Long other) {
        assert(is LongImpl64 other);
        return integer.compare(other.integer);
    }

    shared actual
    Long divided(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.divided(other.integer));
    }

    shared actual
    Long flip(Integer index)
        =>  ofInteger(integer.flip(index));

    shared actual
    Boolean get(Integer index)
        =>  integer.get(index);

    shared actual
    Long leftLogicalShift(Integer shift)
        =>  ofInteger(integer.leftLogicalShift(shift));

    shared actual
    Long neighbour(Integer offset)
        =>  ofInteger(integer.neighbour(offset));

    shared actual
    Integer offset(Long other) {
        assert(is LongImpl64 other);
        return integer.offset(other.integer);
    }

    shared actual
    Long or(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.or(other.integer));
    }

    shared actual
    Long plus(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.plus(other.integer));
    }

    shared actual
    Long plusInteger(Integer integer)
        =>  ofInteger(this.integer.plusInteger(integer));

    shared actual
    Long power(Long exponent) {
        assert(is LongImpl64 exponent);
        return ofInteger(integer.power(exponent.integer));
    }

    shared actual
    Long powerOfInteger(Integer exponent)
        =>  ofInteger(integer.powerOfInteger(exponent));

    shared actual
    Long remainder(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.remainder(other.integer));
    }

    shared actual
    Long rightArithmeticShift(Integer shift)
        =>  ofInteger(integer.rightArithmeticShift(shift));

    shared actual
    Long rightLogicalShift(Integer shift)
        =>  ofInteger(integer.rightLogicalShift(shift));

    shared actual
    Long set(Integer index, Boolean bit)
        =>  ofInteger(integer.set(index, bit));

    shared actual
    Long times(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.times(other.integer));
    }

    shared actual
    Long timesInteger(Integer integer)
        =>  ofInteger(this.integer.timesInteger(integer));

    shared actual
    Long xor(Long other) {
        assert(is LongImpl64 other);
        return ofInteger(integer.xor(other.integer));
    }

    shared actual
    Boolean equals(Object that)
        =>  if (is LongImpl64 that)
            then integer == that.integer
            else false;

    shared actual
    Boolean unit => integer.unit;

    shared actual
    Long fractionalPart => lzero;

    shared actual
    Long wholePart => this;

    shared actual
    Boolean zero => integer.zero;

    shared actual
    String string => integer.string;

    shared actual
    Integer preciseInteger => integer;

    shared actual
    Integer impreciseInteger => integer;

    shared actual
    Integer hash => integer.hash;

    shared actual
    Whole whole => wholeNumber(integer);

    shared actual
    Long negated => ofInteger(integer.negated);

    shared actual
    Long not => ofInteger(integer.not);

    shared actual
    Boolean negative => integer.negative;

    shared actual
    Boolean positive => integer.positive;

    shared actual
    Boolean even => integer.even;

    shared actual
    Byte byte => integer.byte;

    shared actual
    Character character => integer.character;

    shared actual
    Float float => integer.float;
}
