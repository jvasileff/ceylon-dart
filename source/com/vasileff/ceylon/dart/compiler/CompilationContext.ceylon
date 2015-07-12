import com.redhat.ceylon.model.typechecker.model {
    UnitModel=Unit
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
    StringBuilder result = StringBuilder();

    shared
    CeylonTypes ceylonTypes = CeylonTypes(unit);

    shared
    DartTypes dartTypes = DartTypes(ceylonTypes);

    shared variable
    FormalActualOrNoType? lhsFormalActualTop = null;

    shared variable
    FormalActualOrNoType? returnFormalActualTop = null;

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
    FormalActualOrNoType assertedLhsFormalActualTop {
        assert(exists fat = lhsFormalActualTop);
        return fat;
    }

    shared
    TypeOrNoType assertedLhsFormalTop
        =>  switch (fat = assertedLhsFormalActualTop)
            case (is NoType) noType
            else fat[0];

    shared
    TypeOrNoType assertedLhsActualTop
        =>  switch (fat = assertedLhsFormalActualTop)
            case (is NoType) noType
            else fat[1];

    shared
    FormalActualOrNoType assertedReturnFormalActualTop {
        assert(exists fat = returnFormalActualTop);
        return fat;
    }

    shared
    Result withLhsType<Result>(
            FormalActualOrNoType lhsFormalActual,
            Result fun()) {
        value save = lhsFormalActualTop;
        try {
            lhsFormalActualTop = lhsFormalActual;
            value result = fun();
            return result;
        }
        finally {
            lhsFormalActualTop = save;
        }
    }

    shared
    Result withReturnType<Result>(
            FormalActualOrNoType returnFormalActual,
            Result fun()) {
        value save = returnFormalActualTop;
        try {
            returnFormalActualTop = returnFormalActual;
            return fun();
        }
        finally {
            returnFormalActualTop = save;
        }
    }
}
