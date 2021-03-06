import ceylon.ast.core {
    FunctionDefinition,
    Block,
    InvocationStatement,
    ValueDefinition,
    Return,
    FunctionShortcutDefinition,
    Expression,
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
    Resource,
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
    LazySpecification,
    ClassAliasDefinition,
    InterfaceAliasDefinition,
    SpecifiedVariable,
    Import,
    AssertionMessage
}
import ceylon.collection {
    LinkedList
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue,
    ValueModel=Value,
    ClassModel=Class,
    TypeModel=Type
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
    DartFunctionDeclaration,
    DartFunctionExpression,
    dartFormalParameterListEmpty,
    DartExpressionFunctionBody,
    createVariableDeclaration,
    DartTypeName,
    DartBinaryExpression,
    DartNullLiteral,
    DartDoWhileStatement,
    DartExpression
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo,
    expressionInfo,
    nodeInfo,
    parameterInfo,
    ParameterInfo,
    SpecifiedVariableInfo,
    ExpressionInfo,
    typeInfo,
    parametersInfo,
    tryCatchFinallyInfo,
    isCaseInfo,
    elseClauseInfo,
    valueSpecificationInfo,
    lazySpecificationInfo,
    forFailInfo,
    functionDeclarationInfo,
    valueDeclarationInfo,
    specifiedVariableInfo,
    unspecifiedVariableInfo
}

import org.antlr.runtime {
    Token
}

