import interop.dart.async {
    Future
}
import interop.dart.core {
    DString=String
}

shared suppressWarnings("expressionTypeNothing")
interface FileSystemEntity {

    """
       Returns a File instance whose path is the absolute path to this.

       The absolute path is computed by prefixing a relative path with the
       current working directory, and returning an absolute path unchanged.
    """
    shared
    File absolute => nothing;

    """
       Returns a bool indicating whether this object's path is absolute.

       On Windows, a path is absolute if it starts with \\ or a drive letter
       between a and z (upper or lower case) followed by :\ or :/. On
       non-Windows, a path is absolute if it starts with /.
    """
    shared
    Boolean isAbsolute => nothing;

    """
       The directory containing this. If this is a root directory, returns
       this.
    """
    shared
    Directory parent => nothing;

    """
       Get the path of the file.
    """
    shared
    String path => nothing;

//    """
//       Returns a Uri representing the file system entity's location.
//
//       The returned URI's scheme is always "file" if the entity's path is
//       absolute, otherwise the scheme will be empty.
//    """
//    shared Uri uri => nothing;

    """
       Checks whether the file system entity with this path exists. Returns a
       Future<bool> that completes with the ...
    """
    shared
    Future<Boolean> \iexists() => nothing;

    """
       Synchronously checks whether the file system entity with this path
       exists.

       Since FileSystemEntity is abstract, every FileSystemEntity object is
       actually an instance of one of the subclasses File, Directory, and Link.
       Calling existsSync on an instance of one of these subclasses checks
       whether the object exists in the file system object exists and is of the
       correct type (file, directory, or link). To check whether a path points
       to an object on the file system, regardless of the object's type, use
       the typeSync static method.
    """
    shared
    Boolean existsSync() => nothing;
}

shared suppressWarnings("expressionTypeNothing")
class File(String path) satisfies FileSystemEntity {
    """
       Read the entire file contents as a string using the given Encoding.

       Returns a Future<String> that completes with the string once the file contents has been read.
    """
    // FIXME Encoding class
    // FIXME DartString class?
    shared
    Future<DString> readAsString(Object encoding = nothing) => nothing;
}

shared
class Directory(String path) satisfies FileSystemEntity {}
