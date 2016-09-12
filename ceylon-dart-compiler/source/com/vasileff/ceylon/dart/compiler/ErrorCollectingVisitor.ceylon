import ceylon.collection {
    LinkedList
}
import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.common {
    Backend
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    AnalysisError
}
import com.redhat.ceylon.compiler.typechecker.parser {
    RecognitionError
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Visitor,
    Node,
    Message,
    AnalysisMessage,
    UnexpectedError,
    Tree,
    TreeUtil {
        isForBackend
    }
}
import com.redhat.ceylon.model.typechecker.model {
    Unit
}

class PositionedMessage {
    shared Node node;
    shared Message message;

    shared
    new ([AnalysisMessage]|[Node, RecognitionError] details) {
        switch (details)
        case (is [AnalysisMessage]) {
            node = details[0].treeNode;
            message = details[0];
        }
        case (is [Node, RecognitionError]) {
            node = details[0];
            message = details[1];
        }
    }
}

PositionedMessage(*<[AnalysisMessage]|[Node, RecognitionError]>) positionedMessage
    =   flatten(PositionedMessage);

class ErrorCollectingVisitor() extends Visitor() {
    value analysisErrors = LinkedList<PositionedMessage>();
    value recognitionErrors = LinkedList<PositionedMessage>();

    shared
    Integer errorCount
        =>  analysisErrorCount + recognitionErrorCount;

    shared
    Integer analysisErrorCount
        =>  analysisErrors.map(PositionedMessage.message)
                .narrow<AnalysisError|UnexpectedError>().size;

    shared
    Integer recognitionErrorCount
        =>  recognitionErrors.map(PositionedMessage.message).size;

    shared
    PositionedMessage[] positionedMessages
        =>  if (! recognitionErrors.empty)
            then recognitionErrors.sequence()
            else analysisErrors.sequence();

    shared
    void clear() {
        analysisErrors.clear();
        recognitionErrors.clear();
    }

    function isForDart(Tree.AnnotationList? annotations, Unit unit)
        => isForBackend(annotations, dartBackend, unit)
            || isForBackend(annotations, Backend.\iHeader, unit);

    void addErrors(Node that) {
        for (m in CeylonIterable(that.errors)) {
            "By definition"
            assert (is AnalysisMessage | RecognitionError m);

            switch (m)
            case (is AnalysisMessage) {
                analysisErrors.add(positionedMessage(m));
            }
            case (is RecognitionError) {
                recognitionErrors.add(positionedMessage(that, m));
            }
        }
    }

    // TODO what's the logic to deciding whether to call addErrors()?

    shared actual
    void visitAny(Node that) {
        super.visitAny(that);
        addErrors(that);
    }

    function annotationList
            (Tree.Declaration | Tree.ModuleDescriptor | Tree.ImportModule node)
        =>  if (is Tree.Declaration node)
                then (node.annotationList else null)
            else if (is Tree.ModuleDescriptor node)
                then (node.annotationList else null)
            else (node.annotationList else null);

    function forDart
            (Tree.Declaration | Tree.ModuleDescriptor | Tree.ImportModule node)
            // At least in the presence of a bad annotation like 'native(")'
            // in module.ceylon, that.unit may be null!
        =>  if (exists unit = node.unit)
            then isForDart(annotationList(node), node.unit)
            else true;

    shared actual
    void visit(Tree.Declaration that) {
        if (forDart(that)) {
            super.visit(that);
        }
    }

    shared actual
    void visit(Tree.ModuleDescriptor that) {
        if (forDart(that)) {
            super.visit(that);
        }
        else {
            addErrors(that);
        }
    }

    shared actual
    void visit(Tree.ImportModule that) {
        if (forDart(that)) {
            super.visit(that);
        }
    }
}
