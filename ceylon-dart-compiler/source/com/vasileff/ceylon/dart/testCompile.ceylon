import ceylon.interop.java {
    createJavaByteArray
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.vasileff.ceylon.dart.ast {
    DartCompilationUnit
}
import com.vasileff.ceylon.dart.compiler {
    compileDart,
    allWarnings
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.io {
    ByteArrayInputStream
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
    };
}
