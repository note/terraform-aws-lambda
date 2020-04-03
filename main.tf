terraform {
  required_version = ">= 0.12.0"
}

resource "aws_s3_bucket_object" "endpoint_s3_object" {
  bucket = var.deployment_s3_bucket_name
  key    = var.artifact_file_name
  source = var.artifact_file_name

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.artifact_file_name)
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention
}

resource "aws_lambda_function" "lambda_function" {
  s3_bucket     = var.deployment_s3_bucket_name
  s3_key        = aws_s3_bucket_object.endpoint_s3_object.key
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.artifact_file_name)

  runtime = var.runtime

  timeout     = var.timeout
  memory_size = var.memory_size

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.lambda]
}

resource "aws_lambda_permission" "apigw" {
  // SEE: comment on aws_api_gateway_resource in api_gateway.tf
  count = var.http_method != "" ? 1 : 0

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${var.api_gateway_rest_api_arn}/*/*"
}

