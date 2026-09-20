output "kke_bucket_names" {
  value = {
    for env, bucket in aws_s3_bucket.kke_buckets :
    env => bucket.bucket
  }
}
