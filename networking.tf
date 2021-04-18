
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "primary" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.primary_subnet_cidr_block
  map_public_ip_on_launch = true
}

resource "aws_subnet" "secondary" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.secondary_subnet_cidr_block
  map_public_ip_on_launch = true
}
