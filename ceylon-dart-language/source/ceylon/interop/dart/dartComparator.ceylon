import dart.core {
    DInt = \Iint
}

shared
DInt dartComparator<Element>
        (Comparison comparing(Element x, Element y))
        (Element x, Element y)
    =>  dartInt {
            switch (result = comparing(x, y))
            case (smaller) -1
            case (equal) 0
            case (larger) 1;
        };
