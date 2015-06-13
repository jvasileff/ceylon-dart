import ceylon.ast.core {
    Key,
    ScopedKey
}

import com.redhat.ceylon.model.typechecker.model {
    ModelFunction=Function,
    ModelParameterList=ParameterList,
    ModelParameter=Parameter
}

object keys {
    shared
    Key<ModelFunction> declarationModel
        =   ScopedKey<ModelFunction>(`value keys`,
                "declarationModel");

    shared
    Key<ModelParameterList> parameterListModel
        =   ScopedKey<ModelParameterList>(`value keys`,
                "parameterListModel");

    shared
    Key<ModelParameter> parameterModel
        =   ScopedKey<ModelParameter>(`value keys`,
                "parameterModel");

    shared
    Key<String> location
        =   ScopedKey<String>(`value keys`,
                "location");

    shared
    Key<String> identifierName
        =   ScopedKey<String>(`value keys`,
                "identifierName");
}
