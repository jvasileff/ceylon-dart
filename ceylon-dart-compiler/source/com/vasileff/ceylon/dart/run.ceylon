import com.vasileff.ceylon.dart.compiler {
    compile
}
import com.vasileff.ceylon.dart.ast {
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void run() {

    value program =
         """
            void run() {
                print("dart");
                print(1+2+3);
                Integer ten = 10;
                print(ten + ten + identity(1));
                value twenty = ten + ten;

                print(1.plus(2).plus(3));
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
