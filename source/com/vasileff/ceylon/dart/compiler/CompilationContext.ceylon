import com.redhat.ceylon.model.typechecker.model {
    UnitModel=Unit,
    FunctionModel=Function,
    ClassOrInterfaceModel=ClassOrInterface
}

import org.antlr.runtime {
    Token
}

class CompilationContext(unit, tokens) {

    shared
    UnitModel unit;

    shared
    List<Token> tokens;

    shared
    CeylonTypes ceylonTypes = CeylonTypes(unit);

    shared
    DartTypes dartTypes = DartTypes(ceylonTypes);

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

    variable
    ClassMemberTransformer? cmtMemo = null;

    variable
    ExpressionTransformer? etMemo = null;

    variable
    MiscTransformer? mtMemo = null;

    variable
    StatementTransformer? stMemo = null;

    variable
    TopLevelTransformer? tltMemo = null;

    shared
    ClassMemberTransformer classMemberTransformer
        =>  cmtMemo else (cmtMemo = ClassMemberTransformer(this));

    shared
    ExpressionTransformer expressionTransformer
        =>  etMemo else (etMemo = ExpressionTransformer(this));

    shared
    MiscTransformer miscTransformer
        =>  mtMemo else (mtMemo = MiscTransformer(this));

    shared
    StatementTransformer statementTransformer
        =>  stMemo else (stMemo = StatementTransformer(this));

    shared
    TopLevelTransformer topLevelTransformer
        =>  tltMemo else (tltMemo = TopLevelTransformer(this));

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
