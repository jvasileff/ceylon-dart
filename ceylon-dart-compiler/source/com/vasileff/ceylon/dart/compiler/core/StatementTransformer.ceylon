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
    PrefixPostfixStatement,
    AssignmentStatement,
    While,
    Condition,
    BooleanCondition,
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
    ValueSetterDefinition,
    ObjectDefinition,
    SwitchCaseElse,
    CaseClause,
    IsCase,
    MatchCase,
    ExistsOrNonemptyCondition,
    Throw,
    ElseClause,
    FunctionDeclaration,
    DynamicBlock,
    DynamicInterfaceDefinition,
    DynamicModifier,
    DynamicValue,
    Destructure,
    TryCatchFinally,
    Type,
    LazySpecification
}
import ceylon.collection {
    LinkedList
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue
}
import com.vasileff.ceylon.dart.compiler.dartast {
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
    DartTryStatement,
    DartCatchClause,
    DartRethrowExpression,
    createIfStatement,
    DartFunctionDeclaration
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo,
    ValueSpecificationInfo,
    ValueDeclarationInfo,
    ForFailInfo,
    ElseClauseInfo,
    TypeInfo,
    IsCaseInfo,
    FunctionDeclarationInfo,
    UnspecifiedVariableInfo,
    expressionInfo,
    nodeInfo,
    LazySpecificationInfo,
    parameterInfo,
    ParametersInfo,
    ParameterInfo
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
                    switch (returnType = ctx.assertedReturnDeclaration)
                    case (is TypeDetails)
                        withLhs {
                            returnType;
                            null;
                            () => result.transform(expressionTransformer);
                        }
                    case (is FunctionOrValueModel)
                        withLhs {
                            null;
                            returnType;
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
    DartStatement[] transformSwitchCaseElse(SwitchCaseElse that) {
        value info
            =   nodeInfo(that);

        value [switchedType, switchedDeclaration, switchedVariable, variableDeclaration]
            =   generateForSwitchClause(that.clause);

        "Recursive function to generate an if statement for the switch clauses."
        DartStatement generateIf([CaseClause | ElseClause*] clauses) {
            switch (clause = clauses.first)
            case (is CaseClause) {
                switch (caseItem = clause.caseItem)
                case (is MatchCase) {
                    return
                    DartIfStatement {
                        generateMatchCondition {
                            info;
                            switchedType;
                            switchedVariable;
                            caseItem.expressions;
                        };
                        thenStatement = toSingleStatementOrBlock {
                            transformBlock(clause.block);
                        };
                        elseStatement = generateIf(clauses.rest);
                    };
                }
                case (is IsCase) {
                    value variableDeclaration
                        =   IsCaseInfo(caseItem).variableDeclarationModel;

                    "Narrowed variable for case block, if any."
                    value replacementVariable
                        =   if (exists variableDeclaration) then
                                generateReplacementVariableDefinition {
                                    info; variableDeclaration;
                                }
                            else
                                [];

                    return
                    DartIfStatement {
                        generateIsExpression {
                            dScope(caseItem);
                            switchedType;
                            switchedDeclaration;
                            switchedVariable;
                            TypeInfo(caseItem.type).typeModel;
                        };
                        thenStatement = DartBlock {
                            concatenate {
                                replacementVariable,
                                transformBlock(clause.block).first.statements
                            };
                        };
                        elseStatement = generateIf(clauses.rest);
                    };
                }
            }
            case (is ElseClause) {
                return generateElseClause(clause);
            }
            case (is Null) {
                return
                DartExpressionStatement {
                    DartThrowExpression {
                        DartInstanceCreationExpression {
                            const = false;
                            DartConstructorName {
                                dartTypes.dartTypeName {
                                    info;
                                    ceylonTypes.assertionErrorType;
                                    false; false;
                                };
                            };
                            DartArgumentList {
                                [DartSimpleStringLiteral {
                                    "Supposedly exhaustive switch was not exhaustive";
                                }];
                            };
                        };
                    };
                };
            }
        }

        value ifStatement = generateIf(that.cases.children);
        return [DartBlock([variableDeclaration, ifStatement])];
    }

    DartStatement generateElseClause(ElseClause that) {
        value info
            =   ElseClauseInfo(that);

        value variableDeclaration
            =   info.variableDeclarationModel;

        "Narrowed variable for else block, if any."
        value replacementVariable
            =   if (exists variableDeclaration) then
                    generateReplacementVariableDefinition {
                        info;
                        variableDeclaration;
                    }
                else
                    [];

        return switch (child = that.child)
            case (is IfElse)
                toSingleStatementOrBlock {
                    transformIfElse(child).prepend(replacementVariable);
                }
            case (is Block)
                DartBlock {
                    concatenate {
                        replacementVariable,
                        transformBlock(child).first.statements
                    };
                };
    }

    shared actual
    [DartStatement+] transformIfElse(IfElse that) {
        function assertBooleanCondition(Anything a) {
            assert (is BooleanCondition a);
            return a;
        }

        if (that.ifClause.conditions.conditions.every((c) => c is BooleanCondition)) {
            // simple case, no variable declarations
            return
            [DartIfStatement {
                generateBooleanDartCondition {
                    that.ifClause.conditions.conditions.map {
                        assertBooleanCondition;
                    };
                };
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

        value doElseVariable
            =   that.elseClause exists
                then DartSimpleIdentifier(dartTypes.createTempNameCustom("doElse"));

        value statements
            =   LinkedList<DartStatement?>();

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

        "Recursive function to generate nested if statements, one if per condition."
        [DartStatement+] generateIf([Condition+] conditions, Boolean outermost = false) {

            value [tempDefinition, conditionExpression, *replacements]
                =   generateConditionExpression(conditions.first);

            value result
                =   [tempDefinition,
                    DartIfStatement {
                        conditionExpression;
                        DartBlock {
                            concatenate {
                                // declare and define new variables, if any
                                replacements.map(VariableTriple.dartDeclaration),
                                replacements.flatMap(VariableTriple.dartAssignment),

                                // nest if statement for next condition, if any
                                if (nonempty rest = conditions.rest) then
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
                                ].coalesced
                            };
                        };
                        // TODO if outermost, and there is only one condition, optimize
                        //      awaythe doElseVariable and put "else" block here.
                    }].coalesced.sequence();

            assert(nonempty result);

            // wrap in a block to scope temp variable, if exists
            return if (exists tempDefinition)
                then [DartBlock(result)]
                else result;
        }

        statements.addAll(generateIf(that.ifClause.conditions.conditions));

        if (exists doElseVariable) {
            assert (exists elseChild = that.elseClause?.child);
            assert (exists elseClause = that.elseClause);
            statements.add {
                DartIfStatement {
                    doElseVariable;
                    generateElseClause(elseClause);
                };
            };
        }

        assert (nonempty result = statements.coalesced.sequence());

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
                generateBooleanDartCondition {
                    that.conditions.conditions.map {
                        (condition) {
                            "All conditions will be BooleanConditions per prior check"
                            assert (is BooleanCondition condition);
                            return condition;
                        };
                    };
                };
                statementTransformer.transformBlock(that.block).first;
            }];
        }

        value tests = that.conditions.conditions.flatMap((condition)
            =>  let ([tempDefinition, conditionExpression, *replacements]
                        =   generateConditionExpression(condition, true))
                if (!exists tempDefinition) then
                    // block for temp var scoping not required
                    expand {
                        replacements.map(VariableTriple.dartDeclaration),
                        [DartIfStatement {
                            conditionExpression;
                            DartBreakStatement();
                        }],
                        replacements.flatMap(VariableTriple.dartAssignment)
                    }.coalesced
                else
                    expand {
                        replacements.map(VariableTriple.dartDeclaration),
                        [DartBlock {
                            concatenate {
                                [tempDefinition].coalesced,
                                [DartIfStatement {
                                    conditionExpression;
                                    DartBreakStatement();
                                }],
                                replacements.flatMap(VariableTriple.dartAssignment)
                            };
                        }]
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
    [DartFunctionDeclarationStatement] transformValueSetterDefinition
            (ValueSetterDefinition that)
        =>  [DartFunctionDeclarationStatement(generateForValueSetterDefinition(that))];

    shared actual
    [DartStatement] transformValueSpecification(ValueSpecification that) {
        value info = ValueSpecificationInfo(that);
        if (info.declaration is FunctionModel) {
            // Specification for a forward declared function. Assign to the synthetic
            // variable that holds the Callable.

            value callableType
                =   info.declaration.typedReference.fullType;

            value callableVariableName
                =   dartTypes.getName(info.declaration) + "$c";

            value callableVariable
                =   DartSimpleIdentifier(callableVariableName);

            return
            [DartExpressionStatement {
                DartAssignmentExpression {
                    callableVariable;
                    DartAssignmentOperator.equal;
                    withLhs {
                        callableType;
                        null;
                        () => that.specifier.expression.transform(expressionTransformer);
                    };
                };
            }];
        }

        return  [DartExpressionStatement {
                withLhsNoType {
                    () => generateAssignment {
                        nodeInfo(that);
                        ValueSpecificationInfo(that).target;
                        noType;
                        () => that.specifier.expression.transform(expressionTransformer);
                    };
                };
            }];
    }

    shared actual
    DartStatement[] transformLazySpecification(LazySpecification that) {
        value info = LazySpecificationInfo(that);

        if (!info.declaration.shortcutRefinement,
                is FunctionModel functionModel = info.declaration) {
            // Specification for a forward declared function. Assign to the synthetic
            // variable that holds the Callable.

            value allParameterModels
                =>  that.parameterLists
                            .flatMap((pl) => pl.parameters)
                            .map(parameterInfo)
                            .map(ParameterInfo.parameterModel);

            for (p in allParameterModels) {
                // TODO this should be in a separate visitor, probably.
                // Since we're generating Callables, force all parameters to be
                // non-native, to avoid lots of unnecessary boxing/unboxing.
                ctx.disableErasureToNative.add(p.model);
            }

            value callableType
                =   info.declaration.typedReference.fullType;

            value callableVariableName
                =   dartTypes.getName(info.declaration) + "$c";

            value callableVariable
                =   DartSimpleIdentifier(callableVariableName);

            assert (nonempty parameterLists
                =   that.parameterLists);

            // NOTE: forceNonNativeReturn & hasForcedNonNativeReturn are used to eliminate
            // unnecessary boxing that would occur with the second example below, since
            // the functionModel would indicate erase-to-native, but what we want here
            // is to create a Callable.
            //
            //          shared String f(String a);
            //          f = (String s) => s; // ok; standard logic indicates non-native
            //          f(String s) => s;    // would have native return that is
            //                                  immediately boxed w/o the special effort

            return
            [DartExpressionStatement {
                DartAssignmentExpression {
                    callableVariable;
                    DartAssignmentOperator.equal;
                    withLhs {
                        callableType;
                        null;
                        () => generateCallableForBE {
                            info;
                            functionModel;
                            generateFunctionExpressionRaw {
                                info;
                                functionModel;
                                parameterLists;
                                that.specifier;
                                forceNonNativeReturn = true;
                            };
                            parameterList = ParametersInfo(parameterLists.first).model;
                            hasForcedNonNativeReturn =  true;
                        };
                    };
                };
            }];
        }
        else {
            return super.transformLazySpecification(that);
        }
    }

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
        value info = ForFailInfo(that);

        // Only track doFail if there is a fail clause and a break statement
        value doFailVariable = that.failClause exists && info.exits
                then DartSimpleIdentifier(dartTypes.createTempNameCustom("doFail"));

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
                    info;
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
                    info;
                    iteratorDenotableType;
                    // NonNative since that's how we created
                    // `iteratorDenotable` (`withLhsNonNative`)
                    () => withBoxingNonNative {
                        info;
                        iteratorDenotableType;
                        dartIteratorVariable;
                    };
                    "next";
                    [];
                };

        // Don't erase to native loop variables; avoid premature unboxing
        dartTypes.disableErasureToNative(that.forClause.iterator.pattern);

        // VariableTriples for inside the loop
        value variableTriples
            =   generateForPattern {
                    that.forClause.iterator.pattern;
                    // minus Finished, since this will be in the loop after
                    // the test.
                    loopVariableType.minus(ceylonTypes.finishedType);
                    () => withBoxing {
                        info;
                        loopVariableType;
                        null;
                        dartLoopVariable;
                    };
                };

        // Variable declarations and assignements for inside the loop
        value variables
            =   concatenate {
                    variableTriples.map(VariableTriple.dartDeclaration),
                    [DartBlock {
                        [*variableTriples.flatMap(VariableTriple.dartAssignment)];
                    }]
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
                        info;
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
                        info;
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
                        info;
                        ceylonTypes.finishedType;
                        false; false;
                    };
                    true;
                };
                // The forClause block
                DartBlock {
                    // Define the loop variables
                    concatenate {
                        variables,
                        // Statements
                        withDoFailVariable {
                            doFailVariable;
                            () => expand(that.forClause.block.transformChildren(
                                statementTransformer));
                        }
                    };
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

    shared actual
    [] transformClassDefinition(ClassDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        that.visit(topLevelVisitor);
        return [];
    }

    shared actual
    [] transformInterfaceDefinition(InterfaceDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        that.visit(topLevelVisitor);
        return [];
    }

    shared actual
    DartStatement[] transformObjectDefinition(ObjectDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        // define the anonymous class
        that.visit(topLevelVisitor);

        // declare the value, instantiate the object
        return [
            DartVariableDeclarationStatement {
                generateForObjectDefinition(that);
            }
        ];
    }

    shared actual
    DartStatement[] transformFunctionDeclaration(FunctionDeclaration that) {
        value info = FunctionDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            // ignore; must be a declaration for a callable parameter
            return [];
        }

        value callableVariableName
            =   dartTypes.getName(info.declarationModel) + "$c";

        value callableVariable
            =   DartSimpleIdentifier(callableVariableName);

        value functionExpression
            =   generateForwardDeclaredForwarder {
                    info;
                    info.declarationModel;
                    that.parameterLists;
                };

        // Toplevel and local functions will never be implemented as Dart values
        // or operators. Just grab the identifier and define a function.
        value functionIdentifier
            =   dartTypes.dartInvocable {
                    info;
                    info.declarationModel;
                    false;
                }.reference;

        "Functions have simple identifiers."
        assert (is DartSimpleIdentifier functionIdentifier);

        return [
            // Field to hold the Callable for the forward declared function
            DartVariableDeclarationStatement {
                DartVariableDeclarationList {
                    null;
                    dartTypes.dartTypeName {
                        info;
                        info.declarationModel.typedReference.fullType;
                    };
                    [DartVariableDeclaration {
                        callableVariable;
                    }];
                };
            },
            // The function that forwards to the callableVariable
            DartFunctionDeclarationStatement {
                DartFunctionDeclaration {
                    false;
                    generateFunctionReturnType {
                        info;
                        info.declarationModel;
                    };
                    null;
                    functionIdentifier;
                    functionExpression;
                };
            }
        ];
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
            generateForValueDeclarationRaw(info, info.declarationModel);
        }];
    }

    shared actual
    DartStatement[] transformDestructure(Destructure that)
        =>  let (eInfo = expressionInfo(that.specifier.expression),
                parts = generateForPattern {
                    that.pattern;
                    eInfo.typeModel;
                    () => that.specifier.expression.transform {
                        expressionTransformer;
                    };
                })
            concatenate {
                parts.map(VariableTriple.dartDeclaration),
                [DartBlock {
                    [*parts.flatMap(VariableTriple.dartAssignment)];
                }]
            };

    shared actual
    [DartStatement*] transformAssertion(Assertion that)
        =>  [*that.conditions.conditions.flatMap(generateConditionAssertion)];

    // TODO fix this
    String assertionErrorMessage(NodeInfo info)
        =>  ctx.tokens[info.token.tokenIndex..
                       info.endToken.tokenIndex]
            .map(Token.text)
            .fold("")(plus)
            .lines
            .map(String.trimmed)
            .interpose(" ")
            .fold("")(plus);

    [DartStatement+] generateConditionAssertion(Condition that)
        =>  switch (that)
            case (is BooleanCondition)
                [generateBooleanConditionAssertion(that)]
            case (is IsCondition | ExistsOrNonemptyCondition)
                generateIsOrExistsOrNonemptyConditionAssertion(that);

    DartStatement generateBooleanConditionAssertion(BooleanCondition that) {
        value info = nodeInfo(that);

        "The Ceylon source code for the condition"
        value errorMessage = assertionErrorMessage(info);

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
                                info;
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

    [DartStatement+] generateIsOrExistsOrNonemptyConditionAssertion
            (IsCondition | ExistsOrNonemptyCondition that) {

        value info
            =   nodeInfo(that);

        "The Ceylon source code for the condition"
        value errorMessage
            =   assertionErrorMessage(info);

        value [tempDefinition, conditionExpression, *variableTriples]
            =   switch (that)
                case (is IsCondition)
                    generateIsConditionExpression(that, true)
                case (is ExistsOrNonemptyCondition)
                    generateExistsOrNonemptyConditionExpression(that, true);

        "The Dart declarations for the variables if they have not already been declared
         as a class members."
        value replacementAndNewDeclarations
            =   variableTriples
                .filter((triple)
                    =>  !ctx.capturedInitializerDeclarations.contains(triple.declarationModel))
                .map(VariableTriple.dartDeclaration);

        "Assignments for replacements and destructurs"
        value assignmentStatements
            =   variableTriples
                .flatMap(VariableTriple.dartAssignment)
                .sequence();

        value nonDeclarationStatements
            =   concatenate {
                    [tempDefinition].coalesced,
                    // if (!(x is T)) then throw new AssertionError(...)
                    [DartIfStatement {
                        conditionExpression; // negated above
                        DartExpressionStatement {
                            DartThrowExpression {
                                DartInstanceCreationExpression {
                                    const = false;
                                    DartConstructorName {
                                        dartTypes.dartTypeName {
                                            info;
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
                    }],
                    assignmentStatements
                };

        value result
            =   if (tempDefinition exists && !assignmentStatements.empty) then
                    // scope the temp variable in a block
                    concatenate {
                        replacementAndNewDeclarations,
                        [DartBlock(nonDeclarationStatements)]
                    }
                 else
                    concatenate {
                        replacementAndNewDeclarations,
                        nonDeclarationStatements
                    };

        assert (nonempty result);
        return result;
    }

    shared actual
    [DartExpressionStatement] transformThrow(Throw that)
        =>  if (exists expression = that.result) then
                [DartExpressionStatement {
                    DartThrowExpression {
                        withLhsNoType {
                            () => expression.transform(expressionTransformer);
                        };
                    };
                }]
            else
                // TODO we need to start using generateTopLevelInvocation, and perform
                //      native replacements there. Also need to make sure `is` checks
                //      correctly handle replace types.
                [DartExpressionStatement {
                    DartThrowExpression {
                        DartInstanceCreationExpression {
                            const = false;
                            DartConstructorName {
                                dartTypes.dartTypeName {
                                    dScope(that);
                                    ceylonTypes.exceptionType;
                                    false; false;
                                };
                            };
                            DartArgumentList();
                        };
                    };
                }];

    shared actual
    DartStatement[] transformTryCatchFinally(TryCatchFinally that) {
        // Idea: Since Dart allows non-exception objects to be thrown, we could have
        // an interop exception type that wraps Anything (but generic!) that can be
        // caught, consistent with Ceylon's rules. We would need to unwrap on throw.

        if (that.tryClause.resources exists) {
            addError(that, "try with resources not yet supported.");
            return [];
        }

        function assertType(Anything a) {
            assert (is Type a);
            return a;
        }

        value dartCatchClause
            =   switch (catchClauses = that.catchClauses)
                case (is Empty) null
                else let (exceptionVariable = DartSimpleIdentifier(
                                dartTypes.createTempNameCustom("e")))
                    DartCatchClause {
                        null;
                        exceptionVariable;
                        null;
                        DartBlock {
                            [createIfStatement {
                                catchClauses.collect { (clause) =>
                                    let (variableInfo = UnspecifiedVariableInfo
                                            (clause.variable),
                                        typeInfo = TypeInfo(assertType
                                            (clause.variable.type)))
                                    [generateIsExpression {
                                        typeInfo;
                                        // Could be `Anything`, since Dart allows non
                                        // Exception objects to be thrown
                                        ceylonTypes.anythingType;
                                        null;
                                        exceptionVariable;
                                        typeInfo.typeModel;
                                    },
                                    DartBlock {
                                        // really need a convenience fn for this...
                                        [DartVariableDeclarationStatement {
                                            DartVariableDeclarationList {
                                                null;
                                                dartTypes.dartTypeNameForDeclaration {
                                                    variableInfo;
                                                    variableInfo.declarationModel;
                                                };
                                                [DartVariableDeclaration {
                                                    DartSimpleIdentifier {
                                                        dartTypes.getName {
                                                            variableInfo.declarationModel;
                                                        };
                                                    };
                                                    withLhs {
                                                        null;
                                                        variableInfo.declarationModel;
                                                        () => withBoxing {
                                                            variableInfo;
                                                            // Typed as `Anything` as
                                                            // noted above.
                                                            ceylonTypes.anythingType;
                                                            null;
                                                            exceptionVariable;
                                                        };
                                                    };
                                                }];
                                            };
                                        },
                                        *transformBlock(clause.block).first.statements];
                                    }];
                                };
                                DartBlock {
                                    [DartExpressionStatement {
                                        DartRethrowExpression.instance;
                                    }];
                                };
                            }];
                        };
                    };

        return
        [DartTryStatement {
            transformBlock(that.tryClause.block).first;
            emptyOrSingleton(dartCatchClause);
            if (exists finallyBlock = that.finallyClause?.block)
            then transformBlock(finallyBlock).first
            else null;
        }];
    }

    shared actual default
    [] transformNode(Node that) {
        if (that is DynamicBlock | DynamicInterfaceDefinition
                | DynamicModifier | DynamicValue) {

            addError(that, "dynamic is not supported on the Dart VM");
            return [];
        }
        addError(that, "Node type not yet supported (StatementTransformer): \
                        ``className(that)``");
        return [];
    }
}
