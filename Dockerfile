FROM eclipse/che-theia:0.3.19-nightly

USER root
# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v1.13.3/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# Install Squash CLI
ADD https://github.com/solo-io/squash/releases/download/v0.2.1/squash-linux /usr/local/bin/squash
RUN chmod +x /usr/local/bin/squash 

USER theia
