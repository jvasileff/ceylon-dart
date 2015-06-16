import com.vasileff.ceylon.dart.compiler {
    compile
}

shared
void run() {
    value program =
         """
            void main() {
                value x = (Integer t) { print("printing"); return t; };
                value y = (Integer t) => t;
                helloDart(1);
                //void sub(String s, Integer i, [String, Float] t = ["asd", 1.0]) { print("xyz"); }
                void subfd(Float f, String s = "sdef", Integer i = 99) { print("xyz"); }
                void subsc(Float f, String s = "sdef", Integer i = 99) => print("xyz");
                Anything subsc2(Float f, String s = "sdef", Integer i = 99) => print("xyz");
            }

            void helloDart(Integer y) {
                print("Hello Dart!");
                return;
            }
         """;

    compile(program);
}
