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
    ValueSpecification,
    Expression
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
import ceylon.collection {
    LinkedList
}

class ExpressionTransformer
        (CompilationContext ctx)
        extends BaseTransformer<DartExpression>(ctx) {

    shared actual
    DartExpression transformBaseExpression(BaseExpression that) {
        "Supports MNWTA for BaseExpressions"
        assert (is MemberNameWithTypeArguments nameAndArgs = that.nameAndArgs);

        value info = BaseExpressionInfo(that);
        assert (exists targetDeclaration = info.declaration);
        assert (exists lhsType = ctx.lhsTypeTop);
        assert (exists rhsType = info.typeModel?.type);

        if (ctx.typeFactory.isBooleanTrueDeclaration(targetDeclaration)) {
            return generateBooleanLiteral(lhsType, true);
        }
        else if (ctx.typeFactory.isBooleanFalseDeclaration(targetDeclaration)) {
            return generateBooleanLiteral(lhsType, false);
        }
        else if (ctx.typeFactory.isNullDeclaration(targetDeclaration)) {
            return DartNullLiteral();
        }
        else {
            DartExpression unboxed;
            switch (targetDeclaration)
            case (is ValueModel) {
                switch (container = containerOfDeclaration(targetDeclaration))
                case (is PackageModel) {
                    if (sameModule(ctx.unit, targetDeclaration)) {
                        // qualify toplevel in same module with '$package.'
                        unboxed = DartSimpleIdentifier(
                            "$package$" +
                            ctx.naming.identifierPackagePrefix(targetDeclaration) +
                            ctx.naming.getName(targetDeclaration));
                    }
                    else {
                        // qualify toplevel with Dart import prefix
                        unboxed = DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier(
                                ctx.naming.moduleImportPrefix(targetDeclaration));
                            identifier = DartSimpleIdentifier(
                                ctx.naming.identifierPackagePrefix(targetDeclaration) +
                                ctx.naming.getName(targetDeclaration));
                        };
                    }
                }
                case (is ClassOrInterfaceModel
                            | FunctionOrValueModel
                            | ControlBlockModel
                            | ConstructorModel) {
                    if (useGetterSetterMethods(targetDeclaration)) {
                        // invoke the getter
                        unboxed = DartFunctionExpressionInvocation {
                            func = DartSimpleIdentifier(
                                ctx.naming.getName(targetDeclaration) + "$get");
                            argumentList = DartArgumentList();
                        };
                    }
                    else {
                        // identifier for the variable
                        unboxed = DartSimpleIdentifier(
                                ctx.naming.getName(targetDeclaration));
                    }
                }
                else {
                    throw CompilerBug(that,
                        "Unexpected container for base expression: \
                         declaration type '``className(targetDeclaration)``' \
                         container type '``className(container)``'");
                }
            }
            else {
                // FIXME asap
                unboxed = DartSimpleIdentifier(ctx.naming.getName(targetDeclaration));
                //throw CompilerBug(that,
                //        "Unexpected declaration type for base expression: \
                //         ``className(targetDeclaration)``");
            }
            return withBoxing(rhsType, unboxed);
        }
    }

    shared actual
    DartExpression transformFloatLiteral(FloatLiteral that)
        =>  withBoxing(
                ctx.typeFactory.floatType,
                DartDoubleLiteral(that.float));

    shared actual
    DartExpression transformIntegerLiteral(IntegerLiteral that)
        =>  withBoxing(
                ctx.typeFactory.integerType,
                DartIntegerLiteral(that.integer));

    shared actual
    DartExpression transformStringLiteral(StringLiteral that)
        =>  withBoxing(
                ctx.typeFactory.stringType,
                DartSimpleStringLiteral(that.text));

    shared actual
    DartExpression transformInvocation(Invocation that) {
        value info = ExpressionInfo(that);
        assert (exists rhsType = info.typeModel);

        return withBoxing(rhsType, DartFunctionExpressionInvocation {
            // we want a boxed type to invoke, so use 'Anything' (unoptimized!)
            func = ctx.withLhsType(ctx.typeFactory.anythingType, ()
                    =>  that.invoked.transform(this));
            argumentList = dartTransformer.transformArguments(that.arguments);
        });
    }

    shared actual
    DartFunctionExpression transformFunctionExpression
            (FunctionExpression that)
        =>  generateFunctionExpression(that);

    shared
    DartFunctionExpressionInvocation | DartAssignmentExpression
    generateAssignmentExpression(
                Node that,
                ValueModel targetDeclaration,
                Expression rhsExpression) {

        // TODO make sure setters return the new value, or do somthing here
        DartIdentifier targetOrSetter;
        Boolean isMethod;

        switch (container = containerOfDeclaration(targetDeclaration))
        case (is PackageModel) {
            isMethod = false;
            if (sameModule(ctx.unit, targetDeclaration)) {
                // qualify toplevel in same module with '$package$'
                targetOrSetter = DartSimpleIdentifier(
                    "$package$" +
                    ctx.naming.identifierPackagePrefix(targetDeclaration) +
                    ctx.naming.getName(targetDeclaration));
            }
            else {
                // qualify toplevel with Dart import prefix
                targetOrSetter = DartPrefixedIdentifier(
                    DartSimpleIdentifier(
                        ctx.naming.moduleImportPrefix(targetDeclaration)),
                    DartSimpleIdentifier(
                        ctx.naming.identifierPackagePrefix(targetDeclaration) +
                        ctx.naming.getName(targetDeclaration)));
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            isMethod = useGetterSetterMethods(targetDeclaration);
            targetOrSetter =
                if (!isMethod) then
                    // regular variable; no lazy or block getter
                    DartSimpleIdentifier(
                        ctx.naming.getName(targetDeclaration))
                else
                    // setter method
                    DartSimpleIdentifier(
                        ctx.naming.getName(targetDeclaration) + "$set");
        }
        else {
            throw CompilerBug(that,
                "Unexpected container for base expression: \
                 declaration type '``className(targetDeclaration)``' \
                 container type '``className(container)``'");
        }

        DartExpression rhs = ctx.withLhsType(targetDeclaration.type, ()
                =>  rhsExpression.transform(this));

        if (isMethod) {
            return DartFunctionExpressionInvocation {
                func = targetOrSetter;
                argumentList = DartArgumentList(rhs);
            };
        }
        else {
            return DartAssignmentExpression {
                lhsExpression = targetOrSetter;
                operator = "=";
                rhsExpression =  rhs;
            };
        }
    }

    DartExpression generateBooleanLiteral(TypeOrNoType type, Boolean boolean) {
        value box =
            switch(type)
            case (is NoType) false
            case (is TypeModel) ctx.typeFactory
                    .isCeylonOptionalBoolean(type);
        if (box) {
            return DartBooleanLiteral(boolean);
        }
        else {
            // TODO naming
            return DartPrefixedIdentifier(
                DartSimpleIdentifier("$ceylon$language"),
                DartSimpleIdentifier(if(boolean) then "$true" else "$false"));
        }
    }

    shared
    DartFunctionExpression generateFunctionExpression(
            FunctionExpression
                | FunctionDefinition
                | FunctionShortcutDefinition that) {

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
            functionName = ctx.naming.getName(functionModel);
        }
        case (is FunctionShortcutDefinition) {
            value info = FunctionShortcutDefinitionInfo(that);
            parameterLists = that.parameterLists;
            definition = that.definition;
            functionModel = info.declarationModel;
            functionName = ctx.naming.getName(functionModel);
        }

        if (parameterLists.size != 1) {
            throw CompilerBug(that, "Multiple parameter lists not supported");
        }

        value returnType = (functionModel of TypedDeclarationModel).type;

        function dartParameterList() {
            value list = parameterLists.first;
            if (list.parameters.empty) {
                return DartFormalParameterList();
            }

            value parameters = list.parameters.collect((parameter) {
                //value sb = StringBuilder();
                value parameterInfo = ParameterInfo(parameter);
                assert (exists model = parameterInfo.parameterModel);

                switch(parameter)
                case (is DefaultedValueParameter) {
                    value name = DartSimpleIdentifier(
                            parameter.parameter.name.name); // TODO name
                    return DartDefaultFormalParameter {
                        parameter = DartSimpleFormalParameter {
                            identifier = name;
                        };
                        defaultValue = DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$ceylon$language");
                            identifier = DartSimpleIdentifier("dart$defaulted");
                        };
                    };
                }
                case (is ValueParameter) {
                    value name = DartSimpleIdentifier(
                            parameter.name.name); // TODO name
                    return DartSimpleFormalParameter {
                        identifier = name;
                    };
                }
                case (is VariadicParameter
                        | CallableParameter
                        | ParameterReference
                        | DefaultedCallableParameter
                        | DefaultedParameterReference) {
                    throw CompilerBug(that, "Parameter type not supported: \
                                             ``className(parameter)``");
                }
            });
            return DartFormalParameterList {
                positional = true;
                parameters = parameters;
            };
        }

        //Defaulted Parameters:
        //If any exist, use a block (not lazy specifier)
        //At start of block, assign values as necessary
        value defaultedParameters = parameterLists.first
                .parameters.narrow<DefaultedValueParameter>();

        DartFunctionBody body;
        if (defaultedParameters.empty) {
            // no defaulted parameters
            switch (definition)
            case (is Block) {
                body = ctx.withReturnType(returnType, ()
                    => DartBlockFunctionBody(statementTransformer
                            .transformBlock(definition)[0]));
            }
            case (is LazySpecifier) {
                body = DartExpressionFunctionBody(ctx.withLhsType(returnType, ()
                    => definition.expression.transform(expressionTransformer)));
            }
        }
        else {
            // defaulted parameters exist
            value statements = LinkedList<DartStatement>();

            for (param in defaultedParameters) {
                value parameterInfo = ParameterInfo(param);
                assert (exists model = parameterInfo.parameterModel);
                value parameterType = model.type;
                value paramName = DartSimpleIdentifier
                        (param.parameter.name.name); // TODO Name
                statements.add(DartIfStatement {
                    // condition
                    DartFunctionExpressionInvocation {
                        DartPrefixedIdentifier {
                            prefix = DartSimpleIdentifier("$dart");
                            identifier = DartSimpleIdentifier("identical");
                        };
                        DartArgumentList {
                            [paramName,
                             DartPrefixedIdentifier {
                                prefix = DartSimpleIdentifier("$ceylon$language");
                                identifier = DartSimpleIdentifier("dart$defaulted");
                            }];
                        };
                    };
                    // then statement
                    DartExpressionStatement {
                        DartAssignmentExpression {
                            lhsExpression = paramName;
                            operator = "=";
                            rhsExpression = ctx.withLhsType(parameterType, ()
                                =>  param.specifier.expression
                                        .transform(expressionTransformer));
                        };
                    };
                });
            }
            switch (definition)
            case (is Block) {
                statements.addAll(expand(ctx.withReturnType(returnType, ()
                    =>  definition.transformChildren(statementTransformer))));
            }
            case (is LazySpecifier) {
                // for FunctionShortcutDefinition
                statements.add(
                    DartReturnStatement {
                        ctx.withLhsType(returnType, ()
                            =>  definition.expression.transform(this));
                });
            }
            body = DartBlockFunctionBody(DartBlock(*statements));
        }
        return DartFunctionExpression(dartParameterList(), body);
    }

    DartExpression|Absent withBoxing<Absent=Nothing>
            (TypeModel rhsType, DartExpression|Absent expression)
            given Absent satisfies Null {

        assert (exists lhsType = ctx.lhsTypeTop);

        if (exists expression) {
            value conversion =
                switch (lhsType)
                case (is NoType) null
                case (is TypeModel) ctx.typeFactory
                        .boxingConversionFor(lhsType, rhsType);

            if (exists conversion) {
                DartSimpleIdentifier boxingFunction =
                    switch (conversion)
                    case (ceylonBooleanToNative)
                        DartSimpleIdentifier("dart$ceylonBooleanToNative")
                    case (ceylonFloatToNative)
                        DartSimpleIdentifier("dart$ceylonFloatToNative")
                    case (ceylonIntegerToNative)
                        DartSimpleIdentifier("dart$ceylonIntegerToNative")
                    case (ceylonStringToNative)
                        DartSimpleIdentifier("dart$ceylonStringToNative")
                    case (nativeToCeylonBoolean)
                        DartSimpleIdentifier("dart$nativeToCeylonBoolean")
                    case (nativeToCeylonFloat)
                        DartSimpleIdentifier("dart$nativeToCeylonFloat")
                    case (nativeToCeylonInteger)
                        DartSimpleIdentifier("dart$nativeToCeylonInteger")
                    case (nativeToCeylonString)
                        DartSimpleIdentifier("dart$nativeToCeylonString");

                return DartFunctionExpressionInvocation {
                    func = DartPrefixedIdentifier(
                                DartSimpleIdentifier("$ceylon$language"),
                                boxingFunction);
                    argumentList = DartArgumentList(expression);
                };
            }
            else {
                return expression;
            }
        }
        else {
            assert (is Absent null);
            return null;
        }
    }
}
