output "kke_dynamodb_table_name" {
  value = aws_dynamodb_table.devops_app_table.name
}

output "kke_sns_topic_arn" {
  value = aws_sns_topic.devops_app_topic.arn
}

output "kke_ssm_parameter_name" {
  value = aws_ssm_parameter.devops_app_config.name
}
