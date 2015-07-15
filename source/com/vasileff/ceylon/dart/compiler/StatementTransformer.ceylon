import ceylon.ast.core {
    FunctionDefinition,
    Block,
    InvocationStatement,
    ValueDefinition,
    Return,
    FunctionShortcutDefinition,
    Assertion,
    IsCondition,
    ValueSpecification,
    ValueDeclaration,
    IfElse
}
import ceylon.collection {
    LinkedList
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionOrValueModel=FunctionOrValue
}

import org.antlr.runtime {
    Token
}

class StatementTransformer
        (CompilationContext ctx)
        extends BaseTransformer<[DartStatement*]>(ctx) {

    "Parents must set `returnTypeTop`"
    see(`function generateFunctionExpression`)
    shared actual
    [DartReturnStatement] transformReturn(Return that)
        =>  if (exists result = that.result) then
                [DartReturnStatement {
                    withLhsType {
                        ctx.assertedReturnFormalActualTop;
                        () => result.transform(expressionTransformer);
                    };
                }]
            else
                [DartReturnStatement()];

    shared actual
    [DartIfStatement] transformIfElse(IfElse that) {
        // workaround https://github.com/ceylon/ceylon-compiler/issues/2219
        value elseStatement =
                    (switch (c = that.elseClause?.child)
                    case (is Block) transformBlock(c).first
                    case (is IfElse) transformIfElse(c).first
                    case (is Null) null);

        return [DartIfStatement {
            generateBooleanDartCondition(that.ifClause.conditions);
            statementTransformer.transformBlock(that.ifClause.block).first;
            elseStatement;
        }];
    }

    shared actual
    [DartStatement] transformInvocationStatement(InvocationStatement that)
        =>  [DartExpressionStatement(withLhsNoType(()
            =>  expressionTransformer.transformInvocation(that.expression)))];

    shared actual
    [DartVariableDeclarationStatement] transformValueDefinition
            (ValueDefinition that)
        =>  [DartVariableDeclarationStatement(miscTransformer
                .transformValueDefinition(that))];

    shared actual
    [DartStatement] transformValueSpecification(ValueSpecification that)
        =>  [DartExpressionStatement {
                expression = generateAssignmentExpression {
                    that = that;
                    targetDeclaration = ValueSpecificationInfo(that).declaration;
                    rhsExpression = that.specifier.expression;
                };
            }];

    shared actual
    [DartFunctionDeclarationStatement] transformFunctionDefinition
            (FunctionDefinition that)
        =>  [DartFunctionDeclarationStatement(
            generateFunctionDefinition(that))];

    shared actual
    [DartFunctionDeclarationStatement] transformFunctionShortcutDefinition
            (FunctionShortcutDefinition that)
        =>  [DartFunctionDeclarationStatement(
            generateFunctionDefinition(that))];

    shared actual
    [DartBlock] transformBlock(Block that)
        // Dart block's only have Statements. Declarations are wrapped:
        //      FunctionDeclarationStatement(FunctionDeclaration)
        //      VariableDeclarationStatement(VariableDeclarationList)
        //
        // TODO classes and interfaces need jump back to toplevel w/captures
        =>  [DartBlock([*expand(that.transformChildren(this))])];

    shared actual
    [DartStatement*] transformAssertion(Assertion that) {
        // children are 'Annotations' and 'Conditions'
        // 'Conditions' has 'Condition's.

        // TODO Annotations
        // TODO Don't visit conditions individually?
        // annotations, especially 'doc', need to apply to
        // each condition. Any other annotations matter?

        // won't be empty
        return [*that.conditions.children.flatMap((c)
            =>  c.transform(this))];
    }

    shared actual
    [DartStatement*] transformValueDeclaration(ValueDeclaration that) {
        value info = ValueDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            // ignore; must be a declaration for
            // a parameter reference
            return [];
        }
        return super.transformValueDeclaration(that);
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
        // TODO consider erased types, like `Integer? i = 1; assert (is Integer i);`

        //value typeInfo = TypeInfo(that.variable.type);
        value info = IsConditionInfo(that);

        //"The type we are testing for"
        //value isType = typeInfo.typeModel;

        "The declaration model for the new variable"
        value variableDeclaration = info.variableDeclarationModel;

        //"The type of the new variable (intersection of isType and expression/old type)"
        //value variableType = variableDeclaration.type;

        "The expression node if defining a new variable"
        value expression = that.variable.specifier?.expression;

        "The Ceylon source code for the condition"
        value errorMessage =
                ctx.tokens[info.token.tokenIndex..
                           info.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        value statements = LinkedList<DartStatement>();

        // new variable, or narrowing existing?
        if (exists expression) {
            // 1. declare the new variable
            // 2. evaluate expression to temp variable of type of expression
            // 3. check type of the temp variable
            // 4. set the new variable, with appropriate boxing
            // (perform 2-4 in a new block to scope the temp var)

            value variableIdentifier = DartSimpleIdentifier(
                    ctx.dartTypes.getName(variableDeclaration));
            value expressionType = ExpressionInfo(expression).typeModel;

            // 1. declare the new variable
            statements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        keyword = null;
                        ctx.dartTypes.dartTypeNameForDeclaration {
                            that;
                            variableDeclaration;
                        };
                        [DartVariableDeclaration {
                            variableIdentifier;
                        }];
                    };
                };
            };

            value tmpVariable = DartSimpleIdentifier(
                    ctx.dartTypes.createTempName(variableDeclaration));

            statements.add {
                DartBlock {[
                    // 2. evaluate to tmp variable
                    DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            ctx.dartTypes.dartTypeName(that, expressionType, true);
                            [DartVariableDeclaration {
                                tmpVariable;
                                // possibly erase to a native type!
                                withLhsNative {
                                    expressionType;
                                    () => expression.transform(expressionTransformer);
                                };
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
                            withLhs {
                                variableDeclaration;
                                () => withBoxing {
                                    that;
                                    // as noted above, tmpVariable may be erased. Maybe
                                    // when narrowing optionals like String?.
                                    expressionType;
                                    null;
                                    tmpVariable;
                                };
                            };
                        };
                    }];
                };
            };
        }
        else {
            // check type of the original variable,
            // possibly declare new variable with a narrowed type
            assert(is FunctionOrValueModel originalDeclaration =
                    variableDeclaration.originalDeclaration);

            value originalDartVariable = DartSimpleIdentifier(
                    ctx.dartTypes.getName(originalDeclaration));

            statements.add(generateIsAssertion(
                    originalDartVariable, that.negated, errorMessage));

            // erasure to native may have changed
            // erasure to object may have changed
            // type may have narrowed
            value dartTypeChanged =
                ctx.dartTypes.dartTypeModelForDeclaration(originalDeclaration) !=
                ctx.dartTypes.dartTypeModelForDeclaration(variableDeclaration);

            if (dartTypeChanged) {
                value replacementVar = DartSimpleIdentifier(
                        ctx.dartTypes.createReplacementName(variableDeclaration));

                statements.add {
                    DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            keyword = null;
                            ctx.dartTypes.dartTypeNameForDeclaration {
                                that;
                                variableDeclaration;
                            };
                            [DartVariableDeclaration {
                                replacementVar;
                                withLhs {
                                    variableDeclaration;
                                    () => withBoxing {
                                        that;
                                        originalDeclaration.type; // good enough???
                                        // FIXME possibly false assumption that refined
                                        // will be null for non-initial declarations
                                        // (is refinedDeclaration propagated?)
                                        originalDeclaration;
                                        DartSimpleIdentifier {
                                            ctx.dartTypes.getName(originalDeclaration);
                                        };
                                    };
                                };
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
                    ctx.dartTypes.dartObject;
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
                                        DartSimpleIdentifier(ctx.dartTypes.getName(
                                            ctx.ceylonTypes.assertionErrorDeclaration));
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

    suppressWarnings("unusedDeclaration")
    DartStatement? singleStatementOrNull([DartStatement*] statements) {
        if (nonempty statements) {
            if (statements.size > 1) {
                return DartBlock(statements);
            }
            else {
                return statements.first;
            }
        }
        return null;
    }
}
