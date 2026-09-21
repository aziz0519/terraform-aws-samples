module "s3_static_site" {
  source = "./modules/s3-static-site"

  bucket_name    = "nautilus-web-11545"
  index_document = "index.html"
}

output "website_url" {
  value = module.s3_static_site.website_url
}