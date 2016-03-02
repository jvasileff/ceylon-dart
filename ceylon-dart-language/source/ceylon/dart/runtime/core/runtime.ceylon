shared object runtime {
    shared Map<String, String> platformProperties => nothing;
    shared String? environmentVariableValue(String name) => nothing;
    shared String? readLine() => nothing;
    shared void write(String string) { throw; }
    shared void writeLine(String line) { throw; }
    shared void flush() { throw; }
    shared void writeError(String string) { throw; }
    shared void writeErrorLine(String line)  { throw; }
    shared void flushError() { throw; }
    shared Nothing exit(Integer code) => nothing;
}
