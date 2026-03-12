# ------------------------------------------------------------------------------
# AWS COGNITO — USER POOL
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-user-pool"

  # ── Login solo por correo electrónico ──
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  # ── Política de contraseñas ──
  password_policy {
    minimum_length                   = 8
    require_uppercase                = true
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 7
  }

  # ── Atributos estándar requeridos ──
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  # ── Atributos personalizados opcionales ──
  schema {
    name                = "user_role"
    attribute_data_type = "String"
    required            = false
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 50
    }
  }

  schema {
    name                = "room_preference"
    attribute_data_type = "String"
    required            = false
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 100
    }
  }

  # ── Verificación por correo electrónico ──
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Código de verificación — ${var.project_name}"
    email_message        = "Tu código de verificación es: {####}"
  }

  # ── Configuración de cuenta ──
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  tags = {
    Name = "${var.project_name}-user-pool"
  }
}

# ------------------------------------------------------------------------------
# AWS COGNITO — APP CLIENT (público, sin secreto)
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool_client" "main" {
  name         = "${var.project_name}-app-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # Sin secreto para front-end público
  generate_secret = false

  # ── Flujos de autenticación permitidos ──
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]

  # ── OAuth 2.0 ──
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]

  callback_urls = var.cognito_callback_urls
  logout_urls   = var.cognito_logout_urls

  supported_identity_providers = ["COGNITO"]

  # ── Validez de tokens ──
  access_token_validity  = 1   # 1 hora
  id_token_validity      = 1   # 1 hora
  refresh_token_validity = 30  # 30 días

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}

# ------------------------------------------------------------------------------
# AWS COGNITO — DOMINIO (Hosted UI)
# ------------------------------------------------------------------------------

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.project_name}-auth"
  user_pool_id = aws_cognito_user_pool.main.id
}
