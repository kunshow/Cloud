provider "aws" {
region = "us-east-1"
access_key = "AKIAWJVWYHHIWLAA7ZG6"
secret_key = "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"
}
  

resource "aws_vpc" "assign" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "assign-vpc"
  }
}


resource "aws_instance" "assign-server" {
  ami           = "ami-0889a44b331db0194" # us-east-1
  instance_type = "t2.micro"
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.assign.id

  tags = {
    Name = "assign-igw"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.assign.id

  route = []

  tags = {
    Name = "assign-private"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.assign.id

  route = []

  tags = {
    Name = "assign-public"
  }
}


resource "aws_subnet" "assign-private" {
  vpc_id     = aws_vpc.assign.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "assign-private1a"
  }
}


resource "aws_subnet" "assign-private1b" {
  vpc_id     = aws_vpc.assign.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "assign-private1b"
  }
}


resource "aws_subnet" "assign-public1a" {
  vpc_id     = aws_vpc.assign.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "assign-public1a"
  }
}


resource "aws_subnet" "assign-public1b" {
  vpc_id     = aws_vpc.assign.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "assign-public1b"
  }
}






