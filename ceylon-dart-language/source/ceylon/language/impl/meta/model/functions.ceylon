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

shared
// FIXME implement this natively as a no-op.
T unsafeCast<T>(Anything a) {
    assert (is T a);
    return a;
}
