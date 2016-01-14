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
    DartAsExpression
}

shared
class DartInvocable(
        // DartPropetyAccess|DartPrefixedIdentifier may indicate a Dart static method
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
        shared Boolean capturedReferenceValue = false) {

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
            Boolean capturedReferenceValue = this.capturedReferenceValue)
        =>  DartInvocable(
                reference, elementType, setter, callableParameter, callableCast,
                capturedReferenceValue);

    function dartArgumentList(DartArgumentList|[DartExpression*] arguments)
        =>  if (is DartArgumentList arguments)
            then arguments
            else DartArgumentList(arguments);

    function dartArgumentSequence(DartArgumentList|[DartExpression*] arguments)
        =>  if (is DartArgumentList arguments)
            then arguments.arguments
            else arguments;

    function prependedArgumentList(
            DartExpression? initial,
            DartArgumentList | [DartExpression*] arguments)
        =>  if (exists initial) then
                DartArgumentList {
                    dartArgumentSequence(arguments).withLeading(initial);
                }
            else
                dartArgumentList {
                    arguments;
                };

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
            DartArgumentList|[DartExpression*] arguments = [],
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
                    dartArgumentList {
                        arguments;
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
                        arguments;
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
                        arguments;
                    };
                };
            }
        }
        case (dartValue) {
            "Dart values are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            DartExpression target;
            if (!exists receiver) {
                target = reference;
            }
            else {
                "Member identifiers must be DartSimpleIdentifiers."
                assert (!is DartPrefixedIdentifier reference);

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
                    dartArgumentList {
                        arguments;
                    };
                };
            }
            else if (!setter) {
                "Arguments must be empty when accessing values"
                assert (dartArgumentSequence(arguments).empty);

                return if (capturedReferenceValue)
                then DartPropertyAccess(target, DartSimpleIdentifier("v"))
                else target;
            }
            else {
                "Assignment operations must have an argument."
                assert (exists val = dartArgumentSequence(arguments)[0]);

                "Assignment operations must have only one argument"
                assert (dartArgumentSequence(arguments).size == 1);

                return DartAssignmentExpression {
                    if (capturedReferenceValue)
                    then DartPropertyAccess(target, DartSimpleIdentifier("v"))
                    else target;
                    DartAssignmentOperator.equal;
                    val;
                };
            }
        }
        case (dartBinaryOperator) {
            "Binary operators are not setters"
            assert(!setter);

            "Binary operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Binary operators must have a receiver"
            assert (exists receiver);

            "Binary operators must have an argument for the right operand"
            assert (exists rightOperand = dartArgumentSequence(arguments)[0]);

            "Binary operators must have only one argument"
            assert (dartArgumentSequence(arguments).size == 1);

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
            assert (exists index = dartArgumentSequence(arguments)[0]);

            "Index expressions must have only one argument"
            assert (dartArgumentSequence(arguments).size == 1);

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
            assert (exists index = dartArgumentSequence(arguments)[0]);

            "Index assignment expressions must have an argument for assigned value"
            assert (exists val = dartArgumentSequence(arguments)[1]);

            "Index expressions must have exactly two arguments"
            assert (dartArgumentSequence(arguments).size == 2);

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
        case (dartPrefixOperator) {
            "Prefix operators are not setters."
            assert(!setter);

            "Prefix operators are not constructors or static methods."
            assert (!is DartConstructorName | DartPropertyAccess reference);

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

            "Dart Prefix operations must have a receiver"
            assert (exists receiver);

            "Dart Prefix operations cannot have arguments"
            assert (dartArgumentSequence(arguments).empty);

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
            // TODO support this constructors?
            assert (!is DartConstructorName | DartPropertyAccess reference);

            if (!receiver exists) {
                return reference;
            }

            "Member identifiers must be DartSimpleIdentifiers."
            assert (!is DartPrefixedIdentifier reference);

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
        case (dartBinaryOperator) {
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
        case (dartPrefixOperator) {
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
