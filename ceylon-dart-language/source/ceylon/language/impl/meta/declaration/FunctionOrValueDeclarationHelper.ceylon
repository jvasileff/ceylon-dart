import ceylon.dart.runtime.model {
    ModelFunctionOrValue = FunctionOrValue,
    ModelParameter = Parameter
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
