terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
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

check "health_check" {
  data "http" "terraform_io" {
    url = "https://www.terraform.io"
  }

  assert {
    condition = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}
