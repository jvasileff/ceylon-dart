interface ApplicableHelper<out Type, in Arguments>
        satisfies HasModelReference
        given Arguments satisfies Anything[] {

    shared
    Type apply(Anything* arguments) => nothing;

    shared
    Type namedApply({<String->Anything>*} arguments) => nothing;
}
