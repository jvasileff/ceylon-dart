"Interface for language module classes that need to satisfy Callable<>. The compiler will
 add necessary members to implementing classes to forward invocations on their instances
 to the [[invoke]] `Callable`."
shared
interface CustomCallable<out Return, in Arguments>
        satisfies Return(*Arguments)
        given Arguments satisfies Anything[] {

    shared formal Return(*Arguments) invoke;
}
