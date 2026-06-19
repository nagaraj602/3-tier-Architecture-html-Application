# Public Route Table (1 IGW is sufficient for the whole VPC)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-route-table" }
}

# Private Route Table for AZ 1 (Routes to NAT GW 1)
resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }
  tags = { Name = "private-route-table-1a" }
}

# Private Route Table for AZ 2 (Routes to NAT GW 2)
resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_2.id
  }
  tags = { Name = "private-route-table-1b" }
}

# --- Route Table Associations ---

# Public Subnet Associations
resource "aws_route_table_association" "pub_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "pub_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Private App Subnet Associations
resource "aws_route_table_association" "priv_app_1" {
  subnet_id      = aws_subnet.private_app_1.id
  route_table_id = aws_route_table.private_rt_1.id
}
resource "aws_route_table_association" "priv_app_2" {
  subnet_id      = aws_subnet.private_app_2.id
  route_table_id = aws_route_table.private_rt_2.id
}

# Private DB Subnet Associations
resource "aws_route_table_association" "priv_db_1" {
  subnet_id      = aws_subnet.private_db_1.id
  route_table_id = aws_route_table.private_rt_1.id
}
resource "aws_route_table_association" "priv_db_2" {
  subnet_id      = aws_subnet.private_db_2.id
  route_table_id = aws_route_table.private_rt_2.id
}
