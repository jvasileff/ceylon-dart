import com.vasileff.ceylon.dart.compiler {
    DScope
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartBlock,
    DartFunctionDeclaration,
    DartArgumentList,
    DartSimpleIdentifier,
    DartBlockFunctionBody,
    DartTypeName,
    DartFunctionExpression,
    DartExpressionStatement,
    DartFormalParameterList,
    DartSimpleFormalParameter,
    DartFunctionExpressionInvocation
}

shared
DartFunctionDeclaration generateMain(DScope scope)
    =>  let(argumentsIdentifier = DartSimpleIdentifier("arguments"))
        DartFunctionDeclaration {
            false;
            DartTypeName {
                DartSimpleIdentifier("void");
            };
            null;
            DartSimpleIdentifier("main");
            DartFunctionExpression {
                DartFormalParameterList {
                    false; false;
                    [DartSimpleFormalParameter {
                        false;
                        false;
                        ctx.dartTypes.dartList;
                        argumentsIdentifier;
                    }];
                };
                DartBlockFunctionBody {
                    null; false;
                    DartBlock {
                        [DartExpressionStatement {
                            DartFunctionExpressionInvocation {
                                ctx.dartTypes.dartIdentifierForDartModel {
                                    scope;
                                    ctx.dartTypes.dartRunHelper;
                                };
                                DartArgumentList {
                                    [argumentsIdentifier,
                                    DartSimpleIdentifier("$module")];
                                };
                            };
                        }];
                    };
                };
            };
        };
