import ceylon.interop.java {
    CeylonDestroyable
}

import com.redhat.ceylon.compiler.typechecker {
    TypeChecker
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    UsageWarning
}
import com.redhat.ceylon.compiler.typechecker.parser {
    RecognitionError
}
import com.redhat.ceylon.compiler.typechecker.tree {
    AnalysisMessage,
    TreeUtil
}

import java.io {
    BufferedReader,
    IOException,
    InputStreamReader
}

// translated from ErrorCollectingVisitor java source
Integer printErrors(void write(String message),
            Boolean printWarnings,
            Boolean printCount,
            [PositionedMessage*] errors,
            TypeChecker tc) {

    variable Integer warningCount = 0;
    variable Integer errorCount = 0;

    for (PositionedMessage pm in errors) {
        value message = pm.message;
        if (is UsageWarning message, !printWarnings || (message).suppressed) {
            continue;
        }

        value node = TreeUtil.getIdentifyingNode(pm.node);
        value line = message.line;
        variable value position
            =   if (is AnalysisMessage message, exists token = node.token) then
                    token.charPositionInLine
                else if (is RecognitionError message) then
                    message.characterInLine
                else -1;

        value fileName
            =   if (exists unit = node.unit)
                then unit.fullPath
                else "unknown";

        write(fileName);
        write(":");
        write(line.string);
        write(": ");
        if (is UsageWarning message) {
            write("warning");
            warningCount++;
        } else {
            write("error");
            errorCount++;
        }

        write(": ");
        write(message.message);
        write(operatingSystem.newline);
        value ln = getErrorSourceLine(pm, tc);
        if (exists ln) {
            write(ln);
            write(operatingSystem.newline);
            write(getErrorMarkerLine(position));
            write(operatingSystem.newline);
        }
    }

    if (printCount) {
        if (errorCount > 0) {
            write(errorCount.string + " "
                + (if (errorCount == 1) then "error" else "errors") + "\n");
        }

        if (warningCount > 0) {
            write(warningCount.string + " "
                + (if (warningCount == 1) then "warning" else "warnings" + "\n"));
        }
    }

    return errorCount;
}

String? getErrorSourceLine(
        PositionedMessage pm,
        TypeChecker tc) {
    if (pm.node.unit exists) {
        value pu = tc.getPhasedUnitFromRelativePath(pm.node.unit.relativePath);
        value virtualFile = pu.unitFile;
        variable value lineNr = pm.message.line;
        try (br = CeylonDestroyable(BufferedReader(
                        InputStreamReader(virtualFile.inputStream)))) {
            while (exists line = br.resource.readLine()) {
                if (--lineNr <= 0) {
                    return line;
                }
            }
        } catch (IOException e) {
        }
    }
    return null;
}

String getErrorMarkerLine(Integer position) {
    value str = StringBuilder();
    variable value i = 0;
    while (i < position) {
        str.append(" ");
        i++;
    }
    str.append("^");
    return str.string;
}
