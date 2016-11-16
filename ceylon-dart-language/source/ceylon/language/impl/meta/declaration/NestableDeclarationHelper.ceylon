import ceylon.dart.runtime.model {
    ModelPackage = Package,
    ModelDeclaration = Declaration,
    ModelTypedDeclaration = TypedDeclaration,
    ModelTypeDeclaration = TypeDeclaration
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    NestableDeclaration,
    OpenType
}

interface NestableDeclarationHelper
        satisfies AnnotatedDeclarationHelper /*& TypedDeclarationHelper*/ {

    shared actual formal
    ModelTypeDeclaration | ModelTypedDeclaration modelDeclaration;

    shared Boolean actual => modelDeclaration.isActual;

    shared NestableDeclaration | Package container {
        switch (containerModel = modelDeclaration.container)
        case (is ModelPackage) {
            return PackageImpl(containerModel);
        }
        case (is ModelDeclaration) {
            return newNestableDeclaration(containerModel);
        }
    }

    shared Module containingModule => ModuleImpl(modelDeclaration.mod);

    shared Package containingPackage => PackageImpl(modelDeclaration.pkg);

    shared Boolean default => modelDeclaration.isDefault;

    shared Boolean formal => modelDeclaration.isFormal;

    shared Boolean shared => modelDeclaration.isShared;

    shared Boolean toplevel => modelDeclaration.isToplevel;

    // TypedDeclaration

    shared
    OpenType openType
        =>  switch (d = modelDeclaration)
            case (is ModelTypeDeclaration) newOpenType(d.type)
            case (is ModelTypedDeclaration) newOpenType(d.type);
}
