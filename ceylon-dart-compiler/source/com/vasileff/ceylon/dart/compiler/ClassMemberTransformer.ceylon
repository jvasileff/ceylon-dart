import ceylon.ast.core {
    ValueDeclaration,
    ValueDefinition,
    FunctionDeclaration,
    TypeAliasDefinition,
    WideningTransformer,
    Node,
    FunctionDefinition,
    InterfaceDefinition,
    FunctionShortcutDefinition,
    ValueGetterDefinition,
    AnyValue,
    AnyFunction,
    ValueSetterDefinition,
    TypedDeclaration,
    ClassDefinition,
    ObjectDefinition,
    Specifier,
    LazySpecification,
    Assertion,
    ExistsOrNonemptyCondition,
    IsCondition,
    ValueSpecification
}

import com.redhat.ceylon.model.typechecker.model {
    ClassOrInterfaceModel=ClassOrInterface,
    InterfaceModel=Interface,
    SetterModel=Setter,
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue,
    ValueModel=Value,
    TypedDeclarationModel=TypedDeclaration,
    ClassModel=Class
}
import com.vasileff.ceylon.dart.ast {
    DartSimpleIdentifier,
    DartMethodDeclaration,
    DartClassMember,
    DartFormalParameterList,
    DartSimpleFormalParameter,
    dartFormalParameterListEmpty,
    DartTypeName,
    DartFieldDeclaration,
    DartVariableDeclarationList,
    DartVariableDeclaration,
    DartFunctionExpression
}
import com.vasileff.ceylon.dart.nodeinfo {
    AnyFunctionInfo,
    ValueDefinitionInfo,
    AnyValueInfo,
    ValueDeclarationInfo,
    typedDeclarationInfo,
    ValueSetterDefinitionInfo,
    DeclarationInfo,
    ObjectDefinitionInfo,
    LazySpecificationInfo,
    FunctionDeclarationInfo,
    NodeInfo,
    ValueSpecificationInfo
}

shared
class ClassMemberTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<[DartClassMember*]> {

    shared actual
    DartClassMember[] transformLazySpecification(LazySpecification that) {
        value info = LazySpecificationInfo(that);

        if (!info.refined exists) {
            throw CompilerBug(that,
                "LazySpecifications that are not shortcut refinements
                 are not yet supported.");
        }

        // Shortcut refinement; just like function or getter definitions:

        switch (declaration = info.declaration)
        case (is FunctionModel) {
            assert (nonempty parameterLists = that.parameterLists);

            return
            [generateMethodDefinitionRaw {
                info;
                declaration;
                generateFunctionExpressionRaw {
                    info;
                    declaration;
                    parameterLists;
                    that.specifier;
                };
            }];
        }
        case (is ValueModel) {
            return
            [generateMethodDefinitionRaw {
                info;
                declaration;
                generateDefinitionForValueModelGetter {
                    info;
                    declaration;
                    //parameterLists;
                    that.specifier;
                }.functionExpression;
            }];
        }
    }

    shared actual
    [DartClassMember*] transformValueDeclaration(ValueDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        // FIXME ok to just skip these?
        //       Skipping for now to avoid dup declarations w/classes where init params
        //       are declared in the body.
        value info = ValueDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            return [];
        }

        if (info.declarationModel.variable
                && (   info.declarationModel.formal
                    || info.declarationModel.transient)) {
            // Only generate setter declarations for variables that are `formal`
            // or non-references
            return [generateMethodGetterOrSetterDeclaration(that),
                    generateSetterDeclaration(that)];
        }
        else {
            return [generateMethodGetterOrSetterDeclaration(that)];
        }
    }

    shared actual
    []|[DartMethodDeclaration] transformFunctionDeclaration(FunctionDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        // FIXME ok to just skip these?
        //       Skipping for now to avoid dup declarations w/classes where init params
        //       are declared in the body.
        value info = FunctionDeclarationInfo(that);
        if (info.declarationModel.parameter) {
            return [];
        }

        return [generateMethodGetterOrSetterDeclaration(that)];
    }

    shared actual
    [DartClassMember*] transformValueDefinition(ValueDefinition that) {
        value info = ValueDefinitionInfo(that);

        // skip native declarations entirely, for now
        if (!isForDartBackend(info.declarationModel)) {
            return [];
        }

        // Eager values and variables are declared here and initialized in a class
        // body or constructor.
        if (that.definition is Specifier) {
            return [
                DartFieldDeclaration {
                    false;
                    generateForValueDeclaration(that);
                }
            ];
        }

        // NOTE getters cannot be variable, so not worrying about setter declarations
        //      for interfaces which are handled by ValueSetterDefinition
        return generateForMethodGetterOrSetterDefinition(that);
    }

    shared actual
    [DartClassMember*] transformValueGetterDefinition(ValueGetterDefinition that)
        =>  generateForMethodGetterOrSetterDefinition(that);

    shared actual
    [DartClassMember*] transformValueSetterDefinition(ValueSetterDefinition that)
        =>  generateForMethodGetterOrSetterDefinition(that);

