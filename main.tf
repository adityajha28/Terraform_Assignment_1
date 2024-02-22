terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-1" 
}

# Create VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a" 
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create Route Table
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
  tags = {
    Name = "my-route-table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "example_subnet_association" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

# Create Security Group
resource "aws_security_group" "example_security_group" {
  name        = "my-security-group"
  description = "Allow inbound SSH & HTTP and outbound traffic"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["110.226.124.147/32"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Key Pair
resource "aws_key_pair" "example_key_pair" {
  key_name   = "aditya-key-pair"
  public_key = file("adityakeypair.pem.pub") 
}

# Create EC2 Instance
resource "aws_instance" "example_instance" {
  ami           = "ami-06b72b3b2a773be2b"  # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet.id
  key_name      = aws_key_pair.example_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.example_security_group.id]

  user_data = <<EOF
              #!/bin/bash
              yum udpate -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "my-instance"
  }
}
