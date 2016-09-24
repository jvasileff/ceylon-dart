import dart.core {
    DList = List
}
import ceylon.interop.dart {
    DartIterable
}

shared class ArrayList<Element>
        satisfies MutableList<Element> {

    DList<Element> delegate;

    shared new ({Element*} elements = []) {
        delegate = DList.Class.from(DartIterable(elements));
    }

    shared new ofSize(Integer size, Element element) {
        // TODO use filled() when interop named argument support is added
        // delegate = DList.Class.filled(size, element, true);
        delegate = DList.Class.from(DartIterable({element}.repeat(largest(0, size))));
    }

    new newClone(DList<Element> delegate) {
        this.delegate = delegate;
    }

    shared new copy(ArrayList<Element> list)
            extends ArrayList<Element>.newClone(list.delegate) {}

    empty => delegate.isEmpty;

    lastIndex => !empty then delegate.length - 1;

    // TODO validate index
    set(Integer index, Element element) => delegate.set_(index, element);

    add(Element element) => delegate.add(element);

    getFromFirst(Integer index)
        =>  if (0 <= index < size)
            then delegate.get_(index)
            else null;

    insert(Integer index, Element element) => delegate.insert(index, element);

    shared actual
    Element? delete(Integer index) {
        if (0 <= index < size) {
            value previous = delegate.get_(index);
            delegate.removeAt(index);
            return previous;
        }
        print("Out of range ``index``, ``size``");
        return null;
    }

    clone() => newClone(delegate);

    equals(Object other) => (super of MutableList<Element>).equals(other);

    hash => (super of MutableList<Element>).hash;

    deleteSpan(Integer from, Integer to)
        =>  deleteMeasure {
                from = smallest(from, to);
                length = (to - from).magnitude + 1;
            };

    shared actual
    void deleteMeasure(variable Integer from, variable Integer length) {
        if (from < 0) {
            length += from;
            from = 0;
        }
        length = smallest(length, size - from);
        if (length > 0) {
            delegate.removeRange(from, from + length);
        }
    }

    shared actual
    void truncate(Integer size) {
        assert (size >= 0);
        deleteMeasure(size, this.size - size);
    }

    shared
    void copyTo(ArrayList<in Element> destination,
            Integer sourcePosition = 0,
            Integer destinationPosition = 0,
            Integer length = smallest(
                size - sourcePosition,
                destination.size - destinationPosition)) {

        assert(!sourcePosition.negative);
        assert(!destinationPosition.negative);
        assert(!size < sourcePosition + length);
        assert(!destination.size < destinationPosition + length);

        value source
            =   if (identical(this, destination))
                then clone()
                else this;

        variable value i = destinationPosition;
        for (c in source.sublistFrom(sourcePosition).take(length)) {
            destination.set(i++, c);
        }
    }
}
