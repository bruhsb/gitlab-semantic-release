# Semantic-Release for GitLab-CI

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Pipeline Status](https://gitlab.com/<GROUP>/<PROJECT>/badges/main/pipeline.svg)](https://gitlab.com/<GROUP>/<PROJECT>/pipelines)
[![Coverage Status](https://gitlab.com/<GROUP>/<PROJECT>/badges/main/coverage.svg)](https://gitlab.com/<GROUP>/<PROJECT>/-/jobs)
[![Coverage Status](RELEASE_BADGE_PLACEHOLDER)](https://gitlab.com/<GROUP>/<PROJECT>/-/releases)

## Overview

This project uses [semantic-release](https://github.com/semantic-release/semantic-release) to automate the versioning and package publishing process. It ensures that the release version is automatically bumped based on commit messages, and it updates the changelog and creates a GitLab release.

| Component          | Version/Details    |
| ------------------ | ------------------ |
| Node.js Base Image | alpine3.20         |
| Semantic-Release   | 24.2.1 (automated) |
| Docker Builder     | docker:27.5.1      |

## Contributing

All contributions should follow our established guidelines:

1. Clone the repository and install dependencies.
2. Make your changes in a feature branch.
3. Ensure pre-commit hooks are installed locally by running:

   pre-commit install

4. Push your branch to GitLab and open a Merge Request.
5. Semantic-Release will handle versioning, changelog updates, and tagging.

## Automated Updates

This README is updated automatically during releases. The update script inserts the latest release version and can also update badges with dynamic information.

## Setup

### Prerequisites

- Ensure you have a GitLab personal/project access token with read/write permissions to the registry and repository. This token should be added as a masked CI/CD variable named `GITLAB_TOKEN`.

### Configuration Files

#### `.releaserc.yml`

This file contains the configuration for `semantic-release`. It specifies the branches to release from, the plugins to use, and other settings.

- **Branches**: Releases are made from the `main` branch.
- **Plugins**: Includes plugins for changelog generation, commit analysis, GitLab publishing, and more.
- **Tag Format**: Uses the version number as the tag format.

#### `Dockerfile`

The Dockerfile is used to create a Docker image with all necessary dependencies for running `semantic-release`.

- **Base Image**: Uses `node:alpine3.20` for a lightweight Node.js environment.
- **Dependencies**: Installs `semantic-release` and its plugins globally.
- **Verification**: Ensures Node.js and npm are installed correctly.

#### `.gitlab-ci.yml`

This file defines the GitLab CI/CD pipeline for building and releasing the project.

- **Stages**: Consists of `build`, `release`, `tag_image`, and `security_scan` stages.
- **Jobs**:
  - `build_image`: Builds and pushes the Docker image.
  - `trivy_scan`: Scans the Docker image for security vulnerabilities. See [Trivy](https://github.com/aquasecurity/trivy) for more details.
  - `semantic_release`: Runs `semantic-release` using the built Docker image.
  - `tag_image`: Tags the Docker image with the release version.

## Features

- **Automated Versioning**: Bumps the semantic version (major/minor/patch) based on commit prefixes.
- **GitLab Release**: Creates a release in GitLab with the new version.
- **Changelog Update**: Updates `CHANGELOG.md` with release notes generated from commits.
- **Commit & Push**: Commits and pushes changes back to the repository.
- **Security Scanning**: Uses Trivy to scan Docker images for vulnerabilities.

### Pre-Commit Hooks

The `.pre-commit-config.yaml` file is used to configure pre-commit hooks that help maintain code quality by automatically checking for common issues before commits are made.

#### Configured Hooks

- **Basic Pre-Commit Hooks**:

  - `check-yaml`: Ensures all YAML files end with a newline and have valid syntax.
  - `trailing-whitespace`: Removes any extraneous whitespace.
  - `end-of-file-fixer`: Ensures that files end with a newline.

- **Dockerfile Linting**:
  - `hadolint`: Lints Dockerfiles to ensure best practices are followed.

To use these hooks, ensure you have pre-commit installed and run `pre-commit install` to set up the hooks in your local repository. You can manually run all hooks on all files using `pre-commit run -a`.

## Additional Configuration

- **Custom File Updates**: You can configure the release process to update custom files with the release version.
- **Notifications**: Setup notifications for Slack or Mattermost to alert about new releases.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
