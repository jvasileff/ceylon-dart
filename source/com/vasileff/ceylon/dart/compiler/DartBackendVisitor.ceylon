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
    Node,
    Assertion,
    IsCondition,
    ValueSpecification
}

import com.redhat.ceylon.model.typechecker.model {
    ControlBlockModel=ControlBlock,
    FunctionOrValueModel=FunctionOrValue,
    ConstructorModel=Constructor,
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    ValueModel=Value,
    SetterModel=Setter,
    UnitModel=Unit,
    TypeModel=Type,
    PackageModel=Package,
    DeclarationModel=Declaration,
    ElementModel=Element,
    ScopeModel=Scope,
    ClassOrInterfaceModel=ClassOrInterface
}

import org.antlr.runtime {
    Token
}
import ceylon.language.meta.declaration {
    Package
}
import com.redhat.ceylon.model.loader.model {
    FunctionOrValueInterface
}

class DartBackendVisitor
        (UnitModel unit, List<Token> tokens)
        satisfies Visitor {

    shared
    StringBuilder result = StringBuilder();

    value dcw = CodeWriter(result.append);

    value typeFactory = TypeFactory(unit);

    value naming = Naming();

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
            void fallbackStupidMethod() { // (remove asap!)
                value name = naming.getName(targetDeclaration);
                withBoxing(rhsType, () => dcw.write(name));
            }
            switch (targetDeclaration)
            case (is ValueModel) {
                switch (container = containerOfDeclaration(targetDeclaration))
                case (is PackageModel) {
                    if (sameModule(unit, targetDeclaration)) {
                        // qualify toplevel in same module with '$package.'
                        value name =
                            "$package." +
                            naming.identifierPackagePrefix(targetDeclaration) +
                            naming.getName(targetDeclaration);
                        withBoxing(rhsType, () => dcw.write(name));
                    }
                    else {
                        // qualify toplevel with Dart import prefix
                        value name =
                            naming.moduleImportPrefix(targetDeclaration) + "." +
                            naming.identifierPackagePrefix(targetDeclaration) +
                            naming.getName(targetDeclaration);
                        withBoxing(rhsType, () => dcw.write(name));
                    }
                }
                case (is ClassOrInterfaceModel
                            | FunctionOrValueModel
                            | ControlBlockModel
                            | ConstructorModel) {
                    value name =
                        if (!useGetterSetterMethods(targetDeclaration)) then
                            // regular variable; no lazy or block getter
                            naming.getName(targetDeclaration)
                        else
                            // getter invocation
                            naming.getName(targetDeclaration) + "$get()";

                    withBoxing(rhsType, () => dcw.write(name));
                }
                else {
                    throw CompilerBug(that,
                        "Unexpected container for base expression: \
                         declaration type '``className(targetDeclaration)``' \
                         container type '``className(container)``'");
                }
            }
            else {
                fallbackStupidMethod();
                //throw CompilerBug(that,
                //        "Unexpected declaration type for base expression: \
                //         ``className(targetDeclaration)``");
            }
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
        assert (exists declarationModel = info.declarationModel);

        value dartName = naming.getName(declarationModel);

        if (!that.definition is Specifier) {
            unimplementedError(that, "lazySpecifier not yet supported");
            return;
        }

        dcw.writeIndent().write("var ``dartName`` = ");
        withLhsType(declarationModel.type, ()
            =>  that.definition.visitChildren(this));
        dcw.writeLine(";");
    }

    shared actual
    void visitValueSpecification(ValueSpecification that) {
        if (hasError(that)) {
            return;
        }

        value info = ValueSpecificationInfo(that);
        value targetDeclaration = info.declaration;

        String qualifiedName;
        Boolean isMethod;
        //value isMethod = useGetterSetterMethods(targetDeclaration);

        switch (container = containerOfDeclaration(targetDeclaration))
        case (is PackageModel) {
            isMethod = false;
            if (sameModule(unit, targetDeclaration)) {
                // qualify toplevel in same module with '$package.'
                qualifiedName =
                    "$package." +
                    naming.identifierPackagePrefix(targetDeclaration) +
                    naming.getName(targetDeclaration);
            }
            else {
                // qualify toplevel with Dart import prefix
                qualifiedName =
                    naming.moduleImportPrefix(targetDeclaration) + "." +
                    naming.identifierPackagePrefix(targetDeclaration) +
                    naming.getName(targetDeclaration);
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            isMethod = useGetterSetterMethods(targetDeclaration);
            qualifiedName =
                if (!isMethod) then
                    // regular variable; no lazy or block getter
                    naming.getName(targetDeclaration)
                else
                    // setter method
                    naming.getName(targetDeclaration) + "$set";
        }
        else {
            throw CompilerBug(that,
                "Unexpected container for base expression: \
                 declaration type '``className(targetDeclaration)``' \
                 container type '``className(container)``'");
        }

        dcw.writeIndent();
        dcw.write(qualifiedName);
        if (isMethod) {
            dcw.write("(");
            withLhsType(targetDeclaration.type, ()
                =>  that.specifier.expression.visit(this));
            dcw.write(")");
        } else {
            dcw.write(" = ");
            withLhsType(targetDeclaration.type, ()
                =>  that.specifier.expression.visit(this));
        }
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

        FunctionModel functionModel;
        [Parameters+] parameterLists;
        LazySpecifier|Block definition;
        String? functionName;

        switch (that)
        case (is FunctionExpression) {
            value info = FunctionExpressionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = null;
        }
        case (is FunctionDefinition) {
            value info = FunctionDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = naming.getName(functionModel);
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = naming.getName(functionModel);
        }

        if (parameterLists.size != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
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
                    throw CompilerBug(that, "Parameter type not supported: \
                                             ``className(parameter)``");
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
    void visitAssertion(Assertion that) {
        // children are 'Annotations' and 'Conditions'
        // 'Conditions' has 'Condition's.

        // TODO Annotations
        // TODO Don't visit conditions individually?
        // annotations, especially 'doc', need to apply to
        // each condition. Any other annotations matter?

        that.conditions.visitChildren(this);
    }

    shared actual
    void visitIsCondition(IsCondition that) {
        // IsCondition holds a TypedVariable that may
        // or may not include a specifier to define a new variable

        // NOTE: There is no ast node for the typechecker's
        // Tree.IsCondition.Variable (we just get the specifier
        // and identifier from that node, but not the model info).
        // Instead, use ConditionInfo.variableDeclarationModel.

        // TODO don't hardcode AssertionError
        // TODO string escaping
        // TODO types! (including union and intersection, but not reified yet)
        // TODO check not null for Objects
        // TODO check null for Null
        // TODO consider null issues for negated checks

        value typeInfo = TypeInfo(that.variable.type);
        value conditionInfo = IsConditionInfo(that);

        "The type we are testing for"
        assert (exists isType = typeInfo.typeModel);

        "The declaration model for the new variable"
        assert (exists variableDeclaration = conditionInfo.variableDeclarationModel);

        "The type of the new variable (intersection of isType and expression/old type)"
        value variableType = variableDeclaration.type;

        "The expression node if defining a new variable"
        value expression = that.variable.specifier?.expression;

        "The original variable's type, if there is one"
        value originalType = conditionInfo.variableDeclarationModel?.originalDeclaration?.type;

        "If we are narrowing an existing variable, will there also be unboxing?"
        value boxingConversion =
                if (exists originalType)
                then typeFactory.boxingConversionFor(
                        originalType, variableType)
                else null;

        "The identifier for the new variable, if defining one"
        value dartIdentifier =
                if (exists boxingConversion)
                    then naming.createReplacementName(variableDeclaration)
                else if (exists expression)
                    then naming.getName(variableDeclaration)
                else null;

        "The Ceylon source code for the condition"
        value errorMessage =
                tokens[conditionInfo.token.tokenIndex..
                       conditionInfo.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        // determine what to check
        String dartIdentifierToCheck;
        if (exists expression) {
            // check type of an expression
            assert (exists dartIdentifier);
            dcw.writeIndent().write("var ``dartIdentifier`` = ");
            withLhsType(noType, ()
                =>  expression.visit(this)); // (not boxing)
            dcw.writeLine(";");
            dartIdentifierToCheck = dartIdentifier;
        }
        else {
            // check type of the original variable
            assert(exists originalDeclaration = variableDeclaration.originalDeclaration);
            dartIdentifierToCheck = naming.getName(originalDeclaration);
        }

        // check the type
        dcw.writeIndent();
        dcw.write("if (``!that.negated then "!" else ""``\
                   ``dartIdentifierToCheck`` is core.Object) ");
        dcw.startBlock();
        dcw.writeIndent();
        value assertionError = naming.getName(typeFactory.assertionErrorDeclaration);
        dcw.writeLine("throw new ``assertionError``(\"Violated: ``errorMessage``\");");
        dcw.endBlock();
        dcw.writeLine();

        // define an unboxed replacement variable
        if (exists boxingConversion) {
            assert (exists dartIdentifier);
            assert(exists originalDeclaration = variableDeclaration.originalDeclaration);
            dcw.writeIndent();
            dcw.writeLine("var ``dartIdentifier`` = \
                           ``naming.getName(originalDeclaration)``;");
        }
    }

    shared actual
    void visitNode(Node that)
        =>  unimplementedError(that);

    void unimplementedError(Node that, String? message=null)
        =>  error(that,
                "compiler bug: unhandled node \
                 '``className(that)``'" +
                (if (exists message)
                then ": " + message
                else ""));

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

    void withBoxing(TypeModel rhsType, void fun()) {
        assert (exists lhsType = lhsTypeTop);
        value conversion =
            switch (lhsType)
            case (is NoType) null
            case (is TypeModel) typeFactory
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

    void error(Node that, Anything message)
        =>  process.writeErrorLine(
                message?.string else "<null>");

    void generateBooleanLiteral(TypeOrNoType type, Boolean boolean) {
        value box =
            switch(type)
            case (is NoType) false
            case (is TypeModel) typeFactory
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

alias TypeOrNoType => TypeModel | NoType;
