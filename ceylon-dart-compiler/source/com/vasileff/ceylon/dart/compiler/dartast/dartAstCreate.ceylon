import com.vasileff.ceylon.dart.compiler.core {
    concatenate
}

shared
DartPropertyAccess | DartSimpleIdentifier createDartPropertyAccess
        (DartExpression? target, DartSimpleIdentifier propertyName)
    =>  if (exists target)
        then DartPropertyAccess(target, propertyName)
        else propertyName;

shared
DartPrefixedIdentifier | DartSimpleIdentifier createDartPrefixedIdentifier
        (DartSimpleIdentifier? prefix, DartSimpleIdentifier identifier)
    =>  if (exists prefix)
        then DartPrefixedIdentifier(prefix, identifier)
        else identifier;

shared
DartFunctionExpressionInvocation createInlineDartStatements(
        "Zero or more statements, followed by a Return"
        [DartStatement*] statements)
    =>  DartFunctionExpressionInvocation {
            DartFunctionExpression {
                dartFormalParameterListEmpty;
                DartBlockFunctionBody {
                    null; false;
                    DartBlock(statements);
                };
            };
            DartArgumentList([]);
        };

"Create a null safe expression. This function performs no explicit boxing or casting,
 as is obvious by the fact that the input expression parameters are not callables.

 Note: technically the invocation should be cast to the expected lhs type, since Dart
 appears to treat the result of anonymous function invocations as `var`. Regular
 boxing won't work, since we can't claim to be returning `Anything`; we may actually
 be returning an erasedToNative value. So lets not get too pedantic."
shared
DartExpression createNullSafeExpression(
        "Identifier for result of [[maybeNullExpression]]"
        DartSimpleIdentifier parameterIdentifier,
        "The type of the [[maybeNullExpression]] that will be exposed as
         [[parameterIdentifier]]"
        DartTypeName parameterType,
        "Evaluate, test for null, and make available as [[parameterIdentifier]].
         Must be of [[parameterType]]."
        DartExpression maybeNullExpression,
        "Only evaluate if maybeNullExpression is null"
        DartExpression ifNullExpression,
        "Only evaluate if maybeNullExpression is not null"
        DartExpression ifNotNullExpression)
    =>  DartFunctionExpressionInvocation {
            DartFunctionExpression {
                DartFormalParameterList {
                    positional = false;
                    named = false;
                    [DartSimpleFormalParameter {
                        false;
                        false;
                        parameterType;
                        parameterIdentifier;
                    }];
                };
                body = DartExpressionFunctionBody {
                    async = false;
                    DartConditionalExpression {
                        DartBinaryExpression {
                            DartNullLiteral();
                            "==";
                            parameterIdentifier;
                        };
                        ifNullExpression;
                        ifNotNullExpression;
                    };
                };
            };
            DartArgumentList {
                [maybeNullExpression];
            };
        };

"Returns an invoked function that executes [[setup]] and returns [[expression]] if
 [[setup]] is nonempty. Returns [[expression]] otherwise."
shared
DartExpression createExpressionEvaluationWithSetup(
        [DartStatement*] setup, DartExpression expression)
    =>  if (!nonempty setup) then
            expression
        else
            createInlineDartStatements {
                concatenate {
                    setup,
                    [DartReturnStatement {
                        expression;
                    }]
                };
            };

shared
DartIfStatement createIfStatement
        ([[DartExpression, DartBlock]+] parts, DartBlock? finalElse = null)
    =>  DartIfStatement {
            parts.first[0];
            parts.first[1];
            if (nonempty rest = parts.rest)
            then createIfStatement(rest, finalElse)
            else finalElse;
        };

shared
DartVariableDeclarationStatement createVariableDeclaration(
        DartTypeName dartTypeName, DartSimpleIdentifier identifier,
        DartExpression? initializer)
    =>  DartVariableDeclarationStatement {
            DartVariableDeclarationList {
                null;
                dartTypeName;
                [DartVariableDeclaration {
                    identifier;
                    initializer;
                }];
            };
        };

shared
DartExpressionStatement createAssignmentStatement(
        DartExpression lhsExpression,
        DartAssignmentOperator operator,
        DartExpression rhsExpression)
    =>  DartExpressionStatement {
            DartAssignmentExpression {
                lhsExpression;
                operator;
                rhsExpression;
            };
        };

shared
DartExpressionStatement createMethodInvocationStatement(
        DartExpression? target,
        DartSimpleIdentifier methodName,
        DartArgumentList argumentList)
    =>  DartExpressionStatement {
            DartMethodInvocation {
                target;
                methodName;
                argumentList;
            };
        };
