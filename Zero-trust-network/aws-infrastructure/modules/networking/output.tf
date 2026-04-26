output "vpc_id" {
  description = "the id of the vpc"
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "the ids of the private subnet"
  value = module.vpc.private_subnets
}

output "database" {
  description = "the ids of the database subnet"
  value = moduel.vpc.database_subnets
}


