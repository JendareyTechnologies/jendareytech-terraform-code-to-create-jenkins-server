resource "aws_vpc" "jendarey_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-vpc"  
  }
}

resource "aws_subnet" "jendarey_public_subnet_a" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1
  tags = {
    Name = "${var.vpc_name}-vpc-public-subnet-a" 
  }
}

resource "aws_subnet" "jendarey_public_subnet_b" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = var.public_subnet_cidrs[1]
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE2
  tags = {
    Name = "${var.vpc_name}-vpc-public-subnet-b" 
  }
}

resource "aws_subnet" "jendarey_private_subnet_a" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = var.private_subnet_cidrs[0]
  availability_zone       = var.ZONE1
  tags = {
    Name = "${var.vpc_name}-vpc-private-subnet-a" 
  }
}

resource "aws_subnet" "jendarey_private_subnet_b" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = var.private_subnet_cidrs[1]
  availability_zone       = var.ZONE2
  tags = {
    Name = "${var.vpc_name}-vpc-private-subnet-b" 
  }
}

resource "aws_internet_gateway" "jendarey-igw" {
  vpc_id = aws_vpc.jendarey_vpc.id
  tags = {
    Name = "${var.vpc_name}-vpc-igw"
  }
}

resource "aws_default_route_table" "jendarey-main-rtb" {
  default_route_table_id = aws_vpc.jendarey_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jendarey-igw.id
  }
  tags = {
    Name = "${var.vpc_name}-vpc-main-rtb"
  }
}

