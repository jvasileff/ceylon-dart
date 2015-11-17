import java.lang {
    JString=String,
    CharArray
}
import java.io {
    JWriter=Writer,
    JFile=File
}
import ceylon.file {
    File,
    parsePath
}
import java.nio.file {
    JFiles=Files,
    JPath=Path
}

shared
JFile javaFile(File | JFile file)
    =>  if (is JFile file)
        then file
        else JFile(file.path.string);

shared
class TemporaryFile(
        String? prefix = null, String? suffix = null,
        Boolean deleteOnExit = false)
        satisfies Destroyable {

    value path = JFiles.createTempFile(prefix, suffix);
    if (deleteOnExit) {
        path.toFile().deleteOnExit();
    }
    assert (is File f = parsePath(path.string).resource);

    shared File file = f;

    shared actual void destroy(Throwable? error) {
        f.delete();
    }
}

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
JPath javaPath(File file)
    =>  javaFile(file).toPath();

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
