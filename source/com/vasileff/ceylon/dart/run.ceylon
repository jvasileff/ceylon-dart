import com.vasileff.ceylon.dart.compiler {
    compile
}

shared suppressWarnings("unusedDeclaration")
void run() {
    value program2 =
           """
              void prog2() {}
           """;

    value programBoxing =
         """
            import ceylon.language { myTrue = true, myNull = null }
            import ceylon.language.meta { modules }

            \Itrue localTrue = true;

            Boolean returnsTrue() => true;
            Object returnsTrueObject() => true;

            Boolean returnsFalse() { return false; }
            Object returnsFalseObject() { return false; }

            void takesBoolean(Boolean b) {}
            void takesObject(Object o) {}

            variable Boolean toplevelBoolean = true;
            variable Object toplevelObject = true;

            void main() {
                Integer ii1 = 1;
                Integer? ii2 = 1;
                Integer? ii3 = myNull;
                Object oi1 = 1;
                Object oi2 = ii1;
                Object? oi3 = null;

                Float ff1 = 1.0;
                Float? ff2 = 1.0;
                Object fo1 = 1.0;
                Float|Integer fo2 = 1.0;

                Boolean t1 = myTrue;
                Boolean? t2 = myTrue;
                \Itrue t3 = myTrue;
                \Itrue? t4 = myTrue;
                Boolean|String to1 = myTrue;
                \Itrue|String to2 = myTrue;

                Boolean fun_true_b_b = returnsTrue();
                Object fun_true_o_b = returnsTrue();
                Object fun_true_o_o = returnsTrueObject();

                Anything call_b_b = takesBoolean(true);
                Anything call_b_o = takesObject(true);

                Boolean f1 = false;
                Boolean? f2 = false;
                Boolean? f2n = null;
                \Ifalse f3 = false;
                \Ifalse? f4 = false;
                \Ifalse? f5n = null;
                Boolean|String fob1 = false;
                \Ifalse|String fob2 = false;

                // shouldn't box:
                returnsTrue();
                returnsTrueObject();

                value testing = runtime;
                value testing2 = process;
                value testing3 = localTrue;
                value testing4 = modules;

                //class MyClass() {
                //    shared void doSomething(String s) {}
                //}
                //value funcRef = takesBoolean;
                //value funcRef2 = MyClass().doSomething;
                //value staticFuncRef2 = MyClass.doSomething;

                //Boolean computedBool => true;
                //assign computedBool { }

                //Object computedObject => true;
                //assign computedObject { }

                //computedBool = false;
                //computedObject = false;

                toplevelBoolean = false;
                toplevelObject = false;

                Null nil = null;
            }
         """;

    value programAssertions =
         """
            Boolean returnsTrue() => true;
            Object returnsTrueObject() => true;

            Boolean returnsFalse() { return false; }
            Object returnsFalseObject() { return false; }

            void assertions() {
                assert(is Boolean ab = returnsTrueObject());

                Object objToTest = returnsFalse();
                print(objToTest);
                assert (!is Boolean objToTest);
                print(objToTest);

                Anything any = "";
                print(any);
                assert (is Object any);
                print(any);
                assert (is String any);
                print(any);

                String|Float sf = "";
                assert (is String|Integer sf);

                Object tobj = true;
                Object t0 = tobj;
                assert (is Boolean tobj);
                Object t1 = tobj;
                Boolean t2 = tobj;

                Object? obj = "someStringValue";
                assert (is Object obj);
                Object obj2 = obj;
            }
         """;

    value programFunctions =
         """
            void main2() {
                value x = (Integer t) { print("printing"); return t; };
                value y = (Integer t) => t;
                value three = 3;//1 + 1 + 1;
                // TODO:
                // value lazyVal => 1;
                helloDart(1);
                ////void sub(String s, Integer i, [String, Float] t = ["asd", 1.0]) { print("xyz"); }
                //void subfd(Float f, String s = "sdef", Integer i = 99) { print("xyz"); }
                //void subsc(Float f, String s = "sdef", Integer i = 99) => print("xyz");
                //Anything subsc2(Float f, String s = "sdef", Integer i = 99) => print("xyz");
            }

            void helloDart(Integer y) {
                value n = null;
                print("Hello Dart!");
                return;
            }

            Integer helloShortcut1(Integer y) => y;

            Integer helloShortcut2(Integer x) => x;
         """;

    value programScopes =
         """shared
            class CrazyValue() {
                String ov = "ov";
                String complexValue {
                    class ClassInAValue() {
                        shared String theValue {
                            if (true) {
                                value myThis = this;
                                value packageTest = package.CrazyValue;
                                value _ = this.theValue;
                                value o = outer.ov;
                                return "true";
                            }
                            else {
                                return "false";
                            }
                        }
                    }
                    return ClassInAValue().theValue;
                }
            }
         """;

    value programGenericErasure =
         """shared T generic<T>(T t) given T satisfies String {
                //String s = t;
                //assert (is T s);
                return t;
            }
            //shared String nonGeneric(String x) {
            //    return x;
            //}

            shared void run() {
                String myString1 = generic("true");
                //myString1.compare("other");
                //value myString2 = nonGeneric("true");
            }
         """;

    value programAnonymousCallableErasure =
         """String() echoString = () => nothing;
            shared void run() {
                String result = echoString();
            }
         """;

    value programFunctionReferenceErasure =
         """String echoString(String s) => s;
            shared void run() {
                value ref = echoString;
                //value ref = (String s) => s;
                //value result = ref(".");
                value result = ref(".");
                print("x");
            }
         """;

    value programCallables =
         """shared void run() {
                value callableShort = (String x) => x;
                value callableBlock = (String x) {
                    return x;
                };
            }
         """;

    value defaultedParameters =
         """shared void run() {
                value withDefaults = (Integer x, Integer y = 2) {
                    return y;
                };
                withDefaults(3);
                withDefaults(4, 5);
            }
         """;

    value basicExpressions =
         """shared void run() {
                value v1 = 1 < 2;
                value v2 = 1 > 2;
                value v3 = 1 <= 2;
                value v4 = 1 >= 2;
            }
         """;

    compile { true; basicExpressions };
}
