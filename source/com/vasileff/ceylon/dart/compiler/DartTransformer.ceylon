import ceylon.ast.core {
    ArgumentList,
    PositionalArguments,
    Arguments,
    NamedArguments,
    ValueDefinition,
    Specifier,
    CompilationUnit
}

import com.redhat.ceylon.model.typechecker.model {
    PackageModel=Package
}

class DartTransformer(CompilationContext ctx)
        extends BaseTransformer<Anything>(ctx) {

    shared actual
    DartArgumentList transformArguments(Arguments that) {
        switch (that)
        case (is PositionalArguments) {
            return transformPositionalArguments(that);
        }
        case (is NamedArguments) {
            throw CompilerBug(that, "NamedArguments not supported");
        }
    }

    shared actual
    DartArgumentList transformPositionalArguments
            (PositionalArguments that)
        =>  transformArgumentList(that.argumentList);

    shared actual
    DartArgumentList transformArgumentList(ArgumentList that) {
        "spread arguments not supported"
        assert(that.sequenceArgument is Null);
        value info = ArgumentListInfo(that);

        // ceylon.ast doesn't have a node for 'PositionalArgument'
        // so we are getting model info from the argument list
        value args = zip(that.listedArguments, info.listedArgumentModels).collect((t) {
            value [expression, argumentTypeModel, parameterModel] = t;
            // presumably, (argumentTypeModel === ExpressionInfo(expression).typeModel)
            // whereas parameterModel.type describes the parameter, which may be generic

            // A question is if we can always get by with using `Type` for lhs,
            // or if we'll need the element models in order to always base things on
            // the type used in the `formal` declaration associated with this parameter
            // Where should this calculation go? Here, or wherever lhs is put to use?

            // If parameterModel is null, we must be invoking a value, so use
            // type `Anything` to disable erasure.
            return ctx.withLhsType(
                        parameterModel?.type
                        else ctx.typeFactory.anythingType, ()
                =>  expression.transform(expressionTransformer));
        });

        return DartArgumentList(args);
    }

    shared actual
    DartVariableDeclarationList transformValueDefinition
            (ValueDefinition that) {

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
            ctx.naming.dartTypeName(
                    info.declarationModel,
                    info.declarationModel.type);
            [DartVariableDeclaration {
                DartSimpleIdentifier {
                    packagePrefix + ctx.naming.getName(info.declarationModel);
                };
                ctx.withLhsType(info.declarationModel.type, ()
                    =>  that.definition.expression.transform(expressionTransformer));
            }];
        };
    }

    "Transforms the declarations of the [[CompilationUnit]]. **Note:**
     imports are ignored."
    shared actual
    [DartCompilationUnitMember*] transformCompilationUnit(CompilationUnit that)
        =>  that.declarations.flatMap((d)
            => d.transform(topLevelTransformer)).sequence();
}
