resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name

  tags = {
    Project = "StaticWeb"
  }
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

# Upload index.html from root using variable
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_site.id
  key          = var.index_document
  source       = "${path.root}/${var.index_document}"
  content_type = "text/html"

  depends_on = [aws_s3_bucket.static_site]
}