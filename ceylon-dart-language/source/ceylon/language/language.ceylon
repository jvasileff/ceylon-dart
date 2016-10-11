
"Contains information about the Ceylon language version."
see (`value process`, `value runtime`, `value system`,
     `value operatingSystem`)
tagged("Environment")
shared native object language {
    
    "The Ceylon language version."
    shared native String version => "1.3.1-SNAPSHOT";
    
    "The Ceylon language major version."
    shared native Integer majorVersion => 1;
    
    "The Ceylon language minor version."
    shared native Integer minorVersion => 3;
    
    "The Ceylon language release version."
    shared native Integer releaseVersion => 1;
    
    "The Ceylon language version qualifier."
    since("1.3.0")
    shared String versionQualifier => "SNAPSHOT";
    
    "The Ceylon language release name."
    shared native String versionName => "Now We Try It My Way";
    
    "The major version of the code generated for the 
     underlying runtime."
    shared native Integer majorVersionBinary;
    
    "The minor version of the code generated for the 
     underlying runtime."
    shared native Integer minorVersionBinary;
    
    shared native actual String string => "language";
    
}

shared native("jvm") object language {
    
    shared native("jvm") Integer majorVersionBinary => 8;
    
    shared native("jvm") Integer minorVersionBinary => 0;
    
}

shared native("js") object language {
    
    shared native("js") Integer majorVersionBinary => 8;
    
    shared native("js") Integer minorVersionBinary => 0;
    
}

shared native("dart") object language {
    shared native("dart") String version => "1.3.1-DP5-SNAPSHOT";
    shared native("dart") Integer majorVersion => 1;
    shared native("dart") Integer minorVersion => 3;
    shared native("dart") Integer releaseVersion => 1;
    shared native("dart") String versionName => "Now We Try It My Way";
    shared native("dart") Integer majorVersionBinary => 8;
    shared native("dart") Integer minorVersionBinary => 0;
    shared actual native("dart") String string => "language";
}
