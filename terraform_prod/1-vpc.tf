resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}