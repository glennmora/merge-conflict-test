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


2. Second We are provisioning our Terraform. So here we have to make sure we **cd** into our directory where the files are located. This step is important because Jenkins by default goes back to the main directory after it finishes doing a script. That's why we are showing that after the script is done running we will be back in **terraform-repository** instead of still being in **creating-eks-cluster-with-terraform**. 


3. For our third step we will be giving the choice to destroy our environment. This step will wait for user input before proceeding to the next step. It will wait in this stage until it has either been approved or refused so make sure to put in the input. You can *proceed* or *abort* by simply going to the console output it will be at the bottom. Or you can click on the step by checking the *console output logs*. 


4. Next after you *proceed* it will move back to the **creating-eks-cluster-with-terraform** directory where all our resources have been created and it will destroy all the resources.

