variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}


variable "key" {
  description = "AWS key"
  type        = string
  default     = "key"
}

variable "image_id" {
  type = string
}
variable "instance_name" {}
variable "public_key_cont" {}

variable "key" {}
variable "security_group_id" {}
variable "private_key" {}