shared
object statementTransformer
        extends BaseGenerator()
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
                        =   isCaseInfo(caseItem).variableDeclarationModel;

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
                            typeInfo(caseItem.type).typeModel;
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
            =   elseClauseInfo(that);

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
                        //      away the doElseVariable and put "else" block here.
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
        value info = valueSpecificationInfo(that);
        if (info.declaration is FunctionModel) {
            // Specification for a forward declared function or shortcut refinement.
            // Assign to the synthetic variable that holds the Callable.

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
                        valueSpecificationInfo(that).target;
                        noType;
                        () => that.specifier.expression.transform(expressionTransformer);
                    };
                };
            }];
    }

    shared actual
    DartStatement[] transformLazySpecification(LazySpecification that) {
        value info = lazySpecificationInfo(that);

        "StatementTransformer doesn't handle shortcut refinements."
        assert (!info.declaration.shortcutRefinement);

        function generateCallable() {
            // use boxed type for all parameters
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

            "If we're specifying a value as if it were a function, create a synthetic
             FunctionModel. This is for code like:

                String(String) foo;
                foo(String s) => s;"
            value declarationModel
                =   switch (model = info.declaration)
                    case (is FunctionModel) model
                    case (is ValueModel) dartTypes.syntheticFunctionForSpecifier(info);

            assert (nonempty parameterLists
                =   that.parameterLists);

            return generateCallableForBE {
                info;
                declarationModel;
                generateFunctionExpressionRaw {
                    info;
                    declarationModel;
                    parameterLists;
                    that.specifier;
                    forceNonNativeReturn = true;
                };
                parameterList = parametersInfo(parameterLists.first).model;
                hasForcedNonNativeReturn =  true;
            };
        }

        switch (declarationModel = info.declaration)
        case (is FunctionModel) {
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
                        generateCallable;
                    };
                };
            }];
        }
        case (is ValueModel) {
            // A definition for a forward declared value

            value callableVariableName
                =   switch (container = declarationModel.container)
                    // The field for the Dart Function
                    case (is ClassModel) "_" + dartTypes.getName(declarationModel) + "$f"
                    // For getters in functions, assign to the actual $get function, which
                    // is implemented as a Dart variable of type Function.
                    else dartTypes.getName(declarationModel);

            value expressionGenerator
                =   if (!that.parameterLists.empty) then
                        // a function-style specification for a value, e.g. the following
                        // assuming 'foo' was previously declared as a value.
                        //      foo(String s) => ...;
                        generateCallable
                    else
                        // a normal lazy value specification, e.g.
                        //      foo => ...;
                        (() => that.specifier.expression.transform {
                            expressionTransformer;
                        });

            if (declarationModel.transient) {
                return
                [DartExpressionStatement {
                    DartAssignmentExpression {
                        DartSimpleIdentifier {
                            callableVariableName;
                        };
                        DartAssignmentOperator.equal;
                        DartFunctionExpression {
                            dartFormalParameterListEmpty;
                            // same as in BG.generateDefinitionForValueModelGetter()
                            DartExpressionFunctionBody {
                                false;
                                withLhs {
                                    null;
                                    declarationModel;
                                    expressionGenerator;
                                };
                            };
                        };
                    };
                }];
            }
            else {
                // For use after https://github.com/ceylon/ceylon/issues/6428.
                // A values of type Callable that is specified with a LazySpecification
                // that has a parameter list should *not* be transient. The '=>' is
                // to define the function, not to indicate a lazy value.
                return
                [DartExpressionStatement {
                    DartAssignmentExpression {
                        DartSimpleIdentifier {
                            callableVariableName;
                        };
                        DartAssignmentOperator.equal;
                        withLhs {
                            null;
                            declarationModel;
                            expressionGenerator;
                        };
                    };
                }];
            }
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
        value info = forFailInfo(that);

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

        value iteratedInfo
            =   expressionInfo(that.forClause.iterator.iterated);

        // VariableTriples for inside the loop
        value variableTriples
            =   generateForPattern {
                    that.forClause.iterator.pattern;
                    // minus Finished, since this will be in the loop after the test
                    //loopVariableType.minus(ceylonTypes.finishedType);
                    //
                    // No longer using the above minus() since, 1) it triggers a
                    // typechecker bug https://github.com/ceylon/ceylon/issues/5946, and
                    // 2) the typechecker uses the less precise "getIteratedType()"
                    // instead of the possibly refined 'next' type that we're using for
                    // loopVariableType. So, we can use the less precise type too, likely
                    // without risk of unnecessary casting.
                    ctx.unit.getIteratedType(iteratedInfo.typeModel);
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

        "Will we have at least one element? If so, use a do-while loop to guarantee
         one iteration of the loop.

         This helps avoid definite assignment bugs when the iterable's first element is
         Finished, which would result in 0 iterations! This will never happen in real
         code, but there is a test for it..."
        value nonemptyIterable
            =   ctx.unit.isNonemptyIterableType(iteratedInfo.typeModel);

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
                        // initialize the first element now if nonempty iterable,
                        // and we'll use a while(true) loop.
                        nonemptyIterable then withLhs {
                            loopVariableType;
                            null;
                            nextInvocationGenerator;
                        };
                    }];
                };
            },
            // Invoke next() and test for Finished
            let (condition
                =   DartIsExpression {
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
                    })
            // The forClause block
            let (block
                =   DartBlock {
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
                    })
            if (!nonemptyIterable)
            then DartWhileStatement(condition, block)
            else DartDoWhileStatement(block, condition),
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
    [DartStatement*] transformClassDefinition(ClassDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        that.visit(topLevelVisitor);

        return concatenate {
            generateForValueConstructors(that).map { (pair) =>
                [DartVariableDeclarationStatement {
                    pair[0];
                },
                DartFunctionDeclarationStatement {
                    pair[1];
                }];
            };
        };
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
        // Must be a forward declared function

        value info = functionDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            // ignore; must be a declaration for a callable parameter
            return [];
        }

        // TODO consolidate naming logic
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
        =>  [DartBlock([*expand(that.transformChildren(this))])];

    shared actual
    [] transformTypeAliasDefinition(TypeAliasDefinition that) => [];

    shared actual
    [] transformClassAliasDefinition(ClassAliasDefinition that) => [];

    shared actual
    [] transformInterfaceAliasDefinition(InterfaceAliasDefinition that) => [];

    shared actual
    [DartStatement*] transformValueDeclaration(ValueDeclaration that) {
        value info = valueDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            // ignore; must be a declaration for
            // a parameter reference
            return [];
        }

        if (info.declarationModel.transient) {
            // Forward declared value; one or more lazy specifications will follow.
            // Don't worry about setters; they are not allowed for transient forward
            // declared values.
            return [
                // Variable to hold the Function used to obtain the value
                DartVariableDeclarationStatement {
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartFunction;
                        [DartVariableDeclaration {
                            //callableVariable;
                            DartSimpleIdentifier {
                                dartTypes.getName(info.declarationModel);
                            };
                        }];
                    };
                }
            ];
        }

        // For a non-transient (reference) forward declared value.
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
        =>  [*that.conditions.conditions.flatMap((node)
                =>  generateConditionAssertion(node, that.message))
            ];

    String assertionErrorMessage(NodeInfo info)
        =>  ctx.tokens[info.token.tokenIndex..
                       info.endToken.tokenIndex]
            .map(Token.text)
            .fold("")(plus)
            .lines
            .map(String.trimmed)
            .interpose(" ")
            .fold("")(plus);

    [DartStatement+] generateConditionAssertion
            (Condition that, AssertionMessage? message)
        =>  switch (that)
            case (is BooleanCondition)
                [generateBooleanConditionAssertion(that, message)]
            case (is IsCondition | ExistsOrNonemptyCondition)
                generateIsOrExistsOrNonemptyConditionAssertion(that);

    DartExpression generateAssertionErrorString(
            NodeInfo info, AssertionMessage? message) {
        if (exists message) {
            return message.transform(expressionTransformer);
        }
        else {
            return DartSimpleStringLiteral {
                "Violated: ``assertionErrorMessage(info)``";
            };
        }
    }

    DartStatement generateBooleanConditionAssertion(
            BooleanCondition that, AssertionMessage? message) {

        value info = nodeInfo(that);

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
                            [withLhsNative {
                                ctx.ceylonTypes.stringType;
                                () => generateAssertionErrorString(info, message);
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

        /*
            For each Destroyable resource:

                - Initialize the resource (use a tmp var if necessary)
                - Declare a variable to hold a throwable for use in the following
                  catch and finally blocks
                - try block
                    - execute program code from the original try
                - catch block
                    - save the caught throwable in the temp variable created earlier
                - finally block
                    - in a try, attempt to call `destroy` on the resource, passing
                      in the possibly null temp var for the throwable
                    - in a catch, `addSuppressed(theNewThrowable)` to the temp var
                      (if the temp var is not null)

            For Obtainables, do the same but also call obtain().
        */

        value info = tryCatchFinallyInfo(that);

        DartBlock wrapBlockWithResource(Resource resource, DartBlock block) {
            value rInfo
                =   switch (r = resource.resource)
                    case (is Expression) expressionInfo(r)
                    case (is SpecifiedVariable) specifiedVariableInfo(r);

            DartTypeName dartTypeName;
            DartSimpleIdentifier variableIdentifier;
            TypeModel typeModel;
            ValueModel? valueModel;
            Expression expression;

            switch (rInfo)
            case (is ExpressionInfo) {
                typeModel
                    =   rInfo.typeModel;

                valueModel
                    =   null;

                dartTypeName
                    =   dartTypes.dartTypeName {
                            rInfo;
                            typeModel;
                        };

                variableIdentifier
                    =   DartSimpleIdentifier {
                            dartTypes.createTempNameCustom("u");
                        };

                expression
                    = rInfo.node;
            }
            case (is SpecifiedVariableInfo) {
                typeModel
                    =   rInfo.declarationModel.type;

                valueModel
                    =   rInfo.declarationModel;

                dartTypeName
                    =   dartTypes.dartTypeNameForDeclaration {
                            rInfo;
                            rInfo.declarationModel;
                            typeModel;
                        };

                variableIdentifier
                    =   DartSimpleIdentifier {
                            dartTypes.getName(rInfo.declarationModel);
                        };

                expression
                    =   rInfo.node.specifier.expression;
            }

            value isObtainable // else it's Destroyable
                =   ceylonTypes.obtainableType.isSupertypeOf(typeModel);

            value exceptionVariable
                =   DartSimpleIdentifier(dartTypes.createTempNameCustom("e"));

            value setup
                =   // define variable for resource and assign resource
                    [createVariableDeclaration {
                        dartTypeName;
                        variableIdentifier;
                        withLhs {
                            typeModel;
                            valueModel;
                            () => expression.transform(expressionTransformer);
                        };
                    },
                    createVariableDeclaration {
                        dartTypes.dartTypeName {
                            rInfo;
                            ceylonTypes.throwableType;
                        };
                        exceptionVariable;
                        null;
                    },
                    // if obtainable, obtain()
                    isObtainable then DartExpressionStatement {
                        withLhsNoType {
                            () => generateInvocationSynthetic {
                                rInfo;
                                typeModel;
                                () => withBoxing {
                                    rInfo;
                                    typeModel;
                                    valueModel;
                                    variableIdentifier;
                                };
                                "obtain";
                                [];
                            };
                        };
                    }].coalesced.sequence();

            value catchVariable
                =   DartSimpleIdentifier(dartTypes.createTempNameCustom("e"));

            value catchClause
                =   DartCatchClause {
                        null;
                        catchVariable;
                        null;
                        DartBlock {[
                            DartExpressionStatement {
                                DartAssignmentExpression {
                                    exceptionVariable;
                                    DartAssignmentOperator.equal;
                                    dartTypes.invocableForBaseExpression {
                                        info;
                                        ceylonTypes.dartWrapThrownObjectDeclaration;
                                    }.expressionForInvocation {
                                        [catchVariable];
                                    };
                                };
                            },
                            DartExpressionStatement {
                                DartRethrowExpression.instance;
                            }];
                        };
                    };

            value closeStatement
                =   DartExpressionStatement {
                        withLhsNoType {
                            () => generateInvocationSynthetic {
                                rInfo;
                                typeModel;
                                () => withBoxing {
                                    rInfo;
                                    typeModel;
                                    valueModel;
                                    variableIdentifier;
                                };
                                if (isObtainable)
                                    then "release"
                                    else "destroy";
                                [() => withBoxing {
                                    rInfo;
                                    ceylonTypes.throwableType;
                                    null;
                                    exceptionVariable;
                                }];
                            };
                        };
                    };

            value catchVariable2
                =   DartSimpleIdentifier(dartTypes.createTempNameCustom("e"));

            value tearDown
                =   DartIfStatement {
                        DartBinaryExpression {
                            exceptionVariable;
                            "!=";
                            DartNullLiteral();
                        };
                        DartTryStatement {
                            DartBlock {
                                [closeStatement];
                            };
                            [DartCatchClause {
                                dartTypes.dartTypeName {
                                    rInfo;
                                    ceylonTypes.throwableType;
                                };
                                catchVariable2;
                                null;
                                DartBlock {
                                    [withLhsNoType {
                                        () => DartExpressionStatement {
                                            generateInvocationSynthetic {
                                                rInfo;
                                                ceylonTypes.throwableType.type;
                                                () => withBoxing {
                                                    rInfo;
                                                    ceylonTypes.throwableType;
                                                    null;
                                                    exceptionVariable;
                                                };
                                                "addSuppressed";
                                                [() => withBoxing {
                                                    rInfo;
                                                    ceylonTypes.throwableType;
                                                    null;
                                                    catchVariable2;
                                                }];
                                            };
                                        };
                                    }];
                                };
                            }];
                        };
                        closeStatement;
                    };

            return
            DartBlock {
                concatenate {
                    setup,
                    [
                        DartTryStatement {
                            block;
                            [catchClause];
                            DartBlock([tearDown]);
                        }
                    ]
                };
            };
        }

        DartBlock wrapBlockWithResources([Resource*] resources, DartBlock block) {
            DartBlock f([Resource*] resources, DartBlock block) {
                if (!nonempty resources) {
                    return block;
                }
                return f {
                    resources.rest;
                    wrapBlockWithResource(resources.first, block);
                };
            }
            return f(resources.reversed, block);
        }

        value dartCatchClause
            =   switch (catchClauses = that.catchClauses)
                case (is Empty) null
                else let (catchVariable // implicitly final in Dart
                        =   DartSimpleIdentifier(dartTypes.createTempNameCustom("e")))
                    let (exceptionVariable
                        =   DartSimpleIdentifier(dartTypes.createTempNameCustom("e")))
                    DartCatchClause {
                        null;
                        catchVariable;
                        null;
                        DartBlock {
                            [createVariableDeclaration {
                                dartTypes.dartTypeName {
                                    info;
                                    ceylonTypes.throwableType;
                                };
                                exceptionVariable;
                                // Dart allows any object to be thrown, so wrap the thrown
                                // object in an Exception if necessary
                                dartTypes.invocableForBaseExpression {
                                    info;
                                    ceylonTypes.dartWrapThrownObjectDeclaration;
                                }.expressionForInvocation {
                                    [catchVariable];
                                };
                            },
                            createIfStatement {
                                catchClauses.collect { (clause) =>
                                    let (vInfo = unspecifiedVariableInfo(clause.variable))
                                    [generateIsExpression {
                                        vInfo;
                                        ceylonTypes.throwableType;
                                        null;
                                        exceptionVariable;
                                        vInfo.declarationModel.type;
                                    },
                                    DartBlock {
                                        [createVariableDeclaration {
                                            dartTypes.dartTypeNameForDeclaration {
                                                    vInfo;
                                                    vInfo.declarationModel;
                                            };
                                            DartSimpleIdentifier {
                                                dartTypes.getName {
                                                    vInfo.declarationModel;
                                                };
                                            };
                                            withLhs {
                                                null;
                                                vInfo.declarationModel;
                                                () => withBoxing {
                                                    vInfo;
                                                    ceylonTypes.throwableType;
                                                    null;
                                                    exceptionVariable;
                                                };
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

        return [
            if (!dartCatchClause exists && !that.finallyClause exists)
            then wrapBlockWithResources {
                that.tryClause.resources?.children else [];
                transformBlock(that.tryClause.block).first;
            }
            else DartTryStatement {
                wrapBlockWithResources {
                    that.tryClause.resources?.children else [];
                    transformBlock(that.tryClause.block).first;
                };
                emptyOrSingleton(dartCatchClause);
                if (exists finallyBlock = that.finallyClause?.block)
                then transformBlock(finallyBlock).first
                else null;
            }
        ];
    }

    shared actual
    DartStatement[] transformImport(Import that) {
        return [];
    }

    shared actual
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
