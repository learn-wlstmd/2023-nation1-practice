resource "aws_route_table" "wsi-app-a-rt" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wsi-natgw-a.id
  }

  tags = {
    Name = "wsi-app-a-rt"
  }
}

resource "aws_route_table" "wsi-app-b-rt" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.wsi-natgw-b.id
  }

  tags = {
    Name = "wsi-app-b-rt"
  }
}

resource "aws_route_table" "wsi-public-rt" {
  vpc_id = aws_vpc.wsi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wsi-igw.id
  }

  tags = {
    Name = "wsi-public-rt"
  }
}

resource "aws_route_table" "wsi-data-rt" {
  vpc_id = aws_vpc.wsi-vpc.id

  tags = {
    Name = "wsi-data-rt"
  }
}

resource "aws_route_table_association" "wsi-app-a-rt" {
  subnet_id = aws_subnet.wsi-app-a.id
  route_table_id = aws_route_table.wsi-app-a-rt.id
}

resource "aws_route_table_association" "wsi-app-b-rt" {
  subnet_id = aws_subnet.wsi-app-b.id
  route_table_id = aws_route_table.wsi-app-b-rt.id
}

resource "aws_route_table_association" "wsi-data-a-rt-association" {
  subnet_id      = aws_subnet.wsi-data-a.id
  route_table_id = aws_route_table.wsi-data-rt.id
}

resource "aws_route_table_association" "wsi-data-b-rt-association" {
  subnet_id      = aws_subnet.wsi-data-b.id
  route_table_id = aws_route_table.wsi-data-rt.id
}

resource "aws_route_table_association" "wsi-public-rt-association-a" {
  subnet_id      = aws_subnet.wsi-public-a.id
  route_table_id = aws_route_table.wsi-public-rt.id
}

resource "aws_route_table_association" "wsi-public-rt-association-b" {
  subnet_id      = aws_subnet.wsi-public-b.id
  route_table_id = aws_route_table.wsi-public-rt.id
}

