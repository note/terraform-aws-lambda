resource "aws_api_gateway_resource" "proxy" {
  // We cannot just `var.api_gateway_rest_api_id != "" ? 1 : 0` because then terraform complains:
  // The "count" value depends on resource attributes that cannot be determined until apply
  // We don't really care about api_gateway_rest_api_id here, we only care if it's non-empty but seemingly terraform
  // attempts to resolve id itself
  // No idea if there's some terraform operator which can check whether value is non-empty without evaluating it
  // Instead, as a workaround, I use var.http_method
  count = var.http_method != "" ? 1 : 0

  rest_api_id = var.api_gateway_rest_api_id
  parent_id   = var.api_gateway_rest_api_root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_method" "proxy" {
  count = var.http_method != "" ? 1 : 0

  rest_api_id   = var.api_gateway_rest_api_id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  count = var.http_method != "" ? 1 : 0

  rest_api_id = var.api_gateway_rest_api_id
  resource_id = aws_api_gateway_method.proxy[count.index].resource_id
  http_method = aws_api_gateway_method.proxy[count.index].http_method

  integration_http_method = var.http_method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}