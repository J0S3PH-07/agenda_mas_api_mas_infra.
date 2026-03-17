// Cognito moved into module 'modules/cognito'

module "cognito" {
  source = "./terraform/modules/cognito"

  project_name          = var.project_name
  cognito_callback_urls = var.cognito_callback_urls
  cognito_logout_urls   = var.cognito_logout_urls
}
