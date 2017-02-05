import ceylon.dart.runtime.model {
    ModelReference = Reference
}

interface HasModelReference {
    shared formal
    ModelReference modelType;

    // TODO use same format as Metamodel.toTypeString
    string => modelType.string;
}
