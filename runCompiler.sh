#!/bin/bash

# resolve links - $0 may be a softlink
PRG="$0"
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`/"$link"
    fi
done

DIR=$(dirname "$PRG")

ceylon run \
  --rep "${DIR}/ceylon-dart-compiler/build/modules-jvm/main" \
  --run com.vasileff.ceylon.dart::runCompileDartTool \
  com.vasileff.ceylon.dart \
  "$@"
