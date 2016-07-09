import ceylon.collection {
    MutableList,
    ArrayList
}

shared
interface SequentialMutableList<Node, Element>
        satisfies MutableList<Element> & SequentialList<Node, Element> {

    shared formal
    void insertNode(Element element, Node? location = null);

    shared formal
    void removeNode(Node node);

    shared actual formal
    Integer size;

    shared formal
    void setElement(Node node, Element element);

    shared actual
    Element? delete(Integer index) {
        if (exists node = nodeFromFirst(index)) {
            value e = getElement(node);
            removeNode(node);
            return e;
        }
        return null;
    }

    shared actual
    void deleteMeasure(variable Integer from, variable Integer length) {
        if (from < 0) {
            length += from;
            from = 0;
        }
        nodeIterable(forward, from).take(length).each(removeNode);
    }

    shared actual
    void deleteSpan(Integer from, Integer to) {
        value reversed = from > to;
        deleteMeasure {
            from = if (reversed) then to else from;
            length = if (reversed) then (from - to + 1) else (to - from + 1);
        };
    }

    shared actual
    void infill(Element replacement) {
        for (node in nodeIterable()) {
            if (getElement(node) is Null) {
                setElement(node, replacement);
            }
        }
    }

    shared actual
    void insert(Integer index, Element element) {
        if (! 0 <= index < size) {
            throw AssertionError("invalid index ``index``");
        }
        insertNode(element, nodeFromFirst(index));
    }

    shared actual
    void prune() {
        for (node in nodeIterable()) {
            if (getElement(node) is Null) {
                removeNode(node);
            }
        }
    }

    shared actual
    Integer remove(Element&Object element) {
        variable value count = 0;
        for (node in nodeIterable()) {
            if (eq(this.getElement(node), element)) {
                removeNode(node);
                count++;
            }
        }
        return count;
    }

    shared actual
    Boolean removeFirst(Element&Object element) {
        for (node in nodeIterable()) {
            if (eq(this.getElement(node), element)) {
                removeNode(node);
                return true;
            }
        }
        return false;
    }

    shared actual
    Boolean removeLast(Element&Object element) {
        for (node in nodeIterable(backward)) {
            if (eq(this.getElement(node), element)) {
                removeNode(node);
                return true;
            }
        }
        return false;
    }

    shared actual
    void replace(Element&Object element, Element replacement) {
        for (node in nodeIterable()) {
            if (eq(this.getElement(node), element)) {
                setElement(node, replacement);
            }
        }
    }

    shared actual
    Boolean replaceFirst(Element&Object element, Element replacement) {
        for (node in nodeIterable()) {
            if (eq(this.getElement(node), element)) {
                setElement(node, replacement);
                return true;
            }
        }
        return false;
    }

    shared actual
    Boolean replaceLast(Element&Object element, Element replacement) {
        for (node in nodeIterable(backward)) {
            if (eq(this.getElement(node), element)) {
                setElement(node, replacement);
                return true;
            }
        }
        return false;
    }

    shared actual
    void set(Integer index, Element element) {
        assert (exists node = nodeFromFirst(index));
        setElement(node, element);
    }

    shared actual default
    MutableList<Element> clone()
        =>  ArrayList { *this };

    add(Element element) => insertNode(element);

    clear() => truncate(0);

    truncate(Integer size) => nodeIterable(forward, size).each(removeNode);
}
