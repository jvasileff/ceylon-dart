import ceylon.ast.core {
    Visitor,
    CompilationUnit,
    FunctionExpression
}

import com.vasileff.ceylon.dart.nodeinfo {
    FunctionExpressionInfo
}
import ceylon.interop.java {
    CeylonList
}

"Disable erase-to-native for declarations where erasure is undesirable.

 Currently, this includes `Function` declarations for `FunctionExpression`s, and
 parameter declarations for those functions. These functions always be `Callable`s, so
 disabling erasure optimizes away the need for wrapper functions to handle erasure."
shared
void suppressErasure(CompilationUnit unit, CompilationContext ctx) {

    object captureVisitor satisfies Visitor {
        shared actual
        void visitFunctionExpression(FunctionExpression that) {
            value info = FunctionExpressionInfo(that);
            ctx.disableErasureToNative.add(info.declarationModel);

            for (l in CeylonList(info.declarationModel.parameterLists)) {
                for (p in CeylonList(l.parameters)) {
                    ctx.disableErasureToNative.add(p.model);
                }
            }
        }
    }

    unit.visit(captureVisitor);
}
