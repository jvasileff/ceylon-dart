void dartListCopyTo<Element>(List<Element> val,
        "The array into which to copy the elements."
        Array<Element> destination,
        "The index of the first element in this array to copy."
        Integer sourcePosition = 0,
        "The index in the given array into which to copy the first element."
        Integer destinationPosition = 0,
        "The number of elements to copy."
        Integer length
                = smallest(val.size - sourcePosition,
                    destination.size - destinationPosition)) {
    // TODO validate indexes?
    variable value i = destinationPosition;
    for (c in val.sublistFrom(sourcePosition).take(length)) {
        destination.set(i++, c);
    }
}
