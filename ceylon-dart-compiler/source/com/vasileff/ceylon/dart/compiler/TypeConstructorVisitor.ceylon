import com.redhat.ceylon.compiler.typechecker.parser {
    CeylonLexer
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Visitor,
    Node,
    Tree
}

import org.antlr.runtime {
    CommonToken
}

object typeConstructorVisitor extends Visitor() {
    function dummyBaseType(Tree.TypeConstructor typeConstructor) {
        value replacement = Tree.BaseType(typeConstructor.token);
        replacement.declarationModel = typeConstructor.declarationModel;
        replacement.typeModel = typeConstructor.typeModel;

        value identifier = Tree.Identifier(null);
        value token = CommonToken(CeylonLexer.\iUIDENTIFIER, "dummy");
        token.startIndex = 0;
        token.stopIndex = 5;
        identifier.token = token;
        identifier.text = "dummy";
        replacement.identifier = identifier;

        return replacement;
    }

    shared actual
    void visitAny(Node that) {
        super.visitAny(that);
    }

    shared actual
    void visit(Tree.TypedDeclaration that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.TypeOperatorExpression that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }


    shared actual
    void visit(Tree.SpreadType that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.SatisfiesCase that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.IsCase that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.IsCondition that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.TypedArgument that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.FunctionArgument that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.SatisfiesCondition that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.SequencedType that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }

    shared actual
    void visit(Tree.DefaultedType that) {
        if (is Tree.TypeConstructor typeConstructor = that.type) {
            that.type = dummyBaseType(typeConstructor);
        }
        super.visit(that);
    }
}
