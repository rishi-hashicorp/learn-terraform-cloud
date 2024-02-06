variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instancetype" {
  description = "Type of VM instance to provision"
  default     = "t2.micro"
}
