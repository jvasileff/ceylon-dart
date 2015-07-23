import com.vasileff.ceylon.dart.compiler {
    compile,
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void run() {

    value program =
         """
            void run() {
                print("dart");
            }

            native void someNative();

            native String someString;
         """;

    value result = compile { false; program };

    for (dcu in result) {
        value codeWriter = CodeWriter(process.write);
        dcu.write(codeWriter);
    }
}
