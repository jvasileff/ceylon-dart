import ceylon.math.long {
    Long,
    formatLong,
    lzero=zero,
    lone=one,
    longNumber
}
import ceylon.math.whole {
    Whole,
    wholeNumber,
    wholeZero=zero
}

// These are used for Long.offset, so integerAddressableSize is irrelevant
Long integerMax = longNumber(runtime.maxIntegerValue);
Long integerMin = longNumber(runtime.minIntegerValue);

shared
class LongImpl16 satisfies Long {
    "bits 48-63"
    shared Integer w3;

    "bits 32-47"
    shared Integer w2;

    "bits 16-31"
    shared Integer w1;

    "bits 0-15"
    shared Integer w0;

    shared
    new ofWords(Integer w3, Integer w2, Integer w1, Integer w0) {
        this.w3 = w3;
        this.w2 = w2;
        this.w1 = w1;
        this.w0 = w0;
    }

    shared
    new ofWhole(Whole whole) {
        if (whole.zero) {
            this.w0 = 0;
            this.w1 = 0;
            this.w2 = 0;
            this.w3 = 0;
        }
        else {
            this.w0 = whole.integer.and(#ffff);
            this.w1 = whole.rightArithmeticShift(16).integer.and(#ffff);
            this.w2 = whole.rightArithmeticShift(32).integer.and(#ffff);
            this.w3 = whole.rightArithmeticShift(48).integer.and(#ffff);
        }
    }

    shared
    new ofInteger(variable Integer integer) {
        if (! runtime.minIntegerValue <= integer <= runtime.maxIntegerValue) {
            // FIXME throwing exceptions in constructors not supported ATM
            // https://github.com/ceylon/ceylon-spec/issues/1288
            //throw OverflowException();
            assert(false);
        }
        else if (integer.zero) {
            this.w3 = 0;
            this.w2 = 0;
            this.w1 = 0;
            this.w0 = 0;
        }
        else if (integer.positive) {
            w0 = integer.and(#ffff);
            integer /= #10000;
            w1 = integer.and(#ffff);
            integer /= #10000;
            w2 = integer.and(#ffff);
            integer /= #10000;
            w3 = integer.and(#ffff);
        }
        else {
            variable value w3 = 0;
            variable value w2 = 0;
            variable value w1 = 0;
            variable value w0 = 0;

            // convert to two's complement
            integer = -integer;

            // flip the bits
            w0 = integer.not.and(#ffff);
            integer /= #10000;
            w1 = integer.not.and(#ffff);
            integer /= #10000;
            w2 = integer.not.and(#ffff);
            integer /= #10000;
            w3 = integer.not.and(#ffff);

            // and add 1
            w0++;
            if (w0 > #ffff) {
                w0 = 0;
                w1++;
                if (w1 > #ffff) {
                    w1 = 0;
                    w2++;
                    if (w2 > #ffff) {
                        w2 = 0;
                        w3++;
                        w3 = w3.and(#ffff);
                    }
                }
            }

            this.w0 = w0;
            this.w1 = w1;
            this.w2 = w2;
            this.w3 = w3;
        }
    }

    shared actual
    LongImpl16 plus(Long other) {
        value a = this;
        assert(is LongImpl16 b = other);

        Integer c0;
        Integer c1;
        Integer c2;
        Integer c3;

        variable Integer sum;
        sum = a.w0 + b.w0;
        c0 = sum.and(#ffff);
        sum = a.w1 + b.w1 + sum.rightLogicalShift(16);
        c1 = sum.and(#ffff);
        sum = a.w2 + b.w2 + sum.rightLogicalShift(16);
        c2 = sum.and(#ffff);
        sum = a.w3 + b.w3 + sum.rightLogicalShift(16);
        c3 = sum.and(#ffff);

        return ofWords(c3, c2, c1, c0);
    }

    shared actual
    Long plusInteger(Integer integer)
        =>  this + ofInteger(integer);

    shared actual
    LongImpl16 minus(Long other) {
        value a = this;
        assert(is LongImpl16 b = other);

        Integer c0;
        Integer c1;
        Integer c2;
        Integer c3;

        variable Integer diff;
        diff = a.w0 - b.w0;
        c0 = diff.and(#ffff);
        diff = a.w1 - b.w1 + diff.rightArithmeticShift(16);
        c1 = diff.and(#ffff);
        diff = a.w2 - b.w2 + diff.rightArithmeticShift(16);
        c2 = diff.and(#ffff);
        diff = a.w3 - b.w3 + diff.rightArithmeticShift(16);
        c3 = diff.and(#ffff);

        return ofWords(c3, c2, c1, c0);
    }

    shared actual
    Long times(Long other) {
        if (this.zero || other.zero) {
            return lzero;
        } else if (this.unit) {
            return other;
        } else if (other.unit) {
            return this;
        }
        // could check 53 bit range, and do float math

        value a = this;
        assert(is LongImpl16 b = other);

        variable Integer prod;
        variable Integer c0 = 0;
        variable Integer c1 = 0;
        variable Integer c2 = 0;
        variable Integer c3 = 0;

        if (a.w0 != 0) {
            prod = a.w0 * b.w0;
            c0 = prod.and(#ffff);
            prod = a.w0 * b.w1 + prod.rightLogicalShift(16);
            c1 = prod.and(#ffff);
            prod = a.w0 * b.w2 + prod.rightLogicalShift(16);
            c2 = prod.and(#ffff);
            prod = a.w0 * b.w3 + prod.rightLogicalShift(16);
            c3 = prod.and(#ffff);
        }

        if (a.w1 != 0) {
            prod = a.w1 * b.w0 + c1;
            c1 = prod.and(#ffff);
            prod = a.w1 * b.w1 + c2 + prod.rightLogicalShift(16);
            c2 = prod.and(#ffff);
            prod = a.w1 * b.w2 + c3 + prod.rightLogicalShift(16);
            c3 = prod.and(#ffff);
        }

        if (a.w2 != 0) {
            prod = a.w2 * b.w0 + c2;
            c2 = prod.and(#ffff);
            prod = a.w2 * b.w1 + c3 + prod.rightLogicalShift(16);
            c3 = prod.and(#ffff);
        }

        if (a.w3 != 0) {
            prod = a.w3 * b.w0 + c3;
            c3 = prod.and(#ffff);
        }

        return ofWords(c3, c2, c1, c0);
    }

    shared actual
    Long timesInteger(Integer integer)
        =>  this * ofInteger(integer);

    shared actual
    Long divided(Long other) {
        assert(is LongImpl16 other);
        if (other.zero) {
            throw Exception("Divide by zero");
        }
        return if (zero) then
            lzero
        else if (other.unit) then
            this
        else if (other.negativeOne) then
            this.negated
        else if (safelyAddressable && other.safelyAddressable) then
            ofInteger(this.integer / other.integer)
        else
            ofWhole(this.whole / other.whole);
    }

    shared actual
    Long remainder(Long other) {
        assert(is LongImpl16 other);
        if (other.zero) {
            throw Exception("Divide by zero");
        }
        return if (zero) then
            lzero
        else if (other.unit) then
            lzero
        else if (other.negativeOne) then
            lzero
        else if (safelyAddressable && other.safelyAddressable) then
            ofInteger(this.integer % other.integer)
        else
            ofWhole(this.whole % other.whole);
    }

    shared actual
    Long power(Long exponent) {
        if (this.unit) {
            return this;
        }
        else if (exponent.zero) {
            return lone;
        }
        else if (this.negativeOne) {
            return if (exponent.even)
            then lone
            else this;
        }
        else if (exponent.unit) {
            return this;
        }
        else if (exponent.positive) {
            return powerBySquaring(exponent);
        }
        else {
            throw AssertionError(
                "``string``^``exponent`` negative exponents not supported");
        }
    }

    shared actual
    Long powerOfInteger(Integer exponent)
        =>  power(ofInteger(exponent));

    shared actual
    Long and(Long other) {
        value a = this;
        assert(is LongImpl16 b = other);
        return ofWords(
            a.w3.and(b.w3),
            a.w2.and(b.w2),
            a.w1.and(b.w1),
            a.w0.and(b.w0));
    }

    shared actual
    Long or(Long other) {
        value a = this;
        assert(is LongImpl16 b = other);
        return ofWords(
            a.w3.or(b.w3),
            a.w2.or(b.w2),
            a.w1.or(b.w1),
            a.w0.or(b.w0));
    }

    shared actual
    Long xor(Long other) {
        value a = this;
        assert(is LongImpl16 b = other);
        return ofWords(
            a.w3.xor(b.w3),
            a.w2.xor(b.w2),
            a.w1.xor(b.w1),
            a.w0.xor(b.w0));
    }

    shared actual
    Long flip(Integer index)
        =>  if (0 <= index <= 63) then
                let(word = index / 16)
                let(bit = index % 16)
                ofWords(
                    if (word == 3) then w3.flip(bit) else w3,
                    if (word == 2) then w2.flip(bit) else w2,
                    if (word == 1) then w1.flip(bit) else w1,
                    if (word == 0) then w0.flip(bit) else w0)
            else this;

    shared actual
    Boolean get(Integer index)
        =>  if (0 <= index <= 63) then
                let(word = index / 16,
                    bit = index % 16) (
                switch (word)
                case(3) w3.get(bit)
                case(2) w2.get(bit)
                case(1) w1.get(bit)
                else    w0.get(bit))
            else false;

    shared actual
    Long set(Integer index, Boolean val)
        =>  if (0 <= index <= 63) then
                let(word = index / 16)
                let(bit = index % 16)
                ofWords(
                    if (word == 3) then w3.set(bit, val) else w3,
                    if (word == 2) then w2.set(bit, val) else w2,
                    if (word == 1) then w1.set(bit, val) else w1,
                    if (word == 0) then w0.set(bit, val) else w0)
            else this;

    shared actual
    Long leftLogicalShift(variable Integer shift) {
        shift = shift.and($111111);

        if (shift == 0) {
            return this;
        }

        value words = shift / 16;
        value bits = shift % 16;

        if (bits == 0) {
            return switch(words)
            case (1) ofWords(w2, w1, w0, 0)
            case (2) ofWords(w1, w0,  0, 0)
            else     ofWords(w0,  0,  0, 0);
        }

        value right = 16 - bits;
        return switch(words)
        case (0)
            ofWords(
                w3.leftLogicalShift(bits).or(w2.rightLogicalShift(right)).and(#ffff),
                w2.leftLogicalShift(bits).or(w1.rightLogicalShift(right)).and(#ffff),
                w1.leftLogicalShift(bits).or(w0.rightLogicalShift(right)).and(#ffff),
                w0.leftLogicalShift(bits).and(#ffff))
        case (1)
            ofWords(
                w2.leftLogicalShift(bits).or(w1.rightLogicalShift(right)).and(#ffff),
                w1.leftLogicalShift(bits).or(w0.rightLogicalShift(right)).and(#ffff),
                w0.leftLogicalShift(bits).and(#ffff),
                0)
        case (2)
            ofWords(
                w1.leftLogicalShift(bits).or(w0.rightLogicalShift(right)).and(#ffff),
                w0.leftLogicalShift(bits).and(#ffff),
                0, 0)
        else
            ofWords(
                w0.leftLogicalShift(bits).and(#ffff),
                0, 0, 0);
    }

    shared actual
    LongImpl16 rightLogicalShift(variable Integer shift) {
        shift = shift.and($111111);

        if (shift == 0) {
            return this;
        }

        value words = shift / 16;
        value bits = shift % 16;

        if (bits == 0) {
            return switch(words)
            case (1) ofWords(0, w3, w2, w1)
            case (2) ofWords(0,  0, w3, w2)
            else     ofWords(0,  0,  0, w3);
        }

        value left = 16 - bits;
        return switch(words)
        case (0)
            ofWords(
                w3.rightLogicalShift(bits).and(#ffff),
                w2.rightLogicalShift(bits).or(w3.leftLogicalShift(left)).and(#ffff),
                w1.rightLogicalShift(bits).or(w2.leftLogicalShift(left)).and(#ffff),
                w0.rightLogicalShift(bits).or(w1.leftLogicalShift(left)).and(#ffff))
        case (1)
            ofWords(
                0,
                w3.rightLogicalShift(bits).and(#ffff),
                w2.rightLogicalShift(bits).or(w3.leftLogicalShift(left)).and(#ffff),
                w1.rightLogicalShift(bits).or(w2.leftLogicalShift(left)).and(#ffff))
        case (2)
            ofWords(
                0, 0,
                w3.rightLogicalShift(bits).and(#ffff),
                w2.rightLogicalShift(bits).or(w3.leftLogicalShift(left)).and(#ffff))
        else
            ofWords(
                0, 0, 0,
                w3.rightLogicalShift(bits).and(#ffff));
    }

    shared actual
    Long rightArithmeticShift(variable Integer shift) {
        if (!negative) {
            return rightLogicalShift(shift);
        } else {
            shift = shift.and($111111);

            if (shift == 0) {
                return this;
            }

            value l = rightLogicalShift(shift);
            value words = shift / 16;
            value bits = shift % 16;

            if (bits == 0) {
                return switch(words)
                case (1) ofWords(#ffff, l.w3, l.w2, l.w1)
                case (2) ofWords(#ffff, #ffff, l.w3, l.w2)
                else     ofWords(#ffff, #ffff, #ffff, l.w3);
            } else {
                value ones = (-1).leftLogicalShift(16 - bits).and(#ffff);
                return switch(words)
                case (0) ofWords(l.w3.or(ones), l.w2, l.w1, l.w0)
                case (1) ofWords(#ffff, l.w3.or(ones), l.w2, l.w1)
                case (2) ofWords(#ffff, #ffff, l.w3.or(ones), l.w2)
                else     ofWords(#ffff, #ffff, #ffff, l.w3.or(ones));
            }
        }
    }

    shared actual
    Long neighbour(Integer offset)
        =>  this.plusInteger(offset);

    shared actual
    Integer offset(Long other) {
        value diff = this - other;
        if (integerMin <= diff <= integerMax) {
            return diff.integer;
        }
        else {
            throw OverflowException();
        }
    }

    shared actual
    LongImpl16 not
        =>  ofWords(
                w3.not.and(#ffff),
                w2.not.and(#ffff),
                w1.not.and(#ffff),
                w0.not.and(#ffff));

    shared actual
    LongImpl16 negated
        =>  not.plus(lone);

    // same as with Whole - narrow to integer addressable number of bits
    shared actual
    Integer integer
        =>  if (runtime.integerAddressableSize == 64) then
                w0.or(w1.leftLogicalShift(16))
                  .or(w2.leftLogicalShift(32))
                  .or(w3.leftLogicalShift(48))
            else
                w0.or(w1.leftLogicalShift(16));

    shared actual
    Integer preciseInteger {
        value result = impreciseInteger;
        if (! runtime.minIntegerValue <= result <= runtime.maxIntegerValue) {
            throw OverflowException(
                "Cannot represent value without loss of precision.");
        }
        return result;
    }

    shared actual
    Integer impreciseInteger {
        // special case min int, which can't be negated
        if (w3 == #8000 && w2 == 0 && w1 == 0 && w0 == 0) {
            return -9223372036854775808;
        }
        value mag = magnitude;
        variable Integer result;
        result  = mag.w3;
        result *= #10000;
        result += mag.w2;
        result *= #10000;
        result += mag.w1;
        result *= #10000;
        result += mag.w0;
        if (negative) {
            return -result;
        } else {
            return result;
        }
    }

    shared actual
    Whole whole {
        if (safelyAddressable) {
            return wholeNumber(integer);
        }
        else if (zero) {
            return wholeZero;
        }
        else if (positive) {
            return wholeNumber(w3)
                   .leftLogicalShift(16).or(wholeNumber(w2))
                   .leftLogicalShift(16).or(wholeNumber(w1))
                   .leftLogicalShift(16).or(wholeNumber(w0));
        }
        else {
            return      wholeNumber(w3.not.and(#ffff)).leftLogicalShift(48)
                    .or(wholeNumber(w2.not.and(#ffff)).leftLogicalShift(32))
                    .or(wholeNumber(w1.not.and(#ffff)).leftLogicalShift(16))
                    .or(wholeNumber(w0.not.and(#ffff)))
                    .not;
        }
    }

    shared actual
    LongImpl16 magnitude
        =>  if (negative)
            then negated
            else this;

    shared actual
    Long wholePart
        =>  this;

    shared actual
    Long fractionalPart
        =>  lzero;

    shared actual
    Boolean zero
        =>  w0 == 0 && w1 == 0 && w2 == 0 && w3 == 0;

    Boolean negativeOne
        =>  w0 == #ffff && w1 == #ffff && w2 == #ffff && w3 == #ffff;

    shared actual
    Boolean unit
        =>  w0 == 1 && w1 == 0 && w2 == 0 && w3 == 0;

    shared actual
    Boolean positive
        =>  !negative && !zero;

    shared actual
    Boolean negative
        =>  w3.get(15);

    shared actual
    Boolean even
        =>  w0.even;

    shared actual
    Integer sign
        =>  if (negative) then -1
            else if (zero) then 0
            else 1;

    shared actual
    Integer hash
        =>  integer;

    Boolean safelyAddressable
        =>  (w3 == 0 && w2 == 0 && !w1.get(15)) ||
            (w3 == #ffff && w2 == #ffff && w1.get(15));

    shared actual
    String string
        =>  formatLong(this);

    shared actual
    Boolean equals(Object that)
        =>  if (is LongImpl16 that) then
                w3==that.w3 &&
                w2==that.w2 &&
                w1==that.w1 &&
                w0==that.w0
            else
                false;

    shared actual
    Comparison compare(Long other)
        =>  let (thisSign = sign,
                 otherSign = other.sign)
            if (thisSign != otherSign) then
                thisSign <=> otherSign
            else if ((this - other).negative) then
                smaller
            else
                larger;

    Long powerBySquaring(variable Long exponent) {
        variable Long result = lone;
        variable Long x = this;
        while (!exponent.zero) {
            if (!exponent.even) {
                result *= x;
                exponent--;
            }
            x *= x;
            exponent = exponent.rightLogicalShift(1);
        }
        return result;
    }

    shared actual
    Byte byte
        =>  Byte(w0.and(#ff));

    shared actual
    Character character {
        if (!safelyAddressable) {
            throw OverflowException();
        }
        return integer.character;
    }

    shared actual
    Float float
        =>  preciseInteger.float;
}
