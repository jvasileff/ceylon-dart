import ceylon.dart.runtime.model {
    ModelReference = Reference
}

interface HasModelReference {
    shared formal
    ModelReference modelReference;

    // TODO use same format as Metamodel.toTypeString
    string => modelReference.string;
}
