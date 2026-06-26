# Usage:
#   docker build -f Dockerfile.test -t opencode-test .
#   docker run --rm opencode-test
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Vanilla Linux box — only git and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    python3 \
    python3-yaml \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /test
COPY . .
COPY test/run.sh /test-run.sh

RUN git config --global --add safe.directory /test && \
    chmod +x /test-run.sh

CMD ["/bin/bash", "/test-run.sh"]
