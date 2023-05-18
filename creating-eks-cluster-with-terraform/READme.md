## Creating a VPC with Jenkins and Terraform:
1. In this project I will be showing you how to create and destroy a VPC with Terraform and Jenkins. The tools we will use are
* Jenkins
* Terraform
* GitHub Repository

## Requirements
1. First we need to install Terraform in our EC2 or VM. In this case we are using CentOS so we will be using the official Terraform documentation to download Terraform. You can follow this link: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

2. Or you can follow along.
* sudo yum install -y yum-utils
* sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
* sudo yum -y install terraform
* terraform version

## Now Time to create our Pipeline
1. So first we will create our Jenkins pipeline and I'll explain every step as we go. First we are cloning this Terraform repository to our VM.
