import ceylon.language.meta.declaration {
  ValueDeclaration
}

"A reference value declaration that defines state."
native shared sealed interface ReferenceDeclaration
        satisfies ValueDeclaration {}
