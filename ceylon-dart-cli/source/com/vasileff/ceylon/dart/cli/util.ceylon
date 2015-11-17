import com.redhat.ceylon.cmr.api {
    ArtifactContext,
    RepositoryManager
}
import java.io {
    JFile=File
}
import ceylon.file {
    File
}
import com.vasileff.ceylon.dart.compiler {
    ceylonFile,
    parseJson,
    ReportableException,
    JsonObject
}

void verifyLanguageModuleAvailability(RepositoryManager repositoryManager) {
    value version = `module`.version;

    value languageModuleFile = repositoryManager.getArtifact(
        ArtifactContext("ceylon.language", version, ArtifactContext.\iDART))
        else null;

    if (!exists languageModuleFile) {
        throw ReportableException(
              "The Ceylon/Dart language module version ``version``
               was not found. Try installing with:

                   ceylon install-dart --out ~/.ceylon/repo");
    }
}

JsonObject? parseJsonModel(JFile | File file) {
    value jsonObject = parseJson(ceylonFile(file));
    if (is JsonObject jsonObject) {
        return jsonObject;
    }
    return null;
}
