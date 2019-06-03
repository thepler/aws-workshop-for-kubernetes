FROM alpine:3.9.4
## Set environmental variables
ENV EKS_SUBNET_IDS="YOUR_SUBNETS" \
    EKS_SECURITY_GROUPS="YOUR_SECURITY_GROUP" \
    EKS_SERVICE_ROLE="YOUR_EKS_SERVICE_ROLE" \
    EKS_CLUSTER_NAME="YOUR_CLUSTER_NAME" \
    EKS_NODE_STACK_NAME="YOUR_NODE_STACK_NAME" \
    AWS_DEFAULT_REGION="YOUR_REGION" \
    EKS_NODE_AMI="TBD" \
    EKS_VPC_ID="TBD"


## Install Dependencies
RUN apk --update add \
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

## Set default command
CMD bin/sh
