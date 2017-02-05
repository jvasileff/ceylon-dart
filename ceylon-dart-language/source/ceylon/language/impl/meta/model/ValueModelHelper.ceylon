import ceylon.language.meta.model {
    ClosedType = Type
}

interface ValueModelHelper<Get> satisfies ModelHelper {
    shared ClosedType<Get> type => `Get`;
}
