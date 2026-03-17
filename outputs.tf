output "load_balancer_url" {
  description = "The public DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

# ------------------------------------------------------------------------------
# COGNITO OUTPUTS
# ------------------------------------------------------------------------------

output "cognito_user_pool_arn" {
  description = "ARN del User Pool de Cognito"
  value       = module.cognito.user_pool_arn
}

output "cognito_app_client_id" {
  description = "ID del App Client de Cognito"
  value       = module.cognito.client_id
}

output "cognito_hosted_ui_url" {
  description = "URL del Hosted UI de Cognito para login"
  value       = "https://${module.cognito.domain}.auth.${var.aws_region}.amazoncognito.com/login?client_id=${module.cognito.client_id}&response_type=code&scope=openid+email+profile&redirect_uri=${var.cognito_callback_urls[0]}"
}

# ------------------------------------------------------------------------------
# RDS OUTPUTS
# ------------------------------------------------------------------------------

output "rds_endpoint" {
  description = "Endpoint de conexión de la base de datos RDS PostgreSQL"
  value       = module.rds.db_instance_address
}

output "db_password_ssm_path" {
  description = "Ruta en SSM Parameter Store donde se almacena la contraseña de la BD"
  value       = "/${var.project_name}/db/password"
}

output "frontend_url" {
  description = "URL del sitio web del frontend en S3"
  value       = "http://${module.s3_frontend.website_endpoint}"
}
