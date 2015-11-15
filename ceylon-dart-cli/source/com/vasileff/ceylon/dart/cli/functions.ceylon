import java.io {
    JFile=File
}
import ceylon.file {
    File,
    parsePath
}
import java.nio.file {
    JPath=Path
}

JFile javaFile(File file)
    =>  JFile(file.path.string);

JPath javaPath(File file)
    =>  javaFile(file).toPath();

File? ceylonFile(JFile? file) {
    if (exists file) {
        value result = parsePath(file.absolutePath).resource;
        if (is File result) {
            return result;
        }
    }
    return null;
}
