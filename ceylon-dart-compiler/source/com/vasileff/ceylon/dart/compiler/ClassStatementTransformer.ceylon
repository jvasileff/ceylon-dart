import ceylon.ast.core {
    FunctionDefinition,
    ValueDefinition,
    FunctionShortcutDefinition,
    ValueDeclaration,
    Node,
    WideningTransformer,
    LazySpecifier,
    Specifier,
    ValueGetterDefinition,
    ObjectDefinition,
    Statement,
    Specification,
    FunctionDeclaration,
    LazySpecification,
    ClassDefinition,
    ValueSpecification,
    ValueSetterDefinition
}

import com.vasileff.ceylon.dart.ast {
    DartVariableDeclarationStatement,
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartExpressionStatement,
    DartStatement
}
import com.vasileff.ceylon.dart.nodeinfo {
    LazySpecificationInfo
}

"Similar to [[StatementTransformer]], but for translating children of class bodies where
 some declarations are class members and should not be re-declared in a dart constructor."
shared
class ClassStatementTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<[DartStatement*]> {

    shared actual
    DartStatement[] transformStatement(Statement that)
        =>  if (that is Specification && !that is ValueSpecification)
            then super.transformStatement(that)
            else that.transform(statementTransformer);

    "The value may be a class member. So:

     1. If this is a getter (has a LazySpecifier), ignore
     2. Otherwise, assign the value to the member (but don't declaration a new variable)
    "
    shared actual
    DartStatement[] transformValueDefinition(ValueDefinition that) {
        switch (definition = that.definition)
        case (is LazySpecifier) {
            return [];
        }
        case (is Specifier) {
            "A DartVariableDeclarationStatement that will be scrapped for parts."
            assert (is DartVariableDeclarationStatement declarationStatement
                =   that.transform(statementTransformer).first);

            value dartVariableDeclaration
                =   declarationStatement.variableList.variables.first;

            assert (exists initializer
                =   dartVariableDeclaration.initializer);

            return
            [DartExpressionStatement {
                DartAssignmentExpression {
                    dartVariableDeclaration.name;
                    DartAssignmentOperator.equal;
                    initializer;
                };
            }];
        }
    }

    shared actual
    DartStatement[] transformLazySpecification(LazySpecification that) {
        value info = LazySpecificationInfo(that);

        if (!info.refined exists) {
            throw CompilerBug(that,
                "LazySpecifications that are not shortcut refinements
                 are not yet supported.");
        }

        // Functions and Values are (currently) always declared as members.
        return [];
    }

    "Values are (currently) always declared as members."
    shared actual
    DartStatement[] transformValueDeclaration(ValueDeclaration that)
        =>  [];

    "Value getters are always lazy and are (currently) always captured as members."
    shared actual
    DartStatement[] transformValueGetterDefinition(ValueGetterDefinition that)
        =>  [];

    "Value setters are always lazy and are (currently) always captured as members."
    shared actual
    DartStatement[] transformValueSetterDefinition(ValueSetterDefinition that)
        =>  [];

    "Functions are (currently) always captured as members."
    shared actual
    DartStatement[] transformFunctionShortcutDefinition(FunctionShortcutDefinition that)
        =>  [];

    "Functions are (currently) always captured as members."
    shared actual
    DartStatement[] transformFunctionDeclaration(FunctionDeclaration that)
        =>  [];

    "Functions are (currently) always captured as members."
    shared actual
    DartStatement[] transformFunctionDefinition(FunctionDefinition that)
        =>  [];

    "Initialize the value/field. The class will have already been defined by
     [[ClassMemberTransformer.transformObjectDefinition]]."
    shared actual
    DartStatement[] transformObjectDefinition(ObjectDefinition that) {
        value dartVariableDeclaration
            =   generateForObjectDefinition(that).variables.first;

        assert (exists initializer
            =   dartVariableDeclaration.initializer);

        // declare the value, instantiate the object
        return
        [DartExpressionStatement {
            DartAssignmentExpression {
                dartVariableDeclaration.name;
                DartAssignmentOperator.equal;
                initializer;
            };
        }];
    }

    "Nothing to do. The class will have already been defined/declared by
     [[ClassMemberTransformer.transformClassDefinition]]."
    shared actual
    DartStatement[] transformClassDefinition(ClassDefinition that)
        =>  [];

    shared actual default
    [] transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node (ClassStatementTransformer): '``className(that)``'");
    }
}
