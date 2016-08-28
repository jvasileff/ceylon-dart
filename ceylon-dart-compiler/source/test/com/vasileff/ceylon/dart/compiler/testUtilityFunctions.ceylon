import ceylon.file {
    parsePath,
    Nil,
    ExistingResource,
    Directory
}
import ceylon.test {
    assertEquals
}

import com.vasileff.ceylon.dart.compiler {
    testCompile,
    testModuleCompile
}

import java.nio.file {
    JFiles=Files
}

void compileAndCompare(String key) {
    value ceylonPathPart = key +  ".tceylon";
    value dartPathPart = key +  ".tdart";

    assert (exists ceylonResource
        =   `module`.resourceByPath(ceylonPathPart));

    assert (nonempty files
        =   splitBetween(ceylonResource.textContent().lines)((first, second)
                =>  second.startsWith("// file:")).sequence());

    value dartUnits
        =   if (files.size == 1) then
                // single file, not a module
                testCompile {
                    verbose = false;
                    "\n".join(files[0])
                }
            else
                // multiple source files separated by comment of the form:
                //      // file:path/filename.ceylon
                testModuleCompile {
                    verbose = false;
                    suppressAllWarnings = true;
                    files.map((lines)
                        =>  lines.first[8...].trimmed
                                -> "\n".join(lines.rest));
                };

    value dartCode
        =   "\n".join(dartUnits.interpose("/".repeat(70)));

    if (outputToTemp) {
        writeNewTempFile(dartPathPart, dartCode.trimmed);
    }

    value dartText
        =   `module`.resourceByPath(dartPathPart)?.textContent() else "";

    assertEquals {
        actual = dartCode.trimmed;
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

{[Element+]*} splitBetween<Element>
        ({Element*} elements)
        (Boolean split(Element first, Element second)) => object
        satisfies {[Element+]*} {

    shared actual Iterator<[Element+]> iterator() => object
            satisfies Iterator<[Element+]> {

        value it = elements.iterator();
        variable value nextRead = false;
        variable value nextElement = finished of Element | Finished;
        variable value splitNext = false;

        void prepareNext() {
            if (!nextRead) {
                value first = nextElement;
                value second = nextElement = it.next();
                nextRead = true;
                splitNext = if (!is Finished first,
                                !is Finished second)
                            then split(first, second)
                            else false;
            }
        }

        function consumeNext() {
            nextRead = false;
            return nextElement;
        }

        shared actual [Element+] | Finished next() {
            prepareNext();
            if (nextElement is Finished ) {
                return finished;
            }
            value result = object satisfies Iterable<Element> {
                iterator() => object satisfies Iterator<Element> {
                    shared actual Element | Finished next() {
                        prepareNext();
                        if (splitNext) {
                            splitNext = false;
                            return finished;
                        }
                        return consumeNext();
                    }
                };
            }.sequence();
            assert (nonempty result);
            return result;
        }
    };
};
