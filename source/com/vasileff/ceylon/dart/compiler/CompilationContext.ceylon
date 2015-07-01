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
    TypeOrNoType? lhsTypeTop = null;

    shared variable
    TypeOrNoType? returnTypeTop = null;

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
    Result withLhsType<Result>
            (TypeOrNoType lhsType, Result fun()) {
        value save = lhsTypeTop;
        try {
            lhsTypeTop = lhsType;
            value result = fun();
            return result;
        }
        finally {
            lhsTypeTop = save;
        }
    }

    shared
    Result withReturnType<Result>
            (TypeOrNoType returnType, Result fun()) {
        value save = returnTypeTop;
        try {
            returnTypeTop = returnType;
            return fun();
        }
        finally {
            returnTypeTop = save;
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
