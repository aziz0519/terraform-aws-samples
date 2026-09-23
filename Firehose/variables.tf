variable "KKE_S3_BUCKET_NAME" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "KKE_FIREHOSE_STREAM_NAME" {
  description = "Name of the Firehose delivery stream"
  type        = string
}

variable "KKE_FIREHOSE_ROLE_NAME" {
  description = "Name of the Firehose IAM role"
  type        = string
}