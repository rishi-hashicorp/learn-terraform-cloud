variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  default     = "us-central1-a"
}

variable "project" {
  description = "GCP Project ID"
  default     = "hc-0ea6eeb77ca64b1896879483e05"
}

variable "machine_type" {
  description = "Type of VM instance to provision"
  default     = "e2-micro"
}

variable "vm_name" {
  description = "VM instance name"
  default     = "demoinstance-vcs"
}

