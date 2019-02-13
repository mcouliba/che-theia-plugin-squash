FROM eclipse/che-theia:0.3.19-nightly

USER root
# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v1.13.3/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# Install Squash CLI
RUN curl -o /usr/local/bin/squash -L https://github.com/solo-io/squash/releases/download/v0.2.1/squash-linux && \
    chmod +x /usr/local/bin/squash && \
    squash --help

USER theia
