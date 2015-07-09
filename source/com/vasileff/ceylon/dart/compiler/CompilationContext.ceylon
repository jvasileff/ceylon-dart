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
    TypeOrNoType? lhsFormalTop = null;

    shared variable
    TypeOrNoType? lhsActualTop = null;

    shared variable
    TypeOrNoType? returnFormalTop = null;

    shared variable
    TypeOrNoType? returnActualTop = null;

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
    void init() {
        classMemberTransformer = ClassMemberTransformer(this);
        expressionTransformer = ExpressionTransformer(this);
        miscTransformer = MiscTransformer(this);
        statementTransformer = StatementTransformer(this);
        topLevelTransformer = TopLevelTransformer(this);
    }

    shared
    Result withLhsType<Result>(
            TypeOrNoType lhsFormal,
            TypeOrNoType lhsActual,
            Result fun()) {
        value saveFormal = lhsFormalTop;
        value saveActual = lhsActualTop;
        try {
            lhsFormalTop = lhsFormal;
            lhsActualTop = lhsActual;
            value result = fun();
            return result;
        }
        finally {
            lhsFormalTop = saveFormal;
            lhsActualTop = saveActual;
        }
    }

    shared
    Result withReturnType<Result>(
            TypeOrNoType returnFormal,
            TypeOrNoType returnActual,
            Result fun()) {
        value saveFormal = returnFormalTop;
        value saveActual = returnActualTop;
        try {
            returnFormalTop = returnFormal;
            returnActualTop = returnActual;
            return fun();
        }
        finally {
            returnFormalTop = saveFormal;
            returnActualTop = saveActual;
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
