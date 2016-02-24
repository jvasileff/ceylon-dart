import dart.core {
    DList = List,
    DListClass = List_C
}
import ceylon.interop.dart {
    DartIterable
}

"""A _tuple_ is a typed linked list. Each instance of 
   `Tuple` represents the value and type of a single link.
   The attributes `first` and `rest` allow us to retrieve a 
   value from the list without losing its static type 
   information.
   
       value point = Tuple(0.0, Tuple(0.0, Tuple("origin")));
       Float x = point.first;
       Float y = point.rest.first;
       String label = point.rest.rest.first;
   
   Usually, we abbreviate code involving tuples.
   
       [Float,Float,String] point = [0.0, 0.0, "origin"];
       Float x = point[0];
       Float y = point[1];
       String label = point[2];
   
   A list of types enclosed in brackets is an abbreviated 
   tuple type. An instance of `Tuple` may be constructed by 
   surrounding a value list in brackets:
   
       [String,String] words = ["hello", "world"];
   
   The index operator with a literal integer argument is a 
   shortcut for a chain of evaluations of `rest` and 
   `first`. For example, `point[1]` means `point.rest.first`.
   
   A _terminated_ tuple type is a tuple where the type of
   the last link in the chain is `Empty`. An _unterminated_ 
   tuple type is a tuple where the type of the last link
   in the chain is `Sequence` or `Sequential`. Thus, a 
   terminated tuple type has a length that is known
   statically. For an unterminated tuple type only a lower
   bound on its length is known statically.
   
   Here, `point` is an unterminated tuple:
   
       String[] labels = ... ;
       [Float,Float,String*] point = [0.0, 0.0, *labels];
       Float x = point[0];
       Float y = point[1];
       String? firstLabel = point[2];
       String[] allLabels = point[2...];"""
by ("Gavin")
tagged("Sequences", "Basic types", "Collections")
shared final serializable
native class Tuple<out Element, out First, out Rest = []>
        (first, rest)
        extends Object()
        satisfies [Element+]
        given First satisfies Element
        given Rest satisfies Element[] {
    
    "The first element of this tuple. (The head of the 
     linked list.)"
    shared actual native 
    First first;
    
    "A tuple with the elements of this tuple, except for the
     first element. (The tail of the linked list.)"
    shared actual native 
    Rest rest;
    
    shared actual native 
    Integer lastIndex => rest.size;
    
    shared actual native 
    Integer size => 1 + rest.size;
    
    shared actual native 
    Element? getFromFirst(Integer index) 
            => switch (index <=> 0)
            case (smaller) null
            case (equal) first
            case (larger) rest.getFromFirst(index - 1);
    
    "The last element of this tuple."
    shared actual native 
    Element last 
            => if (nonempty rest)
            then rest.last
            else first;
    
    shared actual native 
    Element[] measure(Integer from, Integer length) {
        if (length <= 0) {
            return [];
        }
        Integer realFrom = from < 0 then 0 else from;
        if (realFrom == 0) {
            return length == 1 
                    then [first]
                    else rest[0 : length + realFrom - 1]
                            .withLeading(first);
        }
        return rest[realFrom - 1 : length];
    }
    
    shared actual native 
    Element[] span(Integer from, Integer end) {
        if (from < 0 && end < 0) { return []; }
        Integer realFrom = from < 0 then 0 else from;
        Integer realEnd = end < 0 then 0 else end;
        return realFrom <= realEnd 
            then this[from : realEnd - realFrom + 1]
            else this[realEnd : realFrom - realEnd + 1]
                        .reversed.sequence();
    }
    
    shared actual native 
    Element[] spanTo(Integer to)
            => to < 0 then [] else span(0, to);
    
    shared actual native 
    Element[] spanFrom(Integer from)
            => span(from, size);
    
    "This tuple."
    shared actual native 
    Tuple<Element,First,Rest> clone() => this;
    
    shared actual native 
    Iterator<Element> iterator() 
            => object
            satisfies Iterator<Element> {
        variable Element[] current = outer;
        shared actual Element|Finished next() {
            if (nonempty c = current) {
                current = c.rest;
                return c.first;
            }
            else {
                return finished;
            }
        }
        string => "``outer.string``.iterator()";
    };
    
    "Determine if the given value is an element of this
     tuple."
    shared actual native 
    Boolean contains(Object element) 
            => if (exists first, first == element)
            then true
            else element in rest;
    
    "Return a new tuple that starts with the specified
     [[element]], followed by the elements of this tuple."
    shared actual native
    Tuple<Element|Other,Other,Tuple<Element,First,Rest>>
    withLeading<Other>(
            "The first element of the resulting tuple."
            Other element)
            => Tuple(element, this);
    
    "Return a new tuple containing the elements of this 
     tuple, followed by the given [[element]]."
    shared actual native
    [First,Element|Other+] withTrailing<Other>(
            "The last element of the resulting tuple."
            Other element) 
            => Tuple(first, rest.withTrailing(element));
    
    "Return a tuple containing the elements of this 
     tuple, followed by the given [[elements]]."
    shared actual native
    [First,Element|Other*] append<Other>(
            "The list of elements to be appended."
            Other[] elements)
            => Tuple(first, rest.append(elements));
}

