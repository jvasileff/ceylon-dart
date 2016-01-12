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
    DynamicValue,
    DefaultedParameter,
    DefaultedCallableParameter
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
    DartFunctionExpression,
    DartExpressionFunctionBody,
    DartFormalParameter,
    DartBlockFunctionBody,
    DartReturnStatement,
    DartBlock,
    DartVariableDeclarationStatement,
    DartAssignmentExpression,
    DartExpressionStatement,
    DartAssignmentOperator,
    DartFunctionExpressionInvocation,
    DartArgumentList
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
    nodeInfo,
    DeclarationInfo,
    DefaultedParameterInfo,
    anyFunctionInfo
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

        if (!info.declaration.shortcutRefinement) {
            // Specification for a forward declared function or value that will be
            // handled by ClassStatementTransformer (or StatementTransformer)
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

    DartMethodDeclaration generateBridgeForForwardDeclaredValue
            (ValueDeclaration that)
        =>  let (info = anyValueInfo(that))
            generateMethodDefinitionRaw {
                info;
                info.declarationModel;
                DartFunctionExpression {
                    dartFormalParameterListEmpty;
                    DartExpressionFunctionBody {
                        false;
                        // No boxing since we're using a native dart Function for $f, and
                        // it will return the expected native type for native values.
                        DartFunctionExpressionInvocation {
                            DartSimpleIdentifier {
                                // TODO consolidate naming logic.
                                "_" + dartTypes.getName(info.declarationModel) + "$f";
                            };
                            DartArgumentList([]);
                        };
                    };
                };
            };

    shared actual
    [DartClassMember*] transformValueDeclaration(ValueDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        value info = ValueDeclarationInfo(that);

        // Avoid duplicate declarations where initializer parameters are
        // declared in the body.
        if (info.declarationModel.parameter) {
            return [];
        }

        if (!info.declarationModel.formal
                && !info.declarationModel.transient
                && dartTypes.valueMappedToNonField(info.declarationModel)) {
            // For Ceylon reference values that are translated to non-value Dart elements
            // (like string -> toString()), we need a synthetic field for the reference
            // (e.g. string) and a bridge method (e.g. toString()).
            return [
                generateFieldDeclaration {
                    info;
                    info.declarationModel;
                },
                generateMethodToReferenceForwarder {
                    info;
                    info.declarationModel;
                }
            ];
        }

        if (!info.declarationModel.formal && info.declarationModel.transient) {
            // A forward declared lazy value

            // TODO consolidate naming
            value callableVariableName
                =   "_" + dartTypes.getName(info.declarationModel) + "$f";

            value callableVariable
                =   DartSimpleIdentifier(callableVariableName);

            return [
                // Field to hold the Callable for the forward declared function
                DartFieldDeclaration {
                    false;
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartFunction;
                        [DartVariableDeclaration {
                            callableVariable;
                        }];
                    };
                },
                // The method, which forwards to the callableVariable
                generateBridgeForForwardDeclaredValue(that)
            ];
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

    DartMethodDeclaration generateForwardDeclaredForwarderMethod
            (FunctionDeclaration that) {

        value info
            =   anyFunctionInfo(that);

        value functionExpression
            =   generateForwardDeclaredForwarder {
                    info;
                    info.declarationModel;
                    that.parameterLists;
                };

        value [identifier, dartElementType]
            =   dartTypes.dartInvocable {
                    info;
                    info.declarationModel;
                }.oldPairSimple;

        assert (dartElementType is \IdartFunction | DartOperator);

        return
        DartMethodDeclaration {
            false;
            null;
            generateFunctionReturnType {
                info;
                info.declarationModel;
            };
            null;
            dartElementType is DartOperator;
            identifier;
            functionExpression.parameters;
            functionExpression.body;
        };
    }

    shared actual
    [DartClassMember*] transformFunctionDeclaration(FunctionDeclaration that) {
        // skip native declarations entirely, for now
        if (!isForDartBackend(that)) {
            return [];
        }

        value info = FunctionDeclarationInfo(that);

        // Avoid duplicate declarations where initializer parameters are
        // declared in the body.
        if (info.declarationModel.parameter) {
            return [];
        }

        if (!info.declarationModel.formal) {
            // A forward declared function.

            value callableVariableName
                =   dartTypes.getName(info.declarationModel) + "$c";

            value callableVariable
                =   DartSimpleIdentifier(callableVariableName);

            return [
                // Field to hold the Callable for the forward declared function
                DartFieldDeclaration {
                    false;
                    DartVariableDeclarationList {
                        null;
                        dartTypes.dartTypeName {
                            info;
                            info.declarationModel.typedReference.fullType;
                        };
                        [DartVariableDeclaration {
                            callableVariable;
                        }];
                    };
                },
                // The method, which forwards to the callableVariable
                generateForwardDeclaredForwarderMethod(that)
                // No need to generateDefaultValueStaticMethods since forward declared
                // methods may not be 'default' (There may be default arguments, but the
                // method may not be overriden, and therefore the afformentioned function
                // would return [].)
            ];
        }

        // Else, a regular declaration
        return [generateMethodGetterOrSetterDeclaration(that),
                *generateDefaultValueStaticMethods(info)];
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
            // Similar to BaseGenerator.generateForValueDeclarationRaw()

            "Bridge to a synthetic field for this value if one exists, and one will
             for `default` and non-transient values. Note: [[generateFieldDeclaration]]
             is responsible for declaring the synthetic field."
            value bridgesToSyntheticField
                =   if (info.declarationModel.default)
                    then generateBridgesToSyntheticField(info, info.declarationModel)
                    else [];

            "If the Dart element type for the *getter* is not dartValue, we'll need to add
             a forwarding method or operator getter that returns the value of the dart
             property used to store the value."
            value needBridgeForMappedMember
                =   dartTypes.valueMappedToNonField(info.declarationModel);

            return [
                generateFieldDeclaration {
                    info;
                    info.declarationModel;
                },
                needBridgeForMappedMember then
                generateMethodToReferenceForwarder {
                    info;
                    info.declarationModel;
                },
                *bridgesToSyntheticField
            ].coalesced.sequence();
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
                 generateMethodDefinition(that),
                 *generateDefaultValueStaticMethods(info)]
            else
                [generateMethodDefinition(that),
                 *generateDefaultValueStaticMethods(info)];

    [DartMethodDeclaration*] generateDefaultValueStaticMethods(DeclarationInfo info) {
        if (!is AnyFunctionInfo info) {
            return [];
        }

        // Only calculate values for defaulted parameters in static methods for
        // 'formal' and 'default' methods (otherwise, just do the work in the function
        // body.
        if (!(info.declarationModel.formal || info.declarationModel.default)) {
            return [];
        }

        value parameters
            =   info.node.parameterLists.first.parameters;

        value dartParameters
            =   generateFormalParameterList {
                    false; false;
                    info;
                    parameters;
                    // use true once we handle variable captures?
                    // FIXME does this even work when we pass true? Or do we still
                    //       pretty much just get dart$core.Object?
                    //       For now, we want 'Object' but not the default value, which
                    //       we suspiciously get with 'true'.
                    noDefaults = true;
                }.parameters;

        return [
            for (i->p in parameters.indexed)
                if (is DefaultedParameter p)
                    generateDefaultValueStaticMethod {
                        DefaultedParameterInfo(p);
                        dartParameters[...i - 1];
                    }
        ];
    }

    see(`function BaseGenerator.generateDefaultValueAssignments`)
    DartMethodDeclaration generateDefaultValueStaticMethod
            (DefaultedParameterInfo info, {DartFormalParameter*} precedingParameters) {

        "A parameter for a method is sure to have a containing class or interface."
        assert (exists container
            =   getContainingClassOrInterface(info));

        value that
            =   info.node;

        return
        DartMethodDeclaration {
            false;
            "static";
            // FIXME we're getting Callable rather than Object here... see
            //       generateFormalParameterList() for a special case that overrides
            //       to Object, but the special case shouldn't be necessary and is wrong?
            dartTypes.dartTypeNameForDeclaration {
                info;
                info.parameterModel.model;
            };
            null;
            false;
            dartTypes.dartIdentifierForDefaultedParameterMethod {
                info; info.parameterModel;
            };
            DartFormalParameterList {
                false; false;
                [   // $this parameter
                    DartSimpleFormalParameter {
                        true; false;
                        dartTypes.dartTypeName {
                            info;
                            container.type;
                            false; false;
                        };
                        DartSimpleIdentifier("$this");
                    },
                    *precedingParameters
                ];
            };
            if (is DefaultedCallableParameter that,
                    is FunctionModel model = info.parameterModel.model) then
                // The funcion definition may be recursive! So declare a variable for the
                // Callable first in case the expression references it.
                let (identifier = DartSimpleIdentifier(dartTypes.getName(
                                    info.parameterModel.model)))
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        [DartVariableDeclarationStatement {
                            DartVariableDeclarationList {
                                null;
                                dartTypes.dartObject;
                                [DartVariableDeclaration {
                                    identifier;
                                    null;
                                }];
                            };
                        },
                        DartExpressionStatement {
                            DartAssignmentExpression {
                                identifier;
                                DartAssignmentOperator.equal;
                                generateCallableForBE {
                                    info;
                                    model;
                                    generateFunctionExpression(that);
                                };
                            };
                        },
                        DartReturnStatement {
                            withLhs {
                                null;
                                model;
                                () => identifier;
                                lhsIsParameter = true;
                            };
                        }];
                    };
                }
            else
                DartExpressionFunctionBody {
                    // Simple ValueModel default value
                    false;
                    withLhs {
                        null;
                        info.parameterModel.model;
                        () => that.specifier.expression
                                .transform(expressionTransformer);
                    };
                };
        };
    }

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

        // For interfaces, the implementation is always a static method.
        // For classes, the implementation may be a function or getter.

        switch (container)
        case (is InterfaceModel) {
            // a static method definition for the actual implementation
            return
            DartMethodDeclaration {
                false;
                "static";
                if (is SetterModel declarationModel) then
                    dartTypes.dartReturnTypeNameForDeclaration {
                        scope;
                        declarationModel.getter;
                    }
                else
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
                    ].sequence();
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
