#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

# Create custom directory
mkdir -p $GITHUB_WORKSPACE/proto-k0t0z-lib

# Clone Abseil
git clone --depth 1 -b v27.3 https://github.com/protocolbuffers/protobuf.git

cd protobuf

# Checkout the latest release
git submodule update --init --recursive

# Create build directory
mkdir build && cd build

# Configure and build
cmake .. -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_ABSL_PROVIDER=package -DCMAKE_PREFIX_PATH=$GITHUB_WORKSPACE/absl-k0t0z-lib -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$GITHUB_WORKSPACE/proto-k0t0z-lib -Dprotobuf_BUILD_SHARED_LIBS=OFF
make -j$(nproc)

# Install
make install

# Go back to the original directory
cd $GITHUB_WORKSPACE
