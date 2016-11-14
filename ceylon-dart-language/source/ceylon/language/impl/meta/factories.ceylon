import ceylon.language.meta.model {
    Type, Class, UnionType, IntersectionType, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class,
    ModelUnionType = UnionType,
    ModelIntersectionType = IntersectionType,
    ModelNothingDeclaration = NothingDeclaration
}
import ceylon.dart.runtime.model.runtime {
    TypeDescriptor
}

// FIXME make this native & provide correct type arguments to the type's constructor
shared Class<T> newClass<T=Anything>(ModelType | TypeDescriptor type)
    =>  ClassImpl<T> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared UnionType<T> newUnionType<T=Anything>(ModelType | TypeDescriptor type)
    =>  UnionTypeImpl<T> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared IntersectionType<T> newIntersectionType<T=Anything>
        (ModelType | TypeDescriptor type)
    =>  IntersectionTypeImpl<T> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

"Return the ceylon metamodel type for the type. The type parameter `T` is not actually
 used, but is provided as a convenience in order for callers to avoid an expensive
 assert() on the returned value. Note that the value for `T` is *not* checked for
 correctness!"
shared Type<T> newType<T=Anything>(ModelType | TypeDescriptor type) {
    value t = if (is TypeDescriptor type)
              then type.type
              else type;
    switch (d = t.declaration)
    case (is ModelClass) {
        return newClass(t);
    }
    case (is ModelUnionType) {
        return newUnionType(t);
    }
    case (is ModelIntersectionType) {
        return newIntersectionType(t);
    }
    case (is ModelNothingDeclaration) {
        return nothingType;
    }
    else {
        throw AssertionError(
            "Meta expressions not yet supported for type declaration type: \
            ``className(d)``");
    }
}
