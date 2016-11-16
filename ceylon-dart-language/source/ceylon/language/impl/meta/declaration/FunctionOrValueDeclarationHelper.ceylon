import ceylon.dart.runtime.model {
    ModelFunctionOrValue = FunctionOrValue,
    ModelParameter = Parameter,
    ModelClass = Class
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    NestableDeclaration,
    ClassWithConstructorsDeclaration,
    CallableConstructorDeclaration,
    FunctionOrValueDeclaration
}
import ceylon.language.meta.model {
    ClosedType=Type,
    Class,
    MemberClass,
    Member,
    ClassOrInterface,
    FunctionModel,
    Applicable,
    Qualified
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

interface FunctionOrValueDeclarationHelper
        satisfies NestableDeclarationHelper {

    shared actual formal ModelFunctionOrValue modelDeclaration;

    // TODO ceylon-model support for getting the Parameter?
    //      Inspect container's parameter list?
    ModelParameter? modelParameter => nothing;

    shared Boolean parameter => modelParameter exists;
    shared Boolean defaulted => modelParameter?.isDefaulted else false;
    shared Boolean variadic => modelParameter?.isSequenced else false;
}
