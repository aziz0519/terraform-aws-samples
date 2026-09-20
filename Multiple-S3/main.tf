locals {
  bucket_suffix = "847819251"

  env_bucket_names = {
    Dev     = "devops-dev-bucket-${local.bucket_suffix}"
    Staging = "devops-staging-bucket-${local.bucket_suffix}"
    Prod    = "devops-prod-bucket-${local.bucket_suffix}"
  }
}

# ---------------------------------------------------------
# Create S3 buckets using for_each
# ---------------------------------------------------------
resource "aws_s3_bucket" "kke_buckets" {
  for_each = var.KKE_ENV_TAGS

  bucket = local.env_bucket_names[each.key]

  tags = {
    Name        = local.env_bucket_names[each.key]
    Environment = each.key
    Owner       = each.value.owner
    Backup      = tostring(each.value.backup)
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# ---------------------------------------------------------
# Lifecycle rules for Staging & Prod only
# ---------------------------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "glacier_rules" {
  for_each = {
    for env, meta in var.KKE_ENV_TAGS :
    env => meta if meta.backup == true
  }

  bucket = aws_s3_bucket.kke_buckets[each.key].id

  rule {
    id     = "MoveToGlacier"
    status = "Enabled"

    filter {
        prefix = ""
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

# ---------------------------------------------------------
# Public Read Bucket Policy
# ---------------------------------------------------------
data "aws_iam_policy_document" "public_read" {
  for_each = var.KKE_ENV_TAGS

  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.kke_buckets[each.key].arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  for_each = var.KKE_ENV_TAGS

  bucket = aws_s3_bucket.kke_buckets[each.key].id
  policy = data.aws_iam_policy_document.public_read[each.key].json

  depends_on = [
    aws_s3_bucket.kke_buckets
  ]
}