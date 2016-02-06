shared
interface Stream<out T> {
    shared formal
    StreamSubscription<T> listen(void onData(T event));
}

shared suppressWarnings("unusedDeclaration")
interface StreamSubscription<out T> {}
