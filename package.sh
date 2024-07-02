#!/bin/bash

cd /src

mv install clang

find clang -type f -exec strip {} \ 2>/dev/null
rm clang/lib/libFortranEvaluate.a

tar cfz clang.tar.gz ./clang/

mv clang install
