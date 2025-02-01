FROM node:alpine3.20

# Use a standard multi-line RUN instruction
RUN apk update && \
  apk upgrade && \
  apk add --no-cache bash git ca-certificates curl openssl && \
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
  rm -rf /var/cache/apk/* /tmp/* && \
  npm uninstall -g micromatch && \
  npm install -g conventional-changelog-conventionalcommits semantic-release \
    @semantic-release/changelog @semantic-release/commit-analyzer @semantic-release/exec \
    @semantic-release/git @semantic-release/gitlab @semantic-release/npm \
    @semantic-release/release-notes-generator micromatch@4.0.8 && \
  rm -rf /var/cache/apk/* /root/.npm /tmp/*

HEALTHCHECK --interval=25s --timeout=5s --retries=3 CMD node --version || exit 1

RUN node --version && npm --versionRUN node --version
