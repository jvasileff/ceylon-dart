import ceylon.ast.core {
    Node
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TCNode=Node,
    Tree
}

void augmentNode(TCNode tcNode, Node node) {
    // location
    node.put(keys.location, tcNode.location);

    // model (always use the most precise key type)
    switch(tcNode)
    case (is Tree.TypedDeclaration) {
        switch (tcNode)
        case (is Tree.AnyMethod) {
            node.put(keys.functionModel, tcNode.declarationModel);
        }
        case (is Tree.AttributeDeclaration) { // Tree.AnyAttribute
            node.put(keys.valueModel, tcNode.declarationModel);
        }
        case (is Tree.AttributeGetterDefinition) { // Tree.AnyAttribute
            node.put(keys.valueModel, tcNode.declarationModel);
        }
        case (is Tree.AttributeSetterDefinition) {
            node.put(keys.setterModel, tcNode.declarationModel);
        }
        case (is Tree.ObjectDefinition) {
            node.put(keys.valueModel, tcNode.declarationModel);
            node.put(keys.classModel, tcNode.anonymousClass);
        }
        case (is Tree.Variable) {
            node.put(keys.valueModel, tcNode.declarationModel);
        }
        else {
            throw AssertionError("unexpected node type");
        }
    }
    case (is Tree.MissingDeclaration) {
        node.put(keys.declarationModel, tcNode.declarationModel);
    }
    case (is Tree.ParameterList) {
        node.put(keys.parameterListModel, tcNode.model);
    }
    case (is Tree.Parameter) {
        node.put(keys.parameterModel, tcNode.parameterModel);
    }
    case (is Tree.ImportPath) {
        node.put(keys.referenceableModel, tcNode.model);
    }
    case (is Tree.ImportMemberOrType) {
        node.put(keys.declarationModel, tcNode.declarationModel);
        node.put(keys.importModel, tcNode.importModel);
    }
    case (is Tree.TypeDeclaration) {
        switch (tcNode)
        case (is Tree.AnyClass) {
            node.put(keys.classModel, tcNode.declarationModel);
        }
        case (is Tree.AnyInterface) {
            node.put(keys.interfaceModel, tcNode.declarationModel);
        }
        case (is Tree.TypeConstraint) {
            node.put(keys.typeParameterModel, tcNode.declarationModel);
        }
        case (is Tree.TypeAliasDeclaration) {
            node.put(keys.typeDeclarationModel, tcNode.declarationModel);
        }
        else {
            throw AssertionError("unexpected node type");
        }
    }
    case (is Tree.Constructor) {
        node.put(keys.constructorModel, tcNode.declarationModel);
    }
    case (is Tree.TypeParameterDeclaration) {
        node.put(keys.typeParameterModel, tcNode.declarationModel);
    }
    case (is Tree.Type) {
        if (is Tree.TypeConstructor tcNode) {
            node.put(keys.typeAliasModel, tcNode.declarationModel);
        }
        node.put(keys.typeModel, tcNode.typeModel);
    }
    case (is Tree.TypeArguments) {
        node.put(keys.typeModels, CeylonList(tcNode.typeModels));
    }
    case (is Tree.Term) {
        switch (tcNode)
        case (is Tree.Outer) {
            node.put(keys.typeDeclarationModel, tcNode.declarationModel);
        }
        case (is Tree.FunctionArgument) {
            node.put(keys.functionModel, tcNode.declarationModel);
        }
        case (is Tree.SelfExpression) {
            node.put(keys.typeDeclarationModel, tcNode.declarationModel);
        }
        case (is Tree.LetExpression
                | Tree.OperatorExpression
                | Tree.Bound
                | Tree.IfExpression
                | Tree.SwitchExpression) {
            node.put(keys.typeModel, tcNode.typeModel);
        }
        else {
            // TODO the rest of Tree.Primary
            node.put(keys.typeModel, tcNode.typeModel);
        }
    }
    case (is Tree.PositionalArgument) {
        node.put(keys.typeModel, tcNode.typeModel);
    }
    case (is Tree.TypedArgument) {
        switch (tcNode)
        case (is Tree.MethodArgument) {
            node.put(keys.functionModel, tcNode.declarationModel);
        }
        case (is Tree.AttributeArgument) {
            node.put(keys.valueModel, tcNode.declarationModel);
        }
        case (is Tree.ObjectArgument) {
            node.put(keys.valueModel, tcNode.declarationModel);
        }
        else {
            throw AssertionError("unexpected node type");
        }
    }
    case (is Tree.ComprehensionClause) {
        node.put(keys.typeModel, tcNode.typeModel);
        node.put(keys.typeModel, tcNode.firstTypeModel);
    }
    else {}
}
