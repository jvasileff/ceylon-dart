import dart.core { DIterable = Iterable }

shared
class CeylonIterable<Element>(DIterable<Element> iterable) satisfies {Element*} {
    iterator() => object satisfies Iterator<Element> {
        value iterator = iterable.iterator;
        next() => if (iterator.moveNext())
                  then iterator.current
                  else finished;
    };
}
