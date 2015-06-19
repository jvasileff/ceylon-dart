shared
class CodeWriter(
        Anything(String) append,
        shared variable Integer indentLevel = 0,
        shared variable Integer indentAmount = 4) {

    shared
    CodeWriter indentPlus() {
        indentLevel++;
        return this;
    }

    shared
    CodeWriter indentMinus() {
        indentLevel--;
        return this;
    }

    shared
    CodeWriter writeIndent() {
        write(" ".repeat(
                indentLevel *
                indentAmount));
        return this;
    }

    shared
    CodeWriter write(String s) {
        append(s);
        return this;
    }

    shared
    CodeWriter writeLine(String s = "") {
        write(s);
        write("\n");
        return this;
    }

    shared
    CodeWriter startBlock() {
        write("{");
        writeLine();
        indentPlus();
        return this;
    }

    shared
    CodeWriter endBlock() {
        indentMinus();
        writeIndent().write("}");
        return this;
    }
}
