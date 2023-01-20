# terraform-repository
Hello, everyone. 

In this repository I will be teaching you how to set up a VPC network with AWS. This repository will include an example configuration file that I have already provisioned ahead of time. The VPC will include a router, subnet, security group, and within the security group two EC2 instances. We will configure the security group with inbound traffic. We will also setup a S3 bucket with secrets to keep a separate tfstate file. I will try to explain each concept so you have a thorough understanding at what you're looking at. This repo will contain many files that are tied to the main.tf file. By the end of this you will have successfully created and secured a VPC network!

## Tools used Terraform, Visual Studio Code, AWS, S3 bucket, DynamoDB