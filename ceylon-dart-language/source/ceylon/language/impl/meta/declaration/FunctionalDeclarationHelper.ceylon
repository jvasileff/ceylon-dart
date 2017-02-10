import ceylon.language.meta.declaration {
    FunctionOrValueDeclaration
}
import ceylon.language.meta.model {
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelFunctional = Functional,
    ModelParameter = Parameter,
    ModelTypedDeclaration = TypedDeclaration,
    ModelTypeDeclaration = TypeDeclaration,
    ModelGeneric = Generic
}

interface FunctionalDeclarationHelper
        satisfies GenericDeclarationHelper {

    shared actual formal
    ModelFunctional & ModelGeneric & <ModelTypeDeclaration | ModelTypedDeclaration>
    modelDeclaration;

    shared
    Boolean annotation =>  nothing;

    shared
    FunctionOrValueDeclaration[] parameterDeclarations
        =>  modelDeclaration.parameterLists[0].parameters
                .map(ModelParameter.model)
                .collect(newFunctionOrValueDeclaration);

    shared
    FunctionOrValueDeclaration? getParameterDeclaration(String name)
        =>  if (exists modelParameter
                =   modelDeclaration.parameterLists.first.parameters
                        .find((p) => p.name == name))
            then newFunctionOrValueDeclaration(modelParameter.model)
            else null;

    shared
    Anything memberInvoke
            (Object container, ClosedType<>[] typeArguments = [], Anything* arguments)
        =>  nothing;
}
