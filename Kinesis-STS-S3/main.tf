# ---------------------------------------------------------
# Retrieve AWS Account Identity (STS)
# ---------------------------------------------------------
data "aws_caller_identity" "current" {}

resource "null_resource" "account_identity_logger" {
  provisioner "local-exec" {
    command = "echo \"Logged in as account ID:${data.aws_caller_identity.current.account_id}\" > /home/bob/terraform/account_identity.log"
  }
}

# ---------------------------------------------------------
# Kinesis Stream
# ---------------------------------------------------------
resource "aws_kinesis_stream" "xfusion_stream" {
  name             = var.KKE_KINESIS_STREAM_NAME
  shard_count      = 1
  retention_period = 24

  tags = {
    Environment = var.KKE_ENVIRONMENT
    Purpose     = "Stream ingestion"
  }

  provisioner "local-exec" {
    command = "echo \"Kinesis Stream ${var.KKE_KINESIS_STREAM_NAME} created\" > /home/bob/terraform/kinesis_creation.log"
  }
}

# ---------------------------------------------------------
# S3 Bucket
# ---------------------------------------------------------
resource "aws_s3_bucket" "xfusion_bucket" {
  bucket = var.KKE_S3_BUCKET_NAME

  tags = {
    Environment = var.KKE_ENVIRONMENT
    Owner       = "xfusion"
  }

  provisioner "local-exec" {
    command = "echo \"S3 Bucket ${var.KKE_S3_BUCKET_NAME} created\" > /home/bob/terraform/s3_creation.log"
  }
}