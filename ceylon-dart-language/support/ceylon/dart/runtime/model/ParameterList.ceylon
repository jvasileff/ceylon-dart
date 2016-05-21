shared final
class ParameterList {
    shared [Parameter*] parameters;

    shared new ([Parameter*] parameters = []) {
        this.parameters = parameters;
    }

    shared new empty extends ParameterList() {}

    shared
    Boolean hasSequencedParameter
        =>  parameters.last?.isSequenced else false;
}
