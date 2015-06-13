import ceylon.ast.core {
    ValueParameter,
    DefaultedValueParameter,
    Visitor,
    FunctionDefinition
}

import com.redhat.ceylon.model.typechecker.model {
    ModelType=Type,
    ModelTypedDeclaration=TypedDeclaration
}

class DartBackendVisitor() satisfies Visitor {
    shared actual
    void visitFunctionDefinition(FunctionDefinition that) {
        if (that.parameterLists.size != 1) {
            throw Exception("multiple parameter lists not supported");
        }

        function dartParameterList() {
            value list = that.parameterLists.first;
            value sb = StringBuilder();
            sb.append("(");
            sb.append(", ".join(list.parameters.map(function(parameter) {
                value sb = StringBuilder();
                assert (exists model = parameter.get(keys.parameterModel));
                sb.append("/*``model.type.asString()``*/ ");
                switch(parameter)
                case (is DefaultedValueParameter) {
                    sb.append(parameter.parameter.name.name); // TODO name function
                    sb.append("=");
                    sb.append(parameter.specifier.expression.string); // TODO expressions!
                }
                case (is ValueParameter) {
                    sb.append(parameter.name.name); // TODO name function
                }
                else {
                    throw Exception("parameter type not supported!");
                }
                return sb.string;
            })));
            sb.append(")");
            return sb.string;
        }

        assert (exists model = that.get(keys.declarationModel));
        ModelType type = (model of ModelTypedDeclaration).type;
        print("//type='``type.asString()``'; location='``location(that)``'");
        print("function " + name(that) + dartParameterList() + " {");
            that.visitChildren(this);
        print("}");
    }
}
