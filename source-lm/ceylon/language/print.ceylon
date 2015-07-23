"Print a line to the standard output of the virtual machine 
 process, printing the given value\'s `string`, or `<null>` 
 if the value is `null`.
 
 This function is a shortcut for:
 
     process.writeLine(line?.string else \"<null>\")
 
 and is intended mainly for debugging purposes."
see (`function process.writeLine`)
by ("Gavin")
native shared void print(Anything val) 
        => process.writeLine(stringify(val));

"Print multiple values to the standard output of the virtual 
 machine process as a single line of text, separated by a
 given character sequence."
by ("Gavin")
see (`function process.write`)
native shared void printAll({Anything*} values,
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

native String stringify(Anything val) => val?.string else "<null>";
