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
    IfElse,
    ForFail,
    VariablePattern,
    PrefixPostfixStatement,
    AssignmentStatement,
    While,
    Condition,
    BooleanCondition,
    ExistsOrNonemptyCondition,
    ClassDefinition,
    InterfaceDefinition
}
import ceylon.language.meta {
    type
}

import com.vasileff.ceylon.dart.ast {
    DartArgumentList,
    DartReturnStatement,
    DartVariableDeclarationStatement,
    DartSimpleIdentifier,
    DartWhileStatement,
    DartIfStatement,
    DartIsExpression,
    DartAssignmentExpression,
    DartSimpleStringLiteral,
    DartBreakStatement,
    DartAssignmentOperator,
    DartThrowExpression,
    DartVariableDeclaration,
    DartInstanceCreationExpression,
    DartConstructorName,
    DartBlock,
    DartBooleanLiteral,
    DartFunctionDeclarationStatement,
    DartExpressionStatement,
    DartVariableDeclarationList,
    DartPrefixExpression,
    DartStatement
}
import com.vasileff.ceylon.dart.nodeinfo {
    NodeInfo,
    ValueSpecificationInfo,
    UnspecifiedVariableInfo,
    ValueDeclarationInfo,
    IsConditionInfo
}

import org.antlr.runtime {
    Token
}

