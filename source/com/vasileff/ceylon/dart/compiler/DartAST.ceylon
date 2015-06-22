import ceylon.ast.core {
    ArgumentList
}

abstract
class DartNode() {
    shared formal
    void write(CodeWriter writer);
}

abstract
class DartExpression() extends DartNode() {}

abstract
class DartStatement() extends DartNode() {}

class DartReturnStatement(expression = null)
        extends DartStatement() {

    shared DartExpression? expression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeIndent();
        writer.write("return");
        if (exists expression) {
            writer.write(" ");
            expression.write(writer);
        }
        writer.write(";");
        writer.writeLine();
    }
}

class DartAssignmentExpression
        (lhsExpression, operator, rhsExpression)
        extends DartExpression() {

    shared DartExpression lhsExpression;
    shared String operator; // TODO enum
    shared DartExpression rhsExpression;

    shared
    DartAssignmentExpression copy(
            DartExpression lhsExpression = this.lhsExpression,
            String operator = this.operator,
            DartExpression rhsExpression = this.rhsExpression)
        =>  DartAssignmentExpression
                (lhsExpression, operator, rhsExpression);

    shared actual
    void write(CodeWriter writer) {
        lhsExpression.write(writer);
        writer.write(" " + operator + " ");
        rhsExpression.write(writer);
    }
}

class DartExpressionStatement
        (expression, semicolon = true)
        extends DartStatement() {

    shared DartExpression expression;
    // TODO when is this false?
    shared Boolean semicolon;

    shared actual
    void write(CodeWriter writer) {
        writer.writeIndent();
        expression.write(writer);
        if (semicolon) {
            writer.write(";");
        }
        writer.writeLine();
    }
}

abstract
class DartLiteral() extends DartExpression() {}

class DartSimpleStringLiteral(val)
        extends DartLiteral() {

    shared String val;

    shared actual
    void write(CodeWriter writer) {
        // TODO escaping
        writer.write("\"");
        writer.write(val);
        writer.write("\"");
    }
}

class DartBooleanLiteral(val)
        extends DartLiteral() {

    shared Boolean val;

    shared actual
    void write(CodeWriter writer) {
        writer.write(val.string);
    }
}

class DartDoubleLiteral(val)
        extends DartLiteral() {

    shared Float val;

    shared actual
    void write(CodeWriter writer) {
        writer.write(val.string);
    }
}

class DartIntegerLiteral(val)
        extends DartLiteral() {

    shared Integer val;

    shared actual
    void write(CodeWriter writer) {
        writer.write(val.string);
    }
}

class DartNullLiteral()
        extends DartLiteral() {

    shared actual
    void write(CodeWriter writer) {
        writer.write("null");
    }
}

class DartFunctionExpressionInvocation
        (func, argumentList)
        extends DartExpression() {

    shared DartExpression func;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        func.write(writer);
        argumentList.write(writer);
    }
}

class DartMethodInvocation
        (target, methodName, argumentList)
        extends DartExpression() {

    shared DartExpression? target;
    shared DartSimpleIdentifier methodName;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        if (exists target) {
            target.write(writer);
            writer.write(".");
        }
        methodName.write(writer);
        argumentList.write(writer);
    }
}

abstract
class DartIdentifier()
        extends DartExpression() {}

class DartArgumentList(arguments)
        extends DartNode() {

    // TODO NamedExpression
    shared DartExpression *arguments;

    shared actual
    void write(CodeWriter writer) {

        variable Boolean first = true;
        writer.write("(");
        for (argument in arguments) {
            if (!first) {
                writer.write(", ");
            }
            else {
                first = false;
            }
            argument.write(writer);
        }
        writer.write(")");
    }
}

class DartPrefixedIdentifier(prefix, identifier)
        extends DartIdentifier() {

    shared DartSimpleIdentifier prefix;
    shared DartSimpleIdentifier identifier;

    shared actual
    void write(CodeWriter writer) {
        prefix.write(writer);
        writer.write(".");
        identifier.write(writer);
    }
}

class DartSimpleIdentifier(identifier)
        extends DartIdentifier() {

    shared String identifier;

    shared actual
    void write(CodeWriter writer) {
        writer.write(identifier);
    }
}

class DartTypeName(name)
        extends DartNode() {
    // TODO TypeArgumentList
    shared DartIdentifier name;

    shared actual
    void write(CodeWriter writer) {
        name.write(writer);
    }
}

