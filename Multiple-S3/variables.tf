variable "KKE_ENV_TAGS" {
  type = map(object({
    owner  = string
    backup = bool
  }))
  description = "Environment-specific metadata for S3 buckets"
}
