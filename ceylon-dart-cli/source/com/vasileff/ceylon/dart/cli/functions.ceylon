import java.io {
    JFile=File
}
import ceylon.file {
    File,
    parsePath
}

JFile javaFile(File file)
    =>  JFile(file.path.string);

File assertedCeylonFile(JFile file) {
    assert (is File result = parsePath(file.absolutePath).resource);
    return result;
}
