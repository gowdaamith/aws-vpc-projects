module "vpc" {
  source = "terraform-aws-module/vpc/aws"
  version = "~>5.0"
  
  name = "fintech-zero-trust-${var.environment}-vpc"
  cidr =var.vpc_cidr
  azs = var.AZs
  private_subnets = var.private_subnets
  database_subnets = var.database_subnets
  
  # Strict Air Gap Enforcement 
  create_igw = false
  enable_nat_gateway = false
  single_nat_gateway = false
  
  enable_dns_hostnames = true
  enable_dns_support = true
  
  
  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
    }
  )
}
