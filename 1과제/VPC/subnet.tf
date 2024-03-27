resource "aws_subnet" "wsi-app-a" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "wsi-app-a"
  }
}

resource "aws_subnet" "wsi-app-b" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = false

  tags = {
    Name = "wsi-app-b"
  }
}

resource "aws_subnet" "wsi-public-a" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-public-a"
  }
}

resource "aws_subnet" "wsi-public-b" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.3.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-public-b"
  }
}

resource "aws_subnet" "wsi-data-a" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.4.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-data-a"
  }
}

resource "aws_subnet" "wsi-data-b" {
  vpc_id = aws_vpc.wsi-vpc.id
  cidr_block = "10.1.5.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "wsi-data-b"
  }
}

