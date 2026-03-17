# ------------------------------------------------------------------------------
# S3 BUCKET FOR FRONTEND
# ------------------------------------------------------------------------------

module "s3_frontend" {
  source      = "./terraform/modules/s3_bucket"
  bucket_name = "${var.project_name}-frontend-${random_string.suffix.result}"
  region      = var.aws_region
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
