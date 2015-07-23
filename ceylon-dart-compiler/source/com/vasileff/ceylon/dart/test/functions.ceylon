import ceylon.test {
    assertEquals
}

import com.vasileff.ceylon.dart.compiler {
    compile
}
import com.vasileff.ceylon.dart.ast {
    CodeWriter
}

void compileAndCompare(String ceylon, String expected) {
    value dartUnits = compile { ceylon };
    assert (exists dartUnit = dartUnits[0]);

    value sb = StringBuilder();
    dartUnit.write(CodeWriter(sb.append));

    assertEquals {
        actual = sb.string.trimmed;
        expected =  expected.trimmed;
    };
}
