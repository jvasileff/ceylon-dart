// for i in identical.ceylon largest.ceylon plus.ceylon smallest.ceylon times.ceylon print.ceylon every.ceylon count.ceylon product.ceylon sum.ceylon; do echo // $i ; cat $i ; echo ; done

// add functions.ceylon/identity
shared Value identity<Value>(Value argument) => argument;

// TODO any.ceylon, arrayOfSize.ceylon, formatInteger, infinity.ceylon
// Soon byIncreasing.ceylon, byDecreasing.ceylon, byItem, byKey, forItem, forKey

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

