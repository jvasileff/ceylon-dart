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
         """shared void main() {
                function seven() => 7;
                function ten() => 10;
                function sameBool(Boolean b) => b;

                Boolean likelyTrue(Boolean b=true) {
                    Object o = b;
                    assert (is Boolean o);
                    return o;
                }

                value tenRef = ten;
                value sameBoolRef = sameBool;

                value b1 = 3 < 2;
                value b2 = 1 > 2;
                value b3 = true;
                value b4 = false;

                value i5 =
                    if (1 < 2, 3 < 4, b1)
                    then seven()
                    else
                        if (8 > 9)
                        then tenRef()
                        else
                            if (likelyTrue(), likelyTrue(false), sameBool(b2), sameBoolRef(b3))
                            then 11
                            else 12;

                print(i5);
            }
         """;

    value aos =
         """"Given two [[Comparable]] values, return smallest of the two."
                see (`interface Comparable`,
                     `function largest`,
                     `function min`)
                shared Element smallest<Element>(Element x, Element y)
                        given Element satisfies Comparable<Element>
                        => if (x<y) then x else y;
         """;

    value castDynamicsAndQualifiedExpression =
         """List&Usable something = nothing;

            T foo<T>(Integer i = 1) {
                print(i);
                foo<Float>(i);
                variable Integer j = 99;
                j = 100;
                //print(j = 101);
                Integer jj = j;
                print(j.string);
                Object x = j.string;
                value y = "".contains;
                value z = "".contains("apples");
                //value z = String.contains;
                value zz = something.contains;
                return nothing;
            }
         """;

    value parameterReferences =
         """
            shared Boolean identical(
            "An object with well-defined identity."
            Identifiable x,
            "A second object with well-defined identity."
            Identifiable y)
                    => x===y;

            shared void run() {
                Array<String> x = nothing;
                Array<String> y = nothing;
                Boolean b = x === y;
                Object o = x === y;
            }
         """;

    value scratch =
         """
            interface FirstInterface satisfies Identifiable {
                shared formal String something;

                shared formal String someFunction(String arg1, String arg2="dv");
            }
         """;

    value scratchMPL =
         """
            shared Integer mpl(Integer w)(Integer x)(Integer y)(Integer z) {
                return w + x + y + z;
            }

            shared Integer mpl2(Integer w)(Integer x)(Integer y)(Integer z)
                =>  w + x + y + z;

            shared void run() {
                Integer mpli(Integer w)(Integer x) {
                    return w + x;
                }

                value mpa = (Integer w)(Integer x) {
                    return w + x;
                };

                value f = mpl(1);
                value g = f(2);
                value h = g(3);
                value i = h(4);
                print(i);
                //value g = mpl(2)(3);
                //mpl(1);
                //print(mpl(1)(2)(3)(4));
            }
         """;

    value printFunctions =
         """
            shared void print(Anything val)
                    => process.writeLine(stringify(val));

            shared void printAll({Anything*} values,
                    String separator=", ") {
                variable value first = true;
                values.each(void (element) {
                    if (first) {
                        first = false;
                    }
                    else {
                        process.write(separator);
                    }
                    process.write(stringify(element));
                });
                process.write(operatingSystem.newline);
            }

            String stringify(Anything val) => val?.string else "<null>";
         """;

    value scratchStatements2 =
         """
            shared void run() {
                String? os1 = "os1";
                String? os2 = null;

                print(os1?.size);
                print(os2?.size);

                value fos1 = os1?.getFromFirst;
                value fos2 = os2?.getFromFirst;

                print(fos1(0));
                print(fos2(0));

                print(os1?.getFromFirst(0));
                print(os2?.getFromFirst(0));
            }
         """;

    value scratchStatements3 =
         """
            T echo<T>(String s, T t) => t;
            void run() {
                value identString = echo<String>;
                value identInteger = echo<Integer>;
            }
         """;

    value argumentTypes =
         """
            //shared void takesString(String s) {}

            interface Foo {
                shared default Anything something() => "";
            }
            interface Bar satisfies Foo {
                shared actual String something() => "";
            }

            shared void run() {
                value t = 1 + 1;

                //Resource & Usable su = nothing;
                ////takesString(su);
                //identity<Usable>(su); // Try to make cast to Usable
            }
         """;

    value forLoop =
         """
            {String*} | {Integer*} myIterable = nothing;
            //{Integer*} myIterable = nothing;
            //{Null*} myIterable = nothing;

            shared void run() {
                for (x in myIterable) {
                    print(x);
                }
            }
         """;

    value forLoop2 =
         """
            shared interface MyIterable satisfies Iterable<String | Integer> {
                shared actual formal Iterator<String> | Iterator<Integer> iterator();
            }

            shared void myTest(MyIterable it) {
                value x = it.iterator();
                value y = x.next();

                for (i in it) {
                    print(i);
                }
            }
        """;

    compile { true; forLoop };
}