    shared actual
    [DartClassMember*] transformValueSpecification(ValueSpecification that)
        =>  if (ValueSpecificationInfo(that).declaration.shortcutRefinement)
            then [generateMethodGetterOrSetterDeclaration(that)]
            else [];

    shared actual
    [DartMethodDeclaration*] transformFunctionDefinition(FunctionDefinition that)
        =>  generateForMethodGetterOrSetterDefinition(that);

    shared actual
    [DartMethodDeclaration*] transformFunctionShortcutDefinition
            (FunctionShortcutDefinition that)
        =>  generateForMethodGetterOrSetterDefinition(that);

    [DartMethodDeclaration*] generateForMethodGetterOrSetterDefinition(
             FunctionDefinition
                | FunctionShortcutDefinition
                | ValueDefinition
                | ValueGetterDefinition
                | ValueSetterDefinition that)
        =>  let (info = DeclarationInfo(that))
            if (!isForDartBackend(that)) then
                [] // skip native declarations entirely, for now
            else if (info.declarationModel.container is InterfaceModel
                    && info.declarationModel.shared) then
                [generateMethodGetterOrSetterDeclaration(that),
                 generateMethodDefinition(that)]
            else
                [generateMethodDefinition(that)];

    "Generates a method or getter declaration (not to be confused with *definition*).
     Note: Setter declarations for `AnyValue`s are *not* generated by this method, and
     may be needed for `variable` values."
    DartMethodDeclaration generateMethodGetterOrSetterDeclaration
            (AnyFunction | AnyValue | ValueSetterDefinition | ValueSpecification that) {

        value info
            =   switch (that)
                case (is TypedDeclaration) typedDeclarationInfo(that)
                case (is ValueSetterDefinition) ValueSetterDefinitionInfo(that)
                case (is ValueSpecification) ValueSpecificationInfo(that);

        value declarationModel
            =   switch (info)
                case (is AnyValueInfo) info.declarationModel
                case (is AnyFunctionInfo) info.declarationModel
                case (is ValueSetterDefinitionInfo) info.declarationModel
                case (is ValueSpecificationInfo) info.declaration;

        "The container of a class or interface member is surely a ClassOrInterface"
        assert (is ClassOrInterfaceModel container
            =   (declarationModel of TypedDeclarationModel).container);

        value [identifier, isFunction]
            =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    info;
                    declarationModel;
                };

