#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

# Create custom directory
mkdir -p $GITHUB_WORKSPACE/absl-k0t0z-lib

# Clone Abseil
git clone --depth 1 -b 20240722.0 https://github.com/abseil/abseil-cpp.git

cd abseil-cpp

# Create build directory
mkdir build && cd build

# Configure and build
cmake .. -DABSL_PROPAGATE_CXX_STD=ON -DBUILD_TESTING=OFF -DABSL_BUILD_TESTING=OFF -DABSL_USE_GOOGLETEST_HEAD=OFF -DCMAKE_BUILD_TYPE=Release -DABSL_ENABLE_INSTALL=ON -DCMAKE_INSTALL_PREFIX=$GITHUB_WORKSPACE/absl-k0t0z-lib
make -j$(nproc)

# Install
make install

# Go back to the original directory
cd $GITHUB_WORKSPACE
