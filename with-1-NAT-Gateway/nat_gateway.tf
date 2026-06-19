resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = { Name = "nat-eip" }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = [aws_internet_gateway.igw]

  tags = { Name = "three-tier-nat" }
}