class DartIfStatement(condition, thenStatement, elseStatement=null)
        extends DartStatement() {
    shared DartExpression condition;
    shared DartStatement thenStatement;
    shared DartStatement? elseStatement;

    shared actual
    void write(CodeWriter writer) {
        value thenBlock =
                if (is DartBlock thenStatement)
                then thenStatement
                else DartBlock(thenStatement);

        value elseBlock =
                if (is DartBlock elseStatement) then
                    elseStatement
                else if (exists elseStatement) then
                    DartBlock(elseStatement)
                else
                    null;

        writer.writeIndent();
        writer.write("if (");
        condition.write(writer);
        writer.write(") ");
        thenBlock.write(writer);
        if (exists elseBlock) {
            writer.write("else ");
            elseBlock.write(writer);
        }
        writer.writeLine();
    }
}

"A node that represents the declaration of one or more names.
 Each declared name is visible within a name scope"
abstract
class DartDeclaration() extends DartNode() {
    // DartComment comment
    // List<DartAnnotation> metadata
}

"An identifier that has an initial value associated with it.
 Instances of this class are always children of the class
 VariableDeclarationList."
class DartVariableDeclaration(name, initializer = null)
        extends DartDeclaration() {
    shared DartSimpleIdentifier name;
    shared DartExpression? initializer;

    shared actual
    void write(CodeWriter writer) {
        name.write(writer);
        if (exists initializer) {
            writer.write(" = ");
            initializer.write(writer);
        }
    }
}

"The declaration of one or more variables of the same type."
class DartVariableDeclarationList(variables, type=null, keyword=null)
        extends DartNode() {

    shared [DartVariableDeclaration+] variables;
    shared DartTypeName? type;
    shared String? keyword; // TODO enum for `final`, `const`, `var`

    "The type must be null if the keyword is 'var'."
    assert((keyword else "") != "var" || !type exists);

    shared actual
    void write(CodeWriter writer) {
        if (exists keyword) {
            writer.write(keyword);
            writer.write(" ");
        }
        if (exists type) {
            type.write(writer);
            writer.write(" ");
        }
        variable value first = true;
        for (variable in variables) {
            if (!first) {
                writer.write(", ");
            }
            else {
                first = false;
            }
            variable.write(writer);
        }
    }
}

class DartVariableDeclarationStatement(variableList)
        extends DartStatement() {
    shared DartVariableDeclarationList variableList;

    shared actual
    void write(CodeWriter writer) {
        writer.writeIndent();
        variableList.write(writer);
        writer.writeLine(";");
    }
}

abstract
class DartCompilationUnitMember()
        of DartTopLevelVariableDeclaration
            | DartNamedCompilationUnitMember
        extends DartDeclaration() {}

class DartTopLevelVariableDeclaration(variableList)
        extends DartCompilationUnitMember() {

    // DartComment comment
    // [DartAnnotation*] metadata
    shared DartVariableDeclarationList variableList;

    shared actual
    void write(CodeWriter writer) {
        writer.writeIndent();
        variableList.write(writer);
        writer.writeLine(";");
        writer.writeLine();
    }
}

abstract
class DartNamedCompilationUnitMember(name)
        extends DartCompilationUnitMember() {

    // DartComment comment
    // [Annotation*] metadata
    shared DartSimpleIdentifier name;
}

class DartFunctionDeclaration(
        DartSimpleIdentifier name,
        functionExpression,
        external=false, returnType=null,
        propertyKeyword=null)
        extends DartNamedCompilationUnitMember(name) {

    shared Boolean external;
    shared DartTypeName? returnType;
    shared String? propertyKeyword; // "get" or "set"
    shared DartFunctionExpression functionExpression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeIndent();
        if (exists returnType) {
            returnType.write(writer);
        }
        if (exists propertyKeyword) {
            writer.write(" " + propertyKeyword + " ");
        }
        name.write(writer);
        functionExpression.write(writer);
        if (functionExpression.body is DartExpressionFunctionBody) {
            writer.write(";");
        }
        writer.writeLine();
        writer.writeLine();
    }
}

class DartFunctionDeclarationStatement
        (functionDeclaration)
        extends DartStatement() {

    shared DartFunctionDeclaration functionDeclaration;

    shared actual
    void write(CodeWriter writer) {
        functionDeclaration.write(writer);
    }
}

"A function expression"
class DartFunctionExpression(parameters, body)
        extends DartExpression() {

    shared DartFormalParameterList parameters;
    shared DartFunctionBody body;

    shared actual
    void write(CodeWriter writer) {
        parameters.write(writer);
        writer.write(" ");
        body.write(writer);
    }
}

"A node representing the body of a function or method."
abstract
class DartFunctionBody()
        extends DartNode() {}

