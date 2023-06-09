data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}



terraform {
  required_providers {
    ansible = {
      source  = "ansible/ansible"      
    }

    aws = {
     source = "hashicorp/aws"   
     version = "~> 5.3"
    }
 }
  

}


provider "aws" {
    region = "${var.region}" 
#    access_key = "${var.access_key}"
#    secret_key = "${var.secret_key}"
}

resource "aws_key_pair" "key" {
  key_name   = var.key
  public_key = var.public_key_cont
}

resource "aws_instance" "web" {
  ami               = "${var.image_id}" ##data.aws_ami.ubuntu.id

  instance_type     = "t2.micro"
  key_name               = "${var.key}"
  vpc_security_group_ids      = [aws_default_security_group.grafana-sg.id]
  monitoring             = true
  subnet_id                   = aws_subnet.grafana-subnet-1.id


  tags = {
    Name = "${var.instance_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}



resource "aws_vpc" "grafana-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true 
}

resource "aws_subnet" "grafana-subnet-1" {
  vpc_id            = aws_vpc.grafana-vpc.id
  cidr_block        = "10.0.0.0/16"
  tags = {
    Name = "grafana-subnet-1"
  }
}




resource "aws_eip" "ip" {
  vpc = true
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.ip.id

}

resource "aws_default_security_group" "grafana-sg" {
  vpc_id = aws_vpc.grafana-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "grafana-sg"
  }
}


resource "ansible_playbook" "playbook" {
  playbook   = "./ansible/playbook.yml"
  name       = "web"
  replayable = true
 
#  ignore_playbook_failure = true
  
  extra_vars = {
  ansible_host = aws_instance.web.public_ip
  ansible_ssh_user = "ubuntu"
  ansible_ssh_private_key_file = "${var.private_key}"

  }
}


