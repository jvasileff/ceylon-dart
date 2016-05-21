shared
interface Criteria {
    shared formal Boolean satisfiesType(ClassOrInterface | TypeParameter type);
    shared formal Boolean memberLookup;
}
