import ceylon.language.meta.model {
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type
}
import ceylon.language.impl.meta.model {
    TypeImpl
}

shared
ModelType modelTypeFromType(ClosedType<Anything> t) {
    assert (is TypeImpl<Anything> t);
    return t.modelType;
}
