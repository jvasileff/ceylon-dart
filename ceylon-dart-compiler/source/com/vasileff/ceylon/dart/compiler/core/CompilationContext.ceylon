import ceylon.collection {
    HashSet,
    LinkedList,
    HashMap,
    MutableSet
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.context {
    PhasedUnit,
    Context
}
import com.redhat.ceylon.model.typechecker.model {
    UnitModel=Unit,
    ClassModel=Class,
    ClassOrInterfaceModel=ClassOrInterface,
    FunctionOrValueModel=FunctionOrValue,
    TypedDeclarationModel=TypedDeclaration
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnitMember,
    DartSimpleIdentifier
}
import com.vasileff.jl4c.guava.collect {
    LinkedHashMultimap,
    SetMultimap,
    ImmutableSetMultimap
}

import org.antlr.runtime {
    Token
}

shared
class CompilationContext(PhasedUnit phasedUnit, Context typeCheckerContext) {

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

    "Captured functions and values that occur in class initializers and constructors, as
     opposed to captured functions and values with non-class or interface containers."
    shared variable
    Set<FunctionOrValueModel> capturedInitializerDeclarations
        =   emptySet;

    "A Multimap containing captured initializer declarations by class. Contains the same
     items as [[capturedInitializerDeclarations]]."
    shared variable
    SetMultimap<ClassModel, FunctionOrValueModel> initializerCaptures
        =   ImmutableSetMultimap<ClassModel, FunctionOrValueModel> {};

    shared variable
    ImmutableSetMultimap<FunctionOrValueModel,ClassOrInterfaceModel> capturedDeclarations
        =   ImmutableSetMultimap<FunctionOrValueModel, ClassOrInterfaceModel> {};

    "A multimap to associated each capturing class and interface with its list of
     captures. A [[LinkedHashMultimap]] is used to preserve insertion order. A
     consistent order is important as the capture lists will be used to build parameter
     and argument lists."
    shared variable
    SetMultimap<ClassOrInterfaceModel, FunctionOrValueModel> captures
        =   ImmutableSetMultimap<ClassOrInterfaceModel, FunctionOrValueModel> {};

    "Dart declaration names for Ceylon declarations.

     Additionally, for replacement declarations, the existance of a declaration in this
     map indicates that a cooresponding Dart replacement declaration exists."
    shared
    HashMap<TypedDeclarationModel, String> nameCache
        =   HashMap<TypedDeclarationModel, String>();

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
    FunctionOrValueModel | TypeDetails | Null returnTypeOrDeclarationTop = null;

    "Classes for which we are currently generating a Dart constructor, and therefore need
     to qualify members that are also parameters with `this`"
    shared
    MutableSet<ClassModel> withinConstructorBodySet = HashSet<ClassModel>();

    "Classes for which we are currently generating a 'consolidated' Dart constructor, and
     therefore need to qualify parameter names with their original constructor names by
     prefixing them."
    shared
    MutableSet<ClassModel> withinConsolidatedConstructorSet = HashSet<ClassModel>();

    "Classes for which we are currently calculating default values for parameters of a
     Dart constructor, and therefore need to consider erased to $dart$core.Object."
    shared
    MutableSet<ClassModel> withinConstructorDefaultsSet = HashSet<ClassModel>();

    "Classes for which we are currently calculating initializer parameter lists or extends
     clauses, and therefore need to treat shared callable parameters as Callable values."
    shared
    MutableSet<ClassModel> withinConstructorSignatureSet = HashSet<ClassModel>();

    shared
    CeylonTypes ceylonTypes = CeylonTypes(unit, typeCheckerContext);

    variable
    DartTypes? dartTypesMemo = null;

    variable
    ClassMemberTransformer? cmtMemo = null;

    variable
    ClassStatementTransformer? cstMemo = null;

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
    ClassStatementTransformer classStatementTransformer
        =>  cstMemo else (cstMemo = ClassStatementTransformer(this));

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
    FunctionOrValueModel | TypeDetails assertedReturnDeclaration {
        assert(exists top = returnTypeOrDeclarationTop);
        return top;
    }

    shared
    Boolean withinConstructor(ClassOrInterfaceModel classDeclaration)
        =>  withinConstructorBodySet.contains(classDeclaration);
}
