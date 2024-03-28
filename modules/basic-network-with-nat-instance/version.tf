terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Set the region to avoid error/misplace resource.
provider "aws" {
  region = var.vpc_region
}
