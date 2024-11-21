resource "aws_route_table" "ig-route" {
  vpc_id = aws_vpc.labs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-Route.id
  }

  tags = {
    Name = "lab-rt"
  }
}

resource "aws_route_table_association" "associate-pub" {
  subnet_id      = aws_subnet.labs-public-subnet.id
  route_table_id = aws_route_table.ig-route.id
}

