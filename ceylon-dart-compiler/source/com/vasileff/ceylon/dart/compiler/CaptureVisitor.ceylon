import ceylon.ast.core {
    Visitor,
    BaseExpression
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionOrValueModel=FunctionOrValue
}
import com.vasileff.ceylon.dart.nodeinfo {
    BaseExpressionInfo
}

"Identify captured functions and values. For each class and interface, determine list of
 captures."
shared
class CaptureVisitor(CompilationContext ctx) satisfies Visitor {

    shared actual
    void visitBaseExpression(BaseExpression that) {
        value info = BaseExpressionInfo(that);
        value targetDeclaration = info.declaration;
        value expressionsClassOrInterface = getContainingClassOrInterface(that);
        value targetsClassOrInterface => getContainingClassOrInterface(targetDeclaration);

        // Capture is not required for:
        //  - class or interface members, which can be accessed via "outer" refs
        //  - toplevels, which can be accessed directly
        //  - declarations in the same class or interface as the expression,
        //    which can be accessed directly
        if (is FunctionOrValueModel targetDeclaration,
            exists expressionsClassOrInterface,
            !isClassOrInterfaceMember(targetDeclaration)
                && !isToplevel(targetDeclaration)
                && !eq(expressionsClassOrInterface, targetsClassOrInterface)) {

            ctx.capturedDeclarations.add(targetDeclaration);
            ctx.captures.put(expressionsClassOrInterface, targetDeclaration);

            //print("CAPTURED: ``targetDeclaration.qualifiedNameString``\
            //       ; ``info.filename``:``info.location``\
            //        by: ``getContainingClassOrInterface(that) else "null"``");
        }
    }
}
