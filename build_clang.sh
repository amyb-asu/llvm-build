#!/bin/bash

set -x

build_llvm=`pwd`/build-llvm
build_clang=`pwd`/build-clang
installprefix=`pwd`/install
llvm=`pwd`/llvm-project
mkdir -p $build_llvm
mkdir -p $installprefix

export MAKEFLAGS=-j10

until time cmake -G Ninja -S $llvm/clang -B $build_clang \
    -DLLVM_EXTERNAL_LIT=$build_llvm/utils/lit \
    -DLLVM_ROOT=$installprefix \
    -DCMAKE_INSTALL_PREFIX=$installprefix \
    -DCMAKE_BUILD_TYPE=Release; do
  sleep 5;
done;

until time ninja -C $build_clang install; do
  sleep 5;
done;
