import com.vasileff.ceylon.dart.compiler {
    compile
}

shared
void run() {
    value program2 =
           """
              void prog2() {}
           """;
    value program =
           """
              void main() {
                Integer oi = 55;
                Object x = oi;
                Object y = 90;
              }
           """;
//         """
//            void main() {
//                value x = (Integer t) { print("printing"); return t; };
//                value y = (Integer t) => t;
//
//                // TODO:
//                // value lazyVal => 1;
//
//                helloDart(1);
//                //void sub(String s, Integer i, [String, Float] t = ["asd", 1.0]) { print("xyz"); }
//                void subfd(Float f, String s = "sdef", Integer i = 99) { print("xyz"); }
//                void subsc(Float f, String s = "sdef", Integer i = 99) => print("xyz");
//                Anything subsc2(Float f, String s = "sdef", Integer i = 99) => print("xyz");
//            }
//
//            void helloDart(Integer y) {
//                value n = null;
//                print("Hello Dart!");
//                return;
//            }
//         """;

    compile(program);
}
