package com.vasileff.ceylon.dart.compiler.loader;

import com.redhat.ceylon.model.typechecker.model.Parameter;

public class JsonParameter extends Parameter {
    boolean named;

    public boolean isNamed() {
        return named;
    }

    public void setNamed(boolean named) {
        this.named = named;
    }
}
