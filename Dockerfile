FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y clang build-essential make cmake git curl vim ninja-build bzip2 gzip zip unzip

WORKDIR /src
ARG LLVM_VERSION=16.0.6
RUN mkdir /src/llvm-project -p && cd /src/llvm-project \
  && git init && git remote add origin https://github.com/llvm/llvm-project.git \
  && git fetch --depth 1 origin llvmorg-$LLVM_VERSION && git checkout FETCH_HEAD

COPY build_llvm.sh /src/build_llvm.sh
RUN /src/build_llvm.sh

COPY build_clang.sh /src/build_clang.sh
RUN /src/build_clang.sh

COPY package.sh /src/package.sh
RUN /src/package.sh
