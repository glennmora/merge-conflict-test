output "ec2_public_ip" {
  description = "The public IP address of the ec2 instance"
  value       = aws_instance.my_vm.public_ip
}

output "vpc_ip" {
  description = "ID of VPC"
  value       = aws_vpc.main.id
}

output "ami_id" {
  description = "ID of AMI"
  value       = aws_instance.my_vm.ami
  sensitive   = true
}

output "Datetime" {
  description = "Current Date and Time"
  value       = local.time
}

output "private-addresses" {
  value = aws_instance.server[*].private_ip
}