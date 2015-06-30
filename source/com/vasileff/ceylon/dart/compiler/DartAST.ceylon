shared abstract
class DartNode() {
    shared formal
    void write(CodeWriter writer);
}

"A node that represents an expression."
shared abstract
class DartExpression() extends DartNode() {}

"A node that represents a statement."
shared abstract
class DartStatement() extends DartNode() {}

"A node that represents a directive."
shared abstract
class DartDirective() extends DartAnnotatedNode() {
    // DartComment comment
    // List<DartAnnotation> metadata
}

"A directive that references a URI."
shared abstract
class DartUriBasedDirective(uri)
        extends DartDirective() {

    // DartComment comment
    // List<DartAnnotation> metadata
    shared DartStringLiteral uri;
}

"A node that represents a directive that impacts
 the namespace of a library."
shared abstract
class DartNamespaceDirective(keyword, uri)
        extends DartUriBasedDirective(uri) {

    // DartComment comment
    // List<DartAnnotation> metadata
    shared String keyword;
    DartStringLiteral uri;
    // List<Combinator> combinators
}

"An import directive."
shared
class DartImportDirective(uri, prefix)
        extends DartNamespaceDirective("import", uri) {

    // DartComment comment
    // List<DartAnnotation> metadata
    DartStringLiteral uri;
    // Boolean deferred;
    DartSimpleIdentifier? prefix;
    // List<Combinator> combinators

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent(); // noop
        writer.write("import ");
        uri.write(writer);
        if (exists prefix) {
            writer.write(" as ");
            prefix.write(writer);
        }
        writer.write(";");
    }
}

"A return statement."
shared
class DartReturnStatement(expression = null)
        extends DartStatement() {

    shared DartExpression? expression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("return");
        if (exists expression) {
            writer.write(" ");
            expression.write(writer);
        }
        writer.write(";");
    }
}

shared
class DartAssignmentOperator {
    shared actual String string;

    shared new equal { string = "="; }
    shared new plusEqual { string = "+="; }
    shared new minusEqual { string = "-="; }
    shared new timesEqual { string = "*="; }
    shared new divideEqual { string = "/="; }
    // TODO ~/=, %=, <<=, >>=, &=, ^=, |=
}

"An assignment expression."
shared
class DartAssignmentExpression
        (lhsExpression, operator, rhsExpression)
        extends DartExpression() {

    shared DartExpression lhsExpression;
    shared DartAssignmentOperator operator;
    shared DartExpression rhsExpression;

    shared
    DartAssignmentExpression copy(
            DartExpression lhsExpression = this.lhsExpression,
            DartAssignmentOperator operator = this.operator,
            DartExpression rhsExpression = this.rhsExpression)
        =>  DartAssignmentExpression
                (lhsExpression, operator, rhsExpression);

    shared actual
    void write(CodeWriter writer) {
        lhsExpression.write(writer);
        writer.write(" " + operator.string + " ");
        rhsExpression.write(writer);
    }
}

"An expression used as a statement."
shared
class DartExpressionStatement(expression)
        extends DartStatement() {

    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        expression.write(writer);
        writer.write(";");
    }
}

"A node that represents a literal expression."
shared abstract
class DartLiteral() extends DartExpression() {}

"A string literal expression."
shared abstract
class DartStringLiteral() extends DartLiteral() {}

"A single string literal expression."
shared abstract
class DartSingleStringLiteral()
        extends DartStringLiteral() {}

"A string literal expression that does not contain
 any interpolations."
shared
class DartSimpleStringLiteral(text)
        extends DartSingleStringLiteral() {

    shared String text;

    shared actual
    void write(CodeWriter writer) {
        // TODO escaping
        writer.write("\"");
        writer.write(text);
        writer.write("\"");
    }
}

"A boolean literal expression."
shared
class DartBooleanLiteral(boolean)
        extends DartLiteral() {

    shared Boolean boolean;

    shared actual
    void write(CodeWriter writer) {
        writer.write(boolean.string);
    }
}

"A floating point literal expression."
shared
class DartDoubleLiteral(double)
        extends DartLiteral() {

    shared Float double;

    shared actual
    void write(CodeWriter writer) {
        writer.write(double.string);
    }
}

