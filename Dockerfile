FROM node:alpine3.20

# Install dependencies
RUN apk update && \
  apk upgrade && \
  apk add --no-cache bash git ca-certificates curl openssl
# Install Helm securely
RUN HELM_VERSION=v3.17.0 && \
  curl -fsSL "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" -o helm.tar.gz && \
  tar -zxvf helm.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  rm -rf helm.tar.gz linux-amd64
# Install npm packages
RUN npm install -g conventional-changelog-conventionalcommits semantic-release \
    @semantic-release/changelog @semantic-release/commit-analyzer @semantic-release/exec \
    @semantic-release/git @semantic-release/gitlab @semantic-release/npm \
    @semantic-release/release-notes-generator micromatch@4.0.8 && \
  rm -rf /var/cache/apk/* /root/.npm /tmp/*

HEALTHCHECK --interval=25s --timeout=5s --retries=3 CMD node --version || exit 1

RUN node --version && npm --version
