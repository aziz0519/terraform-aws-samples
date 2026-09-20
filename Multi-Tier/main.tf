# ---------------------------------------------------------
# DynamoDB Table
# ---------------------------------------------------------
resource "aws_dynamodb_table" "devops_app_table" {
  name         = var.KKE_DYNAMODB_TABLE_NAME
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "taskId"

  attribute {
    name = "taskId"
    type = "S"
  }
}
# ---------------------------------------------------------
# SNS Topic
# ---------------------------------------------------------
resource "aws_sns_topic" "devops_app_topic" {
  name = var.KKE_SNS_TOPIC_NAME
}

# ---------------------------------------------------------
# SSM Parameter (SecureString)
# ---------------------------------------------------------
resource "aws_ssm_parameter" "devops_app_config" {
  name        = var.KKE_SSM_PARAM_NAME
  type        = "SecureString"
  value       = "sensitive-config-value"
  description = "DevOps app sensitive configuration"
}