import ceylon.ast.core {
    FunctionDefinition,
    Block,
    InvocationStatement,
    ValueDefinition,
    Return,
    FunctionShortcutDefinition,
    Assertion,
    IsCondition,
    ValueSpecification
}
import ceylon.collection {
    LinkedList
}

import org.antlr.runtime {
    Token
}
import com.redhat.ceylon.model.typechecker.model {
    TypedDeclaration
}

class StatementTransformer
        (CompilationContext ctx)
        extends BaseTransformer<[DartStatement+]>(ctx) {

    "Parents must set `returnTypeTop`"
    see(`function ExpressionTransformer.generateFunctionExpression`)
    shared actual
    [DartReturnStatement] transformReturn(Return that) {
        if (exists result = that.result) {
            assert (exists lhsType = ctx.returnTypeTop);
            value expression = ctx.withLhsType(lhsType, ()
                =>  result.transform(expressionTransformer));
            return [DartReturnStatement(expression)];
        }
        else {
            return [DartReturnStatement()];
        }
    }

    shared actual
    [DartStatement] transformInvocationStatement(InvocationStatement that)
        =>  [DartExpressionStatement(ctx.withLhsType(noType, ()
            => expressionTransformer.transformInvocation(that.expression)))];

    shared actual
    [DartVariableDeclarationStatement] transformValueDefinition
            (ValueDefinition that)
        =>  [DartVariableDeclarationStatement(dartTransformer
                .transformValueDefinition(that))];

    shared actual
    [DartStatement] transformValueSpecification(ValueSpecification that)
        =>  [DartExpressionStatement {
                expression = expressionTransformer.generateAssignmentExpression {
                    that = that;
                    targetDeclaration = ValueSpecificationInfo(that).declaration;
                    rhsExpression = that.specifier.expression;
                };
            }];

    see(`function transformFunctionShortcutDefinition`)
    see(`function TopLevelTransformer.transformFunctionDefinition`)
    see(`function TopLevelTransformer.transformFunctionShortcutDefinition`)
    shared actual
    [DartFunctionDeclarationStatement] transformFunctionDefinition
            (FunctionDefinition that) {
        value info = FunctionDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                (info.declarationModel of TypedDeclaration).type);

        return [
            DartFunctionDeclarationStatement {
                DartFunctionDeclaration {
                    external = false;
                    returnType = returnType;
                    propertyKeyword = null;
                    name = DartSimpleIdentifier(functionName);
                    functionExpression = expressionTransformer
                            .generateFunctionExpression(that);
                };
            }
        ];
    }

    see(`function transformFunctionDefinition`)
    see(`function TopLevelTransformer.transformFunctionDefinition`)
    see(`function TopLevelTransformer.transformFunctionShortcutDefinition`)
    shared actual
    [DartFunctionDeclarationStatement] transformFunctionShortcutDefinition
                (FunctionShortcutDefinition that) {
        value info = FunctionShortcutDefinitionInfo(that);
        value functionModel = info.declarationModel;
        value functionName = ctx.naming.getName(functionModel);
        value returnType = ctx.naming.dartTypeName(
                info.declarationModel,
                (info.declarationModel of TypedDeclaration).type);

        return [
            DartFunctionDeclarationStatement {
                DartFunctionDeclaration {
                    external = false;
                    returnType = returnType;
                    propertyKeyword = null;
                    name = DartSimpleIdentifier(functionName);
                    functionExpression = expressionTransformer
                        .generateFunctionExpression(that);
                };
            }
        ];
    }

    shared actual
    [DartBlock] transformBlock(Block that)
        // Dart block's only have Statements. Declarations are wrapped:
        //      FunctionDeclarationStatement(FunctionDeclaration)
        //      VariableDeclarationStatement(VariableDeclarationList)
        //
        // TODO classes and interfaces need jump back to toplevel w/captures
        =>  [DartBlock([*expand(that.transformChildren(this))])];

    shared actual
    [DartStatement+] transformAssertion(Assertion that) {
        // children are 'Annotations' and 'Conditions'
        // 'Conditions' has 'Condition's.

        // TODO Annotations
        // TODO Don't visit conditions individually?
        // annotations, especially 'doc', need to apply to
        // each condition. Any other annotations matter?

        return [*that.conditions.children.flatMap((c)
            =>  c.transform(this))];
    }

    shared actual
    [DartStatement+] transformIsCondition(IsCondition that) {
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

        //value typeInfo = TypeInfo(that.variable.type);
        value conditionInfo = IsConditionInfo(that);

        //"The type we are testing for"
        //value isType = typeInfo.typeModel;

        "The declaration model for the new variable"
        value variableDeclaration = conditionInfo.variableDeclarationModel;

        "The type of the new variable (intersection of isType and expression/old type)"
        value variableType = variableDeclaration.type;

        "The expression node if defining a new variable"
        value expression = that.variable.specifier?.expression;

        "The original variable's type, if there is one"
        value originalType = conditionInfo.variableDeclarationModel
                .originalDeclaration?.type;

        "If we are narrowing an existing variable, will there also be unboxing?"
        value boxingConversion =
                if (exists originalType)
                then ctx.typeFactory.boxingConversionFor(
                        originalType, variableType)
                else null;

        "The identifier for the new variable, if defining one"
        value dartIdentifier =
                if (exists boxingConversion)
                    then DartSimpleIdentifier(
                            ctx.naming.createReplacementName(
                                variableDeclaration))
                else if (exists expression)
                    then DartSimpleIdentifier(
                            ctx.naming.getName(
                                variableDeclaration))
                else null;

        "The Ceylon source code for the condition"
        value errorMessage =
                ctx.tokens[conditionInfo.token.tokenIndex..
                       conditionInfo.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        value statements = LinkedList<DartStatement>();

        // determine what to check
        DartIdentifier dartIdentifierToCheck;
        if (exists expression) {
            // check type of an expression
            assert (exists dartIdentifier);

            statements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = "var";
                        type = null;
                        [DartVariableDeclaration {
                            name = dartIdentifier;
                            initializer = ctx.withLhsType(noType, ()
                                // (not boxing)
                                =>  expression.transform(expressionTransformer));
                        }];
                    };
                };
            };
            dartIdentifierToCheck = dartIdentifier;
        }
        else {
            // check type of the original variable
            assert(exists originalDeclaration = variableDeclaration.originalDeclaration);
            dartIdentifierToCheck = DartSimpleIdentifier(
                    ctx.naming.getName(originalDeclaration));
        }

        // check the type
        // if (x is !y) then throw new AssertionError(...)
        statements.add {
            DartIfStatement {
                DartIsExpression {
                    dartIdentifierToCheck;
                    // TODO actual type!
                    ctx.naming.dartObject;
                    notOperator = !that.negated;
                };
                DartExpressionStatement {
                    DartThrowExpression {
                        DartInstanceCreationExpression {
                            const = false;
                            DartConstructorName {
                                DartTypeName {
                                    DartPrefixedIdentifier {
                                        DartSimpleIdentifier("$ceylon$language");
                                        DartSimpleIdentifier(ctx.naming.getName(
                                            ctx.typeFactory.assertionErrorDeclaration));
                                    };
                                };
                            };
                            DartArgumentList {
                                [DartSimpleStringLiteral {
                                    "Violated: ``errorMessage``";
                                }];
                            };
                        };
                    };
                };
            };
        };

        // define an unboxed replacement variable
        if (exists boxingConversion) {
            assert (exists dartIdentifier);
            assert (exists originalDeclaration = variableDeclaration.originalDeclaration);

            statements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = "var";
                        type = null;
                        [DartVariableDeclaration {
                            dartIdentifier;
                            DartSimpleIdentifier {
                                ctx.naming.getName(originalDeclaration);
                            };
                        }];
                    };
                };
            };
        }

        assert(nonempty result = statements.sequence());
        return result;
    }
}
