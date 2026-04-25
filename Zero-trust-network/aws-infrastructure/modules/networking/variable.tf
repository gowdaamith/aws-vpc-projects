variable "environment"  {
  description = "the deployment environment"
  type = string 
}

variable "vpc_cidr" {
  description = "the cidr range of the vpc"
  type = string
}

variable "AZs" {
  description = "AZs to use " 
  type = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs" 
  type = list(string) 
}

variable "database_subnets" {
  description = "List of private subnet where the create the database"
  type = list(string)

}

variable "common_tags" {
  description = "tags applied to all resources"
  type = map(string)
  default = {}
}


