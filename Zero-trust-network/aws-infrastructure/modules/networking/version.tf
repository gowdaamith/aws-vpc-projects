# modules/networking/versions.tf

terraform {
  # The module requires at least this version of Terraform core
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # The module requires at least version 5.0 of the AWS provider
      version = ">= 5.0" 
    }
  }
}
