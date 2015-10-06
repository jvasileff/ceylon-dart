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
        // FIXME capture problem with function param
        //Boolean splitting(Character ch) => ch.whitespace,
        Boolean(Character) splitting = (Character ch) => ch.whitespace,
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

"""Builder utility for constructing [[strings|String]] by
   incrementally appending strings or characters.

       value builder = StringBuilder();
       builder.append("hello");
       builder.appendCharacter(' ');
       builder.append("world");
       String hello = builder.string; //hello world"""
shared final class StringBuilder()
        satisfies List<Character> {

    DartStringBuffer delegate = DartStringBuffer();

    "The number characters in the current content, that is,
     the [[size|String.size]] of the produced [[string]]."
    shared actual Integer size => delegate.string.size;

    shared actual Integer? lastIndex
        =>  if (!empty)
            then size - 1
            else null;

    "The resulting string. If no characters have been
     appended, the empty string."
    shared actual String string
        =>  delegate.string;

    shared actual Iterator<Character> iterator()
        =>  string.iterator();

    "Returns a string of the given [[length]] containing
     the characters beginning at the given [[index]]."
    shared
    String substring(Integer index, Integer length)
        =>  string.measure(index, length);

    shared actual
    Character? getFromFirst(Integer index)
        =>  string.getFromFirst(index);

    "Append the characters in the given [[string]]."
    shared
    StringBuilder append(String string) {
        delegate.write(string);
        return this;
    }

    "Append the characters in the given [[strings]]."
    shared
    StringBuilder appendAll({String*} strings) {
        for (s in strings) {
            append(s);
        }
        return this;
    }

    "Prepend the characters in the given [[string]]."
    shared
    StringBuilder prepend(String string) {
        value newString = string + this.string;
        clear();
        delegate.write(newString);
        return this;
    }

    "Prepend the characters in the given [[strings]]."
    shared
    StringBuilder prependAll({String*} strings) {
        for (s in strings) {
            prepend(s);
        }
        return this;
    }

    "Append the given [[character]]."
    shared
    StringBuilder appendCharacter(Character character) {
        delegate.write(character);
        return this;
    }

    "Prepend the given [[character]]."
    shared
    StringBuilder prependCharacter(Character character) {
        prepend(character.string);
        return this;
    }

    "Append a newline character."
    shared
    StringBuilder appendNewline() => appendCharacter('\n');

    "Append a space character."
    shared
    StringBuilder appendSpace() => appendCharacter(' ');

    "Remove all content and return to initial state."
    shared
    StringBuilder clear() {
        delegate.clear();
        return this;
    }

    "Insert a [[string]] at the specified [[index]]."
    shared
    StringBuilder insert(Integer index, String string) {
        "index must not be negative"
        assert (index >= 0);

        "index must not be greater than size"
        assert (index < size);

        value oldString = this.string;

        clear();
        delegate.write(oldString.spanTo(index - 1) + string + oldString.spanFrom(index));
        return this;
    }

    "Insert a [[character]] at the specified [[index]]."
    shared
    StringBuilder insertCharacter(Integer index, Character character)
        =>  insert(index, character.string);

    "Replaces the specified [[number of characters|length]]
     from the current content, starting at the specified
     [[index]], with the given [[string]]. If `length` is
     nonpositive, nothing is replaced."
    shared
    StringBuilder replace(Integer index, Integer length, String string) {
        "index must not be negative"
        assert (index > 0);

        "index must not be greater than size"
        assert (index <= size);

        "index+length must not be greater than size"
        assert (index + length <= size);

        if (!string.empty) {
            value oldString = this.string;

            clear();
            delegate.write(oldString.spanTo(index - 1) + string
                + oldString.spanFrom(index + length));
        }
        return this;
    }

    "Deletes the specified [[number of characters|length]]
     from the current content, starting at the specified
     [[index]]. If `length` is nonpositive, nothing is
     deleted."
    shared StringBuilder delete(Integer index, Integer length/*=1*/) {
        "index must not be negative"
        assert (index >= 0);

        "index must not be greater than size"
        assert (index < size);

        "index+length must not be greater than size"
        assert (index + length <= size);

        value oldString = this.string;

        clear();
        delegate.write(oldString.spanTo(index - 1) + oldString.spanFrom(index + length));
        return this;
    }

    "Deletes the specified [[number of characters|length]]
     from the start of the string. If `length` is
     nonpositive, nothing is deleted."
    shared
    StringBuilder deleteInitial(Integer length) {
        "length must not be greater than size"
        assert (length <= size);

        if (length > 0) {
            return delete(0, length);
        }
        else {
            return this;
        }
    }

    "Deletes the specified [[number of characters|length]]
     from the end of the string. If `length` is nonpositive,
     nothing is deleted."
    shared
    StringBuilder deleteTerminal(Integer length) {
        "length must not be greater than size"
        assert (length <= size);

        if (length > 0) {
            return delete(size - length, length);
        }
        else {
            return this;
        }
    }

    "Reverses the order of the current characters."
    shared
    StringBuilder reverseInPlace() {
        value oldString = this.string;
        clear();
        delegate.write(oldString.reversed);
        return this;
    }

    shared actual
    Boolean equals(Object that)
        =>  if (is StringBuilder that)
            then delegate.equals(that.delegate)
            else false;

    shared actual
    Integer hash => delegate.hash;
}
