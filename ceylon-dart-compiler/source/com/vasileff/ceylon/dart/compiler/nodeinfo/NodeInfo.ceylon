import ceylon.ast.core {
    Node
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.context {
    TypecheckerUnit
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Message
}
import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope
}
import com.vasileff.ceylon.dart.compiler {
    DScope,
    dartBackend,
    Warning
}

import org.antlr.runtime {
    Token
}

shared
class DefaultNodeInfo(shared actual Node node) extends NodeInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared abstract
class NodeInfo()
        of  ExpressionInfo | DeclarationInfo | ConditionInfo
          | ExtensionOrConstructionInfo | NamedArgumentInfo | ArgumentListInfo
          | CompilationUnitInfo | ComprehensionInfo |ComprehensionClauseInfo
          | ElseClauseInfo | ForClauseInfo | ForIteratorInfo | IsCaseInfo
          | ParameterInfo | ParametersInfo | SpreadArgumentInfo | StatementInfo
          | TypeInfo | TypeNameWithTypeArgumentsInfo
          | VariableInfo | ControlClauseInfo | DefaultNodeInfo
        satisfies DScope {

    shared actual formal Node node;

    shared formal TcNode tcNode;

    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    shared TypecheckerUnit typecheckerUnit => tcNode.unit;

    // FIXME location and filename doesn't work for ArgumentListInfo
    // https://github.com/ceylon/ceylon-spec/issues/1385
    shared String location => tcNode.location;
    shared String filename => tcNode.unit?.filename else "unknown file";

    shared actual ScopeModel scope => tcNode.scope;

    shared actual default NodeInfo nodeInfo => this;

    shared {Message*} errors => CeylonList(tcNode.errors);

    shared void addError(String string)
        =>  tcNode.addError(string, dartBackend);

    shared void addUnsupportedError(String string)
        =>  tcNode.addUnsupportedError(string, dartBackend);

    shared void addUnexpectedError(String string)
        =>  tcNode.addUnexpectedError(string, dartBackend);

    shared void addWarning(Warning warning, String message)
        =>  tcNode.addUsageWarning(warning, message, dartBackend);
}
