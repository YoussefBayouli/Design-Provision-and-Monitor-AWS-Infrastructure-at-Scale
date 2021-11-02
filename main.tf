terraform {
  required_version = ">= 0.12"
}
locals {
  lambda_zip_location = "outputs/greet_lambda.zip"
}

data "archive_file" "greet_lambda" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "lambda_function" {
  filename                       = var.file_name
  function_name                  = var.function_name
  role                           = aws_iam_role.iam_lambda.arn
  handler                        = var.handler
  runtime                        = var.runtime
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  source_code_hash               = data.archive_file.greet_lambda.output_base64sha256
  reserved_concurrent_executions = var.reserved_concurrent_executions
  tags                           = var.tags

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = var.lambda_env
  }
}
