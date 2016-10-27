import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}

// FIXME make this native & provide correct type arguments to ClassImpl constructor
shared ClassImpl<> newClassImpl(ModelType modelType)
    =>  ClassImpl(modelType);
