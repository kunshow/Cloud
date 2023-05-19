provider "aws" {
region = "us-east-1"
access_key = "AKIAWJVWYHHI3ZUXXDXO"
secret_key = "8tW4N/J8J4Wfhwsasmwocvs5R75lOXC46pfUSWfx"
  
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your VPC CIDR block

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"  # Replace with your subnet CIDR block
  availability_zone       = "us-east-1a"   # Replace with your desired availability zone

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Replace with your desired destination CIDR block
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_instance" "web_server" {
  ami           = "ami-0889a44b331db0194"  # Replace with the desired AMI ID
  instance_type = "t2.micro"      # Replace with the desired instance type
  subnet_id     = aws_subnet.my_subnet.id

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl start apache2
  EOF

  tags = {
    Name = "web-server"
  }
}