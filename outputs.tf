output "lambda_role_arn" {
  description = "ARN of lambda role"
  value = aws_lambda_function.lambda_function.arn
}
