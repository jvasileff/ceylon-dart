import com.redhat.ceylon.model.typechecker.model {
    UnitModel=Unit,
    TypeModel=Type
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

    shared late
    ClassMemberTransformer classMemberTransformer;

    shared late
    ExpressionTransformer expressionTransformer;

    shared late
    MiscTransformer miscTransformer;

    shared late
    StatementTransformer statementTransformer;

    shared late
    TopLevelTransformer topLevelTransformer;

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
    void init() {
        classMemberTransformer = ClassMemberTransformer(this);
        expressionTransformer = ExpressionTransformer(this);
        miscTransformer = MiscTransformer(this);
        statementTransformer = StatementTransformer(this);
        topLevelTransformer = TopLevelTransformer(this);
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

"Indicates the absence of a type (like void). One use is to
 indicate the absence of a `lhsType` when determining if
 the result of an expression should be boxed."
interface NoType of noType {}

"The instance of `NoType`"
object noType satisfies NoType {}

alias TypeOrNoType => TypeModel | NoType;
alias FormalActualOrNoType => [TypeModel, TypeModel] | NoType;
