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
                    returnType =
                        // TODO seems like a hacky way to create a void keyword
                        if (functionModel.declaredVoid)
                        then DartTypeName(DartSimpleIdentifier("void"))
                        else returnType;
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
                    returnType =
                        // TODO seems like a hacky way to create a void keyword
                        if (functionModel.declaredVoid)
                        then DartTypeName(DartSimpleIdentifier("void"))
                        else returnType;
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

        "The Ceylon source code for the condition"
        value errorMessage =
                ctx.tokens[conditionInfo.token.tokenIndex..
                       conditionInfo.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        value statements = LinkedList<DartStatement>();

        // new variable, or narrowing existing?
        if (exists expression) {
            // 1. declare new variable
            // 2. evaluate expression to temp variable of type of expression
            // 3. check type of the temp variable
            // 4. set new variable, with appropriate boxing
            // (perform 2-4 in a new block to scope the temp var)

            value variableIdentifier = DartSimpleIdentifier(
                    ctx.naming.getName(variableDeclaration));
            value expressionType = ExpressionInfo(expression).typeModel;

            // 1. declare the new variable
            statements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = null;
                        ctx.naming.dartTypeName(
                                variableDeclaration,
                                variableType);
                        [DartVariableDeclaration {
                            variableIdentifier;
                        }];
                    };
                };
            };

            value tmpVariable = DartSimpleIdentifier(
                    ctx.naming.createTempName(variableDeclaration));

            statements.add {
                DartBlock {[
                    // 2. evaluate to tmp variable
                    DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            ctx.naming.dartTypeName(
                                    variableDeclaration,
                                    expressionType);
                            [DartVariableDeclaration {
                                tmpVariable;
                                ctx.withLhsType(expressionType, ()
                                    =>  expression.transform(
                                            expressionTransformer));
                            }];
                        };
                    },

                    // 3. perform is check on tmp variable
                    generateIsAssertion(tmpVariable, that.negated, errorMessage),

                    // 4. set variable
                    DartExpressionStatement {
                        DartAssignmentExpression {
                            variableIdentifier;
                            DartAssignmentOperator.equal;
                            ctx.withLhsType(variableType, ()
                                =>  withBoxing(expressionType, tmpVariable));
                        };
                    }];
                };
            };
        }
        else {
            // check type of the original variable,
            // possibly declare new variable narrowed type
            assert(exists originalDeclaration = variableDeclaration.originalDeclaration);
            value originalDartVariable =
                    DartSimpleIdentifier(ctx.naming.getName(originalDeclaration));

            statements.add(generateIsAssertion(
                    originalDartVariable,
                    that.negated, errorMessage));

            // TODO should base this on the *dart* static type instead
            value typeChanged = !ctx.typeFactory.equalDefiniteTypes(
                    variableType, originalDeclaration.type);

            if (typeChanged) {
                value replacementVar = DartSimpleIdentifier(
                        ctx.naming.createReplacementName(variableDeclaration));

                statements.add {
                    DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            ctx.naming.dartTypeName(
                                    variableDeclaration,
                                    variableDeclaration.type);
                            [DartVariableDeclaration {
                                replacementVar;
                                ctx.withLhsType(variableType, ()
                                    =>  withBoxing(originalDeclaration.type,
                                                   originalDartVariable));
                            }];
                        };
                    };
                };
            }
        }

        assert(nonempty result = statements.sequence());
        return result;
    }

    DartStatement generateIsAssertion(
            DartExpression expressionToCheck,
            Boolean not,
            String errorMessage)
        // if (x is !y) then throw new AssertionError(...)
        =>  DartIfStatement {
                DartIsExpression {
                    expressionToCheck;
                    // TODO actual type!
                    ctx.naming.dartObject;
                    notOperator = !not;
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
                                            ctx.typeFactory
                                                .assertionErrorDeclaration));
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
}
