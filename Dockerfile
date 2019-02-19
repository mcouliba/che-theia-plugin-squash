FROM eclipse/che-theia:0.3.19-nightly

ARG OC_VERSION=3.11.43
ARG GO_VERSION=1.11.5
ARG KUBECTL_VERSION=v1.13.3
ARG SQUASH_VERSION=v0.3.1
USER root

# Preparation (Only when using Alpine Linux)
RUN mkdir /lib64
# The installed `squash` and `oc` binaries were compiled with glibc and on Alpine that is not installed by default
RUN ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN apk upgrade --update && \
    apk add --no-cache --virtual /tmp/.build-deps \
        libcrypto1.0 && \
    ln -s /lib/libcrypto.so.1.0.0 /lib/libcrypto.so.10
    # rm -rfv /var/cache/apk/* && \
    # apk del /tmp/.build-deps

# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# Install oc
RUN curl https://mirror.openshift.com/pub/openshift-v3/clients/${OC_VERSION}/linux/oc.tar.gz | tar -xzC /usr/local/bin/ && \
    oc version

# Install Squash CLI
RUN curl -o /usr/local/bin/squash -L https://github.com/solo-io/squash/releases/download/${SQUASH_VERSION}/squash-linux && \
    chmod +x /usr/local/bin/squash && \
    squash --help

# Install Golang
ENV PATH="/usr/local/go/bin:${PATH}"
RUN curl https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar -xzC /usr/local/ && \
    go version

USER theia
