import com.vasileff.ceylon.dart.compiler {
    compile
}
shared
void run() {
    value program =
         """
            Integer plus(Integer x, Integer y) {
                return x + y;
            }
         """;

    compile(program);
}
