
"A setter declaration for a variable `ValueDeclaration`."
native shared sealed interface SetterDeclaration
        satisfies NestableDeclaration {

    "The variable value this setter is for."
    shared formal ValueDeclaration variable;

    shared actual Boolean actual => variable.actual;
    
    shared actual Boolean formal => variable.formal;

    shared actual Boolean default => variable.default;
    
    shared actual Boolean shared => variable.shared;

    shared actual Package containingPackage => variable.containingPackage;
    
    shared actual Module containingModule => variable.containingModule;
    
    shared actual NestableDeclaration|Package container => variable.container;

    shared actual Boolean toplevel => variable.toplevel;
}
