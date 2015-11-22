import com.vasileff.ceylon.dart.compiler.dartast {
    DartExpression,
    DartArgumentList,
    DartSimpleIdentifier
}

shared
class DartQualifiedInvocable(
        shared DartExpression? receiver,
        shared DartInvocable invocable) {

    shared
    DartQualifiedInvocable with(
            DartExpression? receiver = this.receiver,
            DartInvocable invocable = this.invocable)
        =>  DartQualifiedInvocable(receiver, invocable);

    shared
    DartExpression expressionForLocalCapture()
        =>  invocable.expressionForLocalCapture(receiver);

    shared
    DartExpression expressionForInvocation(
            DartArgumentList|[DartExpression*] arguments = [])
        =>  invocable.expressionForInvocation(receiver, arguments);

    shared
    DartExpression expressionForClosure()
        =>  invocable.expressionForClosure(receiver);
}

object dummyDartInvocable extends DartInvocable(
        DartSimpleIdentifier(""), dartFunction, false) {}

object dummyDartQualifiedInvocable extends DartQualifiedInvocable(
        null, dummyDartInvocable) {}
