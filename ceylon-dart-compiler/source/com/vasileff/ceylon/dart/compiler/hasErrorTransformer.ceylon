import ceylon.ast.core {
    WideningTransformer,
    Node,
    ScopedKey,
    Key
}

import com.redhat.ceylon.compiler.typechecker.analyzer {
    UsageWarning
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Message
}
import com.vasileff.ceylon.dart.nodeinfo {
    NodeInfo,
    keys
}

Key<Boolean> hasErrorKey = ScopedKey<Boolean>
        (`value hasErrorTransformer`, "hasError");

object hasErrorTransformer satisfies WideningTransformer<Boolean> {
    shared actual Boolean transformNode(Node that) {
        if (exists cachedResult = that.get(hasErrorKey)) {
            return cachedResult;
        }
        value thatHasError
            =   if (exists tcNode = that.get(keys.tcNode))
                then NodeInfo(that).errors.any((Message error)
                        =>  !error is UsageWarning)
                else false;

        value hasError = thatHasError
            || that.transformChildren(this).contains(true);

        that.put(hasErrorKey, hasError);
        return hasError;
    }
}
