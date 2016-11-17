interface GettableHelper<out Get=Anything, in Set=Nothing> satisfies ModelHelper {
    shared Get get() => nothing;
    shared void set(Set newValue) { throw; }
    shared void setIfAssignable(Anything newValue) { throw; }
}