"An integer literal expression."
shared
class DartIntegerLiteral(integer)
        extends DartLiteral() {

    shared Integer integer;

    shared actual
    void write(CodeWriter writer) {
        writer.write(integer.string);
    }
}

"A null literal expression."
shared
class DartNullLiteral()
        extends DartLiteral() {

    shared actual
    void write(CodeWriter writer) {
        writer.write("null");
    }
}

"The invocation of a function resulting from evaluating an expression.
 Invocations of methods and other forms of functions are represented
 by [[DartMethodInvocation]] nodes. Invocations of getters and setters are
 represented by either [[DartPrefixedIdentifier]] or [[DartPropertyAccess]]
 nodes."
shared
class DartFunctionExpressionInvocation
        (func, argumentList)
        extends DartExpression() {

    shared DartExpression func;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        parenthesizeNonPrimary(func).write(writer);
        argumentList.write(writer);
    }
}

"The invocation of either a function or a method. Invocations of
 functions resulting from evaluating an expression are represented
 by [[DartFunctionExpressionInvocation]] nodes. Invocations of
 getters and setters are represented by either
 [[DartPrefixedIdentifier]] or [[DartPropertyAccess]] nodes."
shared
class DartMethodInvocation
        (target, methodName, argumentList)
        extends DartExpression() {

    shared DartExpression? target;
    shared DartSimpleIdentifier methodName;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        if (exists target) {
            parenthesizeNonPrimary(target).write(writer);
            writer.write(".");
        }
        methodName.write(writer);
        argumentList.write(writer);
    }
}

"The access of a property of an object.
 Note: [[DartPrefixedIdentifier]] can
 also be used."
shared
class DartPropertyAccess
        (target, propertyName)
        extends DartExpression() {

    shared DartExpression target;
    shared DartSimpleIdentifier propertyName;

    shared actual
    void write(CodeWriter writer) {
        parenthesizeNonPrimary(target).write(writer);
        writer.write(".");
        propertyName.write(writer);
    }
}

"A node that represents an identifier."
shared abstract
class DartIdentifier()
        extends DartExpression() {}

"A list of arguments in the invocation of an executable element
 (that is, a function, method, or constructor)."
shared
class DartArgumentList(arguments = [])
        extends DartNode() {

    shared [DartExpression*] arguments;

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

"An identifier that is prefixed or an access to an object property
 where the target of the property access is a simple identifier."
shared
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

"A simple identifier."
shared
class DartSimpleIdentifier(identifier)
        extends DartIdentifier() {

    shared String identifier;

    shared actual
    void write(CodeWriter writer) {
        writer.write(identifier);
    }
}

"The name of a type, which can optionally include type arguments."
shared
class DartTypeName(name)
        extends DartNode() {

    // TODO TypeArgumentList
    shared DartIdentifier name;

    shared actual
    void write(CodeWriter writer) {
        name.write(writer);
    }
}

"An if statement."
shared
class DartIfStatement
        (condition, thenStatement, elseStatement=null)
        extends DartStatement() {

    shared DartExpression condition;
    shared DartStatement thenStatement;
    shared DartStatement? elseStatement;

    shared actual
    void write(CodeWriter writer) {
        value thenBlock =
                if (is DartBlock thenStatement)
                then thenStatement
                else DartBlock([thenStatement]);

        value elseBlock =
                if (is DartBlock elseStatement) then
                    elseStatement
                else if (exists elseStatement) then
                    DartBlock([elseStatement])
                else
                    null;

        writer.writeLine();
        writer.writeIndent();
        writer.write("if (");
        condition.write(writer);
        writer.write(") ");
        thenBlock.write(writer);
        if (exists elseBlock) {
            writer.write(" else ");
            elseBlock.write(writer);
        }
    }
}

"An AST node that can be annotated with both a
 documentation comment and a list of annotations."
shared abstract
class DartAnnotatedNode() extends DartNode() {
    // DartComment comment
    // List<DartAnnotation> metadata
}

"A node that represents the declaration of one or more names.
 Each declared name is visible within a name scope"
shared abstract
class DartDeclaration() extends DartAnnotatedNode() {
    // DartComment comment
    // List<DartAnnotation> metadata
}

"An identifier that has an initial value associated with it.
 Instances of this class are always children of the class
 [[DartVariableDeclarationList]]."
shared
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
shared
class DartVariableDeclarationList
        (keyword, type, variables)
        extends DartAnnotatedNode() {

    // Comment comment
    // List<DartAnnotation> metadata

    // TODO enum for `final`, `const`, `var`
    shared String? keyword;
    shared DartTypeName? type;
    shared [DartVariableDeclaration+] variables;

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

"A list of variables that are being declared in a
 context where a statement is required."
shared
class DartVariableDeclarationStatement(variableList)
        extends DartStatement() {

    shared DartVariableDeclarationList variableList;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        variableList.write(writer);
        writer.write(";");
    }
}

"A compilation unit."
shared
class DartCompilationUnit(directives, declarations)
        extends DartNode() {

    shared [DartDirective*] directives;
    shared [DartCompilationUnitMember*] declarations;

    shared actual
    void write(CodeWriter writer) {
        directives.each((d) => d.write(writer));
        writer.writeLine();
        declarations.each((d) => d.write(writer));
    }
}

"A node that declares one or more names within
 the scope of a compilation unit."
shared abstract
class DartCompilationUnitMember()
        of DartTopLevelVariableDeclaration
            | DartNamedCompilationUnitMember
        extends DartDeclaration() {}

"The declaration of one or more top-level variables
 of the same type."
shared
class DartTopLevelVariableDeclaration(variableList)
        extends DartCompilationUnitMember() {

    // DartComment comment
    // [DartAnnotation*] metadata
    shared DartVariableDeclarationList variableList;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        variableList.write(writer);
        writer.writeLine(";");
    }
}

