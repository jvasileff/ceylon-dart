"An open intersection type."
native shared sealed interface OpenIntersection satisfies OpenType {
    
    "This intersection's list of satisfied open types."
    shared formal List<OpenType> satisfiedTypes;
}
