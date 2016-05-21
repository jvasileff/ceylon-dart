shared
interface Functional {
    shared formal [ParameterList+] parameterLists;
    shared formal Boolean declaredVoid;

    shared
    String valueParametersAsString {
        value sb = StringBuilder();
        for (parameterList in parameterLists) {
            sb.appendCharacter('(');
            // TODO make sure model.type.string is right for functional parameters!
            sb.append(", ".join(parameterList.parameters.map((p)
                =>  p.model.type.formatted + " " + p.model.name)));
            sb.appendCharacter(')');
        }
        return sb.string;
    }
}
