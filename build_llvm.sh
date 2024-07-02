#!/bin/bash

set -ex

build_llvm=`pwd`/build-llvm
build_clang=`pwd`/build-clang
installprefix=`pwd`/install
llvm=`pwd`/llvm-project
mkdir -p $build_llvm
mkdir -p $installprefix

export MAKEFLAGS=-j43

time cmake -G Ninja -S $llvm/llvm -B $build_llvm \
    -DLLVM_INSTALL_UTILS=ON \
    -DCMAKE_INSTALL_PREFIX=$installprefix \
    -DCMAKE_BUILD_TYPE=Release

ninja -C $build_llvm install
