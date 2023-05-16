
provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIAS6JMJ3VBSU3BSJAP"
  secret_key = "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"
}




module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "web"

  instance_type          = "t2.micro"
  key_name               = "user"
  monitoring             = true
  ami                    = "ami-0eb260c4d5475b901" 

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}                   