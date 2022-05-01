resource "aws_default_vpc" "mgmt-default" {
  force_destroy = false
  tags = {
    Name = "Default MGMT VPC"
  }
}

resource "aws_subnet" "mgmt-svc" {
  vpc_id     = aws_default_vpc.mgmt-default.id
  cidr_block = "172.16.24.0/21"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "svc"
  }
}

resource "aws_subnet" "mgmt-compute" {
  vpc_id     = aws_default_vpc.mgmt-default.id
  cidr_block = "172.16.32.0/21"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "compute"
  }
}

resource "aws_subnet" "mgmt-db" {
  vpc_id     = aws_default_vpc.mgmt-default.id
  cidr_block = "172.16.40.0/21"
  availability_zone = "eu-central-1c"
  tags = {
    Name = "db"
  }
}