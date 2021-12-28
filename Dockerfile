
FROM quay.io/webcenter/che-ubi:latest

ENV \ 
    KUBECTL_VERSION="v1.19.13" \
    OC_VERSION="4.8.2" \
    HELM_VERSION="v3.7.2" \
    VAULT_VERSION="1.9.2" \
    TERRAFORM_VERSION="1.1.2" \
    TERRAGRUNT_VERSION="v0.35.16"


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
    echo "Install vault" &&\
    curl -L https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o /tmp/vault.zip &&\
    unzip /tmp/vault.zip &&\
    mv vault /usr/bin/vault &&\
    chmod +x /usr/bin/vault &&\
    echo "Install terraform" &&\
    curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform.zip &&\
    unzip /tmp/terraform.zip &&\
    mv terraform /usr/bin/terraform &&\
    chmod +x /usr/bin/terraform &&\
    echo "Install terragrunt" &&\
    curl -L https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o /usr/bin/terragrunt &&\
    chmod +x /usr/bin/terragrunt

# Clean
RUN \
    microdnf clean all && \
    rm -rf /tmp/* /var/tmp/*

SHELL ["/bin/bash", "-c"]