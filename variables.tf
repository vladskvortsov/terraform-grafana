
variable "image_id" {
  type = string
  default = "ami-0eb260c4d5475b901"
}


variable "instance_name" {
  type = string
  default = "web"
}

variable "public_key_cont" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdr1Gfzlq3kYLnx4keRGoxLOb6LtejdieKr4e02bvjGrR85RbLLQIylXGCvl7SR4sMWQYF4GvhjiaET5MnA/kR0++Gjs77CY4pZYdWyIrK2RAg1C5XWf4EcCbGrYbi2pm6WFE70MKRBPof/iU4L6Yd1LeIHf8Lm0EAIwXSaNYyxO8L+TUdJ2zjPbwg76WZjTx5mUVU+wjiaIob9nEDJ5soAyT6IJrek18ocO5Agot3aCc+aw0f8p+l4z2JJNUlSOVlDMdInmBJg7XqUXJ5kOClrATSdBj1KfTO+mY4uZNmjgB8x9WuKV3N2xCr6ksqwCKb9uzfWDgUS7o34vertuM6KKT4Lk0VNFcg8auGJCMqZXBcCUIMva/KELPRlB5ShTvlP9HvepLuptznPXcVGsOUiQv4qU1v/ZqBFPeT6ANi+BefX6kryhnTprfA3QTo6o4b1vdzgThT3EaogDg0cvozLCd8rTtWaHwCvaSK/kjzeGJHWxGseWLdReV1rHAv3C0= root@vlad-HP-ProBook-640-G1"
}

variable "aws_region" {
  type = string
  default = "eu-west-2"

}

variable "key" {
  type = string
  default = "key"
}

variable "security_group_id" {
  type = list
  default = ["sg-00006d10243dc6666"]
}



variable "private_key" {
  type = string
  default = "~/terraform-grafana/key.pem"

}



