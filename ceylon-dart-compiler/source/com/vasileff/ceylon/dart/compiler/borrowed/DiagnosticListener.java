package com.vasileff.ceylon.dart.compiler.borrowed;

import java.io.File;

public interface DiagnosticListener {
    void error(File file, long line, long column, String message);
    void warning(File file, long line, long column, String message);

    // FIXME: special API for default module? Else specify version for default module.
    void moduleCompiled(String module, String version);
}