"A node that declares a single name within the scope
 of a compilation unit."
shared abstract
class DartNamedCompilationUnitMember(name)
        extends DartCompilationUnitMember() {

    // DartComment comment
    // [Annotation*] metadata
    shared DartSimpleIdentifier name;
}

"A top-level declaration."
shared
class DartFunctionDeclaration(
        external, // false
        returnType, // null
        propertyKeyword, // null
        name,
        functionExpression)
        extends DartNamedCompilationUnitMember(name) {

    // DartComment comment
    // [Annotation*] metadata
    shared Boolean external;
    shared DartTypeName? returnType;
    shared String? propertyKeyword; // "get" or "set"
    DartSimpleIdentifier name;
    shared DartFunctionExpression functionExpression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        if (exists returnType) {
            returnType.write(writer);
            writer.write(" ");
        }
        if (exists propertyKeyword) {
            writer.write(propertyKeyword);
            writer.write(" ");
        }
        name.write(writer);
        functionExpression.write(writer);
        if (functionExpression.body is DartExpressionFunctionBody) {
            writer.write(";");
        }
        writer.writeLine();
    }
}

"A [[DartFunctionDeclaration]] used as a statement."
shared
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
shared
class DartFunctionExpression(parameters, body)
        extends DartExpression() {

    "`parameters` must be `null` for getters"
    shared DartFormalParameterList? parameters;
    shared DartFunctionBody body;

    shared actual
    void write(CodeWriter writer) {
        if (exists parameters) {
            parameters.write(writer);
        }
        writer.write(" ");
        body.write(writer);
    }
}

"A node representing the body of a function or method."
shared abstract
class DartFunctionBody()
        of DartBlockFunctionBody | DartExpressionFunctionBody
        extends DartNode() {}

"A function body that consists of a block of statements."
shared
class DartBlockFunctionBody
        (keyword, star, block)
        extends DartFunctionBody() {

    shared String? keyword; // (async or sync)
    shared Boolean star; // false
    shared DartBlock block;

    "star may not be true without a keyword"
    assert (!(star && !keyword exists));

    "star must be true with keyword 'sync'"
    assert (!((keyword else "") == "sync" && !star));

    shared actual
    void write(CodeWriter writer) {
        if (exists keyword) {
            writer.write(keyword);
            writer.write(" ");
            if (star) {
                writer.write("* ");
            }
        }
        block.write(writer);
    }
}

