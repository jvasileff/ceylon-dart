native("jvm")
module com.vasileff.ceylon.dart.compiler "1.3.2-DP5-SNAPSHOT" {
    import ceylon.whole "1.3.2";
    import ceylon.buffer "1.3.2";
    import ceylon.collection "1.3.2";
    import ceylon.interop.java "1.3.2";
    shared import ceylon.json "1.3.2";
    shared import ceylon.file "1.3.2";

    import ceylon.ast.create "1.3.2-SNAPSHOT";
    import ceylon.ast.redhat "1.3.2-SNAPSHOT";
    shared import ceylon.ast.core "1.3.2-SNAPSHOT";

    import com.vasileff.ceylon.structures "1.1.1";

    import com.redhat.ceylon.cli "1.3.2";
    shared import com.redhat.ceylon.typechecker "1.3.2";

    shared import java.base "7";
    shared import "net.minidev.json-smart" "1.1.1";
}
