variable "KKE_ENVIRONMENT" {
  type        = string
  description = "Environment name"
}

variable "KKE_DYNAMODB_TABLE_NAME" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "KKE_SNS_TOPIC_NAME" {
  type        = string
  description = "Name of the SNS topic"
}

variable "KKE_SSM_PARAM_NAME" {
  type        = string
  description = "Name of the SSM parameter"
}
