import ceylon.language.meta.declaration {
    Module,
    Package,
    Import,
    ClassDeclaration,
    ClassOrInterfaceDeclaration,
    ConstructorDeclaration,
    FunctionDeclaration,
    Declaration,
    ValueDeclaration
}

"The annotation class for the [[annotation]] meta-annotation."
native shared final sealed annotation class AnnotationAnnotation()
        satisfies OptionalAnnotation<AnnotationAnnotation,
                ClassDeclaration|FunctionDeclaration> {}

"Annotation to mark a class as an *annotation class*, or a 
 top-level function as an *annotation constructor*."
see (`interface Annotation`)
native shared annotation AnnotationAnnotation annotation()
        => AnnotationAnnotation();

"The annotation class for the [[shared]] annotation."
native shared final sealed annotation class SharedAnnotation()
        satisfies OptionalAnnotation<SharedAnnotation,
                FunctionDeclaration|ValueDeclaration|ClassOrInterfaceDeclaration|ConstructorDeclaration|Package|Import> {}

"Annotation to mark a declaration as shared. A `shared` 
 declaration is visible outside the block of code in which 
 it is declared."
native shared annotation SharedAnnotation shared()
        => SharedAnnotation();

"The annotation class for the [[variable]] annotation."
native shared final sealed annotation class VariableAnnotation()
        satisfies OptionalAnnotation<VariableAnnotation,
                ValueDeclaration> {}

"Annotation to mark a value as variable. A `variable` value 
 may be assigned multiple times."
native shared annotation VariableAnnotation variable()
        => VariableAnnotation();

"The annotation class for the [[abstract]] annotation."
native shared final sealed annotation class AbstractAnnotation()
        satisfies OptionalAnnotation<AbstractAnnotation,
                ClassDeclaration|ConstructorDeclaration> {}

"Annotation to mark a class as abstract. An `abstract` class
 may have `formal` members, but may not be directly 
 instantiated. An enumerated class must be `abstract`."
native shared annotation AbstractAnnotation abstract()
        => AbstractAnnotation();

"The annotation class for the [[final]] annotation."
native shared final sealed annotation class FinalAnnotation()
        satisfies OptionalAnnotation<FinalAnnotation,
                ClassDeclaration> {}

"Annotation to mark a class as final. A `final` class may 
 not be extended. Marking a class as `final` affects disjoint
 type analysis."
native shared annotation FinalAnnotation final()
        => FinalAnnotation();
                
"The annotation class for the [[sealed]] annotation."
native shared final sealed annotation class SealedAnnotation()
        satisfies OptionalAnnotation<SealedAnnotation,
                ClassOrInterfaceDeclaration|ConstructorDeclaration> {}
                
"Annotation to mark an interface, class, or constructor as 
 sealed. A `sealed` interface may not be satisfied outside 
 of the module in which it is defined. A `sealed` class may 
 not be extended or instantiated outside of the module in 
 which it is defined. A `sealed` constructor may not be
 invoked outside of the module in which it is defined."
native shared annotation SealedAnnotation sealed()
        => SealedAnnotation();

"The annotation class for the [[actual]] annotation."
native shared final sealed annotation class ActualAnnotation()
        satisfies OptionalAnnotation<ActualAnnotation,
                FunctionDeclaration|ValueDeclaration|ClassOrInterfaceDeclaration> {}

"Annotation to mark a member of a type as refining a member 
 of a supertype."
native shared annotation ActualAnnotation actual()
        => ActualAnnotation();

"The annotation class for the [[formal]] annotation."
native shared final sealed annotation class FormalAnnotation()
        satisfies OptionalAnnotation<FormalAnnotation,
                FunctionDeclaration|ValueDeclaration|ClassOrInterfaceDeclaration> {}

"Annotation to mark a member whose implementation must be 
 provided by subtypes."
native shared annotation FormalAnnotation formal()
        => FormalAnnotation();

"The annotation class for the [[default]] annotation."
native shared final sealed annotation class DefaultAnnotation()
        satisfies OptionalAnnotation<DefaultAnnotation,
                FunctionDeclaration|ValueDeclaration|ClassOrInterfaceDeclaration> {}

"Annotation to mark a member whose implementation may be 
 refined by subtypes. Non-`default` declarations may not be 
 refined."
native shared annotation DefaultAnnotation default()
        => DefaultAnnotation();

"The annotation class for the [[late]] annotation."
native shared final sealed annotation class LateAnnotation()
        satisfies OptionalAnnotation<LateAnnotation,
                ValueDeclaration> {}

"Annotation to disable definite initialization analysis for 
 a reference."
native shared annotation LateAnnotation late()
        => LateAnnotation();

"The annotation class for the [[native]] annotation."
native shared final sealed annotation class NativeAnnotation(
    shared String backend)
        satisfies OptionalAnnotation<NativeAnnotation,Annotated> {}

"Annotation to mark a member whose implementation is defined 
 in platform-native code."
native shared annotation NativeAnnotation native(
    String backend = "")
        => NativeAnnotation(backend);

/*"The annotation class for [[inherited]]."
shared final sealed annotation class InheritedAnnotation()
        satisfies OptionalAnnotation<InheritedAnnotation, 
            ClassDeclaration> {}

"Annotation to mark an annotation class as a *inherited*."
shared annotation InheritedAnnotation inherited() 
        => InheritedAnnotation();*/

"The annotation class for the [[doc]] annotation."
native shared final sealed annotation class DocAnnotation(
    "Documentation, in Markdown syntax, about the annotated 
     program element"
    shared String description)
        satisfies OptionalAnnotation<DocAnnotation,Annotated> {}

