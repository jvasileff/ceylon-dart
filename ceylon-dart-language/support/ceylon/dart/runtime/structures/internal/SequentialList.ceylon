shared
interface SequentialList<Node, Element> satisfies List<Element> {

    shared formal
    Node? nodeFromFirst(Integer index);

    shared actual formal
    Integer size;

    shared formal
    Element getElement(Node node);

    shared formal
    {Node*} nodeIterable(
            Direction direction = forward,
            Integer startIndex = if (direction == forward)
                                 then 0 else (size - 1));

    shared actual default
    List<Element> clone() => [ *this ];

    getFromFirst(Integer index)
        =>  if (exists node = nodeFromFirst(index))
            then getElement(node)
            else null;

    iterator() => nodeIterable().map(getElement).iterator();

    lastIndex => switch (s = size) case (0) null else s - 1;

    hash => (super of List<Element>).hash;

    equals(Object that) => (super of List<Element>).equals(that);
}
