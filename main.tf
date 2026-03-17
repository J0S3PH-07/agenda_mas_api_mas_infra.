# ------------------------------------------------------------------------------
# ROOT CONFIGURATION
# ------------------------------------------------------------------------------

module "networking" {
  source = "./terraform/modules/networking"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  az_a                  = var.az_a
  az_b                  = var.az_b
}

module "security" {
  source = "./terraform/modules/security"

  project_name   = var.project_name
  vpc_id         = module.networking.vpc_id
  container_port = var.container_port
}

module "ecr" {
  source       = "./terraform/modules/ecr"
  project_name = var.project_name
}

module "dns" {
  source = "./terraform/modules/dns"

  domain_name  = var.domain_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "alb" {
  source = "./terraform/modules/alb"

  project_name      = var.project_name
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  container_port    = var.container_port
  certificate_arn   = module.dns.certificate_arn
  domain_name       = var.domain_name
}

module "rds" {
  source = "./terraform/modules/rds"

  project_name       = var.project_name
  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
}

module "ecs" {
  source = "./terraform/modules/ecs"

  project_name              = var.project_name
  aws_region                = var.aws_region
  public_subnet_ids         = module.networking.public_subnet_ids
  ecs_tasks_sg_id           = module.security.ecs_tasks_sg_id
  container_port            = var.container_port
  execution_role_arn        = var.execution_role_arn
  ecr_image_url             = module.ecr.repository_url
  frontend_image_url        = module.ecr.frontend_repository_url
  db_host                   = module.rds.db_instance_address
  db_name                   = var.db_name
  db_username               = var.db_username
  db_password               = module.rds.db_password
  cognito_user_pool_id      = module.cognito.user_pool_id
  cognito_client_id         = module.cognito.client_id
  google_client_id          = var.google_client_id
  google_client_secret      = var.google_client_secret
  domain_name               = var.domain_name
  target_group_arn          = module.alb.target_group_arn
  frontend_target_group_arn = module.alb.frontend_target_group_arn
}
