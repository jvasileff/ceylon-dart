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

String dartStringJoin(String val, {Object*} objects) {
    variable value result = "";
    variable value first = true;
    for (el in objects) {
        if (first) {
            first = false;
        }
        else {
            result = result + val;
        }
        result = result + el.string;
    }
    return result;
}

{String*} dartStringLines(String val)
    =>  val.split('\n'.equals, true, false)
            .map(((s) => s.trimTrailing('\r'.equals)));

{String*} dartStringLinesWithBreaks(String val)
    =>  val.split('\n'.equals, false, false)
            .partition(2)
            .map((lineWithBreak)
                =>  let (line = lineWithBreak[0], br = lineWithBreak[1])
                    if (exists br) then line+br else line);

{String+} dartStringSplit(
        String val,
        Boolean splitting(Character ch) => ch.whitespace,
        Boolean discardSeparators=true,
        Boolean groupSeparators=true)
        => if (val.empty) then Singleton(val) else object
        satisfies {String+} {

    // adapted/hacked from Java impl.
    shared actual
    Iterator<String> iterator() => object
            satisfies Iterator<String> {

        // avoid O(n) on substring()
        value seq = val.sequence();
        value it = seq.iterator();
        variable value index = 0;
        variable value first = true;
        variable value lastWasSeparator = false;
        variable value peeked = false;
        variable value peekedWasSeparator = false;
        variable value eof = false;

        Boolean peekSeparator() {
            // idempotent
            if (!peeked) {
                peeked = true;
                if (!is Finished next = it.next()) {
                    peekedWasSeparator = splitting(next);
                }
                else {
                    eof = true;
                    peekedWasSeparator = false;
                }
            }
            return peekedWasSeparator;
        }

        void eatChar() {
            peeked = false;
            peekSeparator();
            index++;
        }

        Boolean eatSeparator() {
            value result = peekSeparator();
            if (result) {
                eatChar();
            }
            return result;
        }

        // calculate eof
        peekSeparator();

        String substring(Integer start, Integer end)
            =>  String(seq[start:end - start]);

        shared actual
        String|Finished next() {
            if (!eof) {
                variable value start = index;

                // if we start with a separator, or if we returned a separator
                // the last time and we are still looking at a separator: return
                // an empty token once
                if (((first && start == 0) || lastWasSeparator)
                        && peekSeparator()) {
                    first = false;
                    lastWasSeparator = false;
                    return "";
                }
                // are we looking at a separator
                if (eatSeparator()) {
                    if (groupSeparators) {
                        // eat them all in one go if we group them
                        while (eatSeparator()) {}
                    }
                    // do we return them?
                    if (!discardSeparators) {
                        lastWasSeparator = true;
                        return substring(start, index);
                    }
                    // keep going and eat the next word
                    start = index;
                }
                // eat until the next separator
                while (!eof && !peekSeparator()) {
                    eatChar();
                }
                lastWasSeparator = false;
                return substring(start, index);
            }
            else if (lastWasSeparator) {
                // we're missing a last empty token before
                // the EOF because the string ended with a
                // returned separator
                lastWasSeparator = false;
                return "";
            }
            else {
                return finished;
            }
        }
    };
};

native
class DartStringBuffer() {

    shared native
    Boolean empty;

    shared native
    Integer length;

    shared native
    void clear();

    shared native
    void write(Object obj);

    shared native
    void writeCharCode(Integer charCode);

    shared actual native
    String string;
}
