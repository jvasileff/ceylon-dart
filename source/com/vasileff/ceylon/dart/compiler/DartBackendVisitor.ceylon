import ceylon.ast.core {
    ValueParameter,
    DefaultedValueParameter,
    Visitor,
    FunctionDefinition,
    Block,
    InvocationStatement,
    Invocation,
    BaseExpression,
    MemberNameWithTypeArguments,
    PositionalArguments,
    ArgumentList,
    IntegerLiteral,
    StringLiteral,
    CompilationUnit
}

import com.redhat.ceylon.model.typechecker.model {
    ModelType=Type,
    ModelTypedDeclaration=TypedDeclaration
}

class DartBackendVisitor() satisfies Visitor {

    shared
    StringBuilder output = StringBuilder();

    Anything(String) append = output.append;

    shared actual
    void visitBaseExpression(BaseExpression that) {
        "Supports MNWTA for BaseExpression's of Invocations"
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        append(nameAndArgs.name.name); // TODO translate to dart name
        // ignoring type arguments
    }

    shared actual
    void visitIntegerLiteral(IntegerLiteral that) {
        append(that.integer.string);
    }

    shared actual
    void visitStringLiteral(StringLiteral that) {
        append("\"``that.text``\""); // FIXME escaping
    }

    shared actual
    void visitArgumentList(ArgumentList that) {
        "spread arguments not supported"
        assert(that.sequenceArgument is Null);

        variable Boolean first = true;

        for (argument in that.listedArguments) {
            "*very* limitted support for expressions"
            assert(is IntegerLiteral | StringLiteral argument);
            if (first) {
                first = false;
            }
            else {
                append(", ");
            }
            argument.visit(this);
        }
    }

    shared actual
    void visitPositionalArguments(PositionalArguments that) {
        append("(");
        that.visitChildren(this);
        append(")");
    }

    shared actual
    void visitInvocation(Invocation that) {
        "Only BaseExpression supported"
        assert (that.invoked is BaseExpression);
        that.invoked.visit(this);

        "Named arguments not yet supported"
        assert (that.arguments is PositionalArguments);
        that.arguments.visit(this);
    }

    shared actual
    void visitInvocationStatement(InvocationStatement that) {
        that.expression.visit(this); // the Invocation
        append(";");
    }

    shared actual
    void visitBlock(Block that) {
        append("{\n");
        for (child in that.children) {
            child.visit(this);
            append("\n");
        }
        append("}\n");
    }

    shared actual
    void visitFunctionDefinition(FunctionDefinition that) {
        if (that.parameterLists.size != 1) {
            throw Exception("multiple parameter lists not supported");
        }

        function dartParameterList() {
            value list = that.parameterLists.first;
            value sb = StringBuilder();
            sb.append("(");
            sb.append(", ".join(list.parameters.map((parameter) {
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

        append("// location=``location(that)``\n");
        append("/*``type.asString()``*/ ");
        if (model.declaredVoid) {
            append("void ");
        }
        append(name(that) + dartParameterList() + " ");
        that.definition.visit(this);
        append("\n");
    }

    shared actual
    void visitCompilationUnit(CompilationUnit that) {
        // TODO actual imports from the typechecker
        // TODO decide on file structure (one file per module?)
        append("import 'package:ceylon/language/language.dart';\n\n");
        that.visitChildren(this);
    }
}
