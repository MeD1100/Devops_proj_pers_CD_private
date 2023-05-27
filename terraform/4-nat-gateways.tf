resource "aws_eip" "nat" {
   vpc = true

  tags = {
    Name = "nat"
  }
  # EIP may require IGW to exist prior to association
  # Use depends_on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.main]
}


resource "aws_nat_gateway" "gw" {
  #The allocation ID of the Elastic IP address for the gateway.
  allocation_id = aws_eip.nat.id

  #The subnet ID of the subnet in which to place the gateway.
  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "NAT 1"
  }

  depends_on = [aws_internet_gateway.main]
}
