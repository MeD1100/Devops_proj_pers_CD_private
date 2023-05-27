resource "aws_vpc" "main" {

  cidr_block = "192.168.0.0/16"

  #Makes your instances shared on the host.
  instance_tenancy = "default"

  #Required for EKS. Enable/Disable DNS support in the VPC.
  enable_dns_support = true

  #Required for EKS. Enable/Disable DNS hostnames in the VPC.
  enable_dns_hostnames = true

  #Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length.
  assign_generated_ipv6_cidr_block = false

  #A map of tags to assign to the resource.
  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "ng-sg" {
  name        = "node-group-sg"
  description = "Node Group SG"
  vpc_id      = aws_vpc.main.id


  //Adding Rules to Security Group 
  ingress {
    description = "SSH Rule"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP Rule"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "sg_id" {
  value       = aws_security_group.ng-sg.id
  description = "Security group id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}