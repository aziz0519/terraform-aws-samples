locals {
  prefix = terraform.workspace == "prod" ? "prod" : "dev"
}

# Create API Gateways using count
resource "aws_api_gateway_rest_api" "nautilus_api" {
  count = length(var.KKE_API_NAMES)

  name = "${local.prefix}-${var.KKE_API_NAMES[count.index]}"

  tags = {
    Environment = terraform.workspace
  }
}

# Create matching CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "api_logs" {
  count = length(var.KKE_API_NAMES)

  name = "/aws/apigateway/${local.prefix}-${var.KKE_API_NAMES[count.index]}"

  tags = {
    Environment = terraform.workspace
  }
}

# Local-exec provisioner to log creation
resource "null_resource" "log_creation" {
  count = length(var.KKE_API_NAMES)

  depends_on = [aws_api_gateway_rest_api.nautilus_api, aws_cloudwatch_log_group.api_logs]

  triggers = {
    index = count.index
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "Created API Gateway ${local.prefix}-${var.KKE_API_NAMES[count.index]} in workspace ${terraform.workspace}" >> apigateway.log
      echo "Created Log Group /aws/apigateway/${local.prefix}-${var.KKE_API_NAMES[count.index]} in workspace ${terraform.workspace}" >> loggroups.log
    EOT
  }
}