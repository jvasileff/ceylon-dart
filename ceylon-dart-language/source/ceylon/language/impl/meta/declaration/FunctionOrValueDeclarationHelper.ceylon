import ceylon.dart.runtime.model {
    ModelFunctionOrValue = FunctionOrValue,
    ModelParameter = Parameter
}

interface FunctionOrValueDeclarationHelper
        satisfies NestableDeclarationHelper {

    shared actual formal ModelFunctionOrValue modelDeclaration;

    ModelParameter? modelParameter => modelDeclaration.parameter;

    shared Boolean parameter => modelParameter exists;
    shared Boolean defaulted => modelParameter?.isDefaulted else false;
    shared Boolean variadic => modelParameter?.isSequenced else false;
}
