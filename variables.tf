variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
  type        = string
}

variable "Web_subnet" {
  default     = "10.0.10.0/24"
  description = "Web Subnet"
  type        = string
}

variable "subnet_zone" {

}

variable "main_vpc_name" {

}

variable "my_public_ip" {

}

variable "ssh_public_key" {

}

#simple type number
variable "web_port" {
  description = "Web Port"
  default     = 80
  type        = number
}

# simple type string
variable "aws_region" {
  description = "AWS Region"
  default     = "eu-central-1"
  type        = string
}

# simple type bool
variable "enable_dns" {
  description = "DNS support for the VPC"
  type        = bool
  default     = true
}

#  collection type: list
variable "azs" {
  description = "AZs in the Region"
  type        = list(string)
  default = [
    "eu-central-1a",
    "eu-central-1b",
  "eu-central-1c"]
}

# collection type: Map
variable "amis" {
  type = map(string)
  default = {
    "eu-west-1"    = "ami-0fe0b2cf0e1f25c8a",
    "eu-central-1" = "ami-0a261c0e5f51090b1",
    "us-west-1"    = "ami-00d8a762cb0c50254",
    "us-west-2"    = "ami-0ceecbb0f30a902a6"
  }
}

variable "my_instance" {
  type = tuple([string, number, bool])
  default = [
    "t2.micro",
    1,
    true
  ]
}

variable "egress_dsg" {
  type = object({
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = list(string)
  })
  default = {
    from_port  = 0,
    to_port    = 65365,
    protocol   = "tcp"
    cidr_block = ["100.0.0.0/16", "200.0.0.0/16"]
  }
}

variable "ingress_ports" {
  description = "List of Ingress Ports"
  type        = list(number)
  default     = [22, 80, 110, 143, 443, 993, 8080]
}

variable "db_password" {
  type = string
  sensitive = true
}