"The formal parameter list of a method declaration,
 function declaration, or function type alias."
shared
class DartFormalParameterList(
        positional = false,
        named = false,
        parameters = [])
        extends DartNode() {

    // TODO enum for positional|named|Null
    shared Boolean positional;
    shared Boolean named;
    shared [DartFormalParameter*] parameters;

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
shared abstract
class DartFormalParameter()
        of DartNormalFormalParameter
            | DartDefaultFormalParameter
        extends DartNode() {}

"A formal parameter that is required (is not optional)."
shared abstract
class DartNormalFormalParameter()
        of DartSimpleFormalParameter
            //| DartFieldFormalParameter
        extends DartFormalParameter() {

    // DartComment comment
    // [Annotation*] metadata
}

"A simple formal parameter."
class DartSimpleFormalParameter
        (final, var, type, identifier)
        extends DartNormalFormalParameter() {

    shared Boolean final; // false
    shared Boolean var; // false
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
    // ParameterKind ???
    shared DartExpression defaultValue;

    shared actual
    void write(CodeWriter writer) {
        parameter.write(writer);
        writer.write(" = ");
        defaultValue.write(writer);
    }
}

"A function body consisting of a single expression."
class DartExpressionFunctionBody(async, expression)
        extends DartFunctionBody() {

    shared Boolean async;
    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("=> ");
        expression.write(writer);
    }
}

"A sequence of statements."
shared
class DartBlock(statements)
        extends DartStatement() {

    shared [DartStatement*] statements;

    shared actual
    void write(CodeWriter writer) {
        if (nonempty statements) {
            writer.startBlock();
            for (statement in statements) {
                statement.write(writer);
            }
            writer.endBlock();
        }
        else {
            writer.write("{}");
        }
    }
}

"A prefix unary expression."
shared
class DartPrefixExpression
        (operator, operand)
        extends DartExpression() {

    // TODO enum for operator
    shared String operator;
    shared DartExpression operand;

    shared actual
    void write(CodeWriter writer) {
        writer.write(operator);
        parenthesizeNonPrimary(operand).write(writer);
    }
}

"An is expression."
shared
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

"The name of the constructor."
shared
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

"An instance creation expression."
shared
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

"A throw expression."
shared
class DartThrowExpression(expression)
        extends DartExpression() {

    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("throw ");
        expression.write(writer);
    }
}

"A parenthesized expression."
shared
class DartParenthesizedExpression(expression)
        extends DartExpression() {

    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("(");
        expression.write(writer);
        writer.write(")");
    }
}

"A conditional expression."
shared
class DartConditionalExpression(
        condition, thenExpression,elseExpression)
        extends DartExpression() {

    shared DartExpression condition;
    shared DartExpression thenExpression;
    shared DartExpression elseExpression;

    shared actual
    void write(CodeWriter writer) {
        condition.write(writer);
        writer.write(" ? ");
        thenExpression.write(writer);
        writer.write(" : ");
        elseExpression.write(writer);
    }
}

"A binary (infix) expression."
shared
class DartBinaryExpression(
        leftOperand, operator, rightOperand)
        extends DartExpression() {

    shared DartExpression leftOperand;
    shared String operator;
    shared DartExpression rightOperand;

    shared actual
    void write(CodeWriter writer) {
        parenthesizeNonPrimary(leftOperand).write(writer);
        writer.write(" " + operator + " ");
        parenthesizeNonPrimary(rightOperand).write(writer);
    }
}

shared
class DartAsExpression(expression, type)
        extends DartExpression() {

    shared DartExpression expression;
    shared DartTypeName type;

    shared actual
    void write(CodeWriter writer) {
        expression.write(writer);
        writer.write(" as ");
        type.write(writer);
    }
}

shared
alias DartPrimary =>
        DartIdentifier | DartLiteral | DartMethodInvocation |
        DartParenthesizedExpression  | DartPropertyAccess |
        DartFunctionExpressionInvocation;

DartExpression parenthesizeNonPrimary
        (DartExpression expression)
    =>  if (expression is DartPrimary)
        then expression
        else DartParenthesizedExpression(expression);
