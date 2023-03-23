# terraform-repository
Hello, everyone. 

In this repository I will be teaching you how to set up a VPC network with AWS. This repository will include an example configuration file that I have already provisioned ahead of time. The VPC will include a router, subnet, security group, and within the security group two EC2 instances. We will configure the security group with inbound traffic. We will also setup a S3 bucket with secrets to keep a separate tfstate file. I will try to explain each concept so you have a thorough understanding at what you're looking at. This repo will contain many files that are tied to the main.tf file. By the end of this you will have successfully created and secured a VPC network!

### Tools used: 
* Terraform 
* Visual Studio Code
* AWS
* S3 bucket
* DynamoDB

### Imagery

![Screenshot 2023-01-02 211428](https://user-images.githubusercontent.com/108555140/227068716-5a0714c3-c461-4c9e-aa85-76ae30da7e88.png)

- This image shows exactly what we will be creating. We will create our own *VPC* with an *internet gateway*. The internet gateway will pointing to the *Router* which will then direct traffic to the *Route table*. The *Route table* then directs traffic to the *Network access control list (ACL)* which is layer of security that acts as a firewall allowing only certain traffic in and out of the subnet. This is also provisined by the *security group* that we create on the file stating ingress and egress rules. This security group is all part of the subnet that contains our different aws instances. We will be making
