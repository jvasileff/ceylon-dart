import ceylon.language.meta.model {
    Type, Class
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}
import ceylon.dart.runtime.model.runtime {
    TypeDescriptor
}

// FIXME make this native & provide correct type arguments to ClassImpl constructor
shared Class<> newClass(ModelType | TypeDescriptor type)
    =>  ClassImpl {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

shared Type<> newType(ModelType | TypeDescriptor type) {
    value t = if (is TypeDescriptor type)
              then type.type
              else type;
    switch (d = t.declaration)
    case (is ModelClass) {
        return newClass(t);
    }
    else {
        throw AssertionError(
            "Meta expressions not yet supported for type declaration type: \
            ``className(d)``");
    }
}
