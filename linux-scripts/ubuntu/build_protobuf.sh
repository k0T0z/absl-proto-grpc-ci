#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

# Create custom directory
mkdir -p $GITHUB_WORKSPACE/proto-k0t0z-lib

# Define the repository URL
REPO_URL="https://github.com/protocolbuffers/protobuf.git"

# Get the latest tag from the remote repository
LATEST_TAG=$(git ls-remote --tags $REPO_URL | awk -F'/' '{print $NF}' | sort -V | tail -n1)

# Clone Abseil
git clone --depth 1 -b $LATEST_TAG $REPO_URL

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
