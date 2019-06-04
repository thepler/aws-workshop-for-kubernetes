# Configure AWS CLI
availability_zone=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
export AWS_DEFAULT_REGION=${availability_zone%?}

# Lab-specific configuration
export AWS_MASTER_STACK="bryanvh-eks-vpc"

# EKS-specific variables from CloudFormation
export EKS_VPC_ID=$(aws cloudformation describe-stacks --stack-name $AWS_MASTER_STACK | jq -r '.Stacks[0].Outputs[]|select(.OutputKey=="VpcId")|.OutputValue')
export EKS_SUBNET_IDS=$(aws cloudformation describe-stacks --stack-name $AWS_MASTER_STACK | jq -r '.Stacks[0].Outputs[]|select(.OutputKey=="SubnetIds")|.OutputValue')
export EKS_SECURITY_GROUPS=$(aws cloudformation describe-stacks --stack-name $AWS_MASTER_STACK | jq -r '.Stacks[0].Outputs[]|select(.OutputKey=="SecurityGroups")|.OutputValue')
export EKS_SERVICE_ROLE=$(aws cloudformation describe-stacks --stack-name $AWS_MASTER_STACK | jq -r '.Stacks[0].Outputs[]|select(.OutputKey=="EksServiceRoleArn")|.OutputValue')

# EKS-Optimized AMI
if [ "$AWS_DEFAULT_REGION" == "us-east-1" ]; then
  export EKS_WORKER_AMI=ami-0abcb9f9190e867ab
elif [ "$AWS_DEFAULT_REGION" == "us-west-2" ]; then
  export EKS_WORKER_AMI=ami-0923e4b35a30a5f53
fi
echo "EKS_NODE_AMI"=$EKS_WORKER_AMI>> /etc/environment

# Persist lab variables
echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" >> /etc/environment
echo "AWS_MASTER_STACK=$AWS_MASTER_STACK" >> /etc/environment

# Persist EKS variables
echo "EKS_VPC_ID=$EKS_VPC_ID" >> /etc/environment
echo "EKS_SUBNET_IDS=$EKS_SUBNET_IDS" >> /etc/environment
echo "EKS_SECURITY_GROUPS=$EKS_SECURITY_GROUPS" >> /etc/environment
echo "EKS_SERVICE_ROLE=$EKS_SERVICE_ROLE" >> /etc/environment
