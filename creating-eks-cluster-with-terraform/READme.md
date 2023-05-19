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

3. Make sure to have a t2.instance of at least 2GB of Ram and 1GB of CPU or else the terraform environment will not be able to create ideally I would recommend 2GB of Ram and 2GB of CPU. The t2.small is the minimum requirement I would suggest the t2.medium if you're using AWS.

## Now Time to create our Pipeline

![Screenshot 2023-05-18 201719](https://github.com/glennmora/terraform-repository/assets/108555140/c2b7d172-977b-45fa-8c27-05758a681c21)


1. So first we will create our Jenkins pipeline and I'll explain every step as we go. First we are cloning this Terraform repository to our VM.

![Screenshot 2023-05-18 201740](https://github.com/glennmora/terraform-repository/assets/108555140/5c06dddd-56ab-4ae7-b2ca-c7b8e481c3b2)

2. Second We are provisioning our Terraform. So here we have to make sure we **cd** into our directory where the files are located. This step is important because Jenkins by default goes back to the main directory after it finishes doing a script. That's why we are showing that after the script is done running we will be back in **terraform-repository** instead of still being in **creating-eks-cluster-with-terraform**. 

![Screenshot 2023-05-18 201754](https://github.com/glennmora/terraform-repository/assets/108555140/8a0d5e0c-a6fb-4f77-b094-7fa2f4947e26)

3. For our third step we will be giving the choice to destroy our environment. This step will wait for user input before proceeding to the next step. It will wait in this stage until it has either been approved or refused so make sure to put in the input. You can *proceed* or *abort* by simply going to the console output it will be at the bottom. Or you can click on the step by checking the *console output logs*. 

![Screenshot 2023-05-18 201804](https://github.com/glennmora/terraform-repository/assets/108555140/04a11d95-e8b0-4a45-96ee-b1bca142d78a)

4. Next after you *proceed* it will move back to the **creating-eks-cluster-with-terraform** directory where all our resources have been created and it will destroy all the resources.

![Screenshot 2023-05-18 201817](https://github.com/glennmora/terraform-repository/assets/108555140/750f6c50-8a06-4b71-890f-3c79616424ea)

## Why is this project useful?
1. Great question! This project is very useful actually because here we are learning how to use Terraform to create a vpc. However, in most real life scenerious Terraform is often use as a IaC(Infrastructure as Code) tool that has gain popularity because is cloud agnostic. This means it compatible with multiple cloud providers instead of being exclusive to one. Now with a Terraform file you can easily create multiple EC2 instances or VMs in the matter of seconds. Terraform files are reusable. So if you ever need to use it again you can refer
