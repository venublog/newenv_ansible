provider "aws" {

  version = "3.67.0"
  region = "us-east-1"
  profile = "acloud"
}

resource "aws_key_pair" "site_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key)}"
}

resource "aws_security_group" "sg_ec2node" {
  name        = "ec2node-sg--${var.vpc_id}"
  description = "Used for access to the dev instance."
  vpc_id      = var.vpc_id

  #ec2 node

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  ingress {
    from_port   = 9390
    to_port     = 9390
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  ingress {
    from_port   = 5701
    to_port     = 5701
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  ingress {
    from_port   = 3060
    to_port     = 3060
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  ingress {
    from_port   = 9300
    to_port     = 9400
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }    
  ingress {
    from_port   = 9250
    to_port     = 9250
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }   
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#----- EC2 instance for application-----

resource "aws_instance" "ec2node" {
  count                = var.ec2node_count
  ami                  = var.application_ami
  key_name             = var.keypair_id
  instance_type        = var.ec2node_instance_type
  vpc_security_group_ids = ["${aws_security_group.sg_ec2node.id}"]
 
 
  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["user_data"]
  }
 tags = {
    Name = "acloud_guru_application-${count.index+1}"
  }
}
