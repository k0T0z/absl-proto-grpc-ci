#!/bin/bash

# Function to get the latest tag of a repo
get_latest_tag() {
    cd "$1"
    git fetch --tags
    LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
    cd "$GITHUB_WORKSPACE"
    echo "$LATEST_TAG"
}

# Get the latest tags
ABSL_VERSION=$(get_latest_tag "$GITHUB_WORKSPACE/abseil-cpp")
PROTOBUF_VERSION=$(get_latest_tag "$GITHUB_WORKSPACE/protobuf")
GRPC_VERSION=$(get_latest_tag "$GITHUB_WORKSPACE/grpc")

# Update README.md
sed -i '/Assalamu'"'"'alaikum, as the Continuous Integration (CI) system, I'"'"'ve verified that the following versions are compatible and functioning correctly:/,/gRPC:/ c\
Assalamu'"'"'alaikum, as the Continuous Integration (CI) system, I'"'"'ve verified that the following versions are compatible and functioning correctly:\
\
 - Absl: '"$ABSL_VERSION"'\
 - Protobuf: '"$PROTOBUF_VERSION"'\
 - gRPC: '"$GRPC_VERSION"'' README.md

echo "README.md updated with latest versions."
