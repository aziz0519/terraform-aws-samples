output "kke_user_name" {
  value = aws_iam_user.kke_user.name
}

output "kke_role_name" {
  value = aws_iam_role.kke_role.name
}

output "kke_tags_applied" {
  value = aws_iam_user.kke_user.tags
}
