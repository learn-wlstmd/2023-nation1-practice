resource "aws_eip" "wsi-nat-eip-1" {
  domain = "vpc"
  tags = {
    Name = "-"
  }
}

resource "aws_eip" "wsi-nat-eip-2" {
  domain = "vpc"
  tags = {
    Name = "-"
  }
}