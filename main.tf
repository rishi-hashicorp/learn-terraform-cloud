terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = var.region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = var.instancetype

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
