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
    InterfaceDefinition,
    TypeAliasDefinition,
    Node,
    WideningTransformer,
    Break,
    Continue,
    LazySpecifier,
    Specifier,
    ValueGetterDefinition,
    ExistsCondition,
    NonemptyCondition
}
import ceylon.collection {
    LinkedList
}
import ceylon.language.meta {
    type
}

import com.redhat.ceylon.model.typechecker.model {
    ValueModel=Value
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
    DartStatement,
    DartContinueStatement,
    DartNullLiteral,
    DartExpression
}
import com.vasileff.ceylon.dart.nodeinfo {
    NodeInfo,
    ValueSpecificationInfo,
    UnspecifiedVariableInfo,
    ValueDeclarationInfo,
    IsConditionInfo,
    ForFailInfo,
    ElseClauseInfo
}

import org.antlr.runtime {
    Token
}

shared
class StatementTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<[DartStatement*]> {

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

    DartStatement toSingleStatementOrBlock([DartStatement+] statements)
        =>  if (statements.size > 1)
            then DartBlock(statements)
            else statements.first;

    shared actual
    [DartStatement*] transformIfElse(IfElse that) {
        if (that.ifClause.conditions.conditions.every((c) => c is BooleanCondition)) {
            // simple case, no variable declarations
            return
            [DartIfStatement {
                generateBooleanDartCondition(that.ifClause.conditions);
                transformBlock(that.ifClause.block).first;
                if (exists c = that.elseClause?.child,
                    nonempty s = c.transform(this))
                then toSingleStatementOrBlock(s)
                else null;
            }];
        }

        // Idea is:
        //  1. temp boolean to track need to execute "else" block
        //  2. nested if's, one for each condition
        //  3. execute then block in innermost if (after setting temp boolean to 'false'
        //  4. after unwinding all if's, if there's an else, wrap it in an 'if (temp)'

        // TODO don't use a doElseVariable if there is only one condition
        value doElseVariable =  that.elseClause exists then
                DartSimpleIdentifier(dartTypes.createTempNameCustom("doElse"));

        // Narrowed variable for else block, if any
        DartStatement? elseReplacementVariable;
        if (exists elseClause = that.elseClause,
            exists variableDeclaration = ElseClauseInfo(elseClause)
                        .variableDeclarationModel) {

            // TODO consolidate w/same code in generateIsConditionExpression
            assert(is ValueModel originalDeclaration =
                    variableDeclaration.originalDeclaration);

            // erasure to native may have changed
            // erasure to object may have changed
            // type may have narrowed
            value dartTypeChanged =
                dartTypes.dartTypeModelForDeclaration(originalDeclaration) !=
                dartTypes.dartTypeModelForDeclaration(variableDeclaration);

            elseReplacementVariable = dartTypeChanged then
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    keyword = null;
                    dartTypes.dartTypeNameForDeclaration {
                        that;
                        variableDeclaration;
                    };
                    [DartVariableDeclaration {
                        DartSimpleIdentifier {
                            dartTypes.createReplacementName{
                                variableDeclaration;
                            };
                        };
                        withLhs {
                            null;
                            variableDeclaration;
                            () => withBoxing {
                                that;
                                originalDeclaration.type; // good enough???
                                // FIXME possibly false assumption that refined
                                // will be null for non-initial declarations
                                // (is refinedDeclaration propagated?)
                                originalDeclaration;
                                DartSimpleIdentifier {
                                    dartTypes.getName(originalDeclaration);
                                };
                            };
                        };
                    }];
                };
            };
        }
        else {
            elseReplacementVariable = null;
        }

        value statements = LinkedList<DartStatement?>();

        // declare doElse variable, if any
        if (exists doElseVariable) {
            statements.add {
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartBool;
                        [DartVariableDeclaration {
                            doElseVariable;
                            DartBooleanLiteral(true);
                        }];
                    };
                };
            };
        }

        alias ConditionCodeTuple =>
                [DartVariableDeclarationStatement?,
                 DartVariableDeclarationStatement?,
                 DartExpression,
                 DartStatement?];

        "Tuple containing
            - replacementDeclaration
            - tempDefinition
            - conditionExpression
            - replacementDefinition]"
        ConditionCodeTuple conditionCodeTuple(Condition condition) {
            switch (condition)
            case (is BooleanCondition) {
                value conditionExpression=withLhsNative {
                    ceylonTypes.booleanType;
                    () => condition.transform(expressionTransformer);
                };
                return [null, null, conditionExpression, null];
            }
            case (is IsCondition) {
                return generateIsConditionExpression(condition);
            }
            case (is ExistsCondition) {
                throw CompilerBug(condition,
                    "ExistsConditions not yet supported in if statements");
            }
            case (is NonemptyCondition) {
                throw CompilerBug(condition,
                    "NonemptyConditions not yet supported in if statements");
            }
        }

        "Recursive function to generate nested if statements, one if per condition."
        [DartStatement+] generateIf(
                [Condition+] conditions,
                Boolean outermost = false) {

            value [replacementDeclaration, tempDefinition,
                    conditionExpression, replacementDefinition]
                    = conditionCodeTuple(conditions.first);

            value result = [
                tempDefinition,
                DartIfStatement {
                    conditionExpression;
                    DartBlock {
                        [
                            // declare and define new variables, if any
                            replacementDeclaration,
                            replacementDefinition,

                            *(if (nonempty rest = conditions.rest) then
                                // nest if statement for next condition, if any
                                generateIf(rest)
                            else [
                                // last condition; output if block statements
                                if (exists doElseVariable) then
                                    DartExpressionStatement {
                                        DartAssignmentExpression {
                                            doElseVariable;
                                            DartAssignmentOperator.equal;
                                            DartBooleanLiteral(false);
                                        };
                                    }
                                else null,
                                *transformBlock {
                                    that.ifClause.block;
                                }.first.statements
                            ])
                         ].coalesced.sequence();
                    };
                    // TODO if outermost, and there is only one condition, optimize away
                    //      the doElseVariable and put "else" block here.
                }
            ].coalesced.sequence();
            assert(nonempty result);

            // wrap in a block to scope temp variable, if exists
            return if (exists tempDefinition)
                then [DartBlock(result)]
                else result;
        }

        statements.addAll(generateIf(that.ifClause.conditions.conditions));

        if (exists doElseVariable) {
            assert (exists elseChild = that.elseClause?.child);
            statements.add {
                DartIfStatement {
                    doElseVariable;
                    DartBlock {
                        [elseReplacementVariable,
                         *( switch (elseChild)
                            case (is Block)
                                transformBlock(elseChild).first.statements
                            case (is IfElse)
                                elseChild.transform(this))
                        ].coalesced.sequence();
                    };
                };
            };
        }

        value result = statements.coalesced.sequence();

        // wrap in a block to scope doElseVariable, if exists
        return if (exists doElseVariable)
            then [DartBlock(result)]
            else result;
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
    [DartVariableDeclarationStatement|DartFunctionDeclarationStatement]
    transformValueDefinition(ValueDefinition that)
        =>  switch(specifier = that.definition)
            case (is Specifier)
                [DartVariableDeclarationStatement(generateForValueDefinition(that))]
            case (is LazySpecifier)
                [DartFunctionDeclarationStatement(
                    generateForValueDefinitionGetter(that))];

    shared actual
    [DartFunctionDeclarationStatement] transformValueGetterDefinition
            (ValueGetterDefinition that)
        =>  [DartFunctionDeclarationStatement(generateForValueDefinitionGetter(that))];

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
    [DartStatement*] transformBreak(Break that)
        =>  if (exists var = ctx.doFailVariableTop) then
                [DartExpressionStatement {
                    DartAssignmentExpression {
                        var;
                        DartAssignmentOperator.equal;
                        DartBooleanLiteral(false);
                    };
                },
                DartBreakStatement()]
            else
                [DartBreakStatement()];

    shared actual
    [DartContinueStatement] transformContinue(Continue that)
        =>  [DartContinueStatement()];

    shared actual
    DartStatement[] transformForFail(ForFail that) {
        value pattern = that.forClause.iterator.pattern;

        if (!pattern is VariablePattern) {
            throw CompilerBug(that,
                "For pattern type not yet supported: " + type(pattern).string);
        }
        assert (is VariablePattern pattern);

        value info = ForFailInfo(that);
        value variableInfo = UnspecifiedVariableInfo(pattern.variable);
        value variableDeclaration = variableInfo.declarationModel;

        // Only track doFail if there is a fail clause and a break statement
        value doFailVariable = that.failClause exists && info.exits
                then DartSimpleIdentifier(dartTypes.createTempNameCustom("doFail"));

        // Don't erase to native for the loop variable; avoid premature unboxing
        ctx.disableErasureToNative.add(variableDeclaration);

        // The iterator
        value dartIteratorVariable = DartSimpleIdentifier {
            dartTypes.createTempNameCustom("iterator");
        };

        // Temp variable for result of `next()`
        value dartLoopVariable = DartSimpleIdentifier {
            dartTypes.createTempNameCustom("element");
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
        value iteratorDenotableType = ceylonTypes.denotableType {
            iteratorType;
            ceylonTypes.iteratorDeclaration;
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
            // Declare the forFail boolean
            [if (exists doFailVariable)
            then DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartBool;
                        [DartVariableDeclaration {
                            doFailVariable;
                            DartBooleanLiteral(true);
                        }];
                    };
                }
            else null,
            // Declare the loop variable
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartTypeName {
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
                    dartTypes.dartTypeName {
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
                    dartTypes.dartTypeName {
                        that;
                        ceylonTypes.finishedType;
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
                            dartTypes.dartTypeNameForDeclaration {
                                that;
                                variableDeclaration;
                            };
                            [DartVariableDeclaration {
                                DartSimpleIdentifier {
                                    dartTypes.getName(variableDeclaration);
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
                    *withDoFailVariable {
                        doFailVariable;
                        () => expand(that.forClause.block.transformChildren(
                            statementTransformer));
                    }];
                };
            },
            // Conditional Fail Block
            if (exists doFailVariable, exists failClause = that.failClause) then
                DartIfStatement {
                    doFailVariable;
                    transformBlock(failClause.block).first;
                }
            // Unconditional Fail Block
            else if (exists failClause = that.failClause) then
                transformBlock(failClause.block).first
            else null
            ].coalesced.sequence();
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
    [] transformTypeAliasDefinition(TypeAliasDefinition that)
        =>  [];

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
            generateForValueDeclaration(that);
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
                            dartTypes.dartTypeName {
                                that;
                                ceylonTypes.assertionErrorType;
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
                                dartTypes.dartTypeName {
                                    that;
                                    ceylonTypes.assertionErrorType;
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

    shared actual default
    [] transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node: '``className(that)``'");
    }
}
