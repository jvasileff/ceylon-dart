import com.redhat.ceylon.model.typechecker.model {
    UnitModel=Unit,
    FunctionModel=Function,
    ClassOrInterfaceModel=ClassOrInterface,
    FunctionOrValueModel=FunctionOrValue
}

import org.antlr.runtime {
    Token
}
import ceylon.collection {
    HashSet,
    LinkedList
}
import com.vasileff.ceylon.dart.ast {
    DartCompilationUnitMember,
    DartSimpleIdentifier
}
import com.redhat.ceylon.compiler.typechecker.context {
    PhasedUnit
}
import ceylon.interop.java {
    CeylonList
}

shared
class CompilationContext(PhasedUnit phasedUnit) {

    shared
    UnitModel unit = phasedUnit.unit;

    shared
    List<Token> tokens = CeylonList(phasedUnit.tokens);

    "The output."
    shared
    LinkedList<DartCompilationUnitMember> compilationUnitMembers
        =   LinkedList<DartCompilationUnitMember>();

    shared
    HashSet<FunctionOrValueModel> disableErasureToNative
        =   HashSet<FunctionOrValueModel>();

    shared variable
    DartSimpleIdentifier? doFailVariableTop = null;

    "Boxing should calculate a denotable type. Trumps other `lhs` values."
    shared variable
    ClassOrInterfaceModel? lhsDenotableTop = null;

    shared variable
    TypeOrNoType? lhsTypeTop = null;

    shared variable
    Boolean? lhsErasedToNativeTop = null;

    shared variable
    Boolean? lhsErasedToObjectTop = null;

    shared variable
    FunctionModel? returnDeclarationTop = null;

    shared
    CeylonTypes ceylonTypes = CeylonTypes(unit);

    variable
    DartTypes? dartTypesMemo = null;

    variable
    ClassMemberTransformer? cmtMemo = null;

    variable
    ExpressionTransformer? etMemo = null;

    variable
    StatementTransformer? stMemo = null;

    variable
    TopLevelVisitor? tltMemo = null;

    shared
    DartTypes dartTypes
        =>  dartTypesMemo else (dartTypesMemo = DartTypes(ceylonTypes, this));

    shared
    ClassMemberTransformer classMemberTransformer
        =>  cmtMemo else (cmtMemo = ClassMemberTransformer(this));

    shared
    ExpressionTransformer expressionTransformer
        =>  etMemo else (etMemo = ExpressionTransformer(this));

    shared
    StatementTransformer statementTransformer
        =>  stMemo else (stMemo = StatementTransformer(this));

    shared
    TopLevelVisitor topLevelVisitor
        =>  tltMemo else (tltMemo = TopLevelVisitor(this));

    shared
    TypeOrNoType assertedLhsTypeTop {
        assert (exists top = lhsTypeTop);
        return top;
    }

    shared
    Boolean assertedLhsErasedToNativeTop {
        assert (exists top = lhsErasedToNativeTop);
        return top;
    }

    shared
    Boolean assertedLhsErasedToObjectTop {
        assert (exists top = lhsErasedToObjectTop);
        return top;
    }

    shared
    FunctionModel assertedReturnDeclaration {
        assert(exists top = returnDeclarationTop);
        return top;
    }
}
