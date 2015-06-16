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
    ModelTypedDeclaration=TypedDeclaration
}

class DartBackendVisitor() satisfies Visitor {

    shared
    StringBuilder result = StringBuilder();

    CodeWriter dcw = CodeWriter(result.append);

    shared actual
    void visitBaseExpression(BaseExpression that) {
        "Supports MNWTA for BaseExpression's of Invocations"
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        dcw.write(nameAndArgs.name.name); // TODO translate to dart name
        // ignoring type arguments
    }

    shared actual
    void visitIntegerLiteral(IntegerLiteral that) {
        dcw.write(that.integer.string);
    }

    shared actual
    void visitStringLiteral(StringLiteral that) {
        dcw.write("\"``that.text``\""); // FIXME escaping
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
                dcw.write(", ");
            }
            argument.visit(this);
        }
    }

    shared actual
    void visitPositionalArguments(PositionalArguments that) {
        dcw.write("(");
        that.visitChildren(this);
        dcw.write(")");
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
        dcw.writeIndent();
        that.expression.visit(this); // the Invocation
        dcw.writeLine(";");
    }

    shared actual
    void visitBlock(Block that) {
        dcw.startBlock();
        for (child in that.children) {
            child.visit(this);
        }
        dcw.endBlock();
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

        assert (exists model = that.get(keys.functionModel));
        value returnType = (model of ModelTypedDeclaration).type;

        dcw.writeIndent().writeLine(
                "// location=``location(that)``; \
                 return=``returnType.asString()``");
        dcw.writeIndent();
        if (model.declaredVoid) {
            dcw.write("void ");
        }
        dcw.write(name(that) + dartParameterList() + " ");
        that.definition.visit(this);
        dcw.writeLine();
    }

    shared actual
    void visitCompilationUnit(CompilationUnit that) {
        // TODO actual imports from the typechecker
        // TODO decide on file structure (one file per module?)
        dcw.writeLine("import 'package:ceylon/language/language.dart';");
        dcw.writeLine();
        that.visitChildren(this);
    }
}
