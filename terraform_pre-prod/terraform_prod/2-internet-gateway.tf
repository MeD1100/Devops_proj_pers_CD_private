
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "IGW id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}