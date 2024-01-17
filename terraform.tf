terraform {
/*
    cloud {
    organization = "rishi-demo"

    workspaces {
      name = "learn-terraform-cloud"
    }
  }
  */

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}


