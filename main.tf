terraform {
  required_providers {
    ansible = {
      source  = "ansible/ansible"
      
    }
  }
}


provider "aws" {
  region     = var.aws_region

}

resource "aws_key_pair" "key" {
  key_name   = var.key
  public_key = var.public_key_cont

}



resource "aws_instance" "web" {
  ami               = var.image_id

  instance_type     = "t2.micro"
  key_name               = var.key
  vpc_security_group_ids = var.security_group_id
  monitoring             = true


  tags = {
    Name = var.instance_name
    Terraform   = "true"
    Environment = "dev"
  }
}






resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.ip.id

}

resource "aws_eip" "ip" {
  vpc = true

}



resource "ansible_playbook" "playbook" {
  playbook   = "./ansible/playbook.yml"
  name       = "web"
  replayable = true
 
#  ignore_playbook_failure = true
  
  extra_vars = {
  ansible_host = aws_instance.web.public_ip
  ansible_ssh_user = "ubuntu"
  ansible_ssh_private_key_file = var.private_key

  }
}




