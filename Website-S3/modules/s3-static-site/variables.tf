variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "index_document" {
  description = "Index document for static website hosting"
  type        = string
  default     = "index.html"
}