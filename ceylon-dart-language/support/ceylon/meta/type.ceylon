import ceylon.meta.model { ClassModel }

"Returns the closed type and model of a given instance. Since only classes
 can be instantiated, this will always be a [[ClassModel]] model."
see(`function classDeclaration`)
shared native ClassModel<Type,Nothing> type<out Type>(Type instance)
    given Type satisfies Anything;

shared native("dart")
ClassModel<Type,Nothing> type<out Type>(Type instance) given Type satisfies Anything
   =>   nothing;

shared native("jvm")
ClassModel<Type,Nothing> type<out Type>(Type instance) given Type satisfies Anything
   =>   nothing;
