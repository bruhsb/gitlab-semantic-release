#!/usr/bin/env bash
set -e

# Use the first argument as the version or fallback to an environment variable.
VERSION="${1:-$VERSION}"

if [ -z "$VERSION" ]; then
  echo "Error: No version provided. Pass it as an argument or set \$VERSION."
  exit 1
fi

echo "Updating README.md with version: $VERSION"

# Example 2 (optional): If you wanted to dynamically update a badge with the new version,
# you could define placeholders in README.md and then replace them here. For instance:
sed -i "s|RELEASE_BADGE_PLACEHOLDER|https://img.shields.io/badge/release-$VERSION-blue|g" README.md

echo "README.md updated successfully."
