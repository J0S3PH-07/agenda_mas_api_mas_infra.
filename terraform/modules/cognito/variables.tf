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

variable "google_client_id" {
  description = "Google OAuth Client ID"
  type        = string
}

variable "google_client_secret" {
  description = "Google OAuth Client Secret"
  type        = string
  sensitive   = true
}