"Annotation to specify API documentation of a program
 element."
native shared annotation DocAnnotation doc(
    "Documentation, in Markdown syntax, about the annotated element"
    String description) => DocAnnotation(description);

"The annotation class for the [[see]] annotation."
native shared final sealed annotation class SeeAnnotation(
    "The program elements being referred to."
    shared Declaration* programElements)
        satisfies SequencedAnnotation<SeeAnnotation,Annotated> {}

"Annotation to specify references to other program elements
 related to the annotated API."
native shared annotation SeeAnnotation see(
    "The program elements being referred to."
    Declaration* programElements)
        => SeeAnnotation(*programElements);

"The annotation class for the [[by]] annotation."
native shared final sealed annotation class AuthorsAnnotation(
    "The authors, in Markdown syntax, of the annotated 
     program element"
    shared String* authors)
        satisfies OptionalAnnotation<AuthorsAnnotation,Annotated> {}

"Annotation to document the authors of an API."
native shared annotation AuthorsAnnotation by(
    "The authors, in Markdown syntax, of the annotated 
     program element"
    String* authors)
        => AuthorsAnnotation(*authors);

"The annotation class for the [[throws]] annotation."
native shared final sealed annotation class ThrownExceptionAnnotation(
    "The [[Exception]] type that is thrown."
    shared Declaration type,
    "A description, in Markdown syntax, of the circumstances 
     that cause this exception to be thrown."
    shared String when)
        satisfies SequencedAnnotation<ThrownExceptionAnnotation,
                FunctionDeclaration|ValueDeclaration|ClassDeclaration|ConstructorDeclaration> {}

"Annotation to document the exception types thrown by a 
 function, value, class, or constructor."
native shared annotation ThrownExceptionAnnotation throws(
    "The [[Exception]] type that is thrown."
    Declaration type,
    "A description, in Markdown syntax, of the circumstances 
     that cause this exception to be thrown."
    String when = "")
        => ThrownExceptionAnnotation(type, when);

"The annotation class for the [[deprecated]] annotation."
native shared final sealed annotation class DeprecationAnnotation(
    "A description, in Markdown syntax, of why the program 
     element is deprecated, and of what alternatives are 
     available."
    shared String description)
        satisfies OptionalAnnotation<DeprecationAnnotation,
                Annotated> {
    "A description, in Markdown syntax, of why the program 
     element is deprecated, and what alternatives are 
     available, or `null`."
    shared String? reason
            => !description.empty then description;
}

"Annotation to mark program elements which should not be 
 used anymore."
native shared annotation DeprecationAnnotation deprecated(
    "A description, in Markdown syntax, of why the program 
     element is deprecated, and what alternatives are 
     available."
    String reason = "")
        => DeprecationAnnotation(reason);

"The annotation class for the [[tagged]] annotation."
native shared final sealed annotation class TagsAnnotation(
    "The tags, in plain text."
    shared String* tags)
        satisfies OptionalAnnotation<TagsAnnotation,Annotated> {}

"Annotation to categorize an API by tag."
native shared annotation TagsAnnotation tagged(
    "The tags, in plain text."
    String* tags)
        => TagsAnnotation(*tags);

"The annotation class for the [[license]] annotation."
native shared final sealed annotation class LicenseAnnotation(
    "The name, text, or URL of the license."
    shared String description)
        satisfies OptionalAnnotation<LicenseAnnotation,Module> {}

"Annotation to specify the URL of the license of a module or 
 package."
native shared annotation LicenseAnnotation license(
    "The name, text, or URL of the license."
    String description)
        => LicenseAnnotation(description);

"The annotation class for the [[optional]] annotation."
native shared final sealed annotation class OptionalImportAnnotation()
        satisfies OptionalAnnotation<OptionalImportAnnotation,
                Import> {}

"Annotation to specify that a module can be executed even if 
 the annotated dependency is not available."
native shared annotation OptionalImportAnnotation optional()
        => OptionalImportAnnotation();

"The annotation class for the [[suppressWarnings]] 
 annotation."
native shared final sealed annotation class SuppressWarningsAnnotation(
    "The warning types to suppress."
    [String*] warnings)
        satisfies OptionalAnnotation<SuppressWarningsAnnotation, 
            FunctionDeclaration|ValueDeclaration|ClassOrInterfaceDeclaration|ConstructorDeclaration|Module|Package|Import> {}

"Annotation to suppress compilation warnings of the 
 [[specified types|warnings]] when typechecking the 
 annotated program element."
native shared annotation SuppressWarningsAnnotation suppressWarnings(
    "The warning types to suppress.
     
     Allowed warning types are:
     `filenameNonAscii`,
     `filenameCaselessCollision`,
     `deprecation`,
     `compilerAnnotation`,
     `doclink`,
     `expressionTypeNothing`,
     `unusedDeclaration`,
     `unusedImport`,
     `ceylonNamespace`,
     `javaNamespace,` 
     `suppressedAlready`, 
     `suppressesNothing`, 
     `unknownWarning`, 
     `ambiguousAnnotation`,
     `javaAnnotationElement`."
    String* warnings) 
        => SuppressWarningsAnnotation(warnings);

"The annotation class for the [[serializable]] annotation."
native shared final annotation class SerializableAnnotation()
        satisfies OptionalAnnotation<SerializableAnnotation,ClassDeclaration> {
}

"Annotation to specify that a class is serializable.
  
 A serializable class may have instances that cannot be 
 serialized if those instances have reachable references to 
 instances of non-serializable classes."
native shared annotation SerializableAnnotation serializable() 
        => SerializableAnnotation();

