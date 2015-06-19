import ceylon.collection {
    HashMap
}

import com.redhat.ceylon.model.typechecker.model {
    TypedDeclarationModel=TypedDeclaration,
    ValueModel=Value,
    SetterModel=Setter
}

class Naming() {

    variable value counter = 0;

    value nameCache = HashMap<TypedDeclarationModel, String>();

    shared
    String getName(TypedDeclarationModel declaration) {
        if (is SetterModel declaration) {
            getName(declaration.getter);
        }

        variable TypedDeclarationModel original = declaration;
        while (true) {
            if (exists name = nameCache[declaration]) {
                return name;
            }
            if (exists parent = original.originalDeclaration) {
                original = parent;
                continue;
            }
            break;
        }

        switch (declaration)
        case (is ValueModel) {
            return original.name;
        }
        else {
            throw Exception("declaration type not yet supported \
                             for ``className(declaration)``");
        }
    }

    shared
    String createReplacementName(TypedDeclarationModel declaration) {
        if (is SetterModel declaration) {
            return createReplacementName(declaration.getter);
        }

        String replacement;
        switch (declaration)
        case (is ValueModel) {
            replacement = declaration.name + "$" + (counter++).string;
        }
        else {
            throw Exception("declaration type not yet supported \
                             for ``className(declaration)``");
        }
        nameCache.put(declaration, replacement);
        return replacement;
    }

    shared
    String createTempName(TypedDeclarationModel declaration) {
        return declaration.name + "$" + (counter++).string;
    }

}
