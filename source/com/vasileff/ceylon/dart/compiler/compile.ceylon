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
import ceylon.ast.redhat {
    compilationUnitToCeylon
}

shared
void compile(String *listings) {

    value virtualFiles = listings.indexed.map((listing) => object
            satisfies VirtualFile {
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
                        utf8.encode(listing.item)));

        shared actual
        String name
            =>  "virtual-``listing.key``.ceylon";

        shared actual
        String path
            =>  name;
    });

    value builder = TypeCheckerBuilder();
    virtualFiles.each((vf) => builder.addSrcDirectory(vf));

    value typeChecker = builder.typeChecker;
    typeChecker.process();

    // print typechecker messages
    CeylonIterable(typeChecker.messages).each(
            compose(process.writeErrorLine, Object.string));

    value phasedUnits = CeylonIterable(
            typeChecker.phasedUnits.phasedUnits);

    for (phasedUnit in phasedUnits) {
        value unit = compilationUnitToCeylon(
                phasedUnit.compilationUnit,
                augmentNode);
        printNodeAsCode(unit);
        print("========================");
        print("== AST");
        print("========================");
        print(unit);
        print("========================");
        print("== TC-AST");
        print("========================");
        print(phasedUnit.compilationUnit);
        print("========================");
        print("== DART");
        print("========================");
        value visitor = DartBackendVisitor(phasedUnit.unit);
        unit.visit(visitor);
        print(visitor.result);
    }
}
