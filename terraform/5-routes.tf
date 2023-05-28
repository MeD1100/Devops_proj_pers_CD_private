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