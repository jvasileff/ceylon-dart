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
    CompilationUnit,
    ParameterReference,
    VariadicParameter,
    DefaultedCallableParameter,
    DefaultedParameterReference,
    CallableParameter,
    ValueDefinition,
    LazySpecifier,
    FunctionExpression,
    Parameters,
    Return,
    FunctionShortcutDefinition
}

import com.redhat.ceylon.model.typechecker.model {
    TypedDeclarationModel=TypedDeclaration,
    Unit,
    Type
}

class DartBackendVisitor(Unit unit) satisfies Visitor {

    shared
    StringBuilder result = StringBuilder();

    value dcw = CodeWriter(result.append);

    value typeFactory = TypeFactory(unit);

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
    void visitLazySpecifier(LazySpecifier that) {
        dcw.write("=> ");
        that.expression.visit(this);
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
    void visitValueDefinition(ValueDefinition that) {
        assert (exists model = that.get(keys.valueModel));

        value dartName = that.name.name; // TODO name
        value lazy = that.definition is LazySpecifier;
        if (lazy) {
            throw AssertionError("lazySpecifier not yet supported");
        }

        assert(exists rhsType = that
                .definition.expression
                .get(keys.typeModel)?.type);

        dcw.writeIndent().write("var ``dartName`` = ");
        withBoxingConversion(model.type, rhsType, ()
            =>  that.definition.visitChildren(this));
        dcw.writeLine(";");
    }

    shared actual
    void visitReturn(Return that) {
        if (exists result = that.result) {
            dcw.writeIndent();
            dcw.write("return ");
            result.visit(this);
            dcw.writeLine(";");
        }
        else {
            dcw.writeIndent();
            dcw.writeLine("return;");
        }
    }

    shared actual
    void visitFunctionShortcutDefinition(FunctionShortcutDefinition that) {
        generateFunction(that);
    }

    shared actual
    void visitFunctionExpression(FunctionExpression that) {
        generateFunction(that);
    }

    shared actual
    void visitFunctionDefinition(FunctionDefinition that) {
        generateFunction(that);
    }

    void generateFunction(
        FunctionExpression
            | FunctionDefinition
            | FunctionShortcutDefinition that) {
        assert (exists model = that.get(keys.functionModel));

        [Parameters+] parameterLists;
        LazySpecifier|Block definition;
        String? functionName;

        switch (that)
        case (is FunctionExpression) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = null;
        }
        case (is FunctionDefinition) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = name(that);
        }
        case (is FunctionShortcutDefinition) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = name(that);
        }

        if (parameterLists.size != 1) {
            throw Exception("multiple parameter lists not supported");
        }

        value returnType = (model of TypedDeclarationModel).type;

        function dartParameterList() {
            value list = parameterLists.first;
            if (list.parameters.empty) {
                return "()";
            }
            value sb = StringBuilder();
            sb.append("([");
            sb.append(", ".join(list.parameters.map((parameter) {
                value sb = StringBuilder();
                assert (exists model = parameter.get(keys.parameterModel));
                sb.append("/*``model.type.asString()``*/ ");
                switch(parameter)
                case (is DefaultedValueParameter) {
                    sb.append(parameter.parameter.name.name); // TODO name function
                    sb.append(" = $defaulted");
                }
                case (is ValueParameter) {
                    sb.append(parameter.name.name); // TODO name function
                }
                case (is VariadicParameter
                        | CallableParameter
                        | ParameterReference
                        | DefaultedCallableParameter
                        | DefaultedParameterReference) {
                    throw Exception("parameter type not supported!");
                }
                return sb.string;
            })));
            sb.append("])");
            return sb.string;
        }

        if (exists functionName) {
            dcw.writeIndent()
                .writeLine("// location=``location(that)``; \
                            return=``returnType.asString()``")
                .writeIndent()
                .write(model.declaredVoid then "void " else "")
                .write(functionName);
        }

        dcw.write(dartParameterList() + " ");

        //Defaulted Parameters:
        //If any exist, use a block (not lazy specifier)
        //At start of block, assign values as necessary

        value defaultedParameters = parameterLists.first
                .parameters.narrow<DefaultedValueParameter>();

        if (defaultedParameters.empty) {
            // no defaulted parameters
            definition.visit(this);
        }
        else {
            // defaulted parameters exist
            dcw.startBlock();
            for (param in defaultedParameters) {
                value paramName = param.parameter.name.name;
                dcw.writeIndent()
                    .write("if (identical(" + paramName + ", $defaulted)) ");
                dcw.startBlock();
                dcw.writeIndent().write(paramName + " = ");
                param.specifier.expression.visit(this);
                dcw.writeLine(";");
                dcw.endBlock();
                dcw.writeLine();
            }
            switch (definition)
            case (is Block) {
                definition.visitChildren(this);
            }
            case (is LazySpecifier) {
                //for FunctionShortcutDefinition
                dcw.writeIndent();
                if (!model.declaredVoid) {
                    dcw.write("return ");
                }
                definition.expression.visit(this);
                dcw.writeLine(";");
            }
            dcw.endBlock();
        }

        if (exists functionName) {
            // anonymous functions will wind
            // up with an ';' instead
            dcw.writeLine();
        }
    }

    shared actual
    void visitCompilationUnit(CompilationUnit that) {
        // TODO actual imports from the typechecker
        // TODO decide on file structure (one file per module?)
        dcw.writeLine("import 'package:ceylon/language/language.dart';");
        dcw.writeLine();
        that.visitChildren(this);
    }

    void withBoxingConversion(Type lhsType, Type rhsType, void fun()) {
        value conversion = typeFactory
                .boxingConversionFor(lhsType, rhsType);
        if (exists conversion) {
            dcw.write(conversion.prefix);
            fun();
            dcw.write(conversion.suffix);
        }
        else {
            fun();
        }
    }
}
