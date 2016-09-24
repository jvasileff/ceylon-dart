import dart.collection {
    DoubleLinkedQueue
}
import ceylon.interop.dart {
    DartIterable
}

shared class LinkedList<Element> satisfies MutableList<Element> {

    DoubleLinkedQueue<Element> delegate;

    shared new ({Element*} elements = []) {
        delegate = DoubleLinkedQueue.Class.from(DartIterable(elements));
    }

    shared new ofSize(Integer size, Element element) {
        // FIXME Typechecker bug about named args & direct invocations
        delegate = DoubleLinkedQueue.Class.from(
            DartIterable({element}.repeat(largest(0, size)))
        );
    }

    new newClone(DoubleLinkedQueue<Element> delegate) {
        this.delegate = delegate;
    }

    shared new copy(LinkedList<Element> list)
            extends LinkedList<Element>.newClone(list.delegate) {}

    function entryFromFirst(variable Integer index) {
        assert (0 <= index < size);
        if (index < size / 2) {
            variable value result = delegate.firstEntry();
            while (index-- > 0) {
                result = result.nextEntry();
            } 
            return result;
        }
        else {
            variable value result = delegate.lastEntry();
            index = size - index - 1;
            while (index-- > 0) {
                result = result.previousEntry();
            }
            return result;
        }
    }

    empty => delegate.isEmpty;

    lastIndex => !empty then delegate.length - 1;

    shared actual
    void set(Integer index, Element element) {
        assert (0 <= index < size);
        value entry = entryFromFirst(index);
        entry.append(element);
        entry.remove();
    }

    add(Element element) => delegate.add(element);

    getFromFirst(Integer index)
        =>  if (0 <= index < size)
            then entryFromFirst(index).element
            else null;

    shared actual
    void insert(Integer index, Element element) {
        assert (0 <= index <= size);
        if (index == 0) {
            delegate.addFirst(element);
        }
        else if (index == size) {
            delegate.addLast(element);
        }
        else {
            entryFromFirst(index - 1).append(element);
        }
    }

    shared actual
    Element? delete(Integer index) {
        if (!0 <= index < size) {
            return null;
        }
        else if (index == 0) {
            return delegate.removeFirst();
        }
        else if (index == size - 1) {
            return delegate.removeLast();
        }
        else {
            return entryFromFirst(index).remove();
        }
    }

    clone() => newClone(delegate);

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
            variable value entry = entryFromFirst(from);
            while (length-- > 1) {
                value nextEntry = entry.nextEntry();
                entry.remove();
                entry = nextEntry;
            }
            entry.remove();                
        }
    }

    shared actual
    void truncate(Integer size) {
        assert (size >= 0); 
        deleteMeasure(size, this.size - size);
    }

    equals(Object other) => (super of MutableList<Element>).equals(other);

    hash => (super of MutableList<Element>).hash;
}
