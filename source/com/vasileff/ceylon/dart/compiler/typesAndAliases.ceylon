import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type
}

"Indicates the absence of a type (like void). One use is to
 indicate the absence of a `lhsType` when determining if
 the result of an expression should be boxed."
shared interface NoType of noType {}

"The instance of `NoType`"
shared object noType satisfies NoType {}

shared alias TypeOrNoType => TypeModel | NoType;
