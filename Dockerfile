FROM eclipse/che-theia-endpoint-runtime:nightly

ARG KUBECTL_VERSION=v1.13.3
ARG SQUASHCTL_VERSION=v0.4.4

# Preparation
RUN mkdir /lib64
# The installed `squash` and `oc` binaries were compiled with glibc and on Alpine that is not installed by default
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# Install Squash CLI
RUN wget -qO /usr/local/bin/squashctl https://github.com/solo-io/squash/releases/download/${SQUASHCTL_VERSION}/squashctl-linux && \
    chmod +x /usr/local/bin/squashctl
