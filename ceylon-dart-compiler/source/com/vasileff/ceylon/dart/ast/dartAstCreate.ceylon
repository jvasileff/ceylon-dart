shared
DartPropertyAccess | DartSimpleIdentifier createDartPropertyAccess
        (DartExpression? target, DartSimpleIdentifier propertyName)
    =>  if (exists target)
        then DartPropertyAccess(target, propertyName)
        else propertyName;
