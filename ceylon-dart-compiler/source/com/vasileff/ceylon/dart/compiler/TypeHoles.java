package com.vasileff.ceylon.dart.compiler;

public class TypeHoles {
    @SuppressWarnings("unchecked")
    public static <T> T unsafeCast(Object o) {
        return (T) o;
    }
}
