#######################
# PROVIDERS
#######################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket = "aws-sandbox-tf-767090234737-ik9421217"
    key = "aws-dev-bastion-drift-fix.tfstate"
    region = "us-west-2"
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-west-2"
}

#######################
# RESOURCES
#######################
resource "aws_instance" "bastion" {
  ami           = "ami-0470393e21948091e"
  instance_type = "t2.nano"
  #vpc_id        = "vpc-03042df8d312f746d"
  subnet_id     = "subnet-0f57dcd9fa52d67df"
  key_name      = "ik9421217-bastion-key-ppk"
  vpc_security_group_ids = [aws_security_group.cci-bastion-1.id]
  tags = {
    Name  = "cci-ik9421217-bastion-1"
    Terraform   = "true"
    Environment = "dev"
  }
}

####################
# OUTPUT
#####################

/* output "aws_instance_id" {
  value = aws_instance.bastion.id
} */