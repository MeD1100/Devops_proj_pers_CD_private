resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id = aws_subnet.private_1.id

  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.private_2.id

  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public_1.id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public_2.id

  route_table_id = aws_route_table.public.id
}

output "route_table_public" {
  value       = aws_route_table.public.id
  description = "route table public id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "route_table_private" {
  value       = aws_route_table.private.id
  description = "route table private id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "route_table_association_public1" {
  value       = aws_route_table_association.public1.id
  description = "route table association public 1 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "route_table_association_public2" {
  value       = aws_route_table_association.public2.id
  description = "route table association public 2 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "route_table_association_private1" {
  value       = aws_route_table_association.private1.id
  description = "route table association private 1 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "route_table_association_private2" {
  value       = aws_route_table_association.private2.id
  description = "route table association private 2 id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}