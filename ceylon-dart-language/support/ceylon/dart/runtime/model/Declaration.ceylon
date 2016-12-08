import ceylon.dart.runtime.model.internal {
    eq
}

shared abstract
class Declaration() of TypeDeclaration | TypedDeclaration
        extends Element()
        satisfies Annotated {

    variable String? qualifiedNameMemo = null;
    variable Integer? hashMemo = null;

    "An integer used to distinguish two declarations with the same name that have a
     common declaration container. For example, `Local` below:

        void method() {
            if (true) {
                class Local() {}
            } else {
                class Local() {}
            }
        }

     See also https://github.com/ceylon/ceylon/issues/162"
    shared formal Integer? qualifier;
    shared formal String name;

    // TODO shared formal [String*] aliases;

    variable Declaration? refinedDeclarationMemo = null;

    Declaration locateRefinedDeclaration() {
        if (! isActual) {
            return this;
        }

        "Actual members must be inside a class."
        assert(is ClassOrInterface container = this.container);

        "All declarations have a refined declaration."
        assert(exists ret = container.getMember(name)?.refinedDeclaration);
        return ret;
    }

    shared default
    Declaration refinedDeclaration
        =>  refinedDeclarationMemo
            else (refinedDeclarationMemo = locateRefinedDeclaration());

    shared formal Boolean isAnnotation;
    shared formal Boolean isActual;
    shared formal Boolean isDefault;
    shared formal Boolean isDeprecated;
    shared formal Boolean isFormal;
    shared formal Boolean isShared;
    shared formal Boolean isStatic;

    "`true` if this is an anonymous class or anything with a rubbish system-generated
     name."
    shared formal see(`value isNamed`)
    Boolean isAnonymous;

    "`false` if this declaration has a system-generated name, rather than a
     user-generated name. At the moment only object expressions, anonymous function
     expressions and anonymous type constructors are not named. This is different than
     [[isAnonymous]] because named object classes are considered anonymous but do have a
     user-generated name."
    shared formal see(`value isAnonymous`)
    Boolean isNamed;

    "Is the container a [[Package]]?"
    shared default
    Boolean isToplevel
        =>  container is Package;

    shared actual default
    String qualifiedName
        =>  qualifiedNameMemo
            else (qualifiedNameMemo =
                switch (container = this.container)
                case (is Package) container.qualifiedName + "::" + name
                else container.qualifiedName + "." + name);

    shared
    String partiallyQualifiedNameWithTypeParameters {
        value sb = StringBuilder();

        if (is Declaration container = container) {
            sb.append(container.partiallyQualifiedNameWithTypeParameters);
            sb.appendCharacter('.');
        }

        sb.append(name);

        if (is Generic self = this) {
            sb.append(self.typeParametersAsString);
        }

        return sb.string;
    }

    "Is this declaration a member in the strict language spec sense of the word? That
     is, is it a polymorphic kind of declaration (an attribute, method, or class)"
    shared
    Boolean isMember
        =>  (!this is IntersectionType | UnionType)
            && container is ClassOrInterface;

    shared
    Type? memberContainerType {
        if (!isMember) {
            return null;
        }
        assert (is ClassOrInterface c = container);
        return c.type;
    }

    "Get the type parameters of this declaration as their own arguments. Note: what is
     returned is different from [[aggregateTypeArguments]], which also includes type
     arguments from qualifying types. In this case we assume they're uninteresting.

     We do need to compensate for this in [[Type.substituteFromType]] by expanding out
     the type arguments of the qualifying type. An alternative solution would be to just
     expand out all the type args of the qualifying type here.

     Note: this method is inteded for use by subclasses."
    // TODO why don't we make aggregateTypeArguments a member, too?
    shared see(`function aggregateTypeArguments`)
    Map<TypeParameter, Type> typeParametersAsArguments
        =>  if (is Generic self = this, !self.typeParameters.empty)
            then self.typeParameters.tabulate(TypeParameter.type)
            else emptyMap;

    "Is [[other]] assignable to `this`'s type? This method must be refined
     exactly one time!"
    shared formal
    Boolean canEqual(Object other);

    "Resolvable members are members that are not [[Setter]]s and not
     [[isAnonymous]]."
    shared
    Boolean isResolvable
        =>  !this is Setter        // return getters, not setters
            && !this.isAnonymous;  // don't return types for 'object's

    shared actual default
    Boolean equals(Object other) {
        if (!is Declaration other) {
            return false;
        }

        if (this === other) {
            return true;
        }

        if (isToplevel) {
            if (!other.isToplevel) {
                return false;
            }
            return qualifiedName == other.qualifiedName;
        }

        if (!canEqual(other)
                || hash != other.hash
                || name != other.name
                || !eq(qualifier, other.qualifier)) {
            return false;
        }

        if (!eq(container, other.container)) {
            return false;
        }

        return true;
    }

    shared actual default
    Integer hash {
        if (exists h = hashMemo) {
            return h;
        }

        variable value result = 17;
        result += 37 * result + container.hash;
        result += 37 * result + (qualifier?.hash else 0);
        result += 37 * result + name.hash;
        result += 37 * result + (this is Setter).hash;
        result += 37 * result + isAnonymous.hash;

        return hashMemo = result;
    }
}
