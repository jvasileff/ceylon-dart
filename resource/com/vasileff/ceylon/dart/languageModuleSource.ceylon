// for i in identical.ceylon largest.ceylon plus.ceylon smallest.ceylon times.ceylon \
//          print.ceylon every.ceylon count.ceylon product.ceylon sum.ceylon \
//          any.ceylon, arrayOfSize.ceylon, formatInteger.ceylon, infinity.ceylon;
//    do echo // $i ; cat $i ; echo ; done

// TODO max, byIncreasing, byDecreasing, byItem, byKey, forItem, forKey, not, nothing, or, sort

// Fixups/hacks: replace `{}` with `""` in formatInteger

// add functions.ceylon/identity
shared Value identity<Value>(Value argument) => argument;

// for parseInteger
Integer minRadix = 2;
Integer maxRadix = 36;
Integer aIntLower = 'a'.integer;
Integer aIntUpper = 'A'.integer;
Integer zeroInt = '0'.integer;

// identical.ceylon
"Determine if the arguments are [[identical]]. Equivalent to
 `x===y`. Only instances of [[Identifiable]] have 
 well-defined identity."
see (`function identityHash`)
shared Boolean identical(
        "An object with well-defined identity."
        Identifiable x, 
        "A second object with well-defined identity."
        Identifiable y) 
                => x===y;
// largest.ceylon
"Given two [[Comparable]] values, return largest of the two."
see (`interface Comparable`, 
     `function smallest`, 
     `function max`)
shared Element largest<Element>(Element x, Element y) 
        given Element satisfies Comparable<Element> 
        => x>y then x else y;
// plus.ceylon
"Add the given [[Summable]] values.
 
     (1..100).by(2).fold(0)(plus<Integer>)"
see (`function times`, `function sum`)
shared Value plus<Value>(Value x, Value y)
        given Value satisfies Summable<Value>
        => x+y;
// smallest.ceylon
"Given two [[Comparable]] values, return smallest of the two."
see (`interface Comparable`, 
     `function largest`, 
     `function min`)
shared Element smallest<Element>(Element x, Element y) 
        given Element satisfies Comparable<Element> 
        => x<y then x else y;
// times.ceylon
"Multiply the given [[Numeric]] values.
 
     (1..100).by(2).fold(1)(times<Integer>)"
see (`function plus`, `function product`)
shared Value times<Value>(Value x, Value y)
        given Value satisfies Numeric<Value>
        => x*y;
