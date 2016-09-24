import ceylon.dart.runtime.nativecollection {
    HashSet
}

shared
class IntersectionType(satisfiedTypes, unit) extends TypeDeclaration() {

    shared actual [Type+] satisfiedTypes;
    shared actual Unit unit;

    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Type extendedType => unit.anythingDeclaration.type;
    shared actual String name => type.formatted;
    shared actual Null qualifier => null;
    shared actual String qualifiedName => type.qualifiedNameWithTypeArguments;
    shared actual IntersectionType refinedDeclaration => this;
    shared actual Null selfType => null;

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isSealed => false;
    shared actual Boolean isShared => false;
    shared actual Boolean isStatic => false;

    shared actual
    Nothing canEqual(Object other) {
        throw AssertionError("intersection types don't have well-defined equality");
    }

    shared actual
    Nothing container {
        throw AssertionError("intersection types don't have containers.");
    }

    shared actual
    Boolean isToplevel
        =>  false;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  that.isAnything || satisfiedTypes.any((st) => st.declaration.inherits(that));

    shared actual
    Type type
        =>  if (satisfiedTypes.size == 1)
            then satisfiedTypes[0]
            else super.type;

    "Apply the distributive rule X&(Y|Z) == X&Y|X&Z to simplify the intersection to a
     canonical form with no parens. The result is a union of intersections, instead of
     an intersection of unions."
    shared
    TypeDeclaration canonicalized {
        // JV: what's the purpose of this? Why do we care about the size?
        if (satisfiedTypes.size == 1 && satisfiedTypes[0].isExactlyNothing) {
            return unit.nothingDeclaration;
        }

        if (exists satisfiedUnion = satisfiedTypes.find(Type.isUnion)) {
            value unionSet = HashSet<Type>();
            for (caseType in satisfiedUnion.caseTypes) {
                value intersectionSet = HashSet<Type>();
                for (satisfiedType in satisfiedTypes) {
                    if (satisfiedType === satisfiedUnion) {
                        addToIntersection(intersectionSet, caseType, unit);
                    }
                    else {
                        addToIntersection(intersectionSet, satisfiedType, unit);
                    }
                }
                value it = canonicalIntersection(intersectionSet, unit);
                addToUnion(unionSet, it);
            }

            assert (nonempty unionTypes = unionSet.sequence());
            return UnionType {
                unionTypes;
                unit;
            };
        }
        return this;
    }

    shared actual
    String string
        =>  name;
}
