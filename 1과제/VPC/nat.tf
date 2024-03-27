resource "aws_nat_gateway" "wsi-natgw-a" {
  allocation_id = aws_eip.wsi-nat-eip-1.id
  subnet_id = aws_subnet.wsi-app-a.id
  
  tags = {
    Name = "wsi-natgw-a"
  }
}

resource "aws_nat_gateway" "wsi-natgw-b" {
  allocation_id = aws_eip.wsi-nat-eip-2.id
  subnet_id = aws_subnet.wsi-app-b.id
  
  tags = {
    Name = "wsi-natgw-b"
  }
}