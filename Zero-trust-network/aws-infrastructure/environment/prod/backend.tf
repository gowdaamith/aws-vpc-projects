terraform {
  backend "s3" {
    bucket  = "cloudbite-terraform-state-prod"
    key = "networking/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
  }
}

