import com.vasileff.ceylon.dart.compiler {
    compile
}
import com.vasileff.ceylon.dart.ast {
    CodeWriter
}

shared suppressWarnings("unusedDeclaration", "suppressesNothing")
void run() {

    value program =
         """
            interface FirstInterface satisfies Identifiable {
                shared formal String somefun();
                shared formal String something;
                shared formal String someFunction(String arg1, String arg2="dv");

                shared default String fooFunc() {
                    value notthis = 5;
                    print(notthis);

                    print(somefun());
                    print(something);

                    void nestedFn() {
                        print(something);
                    }

                    someFunction("x", "y");
                    return "a";
                }

                interface Inner {
                    shared default String innerFunc() {
                        return "if";
                    }
                }
            }
         """;

    value program2 =
         """
            interface Outer {
                shared formal String outerValue;
                shared String outerFn() {
                    return "outerFn";
                }
                shared void useFns() {
                    value a = outerValue;
                    value b = outerFn();
                }

                interface Inner {
                    shared formal String innerValue;
                    shared String innerFn() {
                        return "innerFn";
                    }
                    shared void useFns() {
                        value a = outerValue;
                        value b = outerFn();
                        value c = innerValue;
                        value d = innerFn();
                    }

                    interface Innest {
                        shared formal String innestValue;
                        shared String innestFn() {
                            return "innestFn";
                        }
                        shared void useFns() {
                            value a = outerValue;
                            value b = outerFn();
                            value c = innerValue;
                            value d = innerFn();
                            value e = innestValue;
                            value f = innestFn();

                            value g = string;
                        }
                    }
                }
            }
         """;

    value program3 =
         """
            shared interface Category<in Element=Object>
                given Element satisfies Object {

                shared formal Boolean contains(Element element);

                shared default
                Boolean containsEvery({Element*} elements) {
                    for (element in elements) {
                        if (!contains(element)) {
                            return false;
                        }
                    }
                    //else {
                    //    return true;
                    //}
                    return true;
                }

                shared default
                Boolean containsAny({Element*} elements) {
                    for (element in elements) {
                        if (contains(element)) {
                            return true;
                        }
                    }
                    //else {
                    //    return false;
                    //}
                    return false;
                }
            }
         """;

    value result = compile { false; program3 };

    for (dcu in result) {
        value codeWriter = CodeWriter(process.write);
        dcu.write(codeWriter);
    }
}


//class Clouter() satisfies Outer {
//    shared actual String outerValue => nothing;
//}
//
//interface Outer {
//    shared actual String string => "";
//    shared formal String outerValue;
//    shared String outerFn() {
//        return "outerFn";
//    }
//    shared void useFns() {
//        value a = outerValue;
//        value b = outerFn();
//    }
//
//    class Clouter() satisfies Outer {
//        shared actual String outerValue => nothing;
//    }
//    class Classer() satisfies Inner {
//        shared actual String innerValue => nothing;
//    }
//
//    shared interface Inner {
//        shared actual String string => "";
//        shared formal String innerValue;
//        shared String innerFn() {
//            return "innerFn";
//        }
//        shared void useFns() {
//            value a = outerValue;
//            value b = outerFn();
//            value c = innerValue;
//            value d = innerFn();
//        }
//
//        shared interface Innest {
//            //shared actual String string => "";
//            shared formal String innestValue;
//            shared String innestFn() {
//                return "innestFn";
//            }
//            shared void useFns() {
//                value a = outerValue;
//                value b = outerFn();
//                value c = innerValue;
//                value d = innerFn();
//                value e = innestValue;
//                value f = innestFn();
//
//                value g = string;
//                value h = outer.string;
//            }
//        }
//
//        shared interface Innest2 satisfies Innest {
//            // Outer$Inner outer$Outer$Inner$Innest2
//        }
//
//        class Clouter() satisfies Outer {
//            shared actual String outerValue => nothing;
//        }
//        class Classer() satisfies Inner {
//            shared actual String innerValue => nothing;
//            class Classest() satisfies Innest {
//                shared actual String innestValue => nothing;
//                shared void testingIt() {
//                    print(outer.innerValue);
//                }
//            }
//        }
//        class Classest() satisfies Innest {
//            shared actual String innestValue => nothing;
//            shared void testingIt() {
//                print(outer.innerValue);
//            }
//        }
//    }
//}
