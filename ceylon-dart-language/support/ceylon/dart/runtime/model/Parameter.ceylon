shared class Parameter(model, isDefaulted = false) {
    //shared String name; // Just get it from the model?
    //shared Boolean atLeastOne;
    //shared Boolean isDeclaredAnything;
    //shared Boolean isHidden;

    shared FunctionOrValue model;
    shared Boolean isDefaulted;
    shared Boolean isSequenced => false; // FIXME
}
