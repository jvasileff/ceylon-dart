import ceylon.interop.java {
    createJavaByteArray,
    CeylonIterable,
    CeylonList,
    javaClass
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnit
}

import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.io {
    ByteArrayInputStream,
    File
}
import com.redhat.ceylon.cmr.ceylon {
    CeylonUtils
}
import com.redhat.ceylon.common.tools {
    SourceArgumentsResolver
}
import java.lang {
    JString=String
}
import java.util {
    EnumSet
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    Warning
}

shared
[DartCompilationUnit*] testCompile(
        Boolean verbose = false,
        Boolean suppressAllWarnings = true,
        {String*} listings = {}) {

    value virtualFiles
        =   listings.indexed.map((listing) => object satisfies VirtualFile {
                children => javaList<VirtualFile> {};
                name => "virtual-``listing.key``.ceylon";
                path => name;
                folder => false;
                \iexists() => true;

                inputStream
                    =>  ByteArrayInputStream(createJavaByteArray(
                            utf8.encode(listing.item)));

                compareTo(VirtualFile other)
                    =>  switch (path.compare(other.path))
                        case (smaller) -1
                        case (larger) 1
                        case (equal) 0;
            });

    return
    compileDart {
        virtualFiles = virtualFiles;
        verboseAst = verbose;
        verboseRhAst = verbose;
        verboseCode = false;
        suppressMainFunction = true;
        suppressWarning
            =   if (suppressAllWarnings)
                then allWarnings
                else [];
    }[0];
}

"A simple CLI compiler that takes two arguments: a source directory and an output
 directory. Warnings are suppressed."
shared
suppressWarnings("expressionTypeNothing")
void bootstrapCompile() {
    assert (exists sourceDirectory = process.arguments[0]);
    assert (exists outputDirectory = process.arguments[1]);

    value sourceDirectories
        =   javaList { File(sourceDirectory) };

    value outputRepositoryManager
        =   CeylonUtils.repoManager()
                .outRepo(outputDirectory)
                .buildOutputManager();

    value resolver
        =   SourceArgumentsResolver(
                sourceDirectories,
                javaList<File> { },
                ".ceylon"
            );

    resolver.expandAndParse(javaList<JString> { }, dartBackend);

    value result = compileDart {
        sourceDirectories = CeylonList(sourceDirectories);
        sourceFiles = CeylonList(resolver.sourceFiles);
        outputRepositoryManager = outputRepositoryManager;
        suppressWarning = CeylonIterable(EnumSet.allOf(javaClass<Warning>()));
    }[1];

    process.exit(
        switch (result)
        case (CompilationStatus.success) 0
        case (CompilationStatus.errorTypeChecker
                | CompilationStatus.errorDartBackend) 1);
}
