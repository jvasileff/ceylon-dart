shared final
class ParameterList(parameters = [], first = true) {
    shared [Parameter*] parameters;
    shared Boolean first;

    shared
    Boolean hasSequencedParameter
        =>  parameters.last?.isSequenced else false;

    string
        =>  "(``", ".join(parameters)``)";
}
