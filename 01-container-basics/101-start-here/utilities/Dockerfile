FROM alpine:3.9.4

## Install Dependencies
RUN apk --update add \
        git \
        curl \
        openssh \
        jq \
        wget \
        python3 \
        py-pip \
        groff \
        less \
        mailcap \
        bash

## Setup kubectl binary
RUN wget -q -O /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/kubectl \
 && chmod +x /usr/local/bin/kubectl

## Setup aws-iam-authenticator binary
RUN wget -q -O /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x /usr/local/bin/aws-iam-authenticator

## Setup aws-cli
RUN pip3 install --upgrade pip \
 && pip3 install awscli

RUN git clone https://github.com/dewjam/aws-workshop-for-kubernetes.git

## Execute environment setup script
COPY env-setup.sh .
RUN chmod +x env-setup.sh \
    && ./env-setup.sh

## Set work directory
WORKDIR /aws-workshop-for-kubernetes

## Set default command
CMD eval $(cat /etc/environment) sh
