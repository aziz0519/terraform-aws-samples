############################################
# Locals: Sanitization + Naming + Tags
############################################
locals {
  # sanitize project/team: lowercase + replace non-alphanumeric (except dash) with dash
  sanitized_project = lower(replace(var.KKE_PROJECT, "[^a-zA-Z0-9-]", "-"))
  sanitized_team    = lower(replace(var.KKE_TEAM, "[^a-zA-Z0-9-]", "-"))

  # prefix: project-team
  name_prefix = "${local.sanitized_project}-${local.sanitized_team}"

  # common tags
  common_tags = {
    Project   = "datacenter"
    Team      = "dev-team"
    ManagedBy = "Terraform"
    Env       = var.KKE_ENVIRONMENT
  }

  # role-specific tags
  role_tags = merge(
    local.common_tags,
    { RoleType = "EC2" }
  )
}

############################################
# IAM User
############################################
resource "aws_iam_user" "kke_user" {
  name = "${local.name_prefix}-user"
  tags = local.common_tags
}

############################################
# IAM Role (EC2 Assume Role)
############################################
resource "aws_iam_role" "kke_role" {
  name = "${local.name_prefix}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.role_tags
}

############################################
# Inline IAM Policy for Secrets Manager
############################################
resource "aws_iam_role_policy" "kke_inline_policy" {
  name = var.KKE_POLICY_NAME
  role = aws_iam_role.kke_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}