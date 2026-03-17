variable "region" {
  type        = string
  description = "AWS region where the bucket will be created"
  default     = "eu-west-1"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket (must be globally unique)"
}

variable "acl" {
  type        = string
  description = "ACL applied to the S3 bucket"
  default     = "public-read"
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "index.html"
}

variable "versioning" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "terraform"
  }
}
