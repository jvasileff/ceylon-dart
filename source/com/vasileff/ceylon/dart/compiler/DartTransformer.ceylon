import ceylon.ast.core {
    ArgumentList,
    PositionalArguments,
    Arguments,
    NamedArguments,
    ValueDefinition,
    Specifier,
    CompilationUnit
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
            return ctx.withLhsType(parameterModel.type, ()
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
        value declarationModel = info.declarationModel;

        value name = DartSimpleIdentifier(ctx.naming.getName(declarationModel));
        value expression = ctx.withLhsType(declarationModel.type, ()
            =>  that.definition.expression.transform(expressionTransformer));

        return DartVariableDeclarationList {
            keyword = "var";
            type = null; // TODO types!
            [DartVariableDeclaration {
                    name = name;
                    initializer = expression;
                }
            ];
        };
    }

    "Transforms the declarations of the [[CompilationUnit]]. **Note:**
     imports are ignored."
    shared actual
    [DartCompilationUnitMember*] transformCompilationUnit(CompilationUnit that)
        =>  that.declarations.collect((d)
            => d.transform(topLevelTransformer));
}
