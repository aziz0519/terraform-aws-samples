variable "KKE_PROJECT" {
  type        = string
  description = "Project name (must be non-empty)"
}

variable "KKE_TEAM" {
  type        = string
  description = "Team name (letters, digits, dashes, underscores)"
}

variable "KKE_ENVIRONMENT" {
  type        = string
  description = "Environment name"
}

variable "KKE_POLICY_NAME" {
  type        = string
  description = "Name of the inline IAM policy"
}
