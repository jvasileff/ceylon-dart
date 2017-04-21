import ceylon.ast.core {
    Visitor,
    CompilationUnit,
    ValueDefinition,
    Specifier
}

import com.vasileff.ceylon.dart.compiler.nodeinfo {
    valueDefinitionInfo
}

shared
void identifyMemoizedValues(CompilationUnit unit, CompilationContext ctx) {
    unit.visit {
        object visitor satisfies Visitor {
            shared actual
            void visitValueDefinition(ValueDefinition that) {
                value info = valueDefinitionInfo(that);
                if (info.declarationModel.member
                        && info.declarationModel.late
                        && that.definition is Specifier) {
                    ctx.memoizedValues.add(info.declarationModel);
                }
            }
        }
    };
}
