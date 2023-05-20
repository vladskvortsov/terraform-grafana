terraform {
  required_providers {
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
      
    }
    local = {
      version = "~> 2.4.0"
      source  = "hashicorp/local"
      
    }
  }
}


provider "aws" {
  region     = "eu-west-2"

}



resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdr1Gfzlq3kYLnx4keRGoxLOb6LtejdieKr4e02bvjGrR85RbLLQIylXGCvl7SR4sMWQYF4GvhjiaET5MnA/kR0++Gjs77CY4pZYdWyIrK2RAg1C5XWf4EcCbGrYbi2pm6WFE70MKRBPof/iU4L6Yd1LeIHf8Lm0EAIwXSaNYyxO8L+TUdJ2zjPbwg76WZjTx5mUVU+wjiaIob9nEDJ5soAyT6IJrek18ocO5Agot3aCc+aw0f8p+l4z2JJNUlSOVlDMdInmBJg7XqUXJ5kOClrATSdBj1KfTO+mY4uZNmjgB8x9WuKV3N2xCr6ksqwCKb9uzfWDgUS7o34vertuM6KKT4Lk0VNFcg8auGJCMqZXBcCUIMva/KELPRlB5ShTvlP9HvepLuptznPXcVGsOUiQv4qU1v/ZqBFPeT6ANi+BefX6kryhnTprfA3QTo6o4b1vdzgThT3EaogDg0cvozLCd8rTtWaHwCvaSK/kjzeGJHWxGseWLdReV1rHAv3C0= root@vlad-HP-ProBook-640-G1"
}





resource "aws_instance" "web" {
  ami               = "ami-0eb260c4d5475b901"

  instance_type     = "t2.micro"
  key_name               = "key"
  vpc_security_group_ids = ["sg-00006d10243dc6666"]
  monitoring             = true


  tags = {
    Name = "web"
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
  ansible_ssh_private_key_file = "~/terraform-grafana/key.pem"
  }
}




