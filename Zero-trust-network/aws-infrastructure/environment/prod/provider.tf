# environments/prod/providers.tf

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# The actual configuration happens here in the environment
provider "aws" {
  # You can hardcode the region here, or pass it via a variable in prod.tfvars
  region = var.aws_region 

  # Best Practice: Apply default tags at the provider level.
  # This ensures every resource created in this environment gets these tags,
  # even if you forget to add them to a specific resource block.
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "CloudBite"
    }
  }
}
