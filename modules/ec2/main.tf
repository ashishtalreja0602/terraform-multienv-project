# terraform {
#   required_version = ">= 1.5.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
# }

# Region
provider "aws" {
  region = "us-west-2"
}

# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.env}-env-terraform-key"
  public_key = file("././env-terraform-key.pub")
}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = var.security-grooup
  vpc_id      = aws_default_vpc.default.id # interpolation
  description = "Inbound and outbound rules for the instance security group"
}

# Inbound & Outbound rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # all protocols and ports
}

# EC2 Instances
resource "aws_instance" "my_instance" {
  count = var.ec2_instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    name = "${var.env}-${var.instance_name}"
  }
}
