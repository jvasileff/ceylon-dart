shared
class ReportableException(String description, Throwable? cause=null)
        extends Exception(description, cause) {}