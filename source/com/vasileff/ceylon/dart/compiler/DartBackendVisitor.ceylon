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
    FunctionShortcutDefinition,
    FloatLiteral,
    Specifier,
    Node
}

import com.redhat.ceylon.model.typechecker.model {
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    Unit,
    Type
}

class DartBackendVisitor(Unit unit) satisfies Visitor {

    shared
    StringBuilder result = StringBuilder();

    value dcw = CodeWriter(result.append);

    value typeFactory = TypeFactory(unit);

    variable TypeOrNoType? lhsTypeTop = null;

    variable TypeOrNoType? returnTypeTop = null;

    function hasError(Node that)
        =>  that.transform(hasErrorTransformer);

    shared actual
    void visitBaseExpression(BaseExpression that) {
        if (hasError(that)) {
            return;
        }

        "Supports MNWTA for BaseExpressions"
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        value info = BaseExpressionInfo(that);
        assert (exists targetDeclaration = info.declaration);
        assert (exists lhsType = lhsTypeTop);
        assert (exists rhsType = info.typeModel?.type);

        if (typeFactory.isBooleanTrueDeclaration(targetDeclaration)) {
            generateBooleanLiteral(lhsType, true);
        }
        else if (typeFactory.isBooleanFalseDeclaration(targetDeclaration)) {
            generateBooleanLiteral(lhsType, false);
        }
        else if (typeFactory.isNullDeclaration(targetDeclaration)) {
            dcw.write("null");
        }
        else {
            // TODO make this work
            withBoxing(rhsType, ()
                =>  dcw.write(nameAndArgs.name.name));
        }
    }

    shared actual
    void visitFloatLiteral(FloatLiteral that) {
        withBoxing(typeFactory.floatType, ()
            => dcw.write(that.float.string));
    }

    shared actual
    void visitIntegerLiteral(IntegerLiteral that) {
        withBoxing(typeFactory.integerType, ()
            => dcw.write(that.integer.string));
    }

    shared actual
    void visitStringLiteral(StringLiteral that) {
        withBoxing(typeFactory.stringType, ()
            =>  dcw.write("\"``that.text``\"")); // FIXME escaping
    }

