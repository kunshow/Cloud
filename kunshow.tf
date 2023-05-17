provider "aws" {
region = "us-east-1"
access_key = "AKIAWJVWYHHIWLAA7ZG6"
secret_key = "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"
}


resource "aws_vpc" "web" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "web"
  }
}


resource "aws_internet_gateway" "web-igw" {
  vpc_id = aws_vpc.web.id

  tags = {
    Name = "web-igw"
  }
}


resource "aws_route_table" "web-private" {
  vpc_id = aws_vpc.web.id

  route = []

  tags = {
    Name = "web-private"
  }
}


resource "aws_route_table" "web-public" {
  vpc_id = aws_vpc.web.id

  route = []

  tags = {
    Name = "web-public"
  }
}


resource "aws_subnet" "web-sbprivate1a" {
  vpc_id     = aws_vpc.web.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "web-sbprivate1a"
  }
}


resource "aws_subnet" "web-sbprivate1b" {
  vpc_id     = aws_vpc.web.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "web-sbprivate1b"
  }
}


resource "aws_subnet" "web-sbpublic1a" {
  vpc_id     = aws_vpc.web.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "web-sbpublic1a"
  }
}


resource "aws_subnet" "web-sbpublic1b" {
  vpc_id     = aws_vpc.web.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "web-sbpublic1b"
  }
}


resource "aws_instance" "web-server" {
  ami           = "ami-0889a44b331db0194" # us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.web-sbpublic1a.id
}


resource "aws_vpc" "peller-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "peller-vpc"
  }
}


resource "aws_vpc" "text-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "text-vpc"
  }
}