shared
class StatementTransformer(CompilationContext ctx)
        extends BaseTransformer<[DartStatement*]>(ctx) {

    shared actual [DartStatement] transformAssignmentStatement(AssignmentStatement that)
        =>  [DartExpressionStatement {
                withLhsNoType(() => that.expression.transform(expressionTransformer));
            }];

    "Parents must set `returnTypeTop`"
    see(`function generateFunctionExpression`)
    shared actual
    [DartReturnStatement] transformReturn(Return that)
        =>  if (exists result = that.result) then
                [DartReturnStatement {
                    withLhs {
                        null;
                        ctx.assertedReturnDeclaration;
                        () => result.transform(expressionTransformer);
                    };
                }]
            else
                [DartReturnStatement()];

    shared actual
    [DartIfStatement] transformIfElse(IfElse that) {
        return
        [DartIfStatement {
            generateBooleanDartCondition(that.ifClause.conditions);
            statementTransformer.transformBlock(that.ifClause.block).first;
            switch (c = that.elseClause?.child)
                    case (is Block) transformBlock(c).first
                    case (is IfElse) transformIfElse(c).first
                    case (is Null) null;
        }];
    }

    shared actual
    [DartWhileStatement] transformWhile(While that) {
        if (that.conditions.conditions.every((c) => c is BooleanCondition)) {
            // simple case, no variable declarations
            return
            [DartWhileStatement {
                generateBooleanDartCondition(that.conditions);
                statementTransformer.transformBlock(that.block).first;
            }];
        }

        value tests = that.conditions.conditions.flatMap((condition) {
            switch (condition)
            case (is BooleanCondition) {
                return
                [DartIfStatement {
                    generateBooleanConditionExpression(condition, true);
                    DartBreakStatement();
                }];
            }
            case (is IsCondition) {
                value [replacementDeclaration, tempDefinition,
                            conditionExpression, replacementDefinition]
                        = generateIsConditionExpression(condition, true);
                return
                {replacementDeclaration, tempDefinition,
                DartIfStatement {
                    conditionExpression;
                    DartBreakStatement();
                },
                replacementDefinition
                }.coalesced;
            }
            case (is ExistsOrNonemptyCondition) {
                throw CompilerBug(that,
                    "ExistsOrNonemptyCondition in while not yet supported.");
            }
        });

        return
        [DartWhileStatement {
            DartBooleanLiteral(true);
            DartBlock {
                tests.chain {
                    statementTransformer.transformBlock(that.block).first.statements;
                }.sequence();
            };
        }];
    }

    shared actual
    [DartStatement] transformInvocationStatement(InvocationStatement that)
        =>  [DartExpressionStatement(withLhsNoType(()
            =>  expressionTransformer.transformInvocation(that.expression)))];

    shared actual
    [DartVariableDeclarationStatement] transformValueDefinition(ValueDefinition that)
        =>  [DartVariableDeclarationStatement(miscTransformer
                .transformValueDefinition(that))];

    shared actual
    [DartStatement] transformValueSpecification(ValueSpecification that)
        =>  [DartExpressionStatement {
                withLhsNoType {
                    () => generateAssignmentExpression {
                        that;
                        ValueSpecificationInfo(that).declaration;
                        () => that.specifier.expression.transform(expressionTransformer);
                    };
                };
            }];

    shared actual
    DartStatement[] transformPrefixPostfixStatement(PrefixPostfixStatement that)
        =>  [DartExpressionStatement {
                withLhsNoType(() => that.expression.transform(expressionTransformer));
            }];

    shared actual
    DartStatement[] transformForFail(ForFail that) {
        value pattern = that.forClause.iterator.pattern;
        if (that.failClause exists) {
            throw CompilerBug(that, "FailClause not yet supported");
        }
        if (!pattern is VariablePattern) {
            throw CompilerBug(that,
                "For pattern type not yet supported: " + type(pattern).string);
        }
        assert (is VariablePattern pattern);

        value variableInfo = UnspecifiedVariableInfo(pattern.variable);

        value variableDeclaration = variableInfo.declarationModel;

        // Don't erase to native for the loop variable; avoid premature unboxing
        ctx.disableErasureToNative.add(variableDeclaration);

        // The iterator
        value dartIteratorVariable = DartSimpleIdentifier {
            ctx.dartTypes.createTempNameCustom("iterator");
        };

        // Temp variable for result of `next()`
        value dartLoopVariable = DartSimpleIdentifier {
            ctx.dartTypes.createTempNameCustom("element");
        };

        // Discover the type of the iterator and obtain a function that
        // will create an expression that yields the iterator
        value [iteratorType, _, iteratorGenerator]
            =   generateInvocationDetailsFromName {
                    that;
                    that.forClause.iterator.iterated;
                    "iterator";
                    [];
                };

        // Simplify iteratorType to a denotable supertype in case it
        // is a union, intersection, or other non-denotable
        // Note: we don't have to do this; we could just use `iteratorType`.
        // But 1) we can, and 2) on occasion it removes a cast from the while
        // loop expession, which of course doesn't matter.
        value iteratorDenotableType = ctx.ceylonTypes.denotableType {
            iteratorType;
            ctx.ceylonTypes.iteratorDeclaration;
        };

        // Discover the type of the loop variable and obtain a function that
        // will create an expression that calls `next` on the iterator
        value [loopVariableType, __, nextInvocationGenerator]
            =   generateInvocationDetailsSynthetic {
                    that;
                    iteratorDenotableType;
                    // NonNative since that's how we created
                    // `iteratorDenotable` (`withLhsNonNative`)
                    () => withBoxingNonNative {
                        that;
                        iteratorDenotableType;
                        dartIteratorVariable;
                    };
                    "next";
                    [];
                };

        return
        [DartBlock {
            // Declare the loop variable
            [DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    ctx.dartTypes.dartTypeName {
                        that;
                        loopVariableType;
                        false; false;
                    };
                    [DartVariableDeclaration {
                        dartLoopVariable;
                        null;
                    }];
                };
            },
            // Declare and create the iterator
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    ctx.dartTypes.dartTypeName {
                        that;
                        iteratorDenotableType;
                        eraseToNative = false;
                        eraseToObject = false;
                    };
                    [DartVariableDeclaration {
                        dartIteratorVariable;
                        withLhsNonNative {
                            iteratorDenotableType;
                            iteratorGenerator;
                        };
                    }];
                };
            },
            DartWhileStatement {
                // Invoke next() and test for Finished
                DartIsExpression {
                    DartAssignmentExpression {
                        dartLoopVariable;
                        DartAssignmentOperator.equal;
                        withLhs {
                            loopVariableType;
                            null;
                            nextInvocationGenerator;
                        };
                    };
                    ctx.dartTypes.dartTypeName {
                        that;
                        ctx.ceylonTypes.finishedType;
                        false; false;
                    };
                    true;
                };
                // The forClause block
                DartBlock {
                    // Define the "real" loop variable
                    [DartVariableDeclarationStatement {
                        DartVariableDeclarationList {
                            null;
                            ctx.dartTypes.dartTypeNameForDeclaration {
                                that;
                                variableDeclaration;
                            };
                            [DartVariableDeclaration {
                                DartSimpleIdentifier {
                                    ctx.dartTypes.getName(variableDeclaration);
                                };
                                withLhs {
                                    variableInfo.declarationModel.type;
                                    variableDeclaration;
                                    () => withBoxing {
                                        that;
                                        loopVariableType;
                                        null;
                                        dartLoopVariable;
                                    };
                                };
                            }];
                        };
                    },
                    // Statements
                    *expand(that.forClause.block.transformChildren(
                            statementTransformer))];
                };
            }];
        }];
    }

    shared actual DartStatement[] transformClassDefinition(ClassDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }
        return super.transformClassDefinition(that);
    }

    shared actual
    DartStatement[] transformInterfaceDefinition(InterfaceDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }
        return super.transformInterfaceDefinition(that);
    }

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
    [DartStatement*] transformValueDeclaration(ValueDeclaration that) {
        value info = ValueDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            // ignore; must be a declaration for
            // a parameter reference
            return [];
        }

        // Seems like this should be fine... Dart supports forward declarations
        return
        [DartVariableDeclarationStatement {
            miscTransformer.transformValueDeclaration(that);
        }];
    }

    shared actual
    [DartStatement*] transformAssertion(Assertion that) {
        // children are 'Annotations' and 'Conditions'
        // 'Conditions' has 'Condition's.

        // TODO Annotations
        // TODO Don't visit conditions individually?
        // annotations, especially 'doc', need to apply to
        // each condition. Any other annotations matter?

        // won't be empty
        return [*that.conditions.conditions.flatMap(generateConditionAssertion)];
    }

    [DartStatement+] generateConditionAssertion(Condition that) {
        "Only IsConditions supported"
        assert (is IsCondition|BooleanCondition that);

        return switch (that)
            case (is IsCondition) generateIsConditionAssertion(that)
            case (is BooleanCondition) [generateBooleanConditionAssertion(that)];
    }

    DartStatement generateBooleanConditionAssertion(BooleanCondition that) {
        value info = NodeInfo(that);

        "The Ceylon source code for the condition"
        value errorMessage =
                ctx.tokens[info.token.tokenIndex..
                           info.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        // if (!condition) then throw new AssertionError(...)
        return
        DartIfStatement {
            DartPrefixExpression {
                "!";
                generateBooleanConditionExpression(that);
            };
            DartExpressionStatement {
                DartThrowExpression {
                    DartInstanceCreationExpression {
                        const = false;
                        DartConstructorName {
                            ctx.dartTypes.dartTypeName {
                                that;
                                ctx.ceylonTypes.assertionErrorType;
                                false; false;
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

    [DartStatement+] generateIsConditionAssertion(IsCondition that) {
        value info = IsConditionInfo(that);

        "The Ceylon source code for the condition"
        value errorMessage =
                ctx.tokens[info.token.tokenIndex..
                           info.endToken.tokenIndex]
                .map(Token.text)
                .reduce(plus) else "";

        value [replacementDeclaration, tempDefinition,
                conditionExpression, replacementDefinition]
            = generateIsConditionExpression(that, true);

        variable [DartStatement?*] statements = [
            replacementDeclaration,
            tempDefinition,
            // if (!(x is T)) then throw new AssertionError(...)
            DartIfStatement {
                conditionExpression; // negated above
                DartExpressionStatement {
                    DartThrowExpression {
                        DartInstanceCreationExpression {
                            const = false;
                            DartConstructorName {
                                ctx.dartTypes.dartTypeName {
                                    that;
                                    ctx.ceylonTypes.assertionErrorType;
                                    false; false;
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
            },
            replacementDefinition
        ];

        if (tempDefinition exists) {
            // scope the temp variable in a block
            statements = [
                replacementDeclaration,
                DartBlock(statements[1:3].coalesced.sequence())];
        }

        assert (nonempty result = statements.coalesced.sequence());
        return result;
    }
}
