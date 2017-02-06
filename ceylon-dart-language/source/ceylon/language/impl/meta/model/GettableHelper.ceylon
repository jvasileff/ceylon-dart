interface GettableHelper<out Get, in Set> satisfies ModelHelper {
    shared Get get() => nothing;
    shared void set(Set newValue) { throw; }
    shared void setIfAssignable(Anything newValue) { throw; }
}
