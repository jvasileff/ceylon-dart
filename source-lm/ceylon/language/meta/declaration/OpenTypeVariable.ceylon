"An open type variable."
native shared sealed interface OpenTypeVariable satisfies OpenType {
    
    "This type variable's type parameter declaration."
    shared formal TypeParameter declaration;
}
