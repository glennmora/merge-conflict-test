terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = "use-your-own-key"
  secret_key = "use-your-own-key"
}

#resource "<provider>_<resource_type>" "local_name"{
#  argument1 = value1
#  argument2 = value2
#  ....
# }

variable "users" {
  type = list(string)
  default = [ "demo-user", "admin1", "john" ]
}

resource "aws_iam_user" "test" {
  for_each = toset(var.users)
  name = each.key
}

# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr_block

#   tags = local.common-tags
#   enable_dns_support = var.enable_dns
# }

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "Production ${var.main_vpc_name}"
  }
  enable_dns_support = var.enable_dns
}

# Create a subnet
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.Web_subnet
  availability_zone = var.azs[0]
  tags = {
    "Name" = "Web_subnet"
  }
}

# Create an Internet Gateway Resource
resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    #"Name" = "${var.main_vpc_name} IGW"
    "Name" = "${local.common-tags["Name"]}-igw"
    "Version" = "${local.common-tags["Version"]}"
  }
}

resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}

resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
 # ingress = [ {
  #  from_port = 22
   # to_port = 22
   # protocol = "tcp"
   # cidr_blocks = ["0.0.0.0/0"]
#  } ]
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = var.egress_dsg["from_port"]
    to_port     = var.egress_dsg["to_port"]
    protocol    = var.egress_dsg["protocol"]
    cidr_blocks = var.egress_dsg["cidr_block"]
  }

  tags = {
    "Name" = "Default Security Group"
  }
}

resource "aws_key_pair" "test_ssh_key" {
  key_name   = "testing_ssh_key"
  public_key = file(var.ssh_public_key)
}

data "aws_ami" "latest_amazon_linux2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  time = formatdate("DD MM YYYY hh:mm", timestamp())
}

resource "aws_instance" "my_vm" {
  # ami = lookup(var.ami, var.region)
  ami                         = data.aws_ami.latest_amazon_linux2.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.web.id
  vpc_security_group_ids      = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.test_ssh_key.key_name
  user_data                   = file("${path.root}/entry-script.sh")
  tags = {
    "Name" = "My EC2 Instance - Amazon Linux 2"
  }
}

resource "aws_instance" "server" {
  ami = var.amis["${var.aws_region}"]
  instance_type = var.my_instance[0]
  # cpu_core_count = var.my_instance[1]
  associate_public_ip_address = var.my_instance[2]
  count = 1

  tags = {
    "Name" = "Amazon Linux 2"
  }
}

resource "aws_instance" "redhat-server" {
  ami = "ami-0b8ea3624881b47a1"
  instance_type = "t2.micro"
  count = 3
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  name = "mydb"
  username = "foo"
  password = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
}