        return
        DartMethodDeclaration {
            false;
            null;
            generateFunctionReturnType(info, declarationModel);
            if (isFunction) then
                null
            else if (that is ValueSetterDefinition) then
                "set"
            // no getter for reference values
            else if (declarationModel.formal || declarationModel.transient) then
                "get"
            else
                null;
            identifier;
            parameters =
                if (isFunction, is AnyFunction that) then
                    generateFormalParameterList {
                        info;
                        that.parameterLists.first;
                    }
                else if (is SetterModel declarationModel) then
                    DartFormalParameterList {
                        false; false;
                        [
                            DartSimpleFormalParameter {
                                false; false;
                                dartTypes.dartReturnTypeNameForDeclaration {
                                    info;
                                    declarationModel.getter;
                                };
                                DartSimpleIdentifier {
                                    // use the attribute's name as the parameter name
                                    dartTypes.getName(declarationModel);
                                };
                            }
                        ];
                    }
                else if (isFunction) then
                    dartFormalParameterListEmpty
                else
                    null;
            body = null;
        };
    }

    DartMethodDeclaration generateSetterDeclaration
            (ValueDeclaration | ValueDefinition that) {

        value info
            =   NodeInfo(that);

        value declarationModel
            =   AnyValueInfo(that).declarationModel;

        value [identifier, isFunction]
            =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                    info;
                    declarationModel;
                    true;
                };

        return
        DartMethodDeclaration {
            false;
            null;
            isFunction then
                DartTypeName {
                    DartSimpleIdentifier {
                        "void";
                    };
                };
            !isFunction then "set";
            identifier;
            DartFormalParameterList {
                false; false;
                [
                    DartSimpleFormalParameter {
                        false; false;
                        dartTypes.dartReturnTypeNameForDeclaration {
                            info;
                            declarationModel;
                        };
                        DartSimpleIdentifier {
                            // use the attribute's name as the parameter name
                            dartTypes.getName(declarationModel);
                        };
                    }
                ];
            };
            body = null;
        };
    }

    DartMethodDeclaration generateMethodDefinition(
            FunctionDefinition
            | FunctionShortcutDefinition
            | ValueDefinition
            | ValueGetterDefinition
            | ValueSetterDefinition that) {

        value info
            =   switch (that)
                case (is TypedDeclaration) typedDeclarationInfo(that)
                case (is ValueSetterDefinition) ValueSetterDefinitionInfo(that);

        value declarationModel
            =   switch(info)
                case (is AnyFunctionInfo) info.declarationModel
                case (is AnyValueInfo) info.declarationModel
                case (is ValueSetterDefinitionInfo) info.declarationModel;

        value functionExpression
            =   switch (that)
                case (is AnyFunction)
                    generateFunctionExpression(that)
                case (is ValueDefinition | ValueGetterDefinition)
                    generateForValueDefinitionGetter(that).functionExpression
                case (is ValueSetterDefinition)
                    generateForValueSetterDefinition(that).functionExpression;

        return
        generateMethodDefinitionRaw {
            info;
            declarationModel;
            functionExpression;
        };
    }

    DartMethodDeclaration generateMethodDefinitionRaw(
            DScope scope,
            FunctionOrValueModel declarationModel,
            "A DartFunctionExpression that will be scrapped for parts."
            DartFunctionExpression functionExpression) {

        "Asserting the enumerated types of the abstract class."
        assert (is FunctionModel | ValueModel | SetterModel declarationModel);

        "The container of a class or interface member is surely a Class or Interface"
        assert (is ClassModel | InterfaceModel container
            =   container(declarationModel));

        "Parameters for the function, not including the possible addition of $this."
        value standardParameters
            =   functionExpression.parameters
                else dartFormalParameterListEmpty;

        // TODO defaulted parameters! (see also transformFunctionDefinition)

        // For interfaces, the implementation is always a static method.
        // For classes, the implementation may be a function or getter.

        switch (container)
        case (is InterfaceModel) {
            // a static method definition for the actual implementation
            return
            DartMethodDeclaration {
                false;
                "static";
                generateFunctionReturnType(scope, declarationModel);
                null;
                DartSimpleIdentifier {
                    dartTypes.getStaticInterfaceMethodName {
                        declarationModel;
                    };
                };
                DartFormalParameterList {
                    true; false;
                    [
                        // $this parameter
                        DartSimpleFormalParameter {
                            true; false;
                            dartTypes.dartTypeName {
                                scope;
                                container.type;
                                false; false;
                            };
                            DartSimpleIdentifier("$this");
                        },
                        // value parameters
                        *standardParameters.parameters
                    ].coalesced.sequence();
                };
                functionExpression.body;
            };
        }
        case (is ClassModel) {
            value [dartIdentifier, isFunction]
                =   dartTypes.dartIdentifierForFunctionOrValueDeclaration {
                        scope;
                        declarationModel;
                    };

            return
            DartMethodDeclaration {
                false;
                null;
                generateFunctionReturnType(scope, declarationModel);
                !isFunction then (
                    if (declarationModel is SetterModel)
                    then "set"
                    else "get"
                );
                dartIdentifier;
                if (is SetterModel declarationModel) then
                    DartFormalParameterList {
                        false; false;
                        [
                            DartSimpleFormalParameter {
                                false; false;
                                dartTypes.dartReturnTypeNameForDeclaration {
                                    scope;
                                    declarationModel.getter;
                                };
                                DartSimpleIdentifier {
                                    // use the attribute's name as the parameter name
                                    dartTypes.getName(declarationModel);
                                };
                            }
                        ];
                    }
                else if (isFunction) then
                    DartFormalParameterList {
                        true; false;
                        standardParameters.parameters;
                    }
                else
                    null;
                functionExpression.body;
            };
        }
    }

    shared actual
    [] transformClassDefinition(ClassDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        that.visit(topLevelVisitor);

        // We might have somethiing later for type families. For now, nada.
        return [];
    }

    shared actual
    [] transformInterfaceDefinition(InterfaceDefinition that) {
        that.visit(topLevelVisitor);
        return [];
    }

    shared actual
    [DartClassMember*] transformObjectDefinition(ObjectDefinition that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        that.visit(topLevelVisitor);

        value info = ObjectDefinitionInfo(that);

        // Declare the member field that will be initialized in a Dart constructor.
        return [
        DartFieldDeclaration {
            false;
            DartVariableDeclarationList {
                null;
                dartTypes.dartTypeNameForDeclaration {
                    info;
                    info.declarationModel;
                };
                [DartVariableDeclaration {
                    DartSimpleIdentifier {
                        dartTypes.getName(info.declarationModel);
                    };
                    null;
                }];
            };
        }];
    }

    shared actual
    [] transformTypeAliasDefinition(TypeAliasDefinition that)
        =>  [];

    shared actual
    DartClassMember[] transformAssertion(Assertion that) {
        // Declare class members for new and replacement values
        value capturedVariableTriples
            =   that.conditions.conditions
                    .narrow<IsCondition | ExistsOrNonemptyCondition>()
                    .map(generateConditionExpression)
                    .flatMap((conditionTuple) => conditionTuple[2...])
                    .filter(compose(ctx.capturedInitializerDeclarations.contains,
                                    VariableTriple.declarationModel));

        return
        capturedVariableTriples.collect((variableTriple)
            =>  DartFieldDeclaration {
                    false;
                    generateForValueDeclarationRaw {
                        // TODO Use Condition node for more accurate line/col info
                        //      (must first make the node avail in VariableTriple)
                        NodeInfo(that);
                        variableTriple.declarationModel;
                    };
                });
    }

    shared actual default
    [] transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node (ClassMemberTransformer): '``className(that)``'");
    }
}
