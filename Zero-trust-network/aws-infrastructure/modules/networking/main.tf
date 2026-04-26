module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~>5.0"
  
  name = "fintech-zero-trust-${var.environment}-vpc"
  cidr = var.vpc_cidr
  
  azs = var.AZs
  private_subnets = var.PSubnets
 
  enable_nat_gateaway = false
  single_nat_gateway  = false
  one_nat_gateway_per_az = false
  
  enable_dns_hostname = true
  enable_dns_support = true

  tags = merge ( 
    var.common_tags,
    {
      Environment = var.environment
    }
  )
}


