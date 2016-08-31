"Forms an [[Iterable]] from a [[List]]... The main reason for this class is to closely
 match the Java runtime implementation of [[Array]] so the language module tests pass!"
shared
{Element*} listIterable<Element>
        (list, offset = 0, limit = runtime.maxIntegerValue, step = 1) {
        List<Element> list;
        Integer offset;
        Integer limit;
        "Must be positive"
        Integer step;

    "step size must be greater than zero"
    assert (step > 0);

    if (limit <= 0) {
        return [];
    }

    value start = if (offset < 0) then 0 else offset;

    value listSize = list.size;

    if (start >= listSize) {
        return [];
    }

    if (start == 0 && step == 1 && listSize <= limit) {
        return list;
    }

    return object
            extends BaseIterable<Element, Null>()
            satisfies Identifiable {

        size = let (unbounded = (listSize - start - 1)/step + 1)
               if (unbounded < limit)
               then unbounded
               else limit;

        empty => false;

        first => list.get(start);

        last => list.get(start + step * (size - 1));

        rest => listIterable(list, start + step, size - 1, step);

        longerThan(Integer length) => size > length;

        shorterThan(Integer length) => size < length;

        skip(Integer amount)
            =>  if (amount <= 0)
                then this
                else listIterable {
                    list;
                    offset = start + amount * step;
                    limit = size - amount;
                    step = step;
                };

        take(Integer amount)
            =>  if (amount >= size)
                then this
                else listIterable(list, start, amount, step);

        by(Integer amount)
            =>  listIterable {
                    list;
                    offset = start;
                    limit = (size + amount - 1) / amount;
                    step = step * amount;
                };

        getFromFirst(Integer index)
            =>  list.getFromFirst(index * step + start);

        function unsafeGet(Integer index) {
            if (exists element = list.getFromFirst(index * step + start)) {
                return element;
            }
            assert (is Element null);
            return null;
        }

        shared actual
        void each(void step(Element element)) {
            for (i in 0:size) {
                step(unsafeGet(i));
            }
        }

        shared actual
        Integer count(Boolean selecting(Element element)) {
            variable value count = 0;
            for (i in 0:size) {
                if (selecting(unsafeGet(i))) {
                    count++;
                }
            }
            return count;
        }

        shared actual
        Boolean any(Boolean selecting(Element element)) {
            for (i in 0:size) {
                if (selecting(unsafeGet(i))) {
                    return true;
                }
            }
            return false;
        }

        shared actual
        Boolean every(Boolean selecting(Element element)) {
            for (i in 0:size) {
                if (!selecting(unsafeGet(i))) {
                    return false;
                }
            }
            return true;
        }

        shared actual
        Element? find(Boolean selecting(Element&Object element)) {
            for (i in 0:size) {
                value element = unsafeGet(i);
                if (exists element, selecting(element)) {
                    return element;
                }
            }
            return null;
        }

        shared actual
        Element? findLast(Boolean selecting(Element&Object element)) {
            for (i in 0:size) {
                value element = unsafeGet(size - 1 - i);
                if (exists element, selecting(element)) {
                    return element;
                }
            }
            return null;
        }

        shared actual
        Iterator<Element> iterator() => object
                satisfies Iterator<Element> {

            variable value nextIndex = 0;
            next() => if (nextIndex < size)
                      then unsafeGet(nextIndex++)
                      else finished;
        };
    };
}
