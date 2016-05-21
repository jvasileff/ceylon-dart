import ceylon.meta.declaration { ClassDeclaration }

"Returns the class declaration for a given instance. Since only classes
 can be instantiated, this will always be a [[ClassDeclaration]] model.
 
 Using `declaration` can be more efficient than using [[type]] and 
 obtaining the ClassDeclaration from the returned ClassModel."
shared native ClassDeclaration classDeclaration(Anything instance);

shared native("dart") ClassDeclaration classDeclaration(Anything instance)
    =>  nothing;
