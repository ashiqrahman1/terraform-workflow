terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ashiqrahmantesting"

    workspaces {
      name = "terraform-workflow"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ssm_parameter" "my-amzn-linux-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "test" {
  ami           = data.aws_ssm_parameter.my-amzn-linux-ami.value
  instance_type = var.instance_type
}

output "public_ip" {
  value = aws_instance.test.public_ip
}
