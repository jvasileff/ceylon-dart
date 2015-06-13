import ceylon.ast.core {
    Node
}
import ceylon.ast.redhat {
    RedHatTransformer,
    SimpleTokenFactory
}
import ceylon.formatter {
    format
}
import ceylon.formatter.options {
    FormattingOptions
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TCNode=Node
}

TCNode tcNode(Node node)
    =>  node.transform(
            RedHatTransformer(
                SimpleTokenFactory()));

void printNode(Node node) {
    value fo = FormattingOptions {
        maxLineLength = 80;
    };
    print(format(tcNode(node), fo));
}
