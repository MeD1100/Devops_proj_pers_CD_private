resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

output "eip_nat" {
  value       = aws_eip.nat.id
  description = "eip nat id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

output "nat_gateway" {
  value       = aws_nat_gateway.nat.id
  description = "nat gateway id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}