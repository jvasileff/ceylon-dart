shared
interface Future<out T> {

    // TODO Function onError named parameter
    shared formal
    Future<Anything> \ithen(Anything onValue(T \ivalue));

    shared formal
    Future<T> whenComplete(Anything action());
}
