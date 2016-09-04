shared
class CodeWriter(
        Anything(String) append,
        shared variable Integer indentLevel = 0,
        shared variable Integer indentAmount = 2) {

    variable Boolean lastWasEndStatement = false;
    variable Boolean topOfFile = true;

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
        lastWasEndStatement = false;
        topOfFile = false;
        return this;
    }

    shared
    CodeWriter writeLine(String s = "") {
        if (!topOfFile) {
            write(s);
            write("\n");
        }
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
