import ceylon.language.meta.declaration {
    FunctionDeclaration
}

"Annotation to mark a function `async`. Functions with this annotation must return
 `Future`s."
shared annotation
AsyncAnnotation async()
    =>  AsyncAnnotation();

"The annotation class for the [[async]] annotation."
shared final sealed annotation
class AsyncAnnotation()
        satisfies OptionalAnnotation<AsyncAnnotation, FunctionDeclaration> {}
