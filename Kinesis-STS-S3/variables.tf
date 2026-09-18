variable "KKE_ENVIRONMENT" {
  type        = string
  description = "Environment tag value"
}

variable "KKE_KINESIS_STREAM_NAME" {
  type        = string
  description = "Name of the Kinesis Stream"
}

variable "KKE_S3_BUCKET_NAME" {
  type        = string
  description = "Name of the S3 bucket"
}
