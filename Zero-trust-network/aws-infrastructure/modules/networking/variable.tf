variable "environment" {
  description = "the environment you are working on "
  type = string
}

variable "vpc_cidr" {
  description = "the cidr range of the vpc"
  type = string 
}

variable "AZs" {
  description = "The az in which you want your subnet"
  type = list(string)
}

variable "PSubnets" {
  description = "The cidr range of the subnets in which range you want the subnets to be in  "
  type = list(string)
}

variable "DSubnets" {
  description = "The cidr range fo the subnets in which range you want the subnets to be in "
  type = list(string)
}


variable  "common_tags" {
  description = "the tags for the hole project"
  type = map(string)
  default = {}
}


  
