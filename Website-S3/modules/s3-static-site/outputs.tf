output "website_url" {
  description = "S3 static website URL"
  value       = "http://aws:4566/${var.bucket_name}/${var.index_document}"
}