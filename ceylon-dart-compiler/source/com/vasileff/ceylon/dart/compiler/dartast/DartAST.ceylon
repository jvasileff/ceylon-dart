import com.vasileff.ceylon.dart.compiler.core {
    eq
}
shared abstract
class DartNode() {
    shared formal
    void write(CodeWriter writer);

    shared actual default
    String string {
        value sb = StringBuilder();
        write(CodeWriter(sb.append));
        return sb.string;
    }
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

shared
class DartAwaitExpression(expression)
        extends DartExpression() {

    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.write("await ");
        expression.write(writer);
    }
}

"A break statement."
shared
class DartBreakStatement(label = null)
        extends DartStatement() {

    shared DartSimpleIdentifier? label;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("break");
        if (exists label) {
            writer.write(" ");
            label.write(writer);
        }
        writer.endStatement();
    }
}

"A switch statement."
shared
class DartSwitchStatement(expression, cases, default=null)
        extends DartStatement() {

    shared DartExpression expression;
    shared [DartSwitchCase+] cases;
    shared DartSwitchDefault? default;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("switch (");
        expression.write(writer);
        writer.write(") {");
        for (c in cases) {
            c.write(writer);
        }
        if (exists default) {
            default.write(writer);
        }
        writer.writeLine();
        writer.writeIndent();
        writer.write("}");
    }
}

"An element within a switch statement"
shared abstract
class DartSwitchMember() extends DartNode() {}

"A case in a switch statement."
shared
class DartSwitchCase(labels, expression, statements)
        extends DartSwitchMember() {

    shared [DartSimpleIdentifier*] labels;
    shared DartExpression expression;
    shared [DartStatement+] statements;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        for (label in labels) {
            label.write(writer);
        }
        writer.write("case ");
        expression.write(writer);
        writer.write(" :");
        writer.indentPlus();
        for (statement in statements) {
            statement.write(writer);
        }
        writer.indentMinus();
    }
}

"The default case in a switch statement."
shared
class DartSwitchDefault(labels, statements)
        extends DartSwitchMember() {

    shared [DartSimpleIdentifier*] labels;
    shared [DartStatement+] statements;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        for (label in labels) {
            label.write(writer);
        }
        writer.write("default ");
        writer.write(" : ");
        for (statement in statements) {
            statement.write(writer);
        }
    }
}

"A continue statement."
shared
class DartContinueStatement(label = null)
        extends DartStatement() {

    shared DartSimpleIdentifier? label;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("continue");
        if (exists label) {
            writer.write(" ");
            label.write(writer);
        }
        writer.endStatement();
    }
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
        writer.endStatement();
    }

    equals(Object that)
        =>  if (is DartImportDirective that)
            then uri==that.uri && eq(prefix, that.prefix)
            else false;

    hash
        =>  [uri, prefix].hash;
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
        writer.endStatement();
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
        writer.endStatement();
    }
}

"A node that represents a literal expression."
shared abstract
class DartLiteral() extends DartExpression() {}

"A string literal expression."
shared abstract
class DartStringLiteral()
        of DartSingleStringLiteral
        extends DartLiteral() {

    shared actual formal Boolean equals(Object other);
    shared actual formal Integer hash;
}

"A single string literal expression."
shared abstract
class DartSingleStringLiteral()
        of DartSimpleStringLiteral
        extends DartStringLiteral() {}

"A string literal expression that does not contain
 any interpolations."
