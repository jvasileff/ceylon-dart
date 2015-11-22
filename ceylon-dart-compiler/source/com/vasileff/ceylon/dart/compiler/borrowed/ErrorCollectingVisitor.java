package com.vasileff.ceylon.dart.compiler.borrowed;

import static com.redhat.ceylon.compiler.typechecker.tree.TreeUtil.isForBackend;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.redhat.ceylon.common.Backend;
import com.redhat.ceylon.compiler.typechecker.analyzer.AnalysisError;
import com.redhat.ceylon.compiler.typechecker.parser.RecognitionError;
import com.redhat.ceylon.compiler.typechecker.tree.AnalysisMessage;
import com.redhat.ceylon.compiler.typechecker.tree.Message;
import com.redhat.ceylon.compiler.typechecker.tree.Node;
import com.redhat.ceylon.compiler.typechecker.tree.Tree;
import com.redhat.ceylon.compiler.typechecker.tree.UnexpectedError;
import com.redhat.ceylon.compiler.typechecker.tree.Visitor;

public class ErrorCollectingVisitor extends Visitor {
    private Backend dartBackend = Backend.registerBackend("Dart", "dart");

    private List<PositionedMessage> analErrors = new ArrayList<PositionedMessage>();
    private List<PositionedMessage> recogErrors = new ArrayList<PositionedMessage>();

    public static class PositionedMessage {
        public Node node;
        public Message message;

        PositionedMessage(Node that, RecognitionError err) {
            node = that;
            message = err;
        }

        PositionedMessage(AnalysisMessage msg) {
            node = msg.getTreeNode();
            message = msg;
        }
    }

    public int getErrorCount() {
        int errCount = 0;
        for (PositionedMessage pm : analErrors) {
            if (pm.message instanceof AnalysisError ||
                pm.message instanceof UnexpectedError) {
                errCount++;
            }
        }
        return errCount;
    }

    public List<PositionedMessage> getPositionedMessages() {
        ArrayList<PositionedMessage> result = new ArrayList<PositionedMessage>();
        if (!recogErrors.isEmpty()) {
            for (PositionedMessage pm : recogErrors) {
                result.add(pm);
            }
        } else {
            for (PositionedMessage pm : analErrors) {
                result.add(pm);
            }
        }
        return result;
    }

    public Set<Message> getErrors() {
        Set<Message> result = new LinkedHashSet<Message>();
        if (!recogErrors.isEmpty()) {
            for (PositionedMessage pm : recogErrors) {
                result.add(pm.message);
            }
        } else {
            for (PositionedMessage pm : analErrors) {
                result.add(pm.message);
            }
        }
        return result;
    }

    public void clear() {
        recogErrors.clear();
        analErrors.clear();
    }

    private void addErrors(Node that) {
        for (Message m: that.getErrors()) {
            if (m instanceof AnalysisMessage) {
                analErrors.add(new PositionedMessage((AnalysisMessage)m));
            } else {
                recogErrors.add(new PositionedMessage(that, (RecognitionError)m));
            }
        }
    }
    @Override
    public void visitAny(Node that) {
        super.visitAny(that);
        addErrors(that);
    }
    @Override
    public void visit(Tree.Declaration that) {
        if (isForBackend(that.getAnnotationList(), dartBackend, that.getUnit())
                || isForBackend(that.getAnnotationList(), Backend.Header, that.getUnit())) {
            super.visit(that);
        }
    }
    @Override
    public void visit(Tree.ModuleDescriptor that) {
        if (isForBackend(that.getAnnotationList(), dartBackend, that.getUnit())
                || isForBackend(that.getAnnotationList(), Backend.Header, that.getUnit())) {
            super.visit(that);
        } else {
            addErrors(that);
        }
    }
    @Override
    public void visit(Tree.ImportModule that) {
        if (isForBackend(that.getAnnotationList(), dartBackend, that.getUnit())
                || isForBackend(that.getAnnotationList(), Backend.Header, that.getUnit())) {
            super.visit(that);
        }
    }
}
