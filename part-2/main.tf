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
