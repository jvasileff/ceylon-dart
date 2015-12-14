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
    ValueSpecification,
    ConstructorDefinition,
    DynamicModifier,
    DynamicInterfaceDefinition,
    DynamicBlock,
    DynamicValue
}

import com.redhat.ceylon.model.typechecker.model {
    InterfaceModel=Interface,
    SetterModel=Setter,
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue,
    ValueModel=Value,
    ClassModel=Class
}
import com.vasileff.ceylon.dart.compiler {
    DScope
}
import com.vasileff.ceylon.dart.compiler.dartast {
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
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    AnyFunctionInfo,
    ValueDefinitionInfo,
    AnyValueInfo,
    ValueDeclarationInfo,
    typedDeclarationInfo,
    ValueSetterDefinitionInfo,
    ObjectDefinitionInfo,
    LazySpecificationInfo,
    FunctionDeclarationInfo,
    ValueSpecificationInfo,
    anyValueInfo,
    declarationInfo,
    nodeInfo
}

shared
class ClassMemberTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<[DartClassMember*]> {

    "Don't transform Constructors; they are handled elsewhere."
    shared actual
    [] transformConstructorDefinition(ConstructorDefinition that)
        =>  [];

    shared actual
    see(`function transformValueGetterDefinition`)
    see(`function transformFunctionShortcutDefinition`)
    DartClassMember[] transformLazySpecification(LazySpecification that) {
        value info = LazySpecificationInfo(that);

        if (!info.refined exists) {
            addError(that,
                "LazySpecifications that are not shortcut refinements
                 are not yet supported.");
            return [];
        }

        // Shortcut refinement; just like function or getter definitions:

        value dartDeclaration
            =   if (container(info.declaration) is InterfaceModel
                        && info.declaration.shared)
                then generateMethodGetterOrSetterDeclaration(that)
                else null;

        DartMethodDeclaration dartDefinition;
        switch (declaration = info.declaration)
        case (is FunctionModel) {
            assert (nonempty parameterLists = that.parameterLists);

            dartDefinition
                =   generateMethodDefinitionRaw {
                        info;
                        declaration;
                        generateFunctionExpressionRaw {
                            info;
                            declaration;
                            parameterLists;
                            that.specifier;
                        };
                    };
        }
        case (is ValueModel) {
            dartDefinition
                =   generateMethodDefinitionRaw {
                        info;
                        declaration;
                        generateDefinitionForValueModelGetter {
                            info;
                            declaration;
                            //parameterLists;
                            that.specifier;
                        }.functionExpression;
                    };
        }

        return [dartDeclaration, dartDefinition].coalesced.sequence();
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
        =>  let (info = declarationInfo(that))
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
    DartMethodDeclaration generateMethodGetterOrSetterDeclaration(
            AnyFunction | AnyValue | ValueSetterDefinition
                | ValueSpecification | LazySpecification that) {

        value info
            =   switch (that)
                case (is TypedDeclaration) typedDeclarationInfo(that)
                case (is ValueSetterDefinition) ValueSetterDefinitionInfo(that)
                case (is ValueSpecification) ValueSpecificationInfo(that)
                case (is LazySpecification) LazySpecificationInfo(that);

        value declarationModel
            =   switch (info)
                case (is AnyValueInfo) info.declarationModel
                case (is AnyFunctionInfo) info.declarationModel
                case (is ValueSetterDefinitionInfo) info.declarationModel
                case (is ValueSpecificationInfo) info.declaration
                case (is LazySpecificationInfo) info.declaration;

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    info;
                    declarationModel;
                }.oldPairSimple;

        return
        DartMethodDeclaration {
            false;
            null;
            generateFunctionReturnType(info, declarationModel);
            if (dartElementType != dartValue) then
                null
            else if (that is ValueSetterDefinition) then
                "set"
            // no getter for reference values
            else if (declarationModel.formal || declarationModel.transient) then
                "get"
            else
                null;
            dartElementType is DartOperator;
            identifier;
            parameters =
                if (dartElementType != dartValue, is AnyFunction that) then
                    generateFormalParameterList {
                        !dartElementType is DartOperator; false;
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
                else if (dartElementType != dartValue) then
                    dartFormalParameterListEmpty
                else
                    null;
            body = null;
        };
    }

    DartMethodDeclaration generateSetterDeclaration
            (ValueDeclaration | ValueDefinition that) {

        value info
            =   nodeInfo(that);

        value declarationModel
            =   anyValueInfo(that).declarationModel;

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    info;
                    declarationModel;
                    true;
                }.oldPairSimple;

        return
        DartMethodDeclaration {
            false;
            null;
            dartElementType != dartValue then
                DartTypeName {
                    DartSimpleIdentifier {
                        "void";
                    };
                };
            dartElementType == dartValue then "set";
            dartElementType is DartOperator;
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
                false;
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
            value [dartIdentifier, dartElementType]
                =   dartTypes.dartInvocable {
                        scope;
                        declarationModel;
                    }.oldPairSimple;

            return
            DartMethodDeclaration {
                false;
                null;
                generateFunctionReturnType(scope, declarationModel);
                dartElementType == dartValue then (
                    if (declarationModel is SetterModel)
                    then "set"
                    else "get"
                );
                dartElementType is DartOperator;
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
                else if (dartElementType != dartValue) then
                    DartFormalParameterList {
                        !dartElementType is DartOperator; false;
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
                    .map((c)
                        =>  if (is IsCondition | ExistsOrNonemptyCondition c)
                            then c
                            else null)
                    .coalesced
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
                        nodeInfo(that);
                        variableTriple.declarationModel;
                    };
                });
    }

    shared actual default
    [] transformNode(Node that) {
        if (that is DynamicBlock | DynamicInterfaceDefinition
                | DynamicModifier | DynamicValue) {
            addError(that, "dynamic is not supported on the Dart VM");
            return [];
        }
        addError(that,
            "Node type not yet supported (ClassMemberTransformer): \
             ``className(that)``");
        return [];
    }
}
