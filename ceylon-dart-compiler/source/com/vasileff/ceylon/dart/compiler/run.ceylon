import com.vasileff.ceylon.dart.compiler.dartast {
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void run() {

    value program =
         """
            shared void run() {
                print("hello");
            }
         """;

    value result = testCompile { false; program };

    for (dcu in result) {
        value codeWriter = CodeWriter(process.write);
        dcu.write(codeWriter);
    }
}
