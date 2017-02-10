shared final
class Parameter(model, isDefaulted = false, isSequenced = false) {
    shared Function | Value model;
    shared Boolean isDefaulted;
    shared Boolean isSequenced;

    shared String name => model.name;    
    shared Boolean atLeastOne => isSequenced && model.type.isSequence;

    string => model.string;
}