"A function body that consists of a block of statements."
class DartBlockFunctionBody(block)
        extends DartFunctionBody() {

    // Token keyword (async or sync)
    // Token star (*)
    shared DartBlock block;

    shared actual
    void write(CodeWriter writer) {
        block.write(writer);
    }
}

"The formal parameter list of a method declaration,
 function declaration, or function type alias."
class DartFormalParameterList(
        positional=false, named=false,
        parameters)
        extends DartNode() {

    shared DartFormalParameter *parameters;
    shared Boolean positional;
    shared Boolean named;

    "positional and named can't both be true"
    assert (!(positional && named));

    shared actual
    void write(CodeWriter writer) {
        writer.write("(");
        if (positional && parameters nonempty) {
            writer.write("[");
        }
        else if (named && parameters nonempty) {
            writer.write("{");
        }
        variable value first = true;
        for (parameter in parameters) {
            if (!first) {
                writer.write(", ");
            }
            else {
                first = false;
            }
            parameter.write(writer);
        }
        if (positional && parameters nonempty) {
            writer.write("]");
        }
        else if (named && parameters nonempty) {
            writer.write("}");
        }
        writer.write(")");
    }
}

"A node representing a parameter to a function."
abstract
class DartFormalParameter()
        of DartNormalFormalParameter
            | DartDefaultFormalParameter
        extends DartNode() {}

"A formal parameter that is required (is not optional)."
abstract
class DartNormalFormalParameter()
        extends DartFormalParameter() {}

"A simple formal parameter."
class DartSimpleFormalParameter
        (identifier, final=false, var=false, type=null)
        extends DartNormalFormalParameter() {

    shared Boolean final;
    shared Boolean var;
    shared DartTypeName? type;
    shared DartSimpleIdentifier identifier;

    "Can only have one of final and var"
    assert (!(final && var));

    "Cannot specify both var and type"
    assert (!(var && type exists));

    shared actual
    void write(CodeWriter writer) {
        if (final) {
            writer.write("final ");

        }
        if (var) {
            writer.write("var ");
        }
        if (exists type) {
            type.write(writer);
            writer.write(" ");
        }
        identifier.write(writer);
    }
}

"A formal parameter with a default value. There are two kinds
 of parameters that are both represented by this class: named
 formal parameters and positional formal parameters."
class DartDefaultFormalParameter
        (parameter, defaultValue)
        extends DartFormalParameter() {

    // TODO defaultNamedParameter option
    shared DartNormalFormalParameter parameter;
    shared DartExpression defaultValue;

    shared actual
    void write(CodeWriter writer) {
        parameter.write(writer);
        writer.write(" = ");
        defaultValue.write(writer);
    }
}

class DartExpressionFunctionBody(expression)
        extends DartFunctionBody() {

    // Token keyword (async or sync)
    // Token star (*)
    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("=> ");
        expression.write(writer);
    }
}

class DartBlock(statements)
        extends DartStatement() {

    shared DartStatement *statements;

    shared actual
    void write(CodeWriter writer) {
        writer.startBlock();
        for (statement in statements) {
            statement.write(writer);
        }
        writer.endBlock();
    }
}

class DartPrefixExpression
        (operator, operand)
        extends DartExpression() {

    shared String operator;
    shared DartExpression operand;

    shared actual
    void write(CodeWriter writer) {
        writer.write(operator);
        writer.write("(");
        operand.write(writer);
        writer.write(")");
    }
}

class DartIsExpression
        (expression, type, notOperator=false)
        extends DartExpression() {

    shared DartExpression expression;
    shared Boolean notOperator;
    shared DartTypeName type;

    shared actual
    void write(CodeWriter writer) {
        expression.write(writer);
        writer.write(" is ");
        if (notOperator) {
            writer.write("!");
        }
        type.write(writer);
    }
}

class DartConstructorName(type, name=null)
        extends DartNode() {
    shared DartTypeName type;
    shared DartSimpleIdentifier? name;

    shared actual
    void write(CodeWriter writer) {
        type.write(writer);
        if (exists name) {
            writer.write(".");
            name.write(writer);
        }
    }
}

class DartInstanceCreationExpression
        (const, constructorName, argumentList)
        extends DartExpression() {
    shared Boolean const;
    shared DartConstructorName constructorName;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        writer.write(if (const) then "const " else "new ");
        constructorName.write(writer);
        argumentList.write(writer);
    }
}

class DartThrowExpression(expression)
        extends DartExpression() {

    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("throw ");
        expression.write(writer);
    }
}

"Hack to allow any string value to be an expression."
class DartVerbatimExpression(expression)
        extends DartExpression() {

    shared String expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write(expression);
    }
}

