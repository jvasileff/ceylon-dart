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
    TypeAliasDefinition,
    FunctionDeclaration,
    LazySpecification,
    ClassDefinition,
    ValueSpecification,
    ValueSetterDefinition,
    InterfaceDefinition,
    ConstructorDefinition,
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue,
    ClassAliasDefinition,
    InterfaceAliasDefinition,
    Import
}

import com.vasileff.ceylon.dart.compiler.dartast {
    DartAssignmentExpression,
    DartAssignmentOperator,
    DartExpressionStatement,
    DartStatement
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    valueDefinitionInfo,
    lazySpecificationInfo,
    objectDefinitionInfo
}

"Similar to [[statementTransformer]], but for translating children of class bodies where
 some declarations are class members and should not be re-declared in a dart constructor."
shared
object classStatementTransformer
        extends BaseGenerator()
        satisfies WideningTransformer<[DartStatement*]> {

    shared actual
    DartStatement[] transformStatement(Statement that)
        =>  that.transform(statementTransformer);

    shared actual
    DartStatement[] transformValueSpecification(ValueSpecification that)
        // This could be a specification for a forward declared function or a shortcut
        // refinement, but StatementTransformer will need to take care of those
        // possibilities
        =>  that.transform(statementTransformer);

    "Ignore type aliases for now."
    shared actual
    [] transformTypeAliasDefinition(TypeAliasDefinition that) => [];

    "Class aliases are handled by [[classMemberTransformer.transformAnyClass]]."
    shared actual
    [] transformClassAliasDefinition(ClassAliasDefinition that) => [];

    "Interface aliases are not reified."
    shared actual
    [] transformInterfaceAliasDefinition(InterfaceAliasDefinition that) => [];

    "Don't transform Constructors; they are handled elsewhere."
    shared actual
    [] transformConstructorDefinition(ConstructorDefinition that)
        =>  [];

    "The value may be a class member. So:

     1. If this is a getter (has a LazySpecifier), ignore
     2. If this is a static value, ignore
     3. Otherwise, assign the value to the member (but don't declare a new variable)

     Note: for item 3, we need to assign to a synthetic field if the declaration is
     overridable (not `default`)."
    shared actual
    DartStatement[] transformValueDefinition(ValueDefinition that) {
        value info = valueDefinitionInfo(that);

        switch (definition = that.definition)
        case (is LazySpecifier) {
            return [];
        }
        case (is Specifier) {
            // ignore static values; they are initialized when declared
            if (info.declarationModel.static) {
                return [];
            }

            // ignore memoized (late + specified)
            if (ctx.memoizedValues.contains(info.declarationModel)) {
                return [];
            }

            // Similar to StatementTransformer.transformAssignmentStatement(), but we
            // can get away with using getName() and DartAssignmentExpression here since
            // we'll never be dealing with a capture, something that needs 'this.', etc.

            return withLhsNoType {
                () => [DartExpressionStatement {
                    DartAssignmentExpression {
                        // The possibly synthetic field for the value
                        dartTypes.identifierForField(info.declarationModel);
                        DartAssignmentOperator.equal;
                        withLhs {
                            null;
                            info.declarationModel;
                            () => that.definition.expression.transform {
                                expressionTransformer;
                            };
                        };
                    };
                }];
            };
        }
    }

    shared actual
    DartStatement[] transformLazySpecification(LazySpecification that) {
        value info = lazySpecificationInfo(that);

        if (!info.declaration.shortcutRefinement) {
            // Specification for a forward declared function or value.
            return that.transform(statementTransformer);
        }

        // It's a shortcut refinement. Functions and Values are (currently) always
        // declared as members.
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
     [[classMemberTransformer.transformObjectDefinition]]."
    shared actual
    DartStatement[] transformObjectDefinition(ObjectDefinition that) {
        value info = objectDefinitionInfo(that);

        if (info.declarationModel.static) {
            // Not an instance field; the class's static field is initialized when
            // declared.
            return [];
        }

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
     [[classMemberTransformer.transformClassDefinition]]."
    shared actual
    DartStatement[] transformClassDefinition(ClassDefinition that)
        =>  [];

    "Nothing to do. The class will have already been defined/declared by
     [[classMemberTransformer.transformInterfaceDefinition]]."
    shared actual
    DartStatement[] transformInterfaceDefinition(InterfaceDefinition that)
        =>  [];

    shared actual
    DartStatement[] transformImport(Import that) {
        return [];
    }

    shared actual
    [] transformNode(Node that) {
        if (that is DynamicBlock | DynamicInterfaceDefinition
                | DynamicModifier | DynamicValue) {
            addError(that, "dynamic is not supported on the Dart VM");
            return [];
        }
        addError(that,
            "Node type not yet supported (ClassStatementTransformer): \
             ``className(that)``");
        return [];
    }
}
