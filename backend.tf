terraform {
  backend "s3" {
    bucket = var.backend_bucket
    key    = "${var.environment}/terraform.tfstate"
    region = var.aws_region
    encrypt = true
    dynamodb_table = var.backend_dynamodb_table
  }
}