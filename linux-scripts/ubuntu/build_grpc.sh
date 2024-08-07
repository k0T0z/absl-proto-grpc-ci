#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

# Create custom directory
mkdir -p $GITHUB_WORKSPACE/grpc-k0t0z-lib

# Define the repository URL
REPO_URL="https://github.com/grpc/grpc.git"

# Get the latest tag from the remote repository
LATEST_TAG=$(git ls-remote --tags $REPO_URL | grep -o 'refs/tags/[^{}]*$' | sort -t '/' -k 3 -V | tail -n1 | awk -F/ '{print $3}')

# Clone Abseil
git clone --depth 1 -b $LATEST_TAG $REPO_URL

cd grpc

# Checkout the latest release
git submodule update --init --recursive

# Create build directory
mkdir build && cd build

# Configure and build
cmake .. -DgRPC_INSTALL=ON \
         -DCMAKE_BUILD_TYPE=Release \
         -DgRPC_ABSL_PROVIDER=package \
         -DgRPC_CARES_PROVIDER=module \
         -DgRPC_PROTOBUF_PROVIDER=package \
         -DgRPC_RE2_PROVIDER=module \
         -DgRPC_SSL_PROVIDER=module \
         -DgRPC_ZLIB_PROVIDER=module \
         -DCMAKE_PREFIX_PATH="$GITHUB_WORKSPACE/absl-k0t0z-lib;$GITHUB_WORKSPACE/proto-k0t0z-lib" \
         -DCMAKE_INSTALL_PREFIX=$GITHUB_WORKSPACE/grpc-k0t0z-lib

make -j$(nproc)

# Install
make install

# Go back to the original directory
cd $GITHUB_WORKSPACE
