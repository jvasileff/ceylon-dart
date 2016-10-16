import com.vasileff.ceylon.dart.compiler.dartast {
    DartExpression,
    DartSimpleIdentifier,
    DartFunctionExpressionInvocation,
    DartArgumentList,
    DartBinaryExpression,
    DartIndexExpression,
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartPrefixExpression,
    createDartPropertyAccess,
    DartFunctionExpression,
    dartFormalParameterListEmpty,
    DartExpressionFunctionBody,
    DartFormalParameterList,
    DartSimpleFormalParameter,
    DartConstructorName,
    DartInstanceCreationExpression,
    DartPropertyAccess,
    DartPrefixedIdentifier,
    DartTypeName,
    DartAsExpression,
    DartLabel,
    DartNamedExpression,
    DartIdentifier
}

shared
class DartInvocable(
        // DartPropetyAccess|DartPrefixedIdentifier may indicate a Dart static member
        // or a qualified toplevel
        shared DartSimpleIdentifier | DartPropertyAccess | DartPrefixedIdentifier
                    | DartConstructorName reference,
        shared DartElementType elementType,
        shared Boolean setter,
        shared Boolean callableParameter = false,
        "If not null, cast to the provided type. [[callableCast]] should be provided when
         [[callableParameter]] is `true`, and the Dart variable holding the `Callable`
         is of type `dart.core.Object`, which happens for defaulted callable parameters."
        shared DartTypeName? callableCast = null,
        shared Boolean capturedReferenceValue = false,
        "If this is an invocable for an interop function, and the function has named
         parameters, a sequence holding all parameter names, with leading `null`s for
         non-named parameter. The size of the sequence must be equal to the total number
         of parameter for the function."
        shared [String?*] interopNamedParameters = []) {

    "Cannot be both a capturedReferenceValue and a callableParameter."
    assert (!(capturedReferenceValue && callableParameter));

    "Cannot be both a setter and a callableParameter."
    assert (!(setter && callableParameter));

    "Callable parameters must be [[dartValue]]s."
    assert (!(callableParameter && elementType != dartValue));

    "Callable casts are only valid for callable parameters."
    assert (!(callableCast exists && !callableParameter));

    // TODO remove this function
    shared
    [DartSimpleIdentifier, DartElementType] oldPairSimple {
        // The `reference` may be a property access or prefixed identifier for things
        // like static interface methods, but callers are trying to make declarations,
        // so let's extract a DartSimpleIdentifier. It's likely that in these cases
        // the identifier will not ultimately be used anyway.

        assert (is DartSimpleIdentifier | DartPropertyAccess | DartPrefixedIdentifier
                reference);

        value simpleIdentifier
            =   switch (reference)
                case (is DartSimpleIdentifier) reference
                case (is DartPropertyAccess) reference.propertyName
                case (is DartPrefixedIdentifier) reference.identifier;

        return [simpleIdentifier, elementType];
    }

    shared
    DartInvocable with(
            DartSimpleIdentifier | DartPropertyAccess | DartPrefixedIdentifier
                    | DartConstructorName reference = this.reference,
            DartElementType elementType = this.elementType,
            Boolean setter = this.setter,
            Boolean callableParameter = this.callableParameter,
            DartTypeName? callableCast = this.callableCast,
            Boolean capturedReferenceValue = this.capturedReferenceValue,
            [String?*] interopNamedArguments = this.interopNamedParameters)
        =>  DartInvocable(
                reference, elementType, setter, callableParameter, callableCast,
                capturedReferenceValue, interopNamedArguments);

    function prependedArgumentList(
            DartExpression? initial,
            [DartExpression*] arguments)
        =>  if (exists initial) then
                DartArgumentList {
                    arguments.withLeading(initial);
                }
            else
                DartArgumentList {
                    arguments;
                };

    function interopArguments([DartExpression*] arguments)
        =>  if (interopNamedParameters.empty)
            then arguments
            else zipPairs(interopNamedParameters, arguments)
                    .map(([argumentName, expression]) {
                if (!exists argumentName) {
                    return expression;
                }
                // if the expression's value is dartDefault, ignore the argument
                if (is DartIdentifier expression, expression.isDefaultIndicatorValue) {
                    return null;
                }
                return DartNamedExpression {
                    DartLabel(DartSimpleIdentifier(argumentName));
                    expression;
                };
            }).coalesced.sequence();

    shared
    DartSimpleIdentifier assertedSimpleIdentifier {
        assert (is DartSimpleIdentifier reference);
        return reference;
    }

    shared
    DartConstructorName assertedConstructorName {
        assert (is DartConstructorName reference);
        return reference;
    }

    "Return a reference to the Dart element for this invocable, as in, an expression to
     a Dart function or variable."
    shared
    DartExpression expressionForLocalCapture(DartExpression? receiver) {
        // Local function and values *initially* do not have receivers (they are not
        // members), but, if a capture is re-captured, it will have a receiver the
        // for the second capture! (The receiver would be the first capturer.)

        "Constructors and Dart static methods are not captured."
        assert (!is DartConstructorName | DartPropertyAccess reference);

        "Local functions and values are never operators."
        assert (elementType == dartFunction || elementType == dartValue);

        if (is DartPrefixedIdentifier reference) {
            // must be a toplevel

            "Toplevels don't have receivers."
            assert (!exists receiver);

            return reference;
        }
        else {
            return createDartPropertyAccess(receiver, reference);
        }
    }

    shared
    DartExpression expressionForInvocation(
            DartExpression? receiver = null,
            [DartExpression*] arguments = [],
            "Is the last argument a spread argument?"
            Boolean hasSpread = false) {

        switch (elementType)
        case (dartFunction) {
            switch (reference)
            // Normal object.member invocation
            case (is DartSimpleIdentifier) {
                return
                DartFunctionExpressionInvocation {
                    createDartPropertyAccess {
                        receiver;
                        reference;
                    };
                    DartArgumentList {
                        interopArguments(arguments);
                    };
                };
            }
            // Could be a Dart static method or a qualified toplevel
            case (is DartPropertyAccess | DartPrefixedIdentifier) {
                return
                DartFunctionExpressionInvocation {
                    reference;
                    prependedArgumentList {
                        receiver;
                        interopArguments(arguments);
                    };
                };
            }
            // It's not a function, it's a constructor
            case (is DartConstructorName) {
                return
                DartInstanceCreationExpression {
                    false;
                    reference;
                    prependedArgumentList {
                        receiver;
                        interopArguments(arguments);
                    };
                };
            }
        }
        case (dartValue) {
            "Dart values are not constructors."
            assert (!is DartConstructorName reference);

            DartExpression target;
            if (!exists receiver) {
                // Possibly a DartPropertyAccess in the case of a Dart static attribute
                target = reference;
            }
            else {
                "Member identifiers must be DartSimpleIdentifiers."
                assert (!is DartPrefixedIdentifier | DartPropertyAccess reference);
                target = createDartPropertyAccess(receiver, reference);
            }

            if (callableParameter) {
                return
                DartFunctionExpressionInvocation {
                    // resolve the f/s property of the Callable
                    DartPropertyAccess {
                        if (exists callableCast) then
                            DartAsExpression {
                                target;
                                callableCast;
                            }
                        else target;
                        DartSimpleIdentifier {
                            if (hasSpread) then "s" else "f";
                        };
                    };
                    DartArgumentList {
                        arguments;
                    };
                };
            }
            else if (!setter) {
                "Arguments must be empty when accessing values"
                assert (arguments.empty);

                return if (capturedReferenceValue)
                then DartPropertyAccess(target, DartSimpleIdentifier("v"))
                else target;
            }
            else {
                "Assignment operations must have an argument."
                assert (exists val = arguments[0]);

                "Assignment operations must have only one argument"
                assert (arguments.size == 1);

                return DartAssignmentExpression {
                    if (capturedReferenceValue)
                    then DartPropertyAccess(target, DartSimpleIdentifier("v"))
                    else target;
                    DartAssignmentOperator.equal;
                    val;
                };
            }
        }
        case (is DartBinaryOperator) {
            "Binary operators are not setters"
            assert(!setter);

            "Binary operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Binary operators must have a receiver"
            assert (exists receiver);

            "Binary operators must have an argument for the right operand"
            assert (exists rightOperand = arguments[0]);

            "Binary operators must have only one argument"
            assert (arguments.size == 1);

            return
            DartBinaryExpression {
                receiver;
                reference.identifier;
                rightOperand;
            };
        }
        case (dartListAccess) {
            "Index methods are not setters."
            assert(!setter);

            "Index methods are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Index expressions must have a receiver"
            assert (exists receiver);

            "Index expressions must have an argument for the index"
            assert (exists index = arguments[0]);

            "Index expressions must have only one argument"
            assert (arguments.size == 1);

            return
            DartIndexExpression {
                receiver;
                index;
            };
        }
        case (dartListAssignment) {
            "Index methods are not setters."
            assert(!setter);

            "Index methods are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Index assignment expressions must have a receiver"
            assert (exists receiver);

            "Index assignment expressions must have an argument for the index"
            assert (exists index = arguments[0]);

            "Index assignment expressions must have an argument for assigned value"
            assert (exists val = arguments[1]);

            "Index expressions must have exactly two arguments"
            assert (arguments.size == 2);

            return
            DartAssignmentExpression {
                DartIndexExpression {
                    receiver;
                    index;
                };
                DartAssignmentOperator.equal;
                val;
            };
        }
        case (is DartPrefixOperator) {
            "Prefix operators are not setters."
            assert(!setter);

            "Prefix operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Dart Prefix operations must have a receiver"
            assert (exists receiver);

            "Dart Prefix operations cannot have arguments"
            assert (arguments.empty);

            return
            DartPrefixExpression {
                reference.identifier;
                receiver;
            };
        }
    }

    "Returns an expression of type $dart$core.Function."
    shared
    DartExpression expressionForClosure(DartExpression? receiver) {
        "Cannot closurize setters."
        assert (!setter);

        "Don't call this for callable parameter values, just obtain the Callable
         with [[expressionForLocalCapture]]!"
        assert (!callableParameter);

        switch (elementType)
        case (dartFunction) {
            assert (!is DartConstructorName reference);

            if (!receiver exists) {
                // Possibly a DartPropertyAccess in the case of a Dart static function
                return reference;
            }

            "Non-static member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier | DartPropertyAccess reference);

            return createDartPropertyAccess(receiver, reference);
        }
        case (dartValue) {
            "Dart values are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "no known cases of this..."
            assert(1==0);

            if (!receiver exists) {
                DartFunctionExpression {
                    dartFormalParameterListEmpty;
                    DartExpressionFunctionBody {
                        false;
                        reference;
                    };
                };
            }

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            return
            DartFunctionExpression {
                dartFormalParameterListEmpty;
                DartExpressionFunctionBody {
                    false;
                    createDartPropertyAccess(receiver, reference);
                };
            };
        }
        case (is DartBinaryOperator) {
            "Binary operators must have a receiver"
            assert (exists receiver);

            "Binary operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            value arg0 = DartSimpleIdentifier("$0");

            return
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false; false; null;
                        arg0;
                    }];
                };
                DartExpressionFunctionBody {
                    false;
                    DartBinaryExpression {
                        receiver;
                        reference.identifier;
                        arg0;
                    };
                };
            };
        }
        case (dartListAccess) {
            "Index methods are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Index expressions must have a receiver"
            assert (exists receiver);

            value arg0 = DartSimpleIdentifier("$0");

            return
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false; false; null;
                        arg0;
                    }];
                };
                DartExpressionFunctionBody {
                    false;
                    DartIndexExpression {
                        receiver;
                        arg0;
                    };
                };
            };
        }
        case (dartListAssignment) {
            "Index methods are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Index assignment expressions must have a receiver"
            assert (exists receiver);

            value arg0 = DartSimpleIdentifier("$0");
            value arg1 = DartSimpleIdentifier("$1");

            return
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false; false; null;
                        arg0;
                    },
                    DartSimpleFormalParameter {
                        false; false; null;
                        arg1;
                    }];
                };
                DartExpressionFunctionBody {
                    false;
                    DartAssignmentExpression {
                        DartIndexExpression {
                            receiver;
                            arg0;
                        };
                        DartAssignmentOperator.equal;
                        arg1;
                    };
                };
            };
        }
        case (is DartPrefixOperator) {
            "Prefix operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Dart Prefix operations must have a receiver"
            assert (exists receiver);

            value arg0 = DartSimpleIdentifier("$0");

            return
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false; false; null;
                        arg0;
                    }];
                };
                DartExpressionFunctionBody {
                    false;
                    DartPrefixExpression {
                        reference.identifier;
                        arg0;
                    };
                };
            };
        }
    }
}
