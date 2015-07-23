"Abstract supertype of resources whose lifecyle may be
 managed by the `try` statement."
native shared interface Usable 
        of Destroyable | Obtainable {}
