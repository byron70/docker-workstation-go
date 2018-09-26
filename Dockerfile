FROM golang:1.8.3-alpine3.6

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8

ARG TF_VERSION=0.11.8
ARG PACKER_VERSION=1.3.1

RUN set -eux
RUN apk add --no-cache ca-certificates alpine-sdk docker \
        zip nmap nano tar openssl openssl-dev \
        bash bash-completion curl wget jq \
        python3 python3-dev python2-dev libffi-dev libc-dev linux-headers openssh \
        bind-tools coreutils

RUN wget https://bootstrap.pypa.io/get-pip.py && \
        python3 get-pip.py && \
        wget -O /usr/local/bin/aws-sudo https://raw.githubusercontent.com/cleardataeng/aws-sudo/master/aws-sudo.sh && \
        chmod +x /usr/local/bin/aws-sudo && \
        pip install awscli click rfc3987 \
                downtoearth virtualenv virtualenvwrapper \
                azure-cli \
                awsrequests

RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
        && wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip

RUN unzip -o packer_*_linux_amd64.zip -d /usr/local/bin/ \
        && unzip -o terraform_*_linux_amd64.zip -d /usr/local/bin/ \
        && rm packer_*.zip \
        && rm terraform_*.zip \
        && chmod +x /usr/local/bin/packer \
        && chmod +x /usr/local/bin/terraform

COPY files/.profile /tmp/
COPY files/.bashrc /tmp/
COPY files/.gitconfig /root/

RUN touch ~/.profile \
        && touch ~/.bashrc \
        && cat /tmp/.profile >> ~/.profile \
        && cat /tmp/.bashrc >> ~/.bashrc \
        && rm -rf /tmp/.profile /tmp/.bashrc \
        && chmod 750 ~/.profile \
        && chmod 750 ~/.bashrc \
        && chmod 644 ~/.gitconfig \
        && sed -i 's/\/root:\/bin\/ash/\/root:\/bin\/bash/g' /etc/passwd \
        && ln -s /usr/bin/pip3 /usr/local/bin/pip \
        && ln -s /usr/bin/python3 /usr/local/bin/python \
        && cat ~/.profile ~/.bashrc

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

WORKDIR /root/

CMD ["bash", "-il"]
