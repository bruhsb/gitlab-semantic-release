FROM node:alpine3.20

# Update system packages and install needed dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache bash git ca-certificates curl nodejs npm && \
    # Install all required global Node packages for semantic-release
    npm install -g \
      conventional-changelog-conventionalcommits \
      semantic-release \
      @semantic-release/changelog \
      @semantic-release/commit-analyzer \
      @semantic-release/exec \
      @semantic-release/git \
      @semantic-release/gitlab \
      @semantic-release/npm \
      @semantic-release/release-notes-generator \
      semantic-release-slack-bot && \
    # Address micromatch vulnerability (CVE-2024-4067)
    npm install -g micromatch@4.0.8 && \
    # Create a non-root user and group
    addgroup -S nodejs && adduser -S nodejs -G nodejs && \
    # Ensure the GitLab build directory is owned by our non-root user
    mkdir -p /builds && chown nodejs:nodejs /builds && \
    rm -rf /var/cache/apk/* /root/.npm /tmp/*

USER nodejs

# Add a basic health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD node --version || exit 1

# Verify installations
RUN node --version && npm --version
