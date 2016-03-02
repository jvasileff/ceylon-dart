import dart.core {
    dprint = print
}
import dart.io {
    DPlatform = Platform,
    dstdin = stdin,
    dstdout = stdout,
    dstderr = stderr,
    dexit = exit
}

shared object runtime {

    StringBuilder outputBuffer
        =   StringBuilder();

    shared Map<String, String> platformProperties
        =   map {
                "os.name" -> DPlatform.operatingSystem,
                "line.separator" -> (if (DPlatform.isWindows) then "\r\n" else "\n"),
                "file.separator" -> DPlatform.pathSeparator,
                "path.separator" -> (if (DPlatform.isWindows) then ";" else ":"),
                "dart.version" -> DPlatform.version
            };

    shared String? environmentVariableValue(String name)
        =>  DPlatform.environment.get_(name).string;

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

    shared void writeLine(String line)
        =>  dstdout.writeln(line);

    shared void flush()
        =>  dstdout.flush();

    shared void writeError(String string)
        =>  dstderr.write(string);

    shared void writeErrorLine(String line)
        =>  dstderr.writeln(line);

    shared void flushError()
        =>  dstderr.flush();

    shared String? readLine()
        =>  dstdin.readLineSync();

    shared Nothing exit(Integer code) {
        dexit(code);
        return nothing;
    }
}
