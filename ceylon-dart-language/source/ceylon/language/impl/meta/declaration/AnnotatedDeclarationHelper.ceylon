import ceylon.language {
    AnnotationType = Annotation
}

interface AnnotatedDeclarationHelper satisfies DeclarationHelper & AnnotatedHelper {
    shared Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType
        =>  nothing;
}
