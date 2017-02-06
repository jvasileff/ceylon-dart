import ceylon.language.meta.model {
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type
}

abstract
class TypeImpl<out Type>() satisfies ClosedType<Type> {
    shared formal ModelType modelReference;
    shared formal TypeHelper<Type> helper;

    typeOf(Anything instance) => helper.typeOf(instance);
    supertypeOf(ClosedType<> type) => helper.supertypeOf(type);
    exactly(ClosedType<> type) => helper.exactly(type);
    string => helper.string;

    shared actual
    ClosedType<Type|Other> union<Other>(ClosedType<Other> other)
        =>  helper.union<Other>(other);

    shared actual
    ClosedType<Type&Other> intersection<Other>(ClosedType<Other> other)
        =>  helper.intersection<Other>(other);
}
