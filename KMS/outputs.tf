output "kke_kms_key_name" {
  value = aws_kms_key.xfusion_kms_key.tags["Name"]
}
