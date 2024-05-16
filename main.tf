terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

data "aws_ami" "demo" {
  owners = ["amazon"]

  filter {
    name   = "image-id"
    values = ["ami-0bb84b8ffd87024d8"]
  }
}

provider "aws" {
  region  = var.region
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.demo.id
  instance_type = var.instancetype

  lifecycle {
    # The AMI ID must refer to an AMI that contains an OS
    precondition {
      condition     = data.aws_ami.demo.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }

    postcondition {
      condition     = self.public_dns != ""
      error_message = "EC2 instance must be in a VPC that has public DNS hostnames enabled."
    }
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

#data "aws_ebs_volume" "demo" {

 # filter {
#    name = "volume-id"
#    values = [aws_instance.app_server.root_block_device[0].volume_id]
#  }

#  lifecycle {
 #   postcondition {
 #     condition     = self.encrypted
 #     error_message = "The server's root volume is not encrypted."
 #   }
 # }
#}

output "api_base_url" {
  value = "https://${aws_instance.app_server.private_dns}:8433/"
}

check "health_check" {
  data "http" "terraform_io" {
    url = "https://www.terraform.io"
  }

  assert {
    condition = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}

