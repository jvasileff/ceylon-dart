shared
class CodeWriter(
        Anything(String) append,
        shared variable Integer indentLevel = 0,
        shared variable Integer indentAmount = 4) {

    variable
    Boolean lastWasEndStatement = false;

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
        lastWasEndStatement = false;
        return this;
    }

    shared
    CodeWriter write(String s) {
        append(s);
        lastWasEndStatement = false;
        return this;
    }

    shared
    CodeWriter writeLine(String s = "") {
        write(s);
        write("\n");
        lastWasEndStatement = false;
        return this;
    }

    shared
    CodeWriter endStatement() {
        write(";");
        lastWasEndStatement = true;
        return this;
    }

    shared
    CodeWriter startBlock() {
        if (lastWasEndStatement) {
            writeLine();
            writeIndent();
        }
        write("{");
        indentPlus();
        lastWasEndStatement = false;
        return this;
    }

    shared
    CodeWriter endBlock() {
        indentMinus();
        writeLine();
        writeIndent();
        write("}");
        lastWasEndStatement = true;
        return this;
    }
}
