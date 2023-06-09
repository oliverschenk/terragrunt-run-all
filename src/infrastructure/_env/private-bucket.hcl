terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket//.?ref=v3.8.2"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  id = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.common_vars.name}"
}

inputs = {
  acl           = "private"
  force_destroy = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle_rule = [
    {
      id      = "${local.id}-lifecycle-rule"
      enabled = true

      expiration = {
        days = 30
      }
    }
  ]

  versioning = {
    enabled = true
  }
}
