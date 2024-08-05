#!/bin/bash

# Get the dependencies.
sudo apt-get install build-essential autoconf libtool pkg-config

# Create custom directory
mkdir -p $GITHUB_WORKSPACE/grpc-k0t0z-lib

# Clone Abseil
git clone --depth 1 -b v1.65.4 https://github.com/grpc/grpc

cd grpc

# Checkout the latest release
git submodule update --init --recursive

# Create build directory
mkdir build && cd build

# Configure and build
cmake .. -DgRPC_INSTALL=ON \
         -DCMAKE_BUILD_TYPE=Release \
         -DgRPC_ABSL_PROVIDER=package \
         -DgRPC_CARES_PROVIDER=package \
         -DgRPC_PROTOBUF_PROVIDER=package \
         -DgRPC_RE2_PROVIDER=package \
         -DgRPC_SSL_PROVIDER=package \
         -DgRPC_ZLIB_PROVIDER=package \
         -DCMAKE_PREFIX_PATH="$GITHUB_WORKSPACE/absl-k0t0z-lib;$GITHUB_WORKSPACE/proto-k0t0z-lib" \
         -DCMAKE_INSTALL_PREFIX=$GITHUB_WORKSPACE/grpc-k0t0z-lib

make -j$(nproc)

# Install
make install

# Go back to the original directory
cd $GITHUB_WORKSPACE
