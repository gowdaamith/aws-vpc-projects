variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "ap-south-1"
}
variable "project_name" {
  description = "Name of the project "
  type = string
  default = "ap-south-1"
}
variable "environment" {
  description = "Enter the environment"
  type = string
  default = "prod"
}
variable "vpc_cidr" {
  description = "Enter the cidr range"
  type = string 
  default = "10.0.0.0/16"
}
variable "db_password" {
  description = "password for the database"
  type = string
  sensitive = true
}


