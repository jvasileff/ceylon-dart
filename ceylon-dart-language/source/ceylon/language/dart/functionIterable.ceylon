shared
{T*} functionIterable<T>(<T|Finished>()() f) => object satisfies {T*} {
    iterator() => object satisfies Iterator<T> {
        value n = f();
        next() => n();
    };
};
