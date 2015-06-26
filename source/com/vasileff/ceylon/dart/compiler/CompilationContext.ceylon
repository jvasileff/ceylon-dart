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
    TypeFactory typeFactory = TypeFactory(unit);

    shared
    Naming naming = Naming(typeFactory);

    shared variable
    TypeOrNoType? lhsTypeTop = null;

    shared variable
    TypeOrNoType? returnTypeTop = null;

    shared late
    DartTransformer dartTransformer;

    shared late
    ExpressionTransformer expressionTransformer;

    shared late
    StatementTransformer statementTransformer;

    shared late
    TopLevelTransformer topLevelTransformer;

    shared
    void init() {
        dartTransformer = DartTransformer(this);
        expressionTransformer = ExpressionTransformer(this);
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