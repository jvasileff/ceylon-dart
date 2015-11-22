import com.vasileff.ceylon.dart.compiler.dartast {
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void run() {

    value program =
         """
            shared void run() {
                dynamic {
                    x = y;
                    print("hello");
                }
            }
         """;

    value result = testCompile { true; program };

    for (dcu in result) {
        value codeWriter = CodeWriter(process.write);
        dcu.write(codeWriter);
    }
}
