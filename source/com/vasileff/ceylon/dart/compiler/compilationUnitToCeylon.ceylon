import ceylon.ast.core {
    CompilationUnit,
    AnyFunction
}
import ceylon.ast.redhat {
    declarationToCeylon,
    importToCeylon
}
import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        TCCompilationUnit=CompilationUnit
    }
}

"Transform a type checker [[Tree.CompilationUnit]] to a
 [[CompilationUnit]]. Attach model and other information
 relevant to compliation to each node."
CompilationUnit transformCompilationUnit(
        TCCompilationUnit tcCompilationUnit) {

    "Must not have package or module descriptors"
    assert (tcCompilationUnit.packageDescriptors.empty,
        tcCompilationUnit.moduleDescriptors.empty);

    return CompilationUnit {
        declarations = CeylonIterable
                (tcCompilationUnit.declarations)
                .collect((tcDeclaration) {

            value declaration = declarationToCeylon(tcDeclaration);
            declaration.put(keys.location, tcDeclaration.location);

            switch (tcDeclaration)
            case (is Tree.AnyMethod) {
                declaration.put(keys.declarationModel,
                        tcDeclaration.declarationModel);
                assert (is AnyFunction declaration);
                for (listIndex -> parameterList in
                        declaration.parameterLists.indexed) {
                    value listModel = tcDeclaration.declarationModel
                                        .parameterLists.get(listIndex);
                    parameterList.put(keys.parameterListModel, listModel);
                    for (pIndex -> parameter in
                            parameterList.parameters.indexed) {
                        // TODO attach model to child nodes too?
                        // (for Defaulted)
                        value parameterModel = listModel.parameters.get(pIndex);
                        parameter.put(keys.parameterModel, parameterModel);
                    }
                }
            }
            //case (is Tree.TypedDeclaration) {
            //    declaration.put(keys.declarationModel,
            //            tcDeclaration.declarationModel);
            //}
            else {}
            return declaration;
        });
        imports = CeylonIterable(tcCompilationUnit.importList.imports)
                .collect(importToCeylon);
    };
}
