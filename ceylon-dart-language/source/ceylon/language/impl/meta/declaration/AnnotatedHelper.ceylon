import ceylon.language {
    AnnotationType = Annotation
}

interface AnnotatedHelper satisfies DeclarationHelper {
    shared Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;
}
