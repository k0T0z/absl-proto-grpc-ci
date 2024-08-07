#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

# Check if the number of arguments is exactly 3
if [ "$#" -ne 3 ]; then
  echo "Error: Exactly 3 arguments are required."
  echo "Usage: $0 <arg1> <arg2> <arg3>"
  exit 1
fi

# Get the latest tags
ABSL_VERSION=$1
PROTOBUF_VERSION=$2
GRPC_VERSION=$3

CURRENT_DATE_TIME=$(date +"%Y-%m-%d %H:%M:%S")

# Update README.md
sed -i '/Assalamu'"'"'alaikum, as the Continuous Integration (CI) system, I'"'"'ve verified that the following versions are compatible and functioning correctly:/,/gRPC:/ c\
Assalamu'"'"'alaikum, as the Continuous Integration (CI) system, I'"'"'ve verified that the following versions are compatible and functioning correctly:\
\n\
Latest check: '"$CURRENT_DATE_TIME"'\n\
\n\
 - Absl: '"$ABSL_VERSION"'\
 - Protobuf: '"$PROTOBUF_VERSION"'\
 - gRPC: '"$GRPC_VERSION"'' README.md

echo "README.md updated with latest versions."
