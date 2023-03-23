# Creating a VPC environment in AWS by provisioning it with Terraform!
Hello, everyone. 

In this repository I will be teaching you how to set up a VPC network with AWS. This repository will include an example configuration file that I have already provisioned ahead of time. The VPC will include a router, subnet, security group, and within the security group two EC2 instances. We will configure the security group with inbound traffic. We will also setup a S3 bucket with secrets to keep a separate tfstate file. I will try to explain each concept so you have a thorough understanding at what you're looking at. This repo will contain many files that are tied to the main.tf file. By the end of this you will have successfully created and secured a VPC network!

### Tools used: 
* **Terraform** 
* **Visual Studio Code
* **AWS
* **S3 bucket
* **DynamoDB

### Imagery

![Screenshot 2023-01-02 211428](https://user-images.githubusercontent.com/108555140/227068716-5a0714c3-c461-4c9e-aa85-76ae30da7e88.png)

- This image shows exactly what we will be creating. We will create our own **VPC** with an **internet gateway**. The internet gateway will pointing to the **Router** which will then direct traffic to the **Route table**. The **Route table** then directs traffic to the **Network access control list (ACL)** which is layer of security that acts as a firewall allowing only certain traffic in and out of the subnet. This is also provisined by the *security group* that we create on the file stating ingress and egress rules. This security group is all part of the subnet that contains our different aws instances. We will be making a EC2 named server, my_vm, redhat-server, and a DynamoDB instance.

### Prerequisites

- Have an existing AWS account
- IAM user with admin permissions
- Key pair
- Terraform downloaded
- S3 bucket

### Let's Get Started!

1. First let's take a look at the **main.tf** file and work our way to the rest of the files

![Screenshot 2023-03-23 071339](https://user-images.githubusercontent.com/108555140/227200810-c751f445-7679-4caf-99b7-d1b31b4df65f.png)

- Here we are establishing what providers we will be using for this project which is **aws** and up to version 4. For the region we are specifying this product to we have that set up in our **variables.tf** file. For the **access key** and the **secret key** you will need to have made already in order for this to work. Or you could go to your AWS console and create one if you search for "Key Pairs".

- Then we are creating a *users* variable and using those to create a IAM user in the following block.

![Screenshot 2023-03-23 072123](https://user-images.githubusercontent.com/108555140/227202551-4ab07da9-eeb6-4527-a5b7-714f54fe72a5.png)

- Now we can start creating our VPC, subnet, and internet gateway.

![Screenshot 2023-03-23 072722](https://user-images.githubusercontent.com/108555140/227203665-bd196b0c-c678-4b0e-a128-0ee84b227496.png)

- So at the top we are creating our vpc we will give it a cidr_block which is provisioned in our **variables.tf** we give it a tag as well. We enabled the DNS support so it's easier for people to access our VPC without the need to use an IP address for example (www.aws.com instead of 192.1.1.24).

- We then create our aws subnet named *web* give it a vpc id corresponding to our vpc we just created **aws_vpc.main** . Our cidr block and availability zone are both defined in our **variables.tf**. Then we finally give it a tag and move to our internet gateway.

- Now with our vpc and subnet set in place we can create our internet gateway. We name it **my_web_igw** we give it a vpc id. give a tag name and version which is described in our **locals.tf**.

2. We have successfully provisioned the main components of our VPC now we will take a look at configuring our route table and security group!

![Screenshot 2023-03-23 074508](https://user-images.githubusercontent.com/108555140/227209141-65da9345-a6ca-427c-9c31-0d08c9f3cd4c.png)

- We first specify the type of resource we will be using in this case is *"aws_default_route_table"* then we give it a name *"main_vpc_default_rt"*. Then we give it a id using our vpc and route table resource. Then we set up the cidr block and use our gate *aws_internet_gateway.my_web_igw.id*. Finally we tag it and create our security group.

- We name our security group **"default_sec_group"** we make sure it's in the VPC. Then I have an example of what the ingress block would look like if we decide not to use our **variables.tf**. However, in this case to keep it more simple I set all the definitions in our **variables.tf** file for both our ingress and egress rules.

### Third Step

- In this part we will set up our ssh key, first linux instance, and add a local resource to show us the time and date our resource was created!

![Screenshot 2023-03-23 104823](https://user-images.githubusercontent.com/108555140/227259332-74d17726-5d10-467d-8809-78aa64fa7ee4.png)

- So at first we create our keypair resource and give it the name **"test_ssh_key"** then we specify where the file is located which we have defined in our **variables.tf**. Next we are creating a instance that will use the latest linux machine. We specify the type of provider so we use **"amazon"**. Then we set to most recent and we need to give it the value of "amzn2-ami-kernel-*-x86_64-gp2"*. The asteric is located in a spot where the ID goes so if a new linux image ID comes out it will always be the latest. Now we make locals block that will provide us with the time and date a resource is created. We use *formatdate* to specifcy the date format.

### Fourth Step

- You've made it this far and now for the meats and potatoes. The virtual machines! So here we will look at the different instances we will create.

![Screenshot 2023-03-23 110309](https://user-images.githubusercontent.com/108555140/227263621-c2b5d407-fdc3-4ee4-8921-939254541716.png)

1. The first VM we create we name it **"my_vm"** we will specify the ami, the type of instance in this case **"t2.micro"**, subnet id, our security, we associate a public ip. You can also set this to false if you don't want it to have internet access. We then give it the SSH key name, and we make a user where we specify where we are going to run a script.

2. Our second instance we will name it **server**
