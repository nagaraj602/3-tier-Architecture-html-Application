data "aws_availability_zones" "available" {
  state = "available"
}

# Public Subnets (For ALB and NAT)
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1a" }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1b" }
}

# Private App Subnets (For ASG/EC2)
resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "private-app-subnet-1a" }
}

resource "aws_subnet" "private_app_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "private-app-subnet-1b" }
}

# Private DB Subnets (For RDS)
resource "aws_subnet" "private_db_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 4)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = { Name = "private-db-subnet-1a" }
}

resource "aws_subnet" "private_db_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 5)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = { Name = "private-db-subnet-1b" }
}