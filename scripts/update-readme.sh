#!/usr/bin/env bash
set -e

# Use the first argument as the version or fallback to an environment variable.
VERSION="${1:-$VERSION}"

if [ -z "$VERSION" ]; then
  echo "Error: No version provided. Pass it as an argument or set \$VERSION."
  exit 1
fi

echo "Updating README.md with version: $VERSION"

# Updated line to replace any existing release version in the badge URL
# with whatever you pass in (e.g., 2.3.1).
sed -i "s|\(https://img.shields.io/badge/release-\)[^/]*\(-blue\)|\1$VERSION\2|g" README.md

echo "README.md updated successfully."