shared
class DartSimpleStringLiteral(text)
        extends DartSingleStringLiteral() {

    shared String text;

    shared actual
    void write(CodeWriter writer) {
        writer.write("\"");
        for (c in text) {
            writer.write(
                switch (c)
                case('\n') "\\n"
                case('\r') "\\r"
                case('\f') "\\f"
                case('\b') "\\b"
                case('\t') "\\t"
                case('\{#0b}') "\\v"
                case('\\') "\\\\"
                case('"') "\\\""
                case('$') "\\$"
                case('\{#7f}') "\\x7f"
                else if (c < ' ') then
                    "\\x``formatInteger(c.integer, 16).padLeading(2, '0')``"
                else c.string);
        }
        writer.write("\"");
    }

    equals(Object other)
        =>  if (is DartSimpleStringLiteral other)
            then this.text == other.text
            else false;

    hash
        =>  text.hash;
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
class DartDoubleLiteral(val)
        extends DartLiteral() {

    String | Float val;

    shared String text
        =   switch (val)
            case (is Float) val.string
            case (is String) val;

    shared actual
    void write(CodeWriter writer) {
        writer.write(text);
    }
}

"An integer literal expression."
shared
class DartIntegerLiteral(val)
        extends DartLiteral() {

    String | Integer val;

    shared String text
        =   switch (val)
            case (is Integer) val.string
            case (is String) val;

    shared actual
    void write(CodeWriter writer) {
        writer.write(text);
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

"A literal that has a type associated with it"
shared abstract
class DartTypedLiteral() extends DartLiteral() {}

"A list literal."
shared
class DartListLiteral(const, elements)
        extends DartTypedLiteral() {

    Boolean const;
    //DartTypeArgumentList? typeArguments = null;
    [DartExpression*] elements;

    shared actual
    void write(CodeWriter writer) {
        if (const) {
           writer.write("const");
        }
        writer.write("[");
        for (e in elements.interpose(", ")) {
            if (is DartExpression e) {
                e.write(writer);
            }
            else {
                writer.write(e);
            }
        }
        writer.write("]");
    }
}

"A map literal."
shared
class DartMapLiteral(const, entries)
        extends DartTypedLiteral() {

    Boolean const;
    [DartMapLiteralEntry*] entries;

    shared actual
    void write(CodeWriter writer) {
        if (const) {
           writer.write("const");
        }
        writer.write("{");
        for (e in entries.interpose(",")) {
            if (is DartMapLiteralEntry e) {
                e.write(writer);
            }
            else {
                writer.write(e);
            }
        }
        writer.write("}");
    }
}

shared
class DartMapLiteralEntry(key, item)
        extends DartNode() {

    DartExpression key;
    DartExpression item;

    shared actual
    void write(CodeWriter writer) {
        key.write(writer);
        writer.write(":");
        item.write(writer);
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

shared
class DartIndexExpression(target, index)
        extends DartExpression() {

    shared DartExpression target;
    shared DartExpression index;

    shared actual
    void write(CodeWriter writer) {
        target.write(writer);
        writer.write("[");
        index.write(writer);
        writer.write("]");
    }
}

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

    equals(Object other)
        =>  if (is DartSimpleIdentifier other)
            then identifier == other.identifier
            else false;

    hash
        =>  identifier.hash;
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
        void writeIfNoIndent(DartIfStatement ifStatement) {
            value thenBlock =
                    if (is DartBlock b = ifStatement.thenStatement)
                    then b
                    else DartBlock([ifStatement.thenStatement]);

            value elseBlock =
                    if (is DartBlock|DartIfStatement e = ifStatement.elseStatement) then
                        e
                    else if (exists e = ifStatement.elseStatement) then
                        DartBlock([e])
                    else
                        null;

            writer.write("if (");
            ifStatement.condition.write(writer);
            writer.write(") ");
            thenBlock.write(writer);
            if (exists elseBlock) {
                writer.write(" else ");
                if (is DartIfStatement elseBlock) {
                    writeIfNoIndent(elseBlock);
                }
                else {
                    elseBlock.write(writer);
                }
            }
        }

        writer.writeLine();
        writer.writeIndent();
        writeIfNoIndent(this);
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
        writer.endStatement();
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
            writer.endStatement();
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

shared
DartFormalParameterList dartFormalParameterListEmpty
    =   DartFormalParameterList(false, false, []);

"A node representing a parameter to a function."
shared abstract
class DartFormalParameter()
        of DartNormalFormalParameter
            | DartDefaultFormalParameter
        extends DartNode() {
    shared formal DartSimpleIdentifier identifier;
}

"A formal parameter that is required (is not optional)."
shared abstract
class DartNormalFormalParameter()
        of DartSimpleFormalParameter
            | DartFieldFormalParameter
        extends DartFormalParameter() {

    // DartComment comment
    // [Annotation*] metadata
}

"A simple formal parameter."
shared
class DartSimpleFormalParameter
        (final, var, type, identifier)
        extends DartNormalFormalParameter() {

    shared Boolean final; // false
    shared Boolean var; // false
    shared DartTypeName? type;
    shared actual DartSimpleIdentifier identifier;

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

"A field formal parameter."
shared
class DartFieldFormalParameter
        (final, const, type, identifier)
        extends DartNormalFormalParameter() {

    shared Boolean final; // false
    shared Boolean const; // false
    shared DartTypeName? type;
    shared actual DartSimpleIdentifier identifier;
    // shared FormalParameterList? parameters

    "Can only have one of final and const"
    assert (!(final && const));

    shared actual
    void write(CodeWriter writer) {
        if (final) {
            writer.write("final ");
        }
        if (const) {
            writer.write("const ");
        }
        if (exists type) {
            type.write(writer);
            writer.write(" ");
        }
        else {
            writer.write("var ");
        }
        writer.write("this.");
        identifier.write(writer);
    }
}

"A formal parameter with a default value. There are two kinds
 of parameters that are both represented by this class: named
 formal parameters and positional formal parameters."
shared
class DartDefaultFormalParameter
        (parameter, defaultValue)
        extends DartFormalParameter() {

    // TODO defaultNamedParameter option
    shared DartNormalFormalParameter parameter;
    // ParameterKind ???
    shared DartExpression defaultValue;

    shared actual DartSimpleIdentifier identifier => parameter.identifier;

    shared actual
    void write(CodeWriter writer) {
        parameter.write(writer);
        writer.write(" = ");
        defaultValue.write(writer);
    }
}

"A function body consisting of a single expression."
shared
class DartExpressionFunctionBody(async, expression)
        extends DartFunctionBody() {

    shared Boolean async;
    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        if (async) {
            writer.write("async ");
        }
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
        parenthesizeNonPrimary(expression).write(writer);
        writer.write(" is ");
        if (notOperator) {
            writer.write("!");
        }
        type.write(writer);
    }
}

shared
class DartConstructorDeclaration
        (const, factory, returnType, name, parameters, initializers,
         redirectedConstructor, body)
        extends DartClassMember() {

    // DartComment comment
    // List<DartAnnotation> metadata
    //shared Boolean external;
    shared Boolean const;
    shared Boolean factory;
    shared DartIdentifier returnType;
    shared DartSimpleIdentifier? name;
    shared DartFormalParameterList parameters;
    shared [DartConstructorInitializer*] initializers;
    shared DartConstructorName? redirectedConstructor;
    shared DartFunctionBody? body;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        returnType.write(writer);
        if (exists name) {
            writer.write(".");
            name.write(writer);
        }
        parameters.write(writer);

        if (nonempty initializers) {
            variable value first = true;
            for (initializer in initializers) {
                if (first) {
                    first = false;
                    writer.write(" : ");
                }
                else {
                    writer.write(", ");
                }
                initializer.write(writer);
            }
        }

        // TODO redirectedConstructor

        if (exists body) {
            writer.write(" ");
            body.write(writer);
        }
        else {
            writer.endStatement();
        }
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

shared abstract
class DartConstructorInitializer()
        of DartSuperConstructorInvocation
            | DartRedirectingConstructorInvocation
            | ConstructorFieldInitializer
        extends DartNode() {}

"The invocation of a superclass' constructor from within a constructor's initialization
 list"
shared
class DartSuperConstructorInvocation(constructorName, argumentList)
        extends DartConstructorInitializer() {

    shared DartSimpleIdentifier? constructorName;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        writer.write("super");
        if (exists constructorName) {
            writer.write(".");
            constructorName.write(writer);
        }
        argumentList.write(writer);
    }
}

"The invocation of a constructor in the same class from within a constructor's
 initialization list."
shared
class DartRedirectingConstructorInvocation(constructorName, argumentList)
        extends DartConstructorInitializer() {

    shared DartSimpleIdentifier? constructorName;
    shared DartArgumentList argumentList;

    shared actual
    void write(CodeWriter writer) {
        writer.write("this");
        if (exists constructorName) {
            writer.write(".");
            constructorName.write(writer);
        }
        argumentList.write(writer);
    }
}

"The initialization of a field within a constructor's initialization list."
shared
class ConstructorFieldInitializer()
        extends DartConstructorInitializer() {

    shared actual
    void write(CodeWriter writer) {
        throw;
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

"A rethrow expression."
shared
class DartRethrowExpression
        extends DartExpression {

    shared new instance extends DartExpression() {}

    shared actual
    void write(CodeWriter writer) {
        writer.write("rethrow");
    }
}

"A catch clause within a try statement."
shared
class DartCatchClause(exceptionType, exceptionParameter, stackTraceParameter, block)
        extends DartStatement() {
    shared DartTypeName? exceptionType;
    shared DartSimpleIdentifier exceptionParameter;
    shared DartSimpleIdentifier? stackTraceParameter;
    shared DartBlock block;

    shared actual
    void write(CodeWriter writer) {
        if (exists exceptionType) {
            writer.write(" on ");
            exceptionType.write(writer);
        }
        writer.write(" catch (");
        exceptionParameter.write(writer);
        if (exists stackTraceParameter) {
            writer.write(", ");
            stackTraceParameter.write(writer);
        }
        writer.write(") ");
        block.write(writer);
    }
}

"A try statement"
shared
class DartTryStatement(block, catchClauses, finallyBlock=null)
        extends DartStatement() {
    shared DartBlock block;
    shared [DartCatchClause*] catchClauses;
    shared DartBlock? finallyBlock;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("try ");
        block.write(writer);
        catchClauses.each((cc) => cc.write(writer));
        if (exists finallyBlock) {
            writer.write(" finally ");
            finallyBlock.write(writer);
        }
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
        parenthesizeNonPrimary(expression).write(writer);
        writer.write(" as ");
        type.write(writer);
    }
}

shared
class DartClassDeclaration(
        abstract, name, extendsClause,
        implementsClause, members)
        extends DartNamedCompilationUnitMember(name) {

    shared Boolean abstract;
    DartSimpleIdentifier name;
    // DartTypeParameterList typeParameters
    shared DartExtendsClause? extendsClause;
    // DartWithClause withClause
    shared DartImplementsClause? implementsClause;
    shared [DartClassMember*] members;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        if (abstract) {
            writer.write("abstract ");
        }
        writer.write("class ");
        name.write(writer);
        writer.write(" ");
        if (exists extendsClause) {
            extendsClause.write(writer);
            writer.write(" ");
        }
        if (exists implementsClause) {
            implementsClause.write(writer);
            writer.write(" ");
        }
        writer.startBlock();
        for (member in members) {
            member.write(writer);
        }
        writer.endBlock();
    }
}

shared
class DartExtendsClause(superClass)
        extends DartNode() {

    shared DartTypeName superClass;

    shared actual
    void write(CodeWriter writer) {
        writer.write(" extends ");
        superClass.write(writer);
    }
}

shared
class DartImplementsClause(interfaces)
        extends DartNode() {

    shared [DartTypeName+] interfaces;

    shared actual
    void write(CodeWriter writer) {
        writer.write("implements ");
        variable value first = true;
        for (iface in interfaces) {
            if (first) {
                first = false;
            }
            else {
                writer.write(", ");
            }
            iface.write(writer);
        }
    }
}

shared abstract
class DartClassMember()
        of  DartConstructorDeclaration |
            DartFieldDeclaration |
            DartMethodDeclaration
        extends DartDeclaration() {}

shared
class DartFieldDeclaration(static, fieldList)
        extends DartClassMember() {

    shared Boolean static;
    shared DartVariableDeclarationList fieldList;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        if (static) {
            writer.write("static ");
        }
        fieldList.write(writer);
        writer.endStatement();
    }
}

shared
class DartMethodDeclaration(
        external, modifierKeyword, returnType,
        propertyKeyword, operator, name, parameters, body)
        extends DartClassMember() {

    shared Boolean external;
    shared String? modifierKeyword; // abstract | static
    shared DartTypeName? returnType;
    shared String? propertyKeyword; // get | set
    shared Boolean operator;
    shared DartSimpleIdentifier name;
    shared DartFormalParameterList? parameters;
    shared DartFunctionBody? body;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        if (external) {
            writer.write("external ");
        }
        if (exists modifierKeyword) {
            writer.write(modifierKeyword);
            writer.write(" ");
        }
        if (exists returnType) {
            returnType.write(writer);
            writer.write(" ");
        }
        if (exists propertyKeyword) {
            writer.write(propertyKeyword);
            writer.write(" ");
        }
        if (operator) {
            writer.write("operator ");
        }
        name.write(writer);
        if (exists parameters) {
            parameters.write(writer);
        }
        if (exists body) {
            writer.write(" ");
            body.write(writer);
            if (body is DartExpressionFunctionBody) {
                writer.endStatement();
            }
        }
        else {
            writer.endStatement();
        }
    }
}

shared
class DartWhileStatement(expression, statement)
        extends DartStatement() {

    shared DartExpression expression;
    shared DartStatement statement;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("while (");
        expression.write(writer);
        writer.write(") ");
        statement.write(writer);
    }
}

shared
class DartDoWhileStatement(statement, expression)
        extends DartStatement() {

    shared DartStatement statement;
    shared DartExpression expression;

    shared actual
    void write(CodeWriter writer) {
        writer.writeLine();
        writer.writeIndent();
        writer.write("do ");
        statement.write(writer);
        writer.write(" while (");
        expression.write(writer);
        writer.write(")");
        writer.endStatement();
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
