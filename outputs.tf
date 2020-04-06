output "lambda_role_name" {
  description = "lambda role name"
  value = aws_iam_role.iam_for_lambda.name
}
