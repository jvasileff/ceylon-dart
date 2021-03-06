import ceylon.file {
    File
}
import ceylon.interop.java {
    javaString,
    CeylonIterable
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    ModuleSourceMapper
}
import com.redhat.ceylon.compiler.typechecker.context {
    Context,
    PhasedUnits
}
import com.redhat.ceylon.model.cmr {
    ArtifactResult
}
import com.redhat.ceylon.model.typechecker.model {
    ModuleImport,
    Module
}
import com.redhat.ceylon.model.typechecker.util {
    ModuleManager
}
import com.vasileff.ceylon.dart.compiler {
    javaFile,
    TypeHoles,
    ReportableException
}

import java.io {
    JFile=File,
    JFileInputStream=FileInputStream
}
import java.lang {
    JString=String
}
import java.util {
    JMap=Map,
    JList=List,
    JLinkedList=LinkedList
}

import net.minidev.json {
    JSONValue
}

shared
class DartModuleSourceMapper(Context context, ModuleManager moduleManager)
        extends ModuleSourceMapper(context, moduleManager) {

    void loadModuleFromMap(
            JMap<JString, Object> model,
            JsonModule m,
            JLinkedList<Module> dependencyTree,
            JList<PhasedUnits> phasedUnitsOfDependencies,
            Boolean forCompiledModule) {

        assert (is JList<out Anything>? dependencies
            =   model.get(javaString("$mod-deps")));

        "We'll always have dependencies; at least the language module."
        assert (exists dependencies);

        // clear the implicit langauge module import added by createModule()
        m.imports.clear();

        for (dependency in CeylonIterable(dependencies)) {
            // Add a ModuleImport to the module. The module will be resolved later, at
            // the request of ModuleValidator.

            String s;
            Boolean optional;
            Boolean export;

            assert (is JString | JMap<out Anything, out Anything> dependency);

            switch (dependency)
            case (is JMap<out Anything, out Anything>) {
                assert (is JString ss = dependency.get(javaString("path")));
                s = ss.string;
                optional = dependency.containsKey(javaString("opt"));
                export = dependency.containsKey(javaString("exp"));
            }
            case (is JString) {
                s = dependency.string;
                optional = false;
                export = false;
            }

            "There will always be a version separator, even if the version is the
             empty string."
            assert (exists slashIndex = s.firstOccurrence('/'));

            value dependencyName = s[0:slashIndex];

            value dependencyVersion = s[slashIndex+1...];

            "Version cannot be the empty string."
            assert (!dependencyVersion.empty);

            assert (is JsonModule dependencyModule = moduleManager.getOrCreateModule(
                            ModuleManager.splitModuleName(dependencyName),
                            dependencyVersion));

            // TODO This can't be right; dependencyModule hasn't yet been resolved
            //      Bug in JsModuleSourceMapper:73?
            value backends = dependencyModule.nativeBackends;

            value mi = ModuleImport(null, dependencyModule, optional, export, backends);

            m.addImport(mi);
        }

        model.remove(javaString("$mod-deps"));
        m.model = model;
        m.loadDeclarations();
    }

    shared actual
    void resolveModule(
            ArtifactResult artifact, Module m, ModuleImport? moduleImport,
            JLinkedList<Module> dependencyTree,
            JList<PhasedUnits> phasedUnitsOfDependencies,
            Boolean forCompiledModule) {

        "This should *always* be a JsonModule, right?"
        assert (is JsonModule m);

        if (m.model exists) {
            return;
        }

        "The json artifact for the model. The passed in artifact is no good; for the
         reason, see [[DartModuleManager.searchedArtifactExtensions]]"
        value modelAc
            =   ArtifactContext(null, artifact.name(), artifact.version(),
                                ArtifactContext.\iDART_MODEL);

        value modelAcResult
            =   context.repositoryManager.getArtifactResult(modelAc) else null;

        if (!exists modelAcResult) {
            throw ReportableException(
                    "Unable to find model artifact for \
                     ``ModuleUtil.makeModuleName(artifact.name(), artifact.version())``");
        }

        value modelFile
            =   modelAcResult.artifact();

        value model
            =   parseJsonModel(modelFile);

        if (!exists model) {
            throw ReportableException(
                    "Unable to parse the model from ``modelFile.absolutePath``");
        }

        loadModuleFromMap(model, m, dependencyTree, phasedUnitsOfDependencies,
                forCompiledModule);
    }
}

shared
JMap<JString, Object>? parseJsonModel(JFile | File file) {
    value jsonObject = JSONValue.parse(JFileInputStream(javaFile(file)));
    if (is JMap<out Anything, out Anything> jsonObject) {
        return TypeHoles.unsafeCast<JMap<JString, Object>>(jsonObject);
    }
    return null;
}
