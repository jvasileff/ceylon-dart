import dart.core { DIterable = Iterable }

shared
class NonemptyCeylonIterable<Element>(DIterable<Element> nonemptyIterable)
        satisfies Iterable<Element, Nothing> {
    iterator() => object satisfies Iterator<Element> {
        variable Integer index = -1;
        value iterator = nonemptyIterable.iterator;
        shared actual Element|Finished next() {
            index++;
            if (iterator.moveNext()) {
                return iterator.current;
            }
            if (index.zero) {
                throw AssertionError(
                    "Backing iterator for nonempty stream produced no elements");
            }
            return finished;
        }
    };
}
