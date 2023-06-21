
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "eu-west-3a"

  tags = {
    Name                              = "private-eu-west-3a"
    "Kubernetes.io/cluster/eks"       = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "eu-west-3b"

  tags = {
    Name                              = "private-eu-west-3b"
    "Kubernetes.io/cluster/eks"       = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name                        = "public-eu-west-3a"
    "Kubernetes.io/cluster/eks" = "owned"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name                        = "public-eu-west-3b"
    "Kubernetes.io/cluster/eks" = "owned"
    "kubernetes.io/role/elb"    = 1
  }
}

output "private_1_id" {
  value       = aws_subnet.private_1.id
  description = "private subnet 1 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "private_2_id" {
  value       = aws_subnet.private_2.id
  description = "private subnet 2 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "public_1_id" {
  value       = aws_subnet.public_1.id
  description = "public subnet 1 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "public_2_id" {
  value       = aws_subnet.public_2.id
  description = "public subnet 2 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}