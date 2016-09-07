import com.vasileff.ceylon.dart.compiler {
    ReportableException
}

shared suppressWarnings("expressionTypeNothing")
void runDart() {
    // this'll work for now...
    try {
        value options
            =   process.arguments.takeWhile((a) => a.startsWith("--")).sequence();

        value moduleAndVersion
            =   process.arguments[options.size];

        if (!exists moduleAndVersion) {
            throw ReportableException("Module must be specified.");
        }

        value arguments
            =   process.arguments.skip(options.size + 1).sequence();

        function multiOption(String optionPrefix)
            =>  options.filter((o) => o.startsWith(optionPrefix))
                       .collect((o) => o.spanFrom(optionPrefix.size));

        function singleOption(String optionPrefix)
            =>  options.filter((o) => o.startsWith(optionPrefix))
                       .first?.spanFrom(optionPrefix.size);

        value exitCode
            =   runDartToplevel {
                    moduleAndVersion = moduleAndVersion;
                    arguments = arguments;
                    toplevel = singleOption("--run=");
                    repositoryManager = repositoryManager {
                        repositories = multiOption("--rep=");
                        systemRepository = singleOption("--sysrep=");
                        cacheRepository = singleOption("--cacherep=");
                        cwd = singleOption("--cwd=");
                    };
                };

        process.exit(exitCode);
    }
    catch (ReportableException e) {
        process.writeErrorLine("error: ``e.message``");
        process.exit(1);
    }
}
