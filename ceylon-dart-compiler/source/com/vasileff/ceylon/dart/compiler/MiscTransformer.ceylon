import ceylon.ast.core {
    ValueDefinition,
    Specifier,
    ValueDeclaration,
    WideningTransformer,
    Node
}

import com.redhat.ceylon.model.typechecker.model {
    PackageModel=Package
}
import com.vasileff.ceylon.dart.ast {
    DartVariableDeclaration,
    DartSimpleIdentifier,
    DartVariableDeclarationList
}
import com.vasileff.ceylon.dart.nodeinfo {
    ValueDefinitionInfo,
    ValueDeclarationInfo
}

shared
class MiscTransformer(CompilationContext ctx)
        extends BaseGenerator(ctx)
        satisfies WideningTransformer<Anything> {

    shared actual
    DartVariableDeclarationList transformValueDeclaration
            (ValueDeclaration that) {

        value info = ValueDeclarationInfo(that);

        value packagePrefix =
                if (info.declarationModel.container is PackageModel)
                then "$package$"
                else "";

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                that;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + dartTypes.getName(info.declarationModel);
                };
                initializer = null;
            }];
        };
    }

    shared actual
    DartVariableDeclarationList transformValueDefinition(ValueDefinition that) {
        if (!that.definition is Specifier) {
            throw CompilerBug(that, "LazySpecifier not supported");
        }

        value info = ValueDefinitionInfo(that);

        value packagePrefix =
                if (info.declarationModel.container is PackageModel)
                then "$package$"
                else "";

        return
        DartVariableDeclarationList {
            null;
            dartTypes.dartTypeNameForDeclaration {
                that;
                info.declarationModel;
            };
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + dartTypes.getName(info.declarationModel);
                };
                withLhs {
                    null;
                    info.declarationModel;
                    () => that.definition.expression.transform(expressionTransformer);
                };
            }];
        };
    }

    shared actual default
    Anything transformNode(Node that) {
        throw CompilerBug(that,
            "Unhandled node: '``className(that)``'");
    }
}
