#!/bin/bash

$OUTPUT_REPOSITORY=/tmp/modules

ceylon copy --verbose=files --all --scripts \
    --no-default-repositories \
    --rep ceylon-dart-cli/build/modules-jvm/main \
    --rep ceylon-dart-compiler/build/modules-jvm/main \
    --out $OUTPUT_REPOSITORY \
    com.vasileff.ceylon.dart.compiler \
    com.vasileff.ceylon.dart.cli

