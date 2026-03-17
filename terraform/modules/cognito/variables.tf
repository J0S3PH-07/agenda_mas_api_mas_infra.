variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "cognito_callback_urls" {
  description = "Callback URLs for Cognito Hosted UI"
  type        = list(string)
}

variable "cognito_logout_urls" {
  description = "Logout URLs for Cognito Hosted UI"
  type        = list(string)
}
