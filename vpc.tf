resource "aws_vpc" "jendarey_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "jendarey_vpc"
  }
}

resource "aws_subnet" "jendarey_public_subnet_a" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1
  tags = {
    Name = "jendarey-public-subnet-a"
  }
}

resource "aws_subnet" "jendarey_public_subnet_b" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE2
  tags = {
    Name = "jendarey_public_subnet_b"
  }
}

resource "aws_subnet" "jendarey_private_subnet_a" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1
  tags = {
    Name = "jendarey_private_subnet_a"
  }
}

resource "aws_subnet" "jendarey_private_subnet_b" {
  vpc_id                  = aws_vpc.jendarey_vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE2
  tags = {
    Name = "jendarey_private_subnet_b"
  }
}

resource "aws_internet_gateway" "jendarey-IGW" {
  vpc_id = aws_vpc.jendarey_vpc.id
  tags = {
    Name = "jendarey-IGW"
  }
}

resource "aws_route_table" "jendarey-pub-RT" {
  vpc_id = aws_vpc.jendarey_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jendarey-IGW.id
  }

  tags = {
    Name = "jendarey-pub-RT"
  }
}

resource "aws_route_table_association" "jendarey-pub-1-a" {
  subnet_id      = aws_subnet.jendarey_public_subnet_a.id
  route_table_id = aws_route_table.jendarey-pub-RT.id
}

resource "aws_route_table_association" "jendarey-pub-2-a" {
  subnet_id      = aws_subnet.jendarey_public_subnet_b.id
  route_table_id = aws_route_table.jendarey-pub-RT.id
}

resource "aws_nat_gateway" "jendarey-nat-gw" {
  allocation_id = aws_eip.jendarey-nat-eip.id
  subnet_id     = aws_subnet.jendarey_public_subnet_a.id
  tags = {
    Name = "jendarey-nat-gw"
  }
}

resource "aws_eip" "jendarey-nat-eip" {}

