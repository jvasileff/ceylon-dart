import ceylon.meta.model { ClosedType = Type }

"Functional equivalent to type literals. Allows you to get a closed type instance
 for a given type argument.

 For example:

     assert(is Interface<List<Integer>> listOfIntegers = typeLiteral<List<Integer>>());
 "
shared native ClosedType<Type> typeLiteral<out Type>()
    given Type satisfies Anything;

shared native("dart") ClosedType<Type> typeLiteral<out Type>()
        given Type satisfies Anything
    =>  nothing;

shared native("jvm") ClosedType<Type> typeLiteral<out Type>()
        given Type satisfies Anything
    =>  nothing;