// print.ceylon
"Print a line to the standard output of the virtual machine 
 process, printing the given value\'s `string`, or `<null>` 
 if the value is `null`.
 
 This function is a shortcut for:
 
     process.writeLine(line?.string else \"<null>\")
 
 and is intended mainly for debugging purposes."
see (`function process.writeLine`)
by ("Gavin")
shared void print(Anything val) 
        => process.writeLine(stringify(val));

"Print multiple values to the standard output of the virtual 
 machine process as a single line of text, separated by a
 given character sequence."
by ("Gavin")
see (`function process.write`)
shared void printAll({Anything*} values,
        "A character sequence to use to separate the values"
        String separator=", ") {
    variable value first = true;
    values.each(void (element) {
        if (first) {
            first = false;
        }
        else {
            process.write(separator);
        }
        process.write(stringify(element));
    });
    process.write(operatingSystem.newline);
}

String stringify(Anything val) => val?.string else "<null>";

// every.ceylon
"Determines if every one of the given boolean values 
 (usually a comprehension) is `true`.
 
     Boolean allPositive = every { for (x in xs) x>0.0 };
 
 If there are no boolean values, return `true`."
see (`function any`, 
     `function Iterable.every`)
shared Boolean every({Boolean*} values) {
    for (val in values) {
        if (!val) {
            return false;
        }
    }
    return true;
}

// count.ceylon
"A count of the number of `true` items in the given values.
 
     Integer negatives = count { for (x in xs) x<0.0 };"
see (`function Iterable.count`)
shared Integer count({Boolean*} values) {
    variable value count=0;
    for (val in values) {
        if (val) {
            count++;
        }
    }
    return count;
}

// product.ceylon
"Given a nonempty stream of [[Numeric]] values, return the 
 product of the values."
see (`function sum`)
shared Value product<Value>({Value+} values) 
        given Value satisfies Numeric<Value> {
    variable value product = values.first;
    for (val in values.rest) {
        product *= val;
    }
    return product;
}

// sum.ceylon
"Given a nonempty stream of [[Summable]] values, return the 
 sum of the values."
see (`function product`)
shared Value sum<Value>({Value+} values) 
        given Value satisfies Summable<Value> {
    value it = values.iterator();
    assert (!is Finished first = it.next());
    variable value sum = first;
    while (!is Finished val = it.next()) {
        sum += val;
    }
    return sum;
}

// any.ceylon
"Determines if any one of the given boolean values 
 (usually a comprehension) is `true`.
 
     Boolean anyNegative = any { for (x in xs) x<0.0 };
 
 If there are no boolean values, return `false`."
see (`function every`, 
     `function Iterable.any`)
shared Boolean any({Boolean*} values) {
    for (val in values) {
        if (val) {
            return true;
        }
    }
    return false;
}

// arrayOfSize.ceylon
"Create an array of the specified [[size]], populating every 
 index with the given [[element]]. The specified `size` must 
 be no larger than [[runtime.maxArraySize]]. If `size<=0`, 
 the new array will have no elements."
throws (`class AssertionError`, 
        "if `size>runtime.maxArraySize`")
see (`value runtime.maxArraySize`)
deprecated ("Use [[Array.ofSize]]")
shared Array<Element> arrayOfSize<Element>(
        "The size of the resulting array. If the size is 
         non-positive, an empty array will be created."
        Integer size,
        "The element value with which to populate the array.
         All elements of the resulting array will have the 
         same value." 
        Element element) 
        => Array.ofSize(size, element);

// formatInteger.ceylon
"The string representation of the given [[integer]] in the 
 base given by [[radix]]. If the given integer is negative, 
 the string representation will begin with `-`. Digits 
 consist of decimal digits `0` to `9`, together with and 
 lowercase letters `a` to `z` for bases greater than 10.
 
 For example:
 
 - `formatInteger(-46)` is `\"-46\"`
 - `formatInteger(9,2)` is `\"1001\"`
 - `formatInteger(10,8)` is `\"12\"`
 - `formatInteger(511,16)` is `\"1ff\"`
 - `formatInteger(512,32)` is `\"g0\"`"
throws (`class AssertionError`, 
        "if [[radix]] is not between [[minRadix]] and 
         [[maxRadix]]")
see (`function parseInteger`)
shared String formatInteger(
            "The integer value to format."
            Integer integer,
            "The base, between [[minRadix]] and [[maxRadix]] 
             inclusive."
            Integer radix = 10) {
    assert (minRadix <= radix <= maxRadix);
    if (integer == 0) {
        return "0";
    }
    variable {Character*} digits = "";
    variable Integer i = integer < 0 
                         then integer 
                         else -integer;
    while (i != 0) {
        Integer d = -(i % radix);
        Character c;
        if (0<=d<10) {
            c = (d+zeroInt).character;
        }
        else if (10<=d<36) {
            c = (d-10+aIntLower).character;
        }
        else {
            assert (false);
        }
        digits = digits.follow(c);
        i = (i + d) / radix;
    }
    if (integer < 0) {
        digits = digits.follow('-');
    }
    return String(digits);
}

// infinity.ceylon
"An instance of [[Float]] representing positive infinity, 
 \{#221E}, the result of dividing a positive number by zero. 
 Negative infinity, -\{#221E}, the result of dividing a
 negative number by zero, is the additive inverse `-infinity`.
 
 Note that any floating-point computation that results in a
 positive value too large to be represented as a `Float` is 
 \"rounded up\" to `infinity`. Likewise, any floating-point 
 computation that yields a negative value whose magnitude is
 too large to be represented as a `Float` is \"rounded down\" 
 to `-infinity`."
shared Float infinity = 1.0/0.0;
