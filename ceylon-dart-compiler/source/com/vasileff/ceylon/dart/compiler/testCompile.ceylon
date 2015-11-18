import ceylon.interop.java {
    createJavaByteArray,
    CeylonIterable,
    CeylonList,
    javaClass
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.cmr.ceylon {
    CeylonUtils
}
import com.redhat.ceylon.common.tools {
    SourceArgumentsResolver
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    Warning
}
import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnit
}
import com.vasileff.jl4c.guava.collect {
    javaList,
    ImmutableListMultimap,
    ImmutableSetMultimap
}

import java.io {
    ByteArrayInputStream,
    File,
    InputStream
}
import java.lang {
    JString=String
}
import java.util {
    EnumSet
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

shared
[DartCompilationUnit*] testModuleCompile(
        Boolean verbose = false,
        Boolean suppressAllWarnings = true,
        {<String -> String>*} listings = {}) {

    "The full path, parent directory, and file."
    function pathParts(String path) {
        value trimmed = path.trim('/'.equals);
        value components = trimmed.split('/'.equals).sequence();

        "nonempty paths will have at least one path segment."
        assert (nonempty components);

        return ["/".join(components.exceptLast),
                "/".join(components),
                components.last];
    }

    "The path, and all parent directories."
    function directorayAndParents(String path)
        =>  let (trimmed = path.trim('/'.equals),
                segments = trimmed.split('/'.equals).sequence())
            { for (i in 1:segments.size) "/".join(segments.take(i)) };

    value files
        =   ImmutableListMultimap<String, VirtualFile> {
                listings.map((listing)
                    =>  let ([d, p, n] = pathParts(listing.key))
                        d -> object satisfies VirtualFile {
                            children = javaList<VirtualFile> {};

                            path = p;

                            name = n;

                            folder = false;

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
            };

    value directories
        =   ImmutableSetMultimap<String, String> {
                *files.keys.flatMap(directorayAndParents).map((directory)
                    =>  let ([d, p, n] = pathParts(directory))
                        d -> p)
            };

    class DirectoryVirtualFile(path) satisfies VirtualFile {
        shared actual String path;

        name = pathParts(path)[2];

        folder = true;

        \iexists() => true;

        children
            =   javaList<VirtualFile> {
                    expand {
                        directories.get(path).map(DirectoryVirtualFile),
                        files.get(path)
                    };
                };

        compareTo(VirtualFile other)
            =>  switch (path.compare(other.path))
                case (smaller) -1
                case (larger) 1
                case (equal) 0;

        shared actual
        InputStream inputStream {
            throw AssertionError("Directories don't have input streams.");
        }
    }

    return
    compileDart {
        virtualFiles = [DirectoryVirtualFile("")];
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