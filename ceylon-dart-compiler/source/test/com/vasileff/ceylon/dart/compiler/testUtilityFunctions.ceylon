import ceylon.file {
    parsePath,
    Nil,
    ExistingResource,
    Directory
}
import ceylon.test {
    assertEquals
}

import com.vasileff.ceylon.dart.ast {
    CodeWriter
}


import java.nio.file {
    JFiles=Files
}
import com.vasileff.ceylon.dart {
    testCompile
}

void compileAndCompare(String ceylon, String expected) {
    value dartUnits = testCompile { false; ceylon };
    assert (exists dartUnit = dartUnits[0]);

    value sb = StringBuilder();
    dartUnit.write(CodeWriter(sb.append));

    assertEquals {
        actual = sb.string.trimmed;
        expected =  expected.trimmed;
    };
}

void compileAndCompare2(String key) {
    value ceylonPathPart = "compiler/" + key +  ".tceylon";
    value dartPathPart = "compiler/" + key +  ".tdart";

    assert (exists ceylonResource = `module`.resourceByPath(ceylonPathPart));

    value dartUnits = testCompile { false; ceylonResource.textContent() };
    assert (exists dartUnit = dartUnits[0]);
    value dartCode = dartUnit.string.trimmed;

    if (outputToTemp) {
        writeNewTempFile(dartPathPart, dartCode);
    }

    value dartText = `module`.resourceByPath(dartPathPart)?.textContent() else "";

    assertEquals {
        actual = dartCode;
        expected =  dartText.trimmed;
    };
}

Directory tempDirectory
    =   createTemporaryDirectory("ceylon-dart-test");

Boolean outputToTemp
    =   process.propertyValue("output-to-temp") exists;

void writeNewTempFile(String pathPart, String content) {
    value tempPath = tempDirectory.path;
    value dartPath = tempPath.childPath(pathPart);
    switch (dartFileResource = dartPath.resource)
    case (is Nil) {
        process.writeErrorLine("Outputing file: \
                                '``dartPath.string``'");
        value dartFile = dartFileResource.createFile(true);
        value appender = dartFile.Appender();
        appender.write(content);
        appender.close();
    }
    case (is ExistingResource) {
        process.writeErrorLine("Not outputing file; resource already exists: \
                                '``dartPath.string``'");
    }
}

Directory createTemporaryDirectory(String prefix = "") {
    value javaFile = JFiles.createTempDirectory(prefix);
    assert (is Directory result = parsePath(javaFile.string).resource);
    return result;
}
