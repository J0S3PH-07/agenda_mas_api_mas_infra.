# Terraform S3 website bucket

This module creates an S3 bucket configured for static website hosting and
opens a public read policy for objects.

Usage example:

```hcl
module "static_site" {
  source      = "./terraform/s3_bucket"
  bucket_name = "my-unique-bucket-name-12345"
  region      = "eu-west-1"
}
```

Initialize and apply:

```bash
terraform init
terraform apply -var="bucket_name=your-unique-bucket-name"
```

Note: This creates a public bucket for static hosting. Review policies and
access controls before using in production.
