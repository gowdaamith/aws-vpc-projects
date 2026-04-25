provider "aws" {
  region = "ap-south-1"
}

# s3 bucket for the state 

resource "aws_s3_bucket" "terraform_state" {
  bucket = "amith-kn-terraform-state-unique-id" # change this name 
}

# Enable verrsioning

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration  { status = "Enabled" }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name  = "terraform_running_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute { name = "LockID" ; type  = "S" }
}


