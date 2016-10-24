import dart.core {
    DIterator = Iterator {
        DIteratorClass = Class
    }
}
import dart.collection {
    DIterableBase = IterableBase {
        DIterableBaseClass = Class
    }
}

shared
class DartIterable<Element>({Element*} elements)
        extends DIterableBase<Element>.Class() {

    shared actual
    DIterator<Element> iterator => object extends DIterator<Element>.Class() {
        Iterator<Element> iterator = elements.iterator();

        variable Element? currentElement = null;

        shared actual
        Element? current => currentElement;

        // FIXME current wasn't supposed to be variable...
        assign current {
        }

        shared actual
        Boolean moveNext() {
            switch (next = iterator.next())
            case (finished) {
                currentElement = null;
                return false;
            }
            else {
                currentElement = next;
                return true;
            }
        }
    };

    assign iterator {}
}