    shared actual
    void visitArgumentList(ArgumentList that) {
        "spread arguments not supported"
        assert(that.sequenceArgument is Null);

        value info = ArgumentListInfo(that);

        variable Boolean first = true;

        // ceylon.ast doesn't have a node for 'PositionalArgument'
        // so we are getting model info from the argument list
        for ([expression, argumentTypeModel, parameterModel] in
                zip(that.listedArguments,
                    info.listedArgumentModels)) {
            if (first) {
                first = false;
            }
            else {
                dcw.write(", ");
            }
            withLhsType(parameterModel.type, ()
                => expression.visit(this));
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
        value info = ExpressionInfo(that);
        assert (exists rhsType = info.typeModel);

        withBoxing(rhsType, void() {
            // we want a boxed type to invoke, so use 'Anything'
            withLhsType(typeFactory.anythingType, ()
                =>  that.invoked.visit(this));

            "Named arguments not yet supported"
            assert (that.arguments is PositionalArguments);
            that.arguments.visit(this);
        });
    }

    shared actual
    void visitInvocationStatement(InvocationStatement that) {
        dcw.writeIndent();
        withLhsType(noType, ()
            =>  that.expression.visit(this));
        dcw.writeLine(";");
    }

    "Parents must set [[returnTypeTop]]"
    shared actual
    void visitLazySpecifier(LazySpecifier that) {
        dcw.write("=> ");
        assert (exists lhsType = returnTypeTop);
        withLhsType(lhsType, ()
            =>  that.expression.visit(this));
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
        if (hasError(that)) {
            return;
        }

        value info = ValueDefinitionInfo(that);
        assert (exists type = info.declarationModel?.type);

        value dartName = that.name.name; // TODO name

        "lazySpecifier not yet supported"
        assert (that.definition is Specifier);

        dcw.writeIndent().write("var ``dartName`` = ");
        withLhsType(type, ()
            =>  that.definition.visitChildren(this));
        dcw.writeLine(";");
    }

    "Parents must set [[returnTypeTop]]"
    shared actual
    void visitReturn(Return that) {
        if (exists result = that.result) {
            assert (exists lhsType = returnTypeTop);
            dcw.writeIndent();
            dcw.write("return ");
            withLhsType(lhsType, ()
                =>  result.visit(this));
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

        if (hasError(that)) {
            return;
        }

        FunctionModel? functionModel;
        [Parameters+] parameterLists;
        LazySpecifier|Block definition;
        String? functionName;

        switch (that)
        case (is FunctionExpression) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = null;
            value info = FunctionExpressionInfo(that);
            functionModel = info.declarationModel;
        }
        case (is FunctionDefinition) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = name(that);
            value info = FunctionDefinitionInfo(that);
            functionModel = info.declarationModel;
        }
        case (is FunctionShortcutDefinition) {
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionName = name(that);
            value info = FunctionShortcutDefinitionInfo(that);
            functionModel = info.declarationModel;
        }

        // no errors, and we just initialized it
        assert (exists functionModel);

        if (parameterLists.size != 1) {
            throw Exception("multiple parameter lists not supported");
        }

        value returnType = (functionModel of TypedDeclarationModel).type;

        function dartParameterList() {
            value list = parameterLists.first;
            if (list.parameters.empty) {
                return "()";
            }
            value sb = StringBuilder();
            sb.append("([");
            sb.append(", ".join(list.parameters.map((parameter) {
                value sb = StringBuilder();
                value parameterInfo = ParameterInfo(parameter);
                assert (exists model = parameterInfo.parameterModel);
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
                //.writeLine("// location=``location(that)``; \
                //            return=``returnType.asString()``")
                .writeIndent()
                .write(functionModel.declaredVoid then "void " else "")
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
            withReturnType(returnType, ()
                =>  definition.visit(this));
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
                withReturnType(returnType, ()
                    =>  definition.visitChildren(this));
            }
            case (is LazySpecifier) {
                //for FunctionShortcutDefinition
                dcw.writeIndent();
                if (!functionModel.declaredVoid) {
                    dcw.write("return ");
                }
                withLhsType(returnType, ()
                    =>  definition.expression.visit(this));
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
    void visitNode(Node that)
        =>  error(that,
                "compiler bug: unhandled node \
                 '``className(that)``'");

    shared actual
    void visitCompilationUnit(CompilationUnit that) {
        // TODO actual imports from the typechecker
        // TODO decide on file structure (one file per module?)
        dcw.writeLine("import 'package:ceylon/language/language.dart';");
        dcw.writeLine();
        that.visitChildren(this);
    }

    void withLhsType(TypeOrNoType lhsType, void fun()) {
        value save = lhsTypeTop;
        lhsTypeTop = lhsType;
        fun();
        lhsTypeTop = save;
    }

    void withReturnType(TypeOrNoType returnType, void fun()) {
        value save = returnTypeTop;
        returnTypeTop = returnType;
        fun();
        returnTypeTop = save;
    }

    void withBoxing(Type rhsType, void fun()) {
        assert (exists lhsType = lhsTypeTop);
        value conversion =
            switch (lhsType)
            case (is NoType) null
            case (is Type) typeFactory
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

    void error(Node that, String message)
        =>  process.writeErrorLine(message);

    void generateBooleanLiteral(TypeOrNoType type, Boolean boolean) {
        value box =
            switch(type)
            case (is NoType) false
            case (is Type) typeFactory
                .isCeylonOptionalBoolean(type);
        if (box) {
            dcw.write(if(boolean) then "true" else "false");
        }
        else {
            dcw.write(if(boolean) then "$true" else "$false");
        }
    }
}

"Indicates the absence of a type (like void). One use is to
 indicate the absence of a `lhsType` when determining if
 the result of an expression should be boxed."
interface NoType of noType {}

"The instance of `NoType`"
object noType satisfies NoType {}

alias TypeOrNoType => Type | NoType;
