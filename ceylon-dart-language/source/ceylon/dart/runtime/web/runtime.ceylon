import dart.core {
    dprint = print
}

shared object runtime {

    StringBuilder outputBuffer
        =   StringBuilder();

    shared Map<String, String> platformProperties
        =   map {
                "os.name" -> "UNKNOWN",
                "line.separator" -> "\n",
                "file.separator" -> "/",
                "path.separator" -> ":",
                "dart.version" -> "UNKNOWN"
            };

    shared String? environmentVariableValue(String name)
        =>  null;

    shared String? readLine()
        =>  null;

    shared void write(String string) {
        value newlineIndex = string.lastOccurrence('\n');
        if (exists newlineIndex) {
            dprint(outputBuffer.string + string[0:newlineIndex]);
            outputBuffer.clear();
            outputBuffer.append(string.spanFrom(newlineIndex + 1));
        }
        else {
            outputBuffer.append(string);
        }
    }

    shared void writeLine(String line) {
        write(line);
        write(operatingSystem.newline);
    }

    shared void flush() {}

    shared void writeError(String string)
        =>  write(string);

    shared void writeErrorLine(String line)
        =>  writeLine(line);

    shared void flushError() {}

    shared Nothing exit(Integer code)
        =>  nothing;
}
