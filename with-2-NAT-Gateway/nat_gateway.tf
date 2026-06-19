# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_1" {
  domain = "vpc"
  tags   = { Name = "nat-eip-1a" }
}

resource "aws_eip" "nat_eip_2" {
  domain = "vpc"
  tags   = { Name = "nat-eip-1b" }
}

# NAT Gateway for AZ 1
resource "aws_nat_gateway" "nat_gw_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = [aws_internet_gateway.igw]

  tags = { Name = "three-tier-nat-1a" }
}

# NAT Gateway for AZ 2
resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.public_2.id
  depends_on    = [aws_internet_gateway.igw]

  tags = { Name = "three-tier-nat-1b" }
}
