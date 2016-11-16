import ceylon.language.meta.declaration {
    FunctionOrValueDeclaration
}
import ceylon.language.meta.model {
    ClosedType = Type
}

interface FunctionalDeclarationHelper
        satisfies GenericDeclarationHelper {

    shared
    Boolean annotation =>  nothing;

    shared
    FunctionOrValueDeclaration[] parameterDeclarations => nothing;

    shared
    FunctionOrValueDeclaration? getParameterDeclaration(String name) => nothing;

    // shared
    // FunctionModel<Return, Arguments>& Applicable<Return, Arguments>
    // apply<Return=Anything, Arguments=Nothing>(ClosedType<>* typeArguments)
    //         given Arguments satisfies Anything[]
    //     =>  nothing;

    // shared
    // FunctionModel<Return, Arguments>
    // & Qualified<FunctionModel<Return, Arguments>, Container>
    // memberApply<Container=Nothing, Return=Anything, Arguments=Nothing>
    //         (ClosedType<Object> containerType, ClosedType<>* typeArguments)
    //         given Arguments satisfies Anything[]
    //     =>  nothing;

    shared
    Anything memberInvoke
            (Object container, ClosedType<>[] typeArguments = [], Anything* arguments)
        =>  nothing;
}
