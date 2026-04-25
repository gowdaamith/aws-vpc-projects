module "networking" {
  source = "../../modules/networking"

  environment      = var.environment
  vpc_cidr         = var.vpc_cidr
  azs              = var.azs
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets
  common_tags      = var.common_tags
}
