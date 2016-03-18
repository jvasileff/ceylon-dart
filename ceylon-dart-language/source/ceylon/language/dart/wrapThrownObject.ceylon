shared
Throwable wrapThrownObject(Object thrown)
    =>  if (is Throwable thrown)
        then thrown
        else Exception(thrown.string);
