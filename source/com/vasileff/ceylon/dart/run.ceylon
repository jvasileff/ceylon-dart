import com.vasileff.ceylon.dart.compiler {
    compile
}

shared
void run() {
    value program =
         """
            void main() {
                helloDart(1);
            }

            void helloDart(Integer y) {
                print("Hello Dart!");
            }
         """;

    compile(program);
}
