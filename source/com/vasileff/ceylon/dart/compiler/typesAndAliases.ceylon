import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type
}

"Indicates the absence of a type (like void). One use is to
 indicate the absence of a `lhsType` when determining if
 the result of an expression should be boxed."
interface NoType of noType {}

"The instance of `NoType`"
object noType satisfies NoType {}

alias TypeOrNoType => TypeModel | NoType;
