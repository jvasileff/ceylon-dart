import dart.core {
    dprint = print
}
import dart.io {
    DPlatform = Platform,
    dstdin = stdin,
    dexit = exit
}
import ceylon.interop.dart {
    dartString
}

"Represents the current process (instance of the virtual
 machine)."
by ("Gavin", "Tako")
see (`value language`, `value runtime`, `value system`,
     `value operatingSystem`)
tagged("Environment")
shared native object process {
    
    "The command line arguments to the virtual machine."
    shared native String[] arguments;
    
    "Determine if an argument of form `-name` or `--name` 
     was specified among the command line arguments to 
     the virtual machine."
    shared native Boolean namedArgumentPresent(String name);

    "The value of the first argument of form `-name=value`, 
     `--name=value`, or `-name value` specified among the 
     command line arguments to the virtual machine, if
     any."
    shared native String? namedArgumentValue(String name);

    "The value of the given system property of the virtual
     machine, if any."
    shared native String? propertyValue(String name);

    "The value of the given environment variable defined 
     for the current virtual machine process."
    shared native String? environmentVariableValue(String name);
    
    "Print a string to the standard output of the virtual
     machine process."
    shared native void write(String string);
    
    "Print a line to the standard output of the virtual 
     machine process."
    see (`function print`)
    shared native void writeLine(String line="") {
        write(line);
        write(operatingSystem.newline); 
    }
    
    "Flush the standard output of the virtual machine 
     process."
    shared native void flush();
    
    "Print a string to the standard error of the virtual 
     machine process."
    shared native void writeError(String string);
    
    "Print a line to the standard error of the virtual 
     machine process."
    shared native void writeErrorLine(String line="") {
        writeError(line);
        writeError(operatingSystem.newline);
    }
    
    "Flush the standard error of the 
     virtual machine process."
    shared native void flushError();
    
    "Read a line of input text from the standard input of 
     the virtual machine process. Returns a line of text 
     after removal of line-termination characters, or `null`
     to indicate the standard input has been closed."
    shared native String? readLine();
    
    "Force the virtual machine to terminate with the given
     exit code."
    shared native Nothing exit(Integer code);

    shared actual native String string => "process";

}

variable native("dart")
[String*] processArguments = [];

native("dart")
Map<String, String> properties = map {
  "os.name" -> DPlatform.operatingSystem,
  "line.separator" -> (if (DPlatform.isWindows) then "\r\n" else "\n"),
  "file.separator" -> DPlatform.pathSeparator,
  "path.separator" -> (if (DPlatform.isWindows) then ";" else ":"),
  "dart.version" -> DPlatform.version
};

native("dart")
StringBuilder outputBuffer = StringBuilder();

shared native("dart") object process {

    shared native("dart") String[] arguments => processArguments;

    shared native("dart") Boolean namedArgumentPresent(String name) => false;

    shared native("dart") String? namedArgumentValue(String name) => null;

    shared native("dart") String? propertyValue(String name) => properties.get(name);

    shared native("dart") String? environmentVariableValue(String name)
        =>  DPlatform.environment.get_(name).string;

    shared native("dart") void write(String string) {
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

    shared native("dart") void writeLine(String line="") {
        write(line);
        write(operatingSystem.newline);
    }

    shared native("dart") void flush() {}

    shared native("dart") void writeError(String string)
        =>  write(string);

    shared native("dart") void writeErrorLine(String line="") {
        writeError(line);
        writeError(operatingSystem.newline);
    }

    shared native("dart") void flushError() {}

    shared native("dart") String? readLine()
        =>  dstdin.readLineSync();

    shared native("dart") Nothing exit(Integer code) {
        dexit(code);
        return nothing;
    }

    shared actual native("dart") String string => "process";
}
