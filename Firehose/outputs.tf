output "kke_firehose_stream_name" {
  value = aws_kinesis_firehose_delivery_stream.firehose_stream.name
}

output "kke_s3_bucket_name" {
  value = aws_s3_bucket.firehose_bucket.bucket
}

output "kke_firehose_role_arn" {
  value = aws_iam_role.firehose_role.arn
}