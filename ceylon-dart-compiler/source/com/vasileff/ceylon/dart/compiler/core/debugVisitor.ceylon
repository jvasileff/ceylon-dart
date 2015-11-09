import ceylon.ast.core {
    Visitor,
    CompilationUnit,
    Declaration,
    Parameter
}

shared
object debugVisitor satisfies Visitor {

    shared actual
    void visitCompilationUnit(CompilationUnit that) {
        //super.visitCompilationUnit(that);
        return;
    }

    shared actual
    void visitDeclaration(Declaration that) {
        super.visitDeclaration(that);
    }

    shared actual
    void visitParameter(Parameter that) {
        super.visitParameter(that);
    }
}
