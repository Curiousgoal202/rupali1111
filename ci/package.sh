#!/bin/bash
set -e
RELEASE="payment-${BUILD_ID:-$(date +%s)}"
mkdir -p artifacts
tar -czf artifacts/${RELEASE}.tar.gz app
echo "Artifact created: artifacts/${RELEASE}.tar.gz"
