variable "deployment_s3_bucket_name" {
  description = "name of s3 bucket to which zip artifact will be uploaded to"
  type        = string
}

variable "api_gateway_rest_api_id" {
  description = "id of aws_api_gateway_rest_api"
  type        = string

  // Use the default for lambda with not API GW integration (e.g. triggered by event instead of API call)
  default = ""
}

variable "api_gateway_rest_api_root_resource_id" {
  description = "root_resource_id of aws_api_gateway_rest_api"
  type        = string

  // Use the default for lambda with not API GW integration (e.g. triggered by event instead of API call)
  default = ""
}

variable "api_gateway_rest_api_arn" {
  description = "execution_arn of aws_api_gateway_rest_api"
  type        = string

  // Use the default for lambda with not API GW integration (e.g. triggered by event instead of API call)
  default = ""
}

variable "http_method" {
  description = "http method"
  type        = string

  // Use the default for lambda with not API GW integration (e.g. triggered by event instead of API call)
  default = ""
}

variable "path_part" {
  description = "path part of the URL"
  type        = string

  // Use the default for lambda with not API GW integration (e.g. triggered by event instead of API call)
  default = ""
}

variable "function_name" {
  description = "AWS lambda function name. Has nothing to do with function name in the backend code itself"
  type        = string
}

variable "artifact_file_name" {
  description = "filename of the articat to be deployed (zip/jar file)"
  type        = string
}

variable "handler" {
  description = "Function from the backend code to be called. Format and its semantics depends on programming language and packaging method"
  type        = string
}

variable "runtime" {
  description = "AWS lambda runtime"
  type        = string
}

variable "timeout" {
  description = "AWS lambda execution timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "AWS lambda memory size in megabytes"
  type        = number
  default     = 256
}

variable "log_retention" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}
