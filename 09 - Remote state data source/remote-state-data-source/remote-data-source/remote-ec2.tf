terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
  # Provider Block
provider "aws" {
    region  = "us-west-1"
    profile = "Kenmak"
  }

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "my-terraformstate-landmark-buc"
    key    = "terraform/terraform.tfstate"  # S3 path where the state file is stored
    region = "us-west-1"
  }
}

/*data "terraform_remote_state" "network" {
  backend = "local"
  config = {
      path    = "../remote-data-source/terraform.tfstate"  # path where state file is stored locally
  }
}*/

resource "aws_instance" "my-ec2"{
  ami = data.aws_ami.amzlinux2.id
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.network.outputs.public_subnets[1] # using the output data from the subnet created with the vpc. Since the subnet was outputted as a list, that's why we specified [1] at the end

  tags = {
    "Name" = "My_ec2"
  }
}
