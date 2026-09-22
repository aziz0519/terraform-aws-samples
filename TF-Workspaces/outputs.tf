output "kke_api_gateway_names" {
  value = [for api in aws_api_gateway_rest_api.nautilus_api : api.name]
}

output "kke_log_group_names" {
  value = [for lg in aws_cloudwatch_log_group.api_logs : lg.name]
}