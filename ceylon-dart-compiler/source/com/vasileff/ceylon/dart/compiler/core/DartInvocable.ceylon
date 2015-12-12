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
    DartPrefixedIdentifier
}

shared
class DartInvocable(
        // DartPropetyAccess|DartPrefixedIdentifier may indicate a Dart static method
        // or a qualified toplevel
        shared DartSimpleIdentifier | DartPropertyAccess | DartPrefixedIdentifier
                    | DartConstructorName reference,
        shared DartElementType elementType,
        shared Boolean setter) {


    // TODO remove this function
    shared
    [DartSimpleIdentifier, DartElementType] oldPairSimple {
        assert (is DartSimpleIdentifier reference);
        return [reference, elementType];
    }

    shared
    DartInvocable with(
            DartSimpleIdentifier | DartPropertyAccess | DartPrefixedIdentifier
                    | DartConstructorName reference = this.reference,
            DartElementType elementType = this.elementType,
            Boolean setter = this.setter)
        =>  DartInvocable(reference, elementType, setter);

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

    shared
    DartExpression expressionForLocalCapture(DartExpression? receiver) {
        // Local function and values *initially* do not have receivers (they are not
        // members), but, if a capture is re-captured, it will have a receiver the
        // for the second capture! (The receiver would be the first capturer.)

        "Setters are not yet supported for capture."
        assert (!setter);

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
            DartArgumentList|[DartExpression*] arguments = []) {

        switch (elementType)
        case (dartFunction) {
            switch (reference)
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

            if (!setter) {
                "Arguments must be empty when accessing values"
                assert (dartArgumentSequence(arguments).empty);

                return target;
            }
            else {
                "Assignment operations must have an argument."
                assert (exists val = dartArgumentSequence(arguments)[0]);

                "Assignment operations must have only one argument"
                assert (dartArgumentSequence(arguments).size == 1);

                return DartAssignmentExpression {
                    target;
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

    shared
    DartExpression expressionForClosure(DartExpression? receiver) {
        "Cannot closurize setters."
        assert (!setter);

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

            // no known cases of this...

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
