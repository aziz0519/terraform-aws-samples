output "kke_caller_identity_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "kke_kinesis_stream_name" {
  value = aws_kinesis_stream.xfusion_stream.name
}

output "kke_s3_bucket_name" {
  value = aws_s3_bucket.xfusion_bucket.bucket
}
