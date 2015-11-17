import java.util {
    ListResourceBundle
}
import java.lang {
    ObjectArray
}
import ceylon.interop.java {
    createJavaStringArray,
    createJavaObjectArray
}

object repoUsingToolresourceBundle extends ListResourceBundle() {
    shared actual ObjectArray<ObjectArray<Object>> contents
        =>  createJavaObjectArray([
                ["module.not.found", "Module {0} not found in the following repositories:"],
                ["missing.version.suggestion", "Not all repositories could be searched for matching modules/versions, try again using a specific version"],
                ["version.not.found", "Version {0} not found for module {1}"],
                ["missing.version", "Missing required version number for module {0}"],
                ["try.versions", "Try one of the following versions: "],
                ["compiling", "Source found for module {0}, compiling..."],
                ["compilation.failed", "Failed to compile sources"]
            ].map((e) => createJavaStringArray(e)));
}

object installResourceBundle extends ListResourceBundle() {
    shared actual ObjectArray<ObjectArray<Object>> contents
        // copied from tools/copy/resources/messages.properties
        =>  createJavaObjectArray([
                ["module.not.found", "Module {0} not found in the following repositories:"],
                ["missing.version.suggestion", "Not all repositories could be searched for matching modules/versions, try again using a specific version"],
                ["version.not.found", "Version {0} not found for module {1}"],
                ["missing.version", "Missing required module version number"],
                ["try.versions", "Try one of the following versions:"],
                ["unable.create.out.dir", "The ''out'' directory {0} does not exist and could not be created"],
                ["not.dir.out.dir", "The given ''out'' directory {0} exists, but is not a directory"],
                ["copying.module", "Module {0} [{1}/{2}]"],
                ["copying.artifact", "> {0} [{1}/{2}]"],
                ["copying.ok", "Ok"],
                ["copying.skipped", "Skipped"]
            ].map((e) => createJavaStringArray(e)));
}
