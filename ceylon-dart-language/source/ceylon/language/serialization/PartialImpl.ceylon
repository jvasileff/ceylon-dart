native class PartialImpl(Object id) extends Partial(id) {
    shared native actual void instantiate();
    shared native actual void initialize<Id>(DeserializationContextImpl<Id> context)
            given Id satisfies Object;
}

native("dart") class PartialImpl(Object id) extends Partial(id) {
    shared native("dart") actual
    void instantiate() {
        throw;
    }

    shared native("dart") actual
    void initialize<Id>(DeserializationContextImpl<Id> context)
            given Id satisfies Object {
        throw;
    }
}
