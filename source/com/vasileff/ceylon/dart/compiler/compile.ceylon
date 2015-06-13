import ceylon.interop.java {
    createJavaByteArray,
    CeylonIterable
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.io {
    InputStream,
    ByteArrayInputStream
}
import java.util {
    List
}

shared
void compile(String program) {

    object source satisfies VirtualFile {
        shared actual
        List<out VirtualFile> children
            =>  javaList {};

        shared actual
        Integer compareTo(VirtualFile other)
            =>  switch (path.compare(other.path))
                case (smaller) -1
                case (larger) 1
                case (equal) 0;

        shared actual
        Boolean folder
            =>  false;

        shared actual
        InputStream inputStream
            =>  ByteArrayInputStream(
                    createJavaByteArray(
                        utf8.encode(program)));

        shared actual
        String name
            =>  "virtual.ceylon";

        shared actual
        String path
            =>  name;
    }

    value builder = TypeCheckerBuilder();
    builder.addSrcDirectory(source);

    value typeChecker = builder.typeChecker;
    typeChecker.process();

    // print typechecker messages
    CeylonIterable(typeChecker.messages).each(
            compose(process.writeErrorLine, Object.string));

    value phasedUnits = CeylonIterable(
            typeChecker.phasedUnits.phasedUnits);

    for (phasedUnit in phasedUnits) {
        value unit = transformCompilationUnit(
                phasedUnit.compilationUnit);
        printNode(unit);
        print(phasedUnit.compilationUnit);
        value visitor = DartBackendVisitor();
        unit.visit(visitor);
        print(visitor.result);
    }
}
