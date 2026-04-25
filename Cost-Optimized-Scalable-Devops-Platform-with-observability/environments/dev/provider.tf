terraform {
  requried_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    buckett = "amith-kn-terraform-state-unique-id"
    region = "ap-south-1"
    key  = "dev/terraform.tfstate"
    dynamodb_table = "terraform-running-locks"
    encrypt = true

}

provider "aws" {
  region = "ap-south-1"
}






