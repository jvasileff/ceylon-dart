package com.vasileff.ceylon.dart.compiler;

class TypeHoles {
    @SuppressWarnings("unchecked")
    static <T> T unsafeCast(Object o) {
        return (T) o;
    }
}
