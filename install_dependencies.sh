#!/bin/bash

# Exit with a non-zero value if any command fails.
set -e

sudo apt-get update
sudo apt-get install -y cmake build-essential autoconf libtool pkg-config
