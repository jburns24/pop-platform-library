#trivy:ignore:ds026 TODO: Add HEALTHCHECK instruction in Dockerfile
FROM ubuntu:24.04@sha256:b359f1067efa76f37863778f7b6d0e8d911e3ee8efa807ad01fbf5dc1ef9006b AS builder

USER root


RUN apt-get update && apt-get install -y curl unzip ca-certificates --no-install-recommends

# Install kubectl, and helm
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
  chmod 700 get_helm.sh && \
  ./get_helm.sh

FROM ghcr.io/weaveworks/tf-runner:main-bb223966@sha256:e82ed413b8e81fdf1d999cb87e41d51fe2b5fd84ce11c1eb40ae9f4b86187cdd

ARG TF_VERSION=1.9.3
ARG TARGETARCH

# Switch to root to have permissions for operations
USER root
# trivy:ignore:ds005 TODO: Use COPY instead of ADD
ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${TARGETARCH}.zip /terraform_${TF_VERSION}_linux_${TARGETARCH}.zip
RUN unzip -oq /terraform_${TF_VERSION}_linux_${TARGETARCH}.zip -d /usr/local/bin/ && \
  rm /terraform_${TF_VERSION}_linux_${TARGETARCH}.zip && \
  chmod +x /usr/local/bin/terraform && \
  apk add --no-cache aws-cli

# Copy Terraform from the builder stage
COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=builder /usr/local/bin/helm /usr/local/bin/helm

# Switch back to the non-root user after operations
USER 65532:65532
