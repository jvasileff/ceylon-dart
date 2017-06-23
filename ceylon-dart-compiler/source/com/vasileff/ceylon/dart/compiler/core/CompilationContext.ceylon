import ceylon.collection {
    HashSet,
    LinkedList,
    HashMap,
    MutableSet
}

import com.redhat.ceylon.model.typechecker.model {
    ValueModel=Value,
    UnitModel=Unit,
    ClassModel=Class,
    ClassOrInterfaceModel=ClassOrInterface,
    FunctionOrValueModel=FunctionOrValue,
    TypedDeclarationModel=TypedDeclaration,
    TypeParameterModel=TypeParameter,
    TypeModel=Type
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnitMember,
    DartSimpleIdentifier
}
import com.vasileff.ceylon.structures {
    SetMultimap,
    HashMultimap
}

import org.antlr.runtime {
    Token
}

shared
CompilationContext ctx
    =>  compilationContextual.get();

shared
Contextual<CompilationContext> compilationContextual
    =   Contextual<CompilationContext>();

shared final
class CompilationContext {

    shared
    UnitModel unit;

    shared
    List<Token> tokens;

    shared
    new (unit, tokens) {
        UnitModel unit;
        List<Token> tokens;
        this.unit = unit;
        this.tokens = tokens;
    }

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
        =   HashMultimap<ClassModel, FunctionOrValueModel> {};

    shared variable
    SetMultimap<FunctionOrValueModel | TypeParameterModel, ClassOrInterfaceModel>
    capturedDeclarations
        =   HashMultimap<FunctionOrValueModel| TypeParameterModel,
                         ClassOrInterfaceModel> {};

    "A multimap to associated each capturing class and interface with its list of
     captures. A [[HashMultimap]] with linked stability is used to preserve insertion
     order. A consistent order is important as the capture lists will be used to build
     parameter and argument lists."
    shared variable
    SetMultimap<ClassOrInterfaceModel, FunctionOrValueModel | TypeParameterModel> captures
        =   HashMultimap<ClassOrInterfaceModel, FunctionOrValueModel> {};

    "Value members that are `late` and specified."
    shared
    MutableSet<ValueModel> memoizedValues
        =   HashSet<ValueModel>();

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

    "When [[lhsDenotableTop]] is used, what type do we expect the rhs expression to
     yield? This is used to ensure type arguments are applied to type constructors as
     necessary."
    shared variable
    TypeModel? lhsDenotableRhsExpectedTop = null;

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
    CeylonTypes ceylonTypes = CeylonTypes(unit);

    shared
    DartTypes dartTypes = DartTypes(ceylonTypes);

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
