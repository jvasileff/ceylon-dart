import ceylon.collection {
    linked,
    HashMap
}
import ceylon.file {
    File,
    parsePath,
    Resource,
    Nil,
    Path,
    ExistingResource
}
import ceylon.interop.java {
    JavaList
}

import java.io {
    JWriter=Writer,
    JFile=File
}
import java.lang {
    JString=String,
    CharArray
}
import java.nio.file {
    JPath=Path,
    JFiles=Files
}
import java.util {
    JList=List
}

shared
JFile javaFile(Resource | Path | JFile | String resource)
    =>  switch (resource)
        case (is JFile) resource
        case (is String) JFile(resource)
        else if (is Resource resource)
            then JFile(resource.path.string)
            else JFile(resource.string);

shared
JWriter javaWriter(File.Appender appender) => object
        extends JWriter() {

    close() => appender.close();

    flush() => appender.flush();

    write(CharArray charArray, Integer offset, Integer length)
        // What's the best way to do this?
        =>  appender.write(JString(charArray, offset, length).string);
};

shared
JPath javaPath(Path | Resource resource)
    =>  javaFile(resource).toPath();

shared
File? ceylonFile(File | JFile? file) {
    if (is File file) {
        return file;
    }
    if (exists file) {
        value result = parsePath(file.absolutePath).resource;
        if (is File result) {
            return result;
        }
    }
    return null;
}

shared
ExistingResource createSymbolicLink(Nil nil, Path linkedPath) {
    // Workaround https://github.com/ceylon/ceylon-sdk/issues/540
    // Should return Link.

    JFiles.createSymbolicLink(javaPath(nil), javaPath(linkedPath));
    assert (is ExistingResource link = nil.path.resource); // fails
    return link;
}

shared
JList<Element> javaList<Element>({Element*} elements)
        given Element satisfies Object
    =>  JavaList(elements.sequence());

shared
Map<Key, Item> linkedMap<Key, Item>({<Key->Item>*} entries)
        given Key satisfies Object
    =>  HashMap { stability = linked; *entries };