native
[Element*] tupleWithList<Element>(Object /*DList<Element>*/ list, [Element*] rest = []);

native
[Element*] tupleOfElements<Element>({Element*} rest);

native
[Element*] tupleTrailing<Element>({Element*} initial, Element element);

abstract native("dart")
class BaseTuple<out Element, out First, out Rest = []>
        extends Object
        satisfies [Element+]
        given First satisfies Element
        given Rest satisfies Element[] {

    DList<Element> list;
    [Element*] restSequence;

    shared
    new (Element first, [Element*] rest = []) extends Object() {
        list = DListClass(1);
        list.set_(0, first);
        this.restSequence = rest;
    }

    shared
    new trailing({Element*} initial, Element element) extends Object() {
        list = DListClass.from(DartIterable(initial.chain({element})));
        this.restSequence = [];
    }

    shared
    new ofElements({Element*} rest) extends Object() {
        list = DListClass.from(DartIterable(rest));
        if (list.isEmpty) {
            throw AssertionError("list must not be empty");
        }
        this.restSequence = [];
    }

    shared
    new withList(DList<Element> list, [Element*] rest = []) extends Object() {
        if (list.isEmpty) {
            throw AssertionError("list must not be empty");
        }
        this.list = list;
        this.restSequence = rest;
    }

    shared actual
    First first {
        assert (is First first = getFromFirst(0));
        return first;
    }

    shared actual
    Rest rest {
        assert(is Rest result
            =   if (list.length == 1)
                then restSequence
                else tupleWithList(list.sublist(1), restSequence));
        return result;
    }

    shared actual
    Integer lastIndex => size - 1;

    shared actual
    Integer size => list.length + restSequence.size;

    shared actual
    Element? getFromFirst(Integer index)
        =>  if (index < 0) then
                null
            else if (index < list.length) then
                list.get_(index)
            else
                restSequence.getFromFirst(index - list.length);

    // TODO optimize

    shared actual
    Element last {
        assert (exists result = getFromLast(0));
        return result;
    }

    //shared actual
    //Element[] measure(Integer from, Integer length) => super.measure(from, length);

    //shared actual
    //Element[] span(Integer from, Integer end) => super.span(from, end);

    //shared actual
    //Element[] spanTo(Integer to) => super.spanTo(to);

    shared actual
    Element[] spanFrom(Integer from) {
        // Important: Always return a Tuple.
        //
        // Destructuring and subrange expressions may have Tuple results when enough
        // static type information is available.
        //
        // This could be optimized at some point; the Java backend uses a utility method
        // for spanFrom for when a Tuple is the expected result, leaving the
        // Tuple.spanFrom method free to return *just* a Sequential.
        if (from > lastIndex) {
            return package.empty;
        }
        return tupleOfElements(super.spanFrom(from));
    }

    shared actual
    BaseTuple<Element,First,Rest> clone() => this;

    shared actual
    Iterator<Element> iterator() => (super of List<Element>).iterator();

    shared actual
    Boolean contains(Object element) => super.contains(element);

    shared actual
    Tuple<Element|Other,Other,Tuple<Element,First,Rest>>
    withLeading<Other>(Other element) {
        assert (is Tuple<Element, First, Rest> self = (this of Anything));
        return Tuple(element, self);
    }

    shared actual
    [First,Element|Other+] withTrailing<Other>(Other element) {
        assert (is [First,Element|Other+] result = tupleTrailing(this, element));
        return result;
    }

    shared actual
    [First,Element|Other*] append<Other>(Other[] elements) {
        assert (is [First, Element | Other*] result
            =   tupleWithList(list, restSequence.append(elements)));
        return result;
    }
}
