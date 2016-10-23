import dart.core {
    DInt = \Iint,
    DList = List
}
import ceylon.interop.dart {
    DartIterable,
    dartComparator
}
import ceylon.language.impl {
    listIterable
}

"A fixed-sized array of mutable elements. An _empty_ array 
 is an array of [[size]] `0`. An array may be created with
 a list of initial elements, or, via the constructor 
 [[ofSize]], with a size and single initial value for all 
 elements.
 
     value array = Array { \"hello\", \"world\" };
     value ints = Array.ofSize(1k, 0);
 
 Arrays are mutable. Any element of an array may be set to a 
 new value.
 
     value array = Array { \"hello\", \"world\" };
     array[0] = \"goodbye\";
 
 Arrays are lists and support all operations inherited from 
 [[List]], along with certain additional operations for 
 efficient mutation of the array: [[set]], [[swap]], [[move]], 
 [[sortInPlace]], [[reverseInPlace]], and [[copyTo]].
 
 This class is provided primarily to support interoperation 
 with Java, and for some performance-critical low-level 
 programming tasks."
tagged("Collections")
shared final serializable native 
class Array<Element>
        satisfies SearchableList<Element> &
                  Ranged<Integer,Element,Array<Element>> &
                  IndexedCorrespondenceMutator<Element> {
    
    "Create an array with the given [[elements]]."
    shared native new ({Element*} elements) {}
    
    "Create an array of the specified [[size]], populating 
     every index with the given [[element]]. The specified 
     `size` must be no larger than [[runtime.maxArraySize]].
     If `size<=0`, the new array will have no elements."
    throws (`class AssertionError`, 
        "if `size>runtime.maxArraySize`")
    see (`value runtime.maxArraySize`)
    since("1.2.0")
    shared native new ofSize(
            "The size of the resulting array. If the size is 
             non-positive, an empty array will be created."
            Integer size, 
            "The element value with which to populate the 
             array. All elements of the resulting array will 
             have the same value."
            Element element) {
        assert (size<runtime.maxArraySize);
    }
    
    //"Get the element at the specified index, or `null` if
    // the index falls outside the bounds of this array."
    //shared actual native Element? get(Integer index);
    
    "Get the element at the specified index, where the array
     is indexed from the _end_ of the array, or `null` if
     the index falls outside the bounds of this array."
    shared actual native Element? getFromLast(Integer index);
    
    "Get the element at the specified index, or `null` if
     the index falls outside the bounds of this array."
    shared actual native Element? getFromFirst(Integer index);
    
    //shared actual native Boolean->Element? lookup(Integer index);
    
    shared actual native Integer? lastIndex;
    
    shared actual native Element? first;
    shared actual native Element? last;
    
    "The immutable number of elements of this array."
    aliased ("length")
    shared actual native Integer size;
    
    shared actual native Boolean empty;
    shared actual native Boolean defines(Integer index);
    shared actual native Iterator<Element> iterator();
    shared actual native Boolean contains(Object element);
    shared actual native Element[] sequence();
    shared actual native {Element&Object*} coalesced;
    
    "A new array with the same elements as this array."
    shared actual native Array<Element> clone();
    
    "Replace the existing element at the specified [[index]] 
     with the given [[element]]."
    throws (`class AssertionError`,
        "if the given index is out of bounds, that is, if 
         `index<0` or if `index>lastIndex`")
    shared actual native 
    void set(
        "The index of the element to replace."
        Integer index,
        "The new element."
        Element element);
    
    "Efficiently copy the elements in the measure
     `sourcePosition:length` of this array to the measure 
     `destinationPosition:length` of the given 
     [[array|destination]], which may be this array.
     
     The given [[sourcePosition]] and [[destinationPosition]] 
     must be non-negative and, together with the given 
     [[length]], must identify meaningful ranges within the 
     two arrays, satisfying:
     
     - `size >= sourcePosition+length`, and 
     - `destination.size >= destinationPosition+length`.
     
     If the given `length` is not strictly positive, no
     elements are copied."
    throws (`class AssertionError`, 
        "if the arguments do not identify meaningful ranges 
         within the two arrays:
         
         - if the given [[sourcePosition]] or 
           [[destinationPosition]] is negative, 
         - if `size < sourcePosition+length`, or 
         - if `destination.size < destinationPosition+length`.")
    shared native 
    void copyTo(
        "The array into which to copy the elements, which 
         may be this array."
        Array<in Element> destination,
        "The index of the first element in this array to 
         copy."
        Integer sourcePosition = 0,
        "The index in the given array into which to copy the 
         first element."
        Integer destinationPosition = 0,
        "The number of elements to copy."
        Integer length 
                = smallest(size - sourcePosition,
                    destination.size - destinationPosition));
        
    shared actual native 
    Array<Element> span(Integer from, Integer to);
    shared actual native 
    Array<Element> spanFrom(Integer from);
    shared actual native 
    Array<Element> spanTo(Integer to);
    shared actual native 
    Array<Element> measure(Integer from, Integer length);
    
    shared actual native {Element*} skip(Integer skipping);
    shared actual native {Element*} take(Integer taking);
    shared actual native {Element*} by(Integer step);
    
    shared actual native 
    Integer count(Boolean selecting(Element element));
    shared actual native 
    void each(void step(Element element));
    shared actual native
    Boolean any(Boolean selecting(Element element));
    shared actual native
    Boolean every(Boolean selecting(Element element));
    shared actual native
    {Element*} filter(Boolean selecting(Element element));
    shared actual native
    Element? find(Boolean selecting(Element&Object element));
    shared actual native
    Element? findLast(Boolean selecting(Element&Object element));
    shared actual native
    Integer? firstIndexWhere(Boolean selecting(Element&Object element));
    shared actual native
    Integer? lastIndexWhere(Boolean selecting(Element&Object element));
    shared actual native 
    {Integer*} indexesWhere(Boolean selecting(Element&Object element));
    shared actual native
    <Integer->Element&Object>? locate(Boolean selecting(Element&Object element));
    shared actual native
    <Integer->Element&Object>? locateLast(Boolean selecting(Element&Object element));
    shared actual native
    {<Integer->Element&Object>*} locations(Boolean selecting(Element&Object element));
    shared actual native
    Result|Element|Null reduce<Result>
            (Result accumulating(Result|Element partial, Element element));
    
    shared actual native 
    Boolean occursAt(Integer index, Element element);
    shared actual native
    Integer? firstOccurrence(Element element, Integer from, Integer length);
    shared actual native
    Integer? lastOccurrence(Element element, Integer from, Integer length);
    shared actual native
    Boolean occurs(Element element, Integer from, Integer length);
    
    shared actual native 
    {Integer*} occurrences(Element element, Integer from, Integer length);
    
    "Given two indices within this array, efficiently swap 
     the positions of the elements at these indices. If the 
     two given indices are identical, no change is made to 
     the array. The array always contains the same elements
     before and after this operation."
    throws (`class AssertionError`,
        "if either of the given indices is out of bounds") 
    since("1.2.0")
    shared native
    void swap(
            "The index of the first element."
            Integer i,
            "The index of the second element." 
            Integer j);
    
    "Efficiently move the element of this array at the given 
     [[source index|from]] to the given 
     [[destination index|to]], shifting every element 
     falling between the two given indices by one position 
     to accommodate the change of position. If the source 
     index is larger than the destination index, elements 
     are shifted toward the end of the array. If the source 
     index is smaller than the destination index, elements 
     are shifted toward the start of the array. If the given 
     indices are identical, no change is made to the array. 
     The array always contains the same elements before and 
     after this operation."
    throws (`class AssertionError`,
        "if either of the given indices is out of bounds") 
    since("1.2.0")
    shared native
    void move(
            "The source index of the element to move."
            Integer from, 
            "The destination index to which the element is
             moved."
            Integer to);
    
    "Reverses the order of the current elements in this 
     array. This operation works by side-effect, modifying 
     the array. The array always contains the same elements 
     before and after this operation."
    since("1.1.0")
    shared native 
    void reverseInPlace();
    
    "Sorts the elements in this array according to the 
     order induced by the given 
     [[comparison function|comparing]]. This operation works 
     by side-effect, modifying the array.  The array always 
     contains the same elements before and after this 
     operation."
    since("1.1.0")
    shared native 
    void sortInPlace(
        "A comparison function that compares pairs of
         elements of this array."
        Comparison comparing(Element x, Element y));
    
    "Sorts the elements in this array according to the 
     order induced by the given 
     [[comparison function|comparing]], returning a new
     sequence. This operation has no side-effect, and does
     not modify the array."
    shared actual native 
    Element[] sort(
        "A comparison function that compares pairs of
         elements of this array."
        Comparison comparing(Element x, Element y));
    
    shared actual native Boolean equals(Object that)
            => (super of List<Element>).equals(that);
    shared actual native Integer hash
            => (super of List<Element>).hash;
    shared actual native String string
            => (super of Collection<Element>).string;
}

shared native("dart")
final serializable class Array<Element>
        satisfies SearchableList<Element> &
                  Ranged<Integer,Element,Array<Element>> &
                  IndexedCorrespondenceMutator<Element> {

    variable DList<Element> list;

    shared native("dart")
    new ({Element*} elements) {
        if (is List<Anything> elements) {
            list = DList.Class(elements.size);
            value iterator = elements.iterator();
            for (i in 0:elements.size) {
                value element = iterator.next();
                if (is Finished element) {
                    assert (is Element finished);
                    list.set_(i, finished);
                }
                else {
                    list.set_(i, element);
                }
            }
        }
        else {
            list = DList.Class.from(DartIterable(elements));
        }
    }

    shared native("dart")
    new ofSize(Integer size, Element element) {
        if (size > runtime.maxArraySize) {
            throw AssertionError("array size must be no larger than ``runtime.maxArraySize``");
        }
        list = DList.Class<Element>.filled(largest(size, 0), element);
    }

    new withList(DList<Element> list) {
        this.list = list;
    }

    shared actual native("dart")
    Element? getFromFirst(Integer index)
        =>  if (0 <= index < size)
            then list.get_(index)
            else null;

    shared actual native("dart")
    Integer? lastIndex
        =>  !list.isEmpty then list.length - 1;

    shared actual native("dart")
    Integer size
        =>  list.length;

    shared actual native("dart")
    Boolean empty
        =>  list.isEmpty;

    shared actual native("dart")
    Array<Element> clone()
        =>  Array.withList(list.toList());

    shared actual native("dart")
    void set(Integer index, Element element) {
        if (index < 0 || index > size - 1) {
            throw AssertionError("Index out of bounds");
        }
        list.set_(index, element);
    }

    shared native("dart")
    void swap(Integer i, Integer j) {
        if (i < 0 || j < 0) {
          throw AssertionError("array index may not be negative");
        }
        if (i >= size || j >= size) {
          throw AssertionError(
              "array index must be less than size of array ``size.string``");
        }
        value oldI = list.get_(i);
        list.set_(i, list.get_(j));
        list.set_(j, oldI);
    }

    shared native("dart")
    void reverseInPlace() {
        for (index in 0:size/2) {
            value otherIndex = size - index - 1;
            value x = list.get_(index);
            list.set_(index, list.get_(otherIndex));
            list.set_(otherIndex, x);
        }
    }

    shared native("dart")
    void move(Integer from, Integer to) {
        if (from < 0 || to < 0) {
            throw AssertionError("array index may not be negative");
        }
        if (from >= size || to >= size) {
            throw AssertionError("array index must be less than size of array ``size``");
        }
        if (from == to) {
            return;
        }
        Integer len;
        Integer srcPos;
        Integer destPos;
        if (from > to) {
          len = from - to;
          srcPos = to;
          destPos = to + 1;
        }
        else {
          len = to - from;
          srcPos = from + 1;
          destPos = from;
        }
        value x = list.get_(from);
        list.setRange(destPos,  destPos + len, list, srcPos);
        list.set_(to, x);
    }

    shared native("dart")
    void copyTo(Array<in Element> destination,
            Integer sourcePosition = 0,
            Integer destinationPosition = 0,
            Integer length = smallest(
                size - sourcePosition,
                destination.size - destinationPosition)) {

        // TODO validate indexes
        destination.list.setRange {
            start = destinationPosition;
            end = destinationPosition + length;
            iterable = list;
            skipCount = sourcePosition;
        };
    }

    shared actual native("dart")
    Boolean any(Boolean selecting(Element element)) {
        for (i in 0:size) {
            if (selecting(list.get_(i))) {
                return true;
            }
        }
        return false;
    }

    shared actual native("dart")
    Boolean every(Boolean selecting(Element element)) {
        for (i in 0:size) {
            if (!selecting(list.get_(i))) {
                return false;
            }
        }
        return true;
    }

    // TODO optimize
    shared actual native("dart")
    Array<Element> span(Integer from, Integer to)
        =>  Array((super of List<Element>).span(from, to));

    // TODO optimize
    shared actual native("dart")
    Array<Element> spanFrom(Integer from)
        =>  Array((super of List<Element>).spanFrom(from));

    // TODO optimize
    shared actual native("dart")
    Array<Element> spanTo(Integer to)
        =>  Array((super of List<Element>).spanTo(to));

    // TODO optimize
    shared actual native("dart")
    Array<Element> measure(Integer from, Integer length)
        =>  Array((super of List<Element>).measure(from, length));

    shared actual native("dart")
    {Element*} skip(Integer skipping)
        =>  listIterable {
                list = this;
                offset = skipping;
            };

    shared actual native("dart")
    {Element*} take(Integer taking)
        =>  listIterable {
                list = this;
                limit = taking;
            };

    shared actual native("dart")
    {Element*} by(Integer step)
        =>  listIterable {
                list = this;
                step = step;
            };

    shared actual native("dart")
    Sequential<Element> sort(Comparison comparing(Element x, Element y)) {
        value result = list.toList();
        result.sort(dartComparator(comparing));
        return ArraySequence<Element>(Array.withList(result));
    }

    shared native("dart")
    void sortInPlace(Comparison comparing(Element x, Element y)) {
        list.sort(dartComparator(comparing));
    }

    shared actual native("dart")
    Boolean equals(Object that)
        =>  (super of List<Element>).equals(that);

    shared actual native("dart")
    Integer hash
        =>  (super of List<Element>).hash;

    shared actual native("dart")
    String string
            => (super of Collection<Element>).string;
}
