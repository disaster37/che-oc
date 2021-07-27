
FROM redhat/ubi8-minimal:8.4

ENV KUBECTL_VERSION="v1.18.6" \
    OC_VERSION="4.3.3" \
    HELM_VERSION="v3.6.3" \
    RANCHER_VERSION="v2.4.6"


ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/ubi.sh /tmp/ubi.sh
RUN sh /tmp/ubi.sh

# Install some tools
RUN \
    echo "Install kubectl" &&\
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl &&\
    chmod +x /usr/bin/kubectl &&\
    echo "Install oc" &&\
    curl -o- -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-linux-${OC_VERSION}.tar.gz | tar xvz -C /usr/local/bin oc &&\
    chmod +x /usr/local/bin/oc &&\
    echo "Install helm" &&\
    curl -o- -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xvz -C /usr/local/bin --strip-components=1 &&\
    chmod +x /usr/local/bin/helm &&\
    echo "Install rancher" &&\
    curl -o- -L https://github.com/rancher/cli/releases/download/${RANCHER_VERSION}/rancher-linux-amd64-${RANCHER_VERSION}.tar.gz | tar xvz -C /usr/local/bin --strip-components=2 &&\
    chmod +x /usr/local/bin/rancher
    

# Install chectl
RUN microdnf install -y nodejs
USER theia
RUN bash -c "bash <(curl -sL  https://www.eclipse.org/che/chectl/)"

# Clean
USER root
RUN \
    microdnf clean all && \
    rm -rf /tmp/* /var/tmp/*