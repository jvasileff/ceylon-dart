import com.vasileff.ceylon.dart.compiler.dartast {
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void runSample() {

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

shared
void runModuleSample() {
    value mod =
         """
            module simple "1.0.0" {
                import interop.dart.io "1.0.0";
            }
         """;

    value pack =
         """
            package simple;
         """;

    value run =
         """
            shared void run() {
                print("hello");
            }
         """;

    value result = testModuleCompile {
        false;
        true;
        "simple/module.ceylon" -> mod,
        "simple/package.ceylon" -> pack,
        "simple/run.ceylon" -> run
    };

    for (dcu in result) {
        value codeWriter = CodeWriter(process.write);
        dcu.write(codeWriter);
    }
}
