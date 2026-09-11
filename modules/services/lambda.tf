resource "aws_lambda_function" "antifraud_engine" {
  filename = "../../lambda/antifraud-engine.zip"
  function_name = "antifraud-engine-${var.environment}"
  role = aws_iam_role.antifraud_lambda_role.arn
  handler = "com.payments.antifraud.Handler"
  source_code_hash = filebase64sha256("../../lambda/antifraud-engine.zip")
  runtime = "java17"
  timeout = 30
  memory_size = 512
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.fraud_detection_table
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "antifraud-engine-${var.environment}"
    Component = "antifraud"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "settlement_engine" {
  filename = "../../lambda/settlement-engine.zip"
  function_name = "settlement-engine-${var.environment}"
  role = aws_iam_role.settlement_lambda_role.arn
  handler = "com.payments.settlement.Handler"
  source_code_hash = filebase64sha256("../../lambda/settlement-engine.zip")
  runtime = "java17"
  timeout = 300
  memory_size = 1024
  ephemeral_storage = {
    size = 1024
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.settlement_table
      RDS_ENDPOINT = var.rds_endpoint
      SETTLEMENT_QUEUE_URL = "https://sqs.${var.aws_region}.amazonaws.com/${var.account_id}/${var.environment}-settlement-queue"
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "settlement-engine-${var.environment}"
    Component = "settlement"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "payment_processor" {
  filename = "../../lambda/payment-processor.zip"
  function_name = "payment-processor-${var.environment}"
  role = aws_iam_role.lambda_execution_role.arn
  handler = "com.payments.processor.Handler"
  source_code_hash = filebase64sha256("../../lambda/payment-processor.zip")
  runtime = "java17"
  timeout = 60
  memory_size = 1024
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      ANTIFRAUD_FUNCTION_NAME = aws_lambda_function.antifraud_engine.function_name
      SETTLEMENT_FUNCTION_NAME = aws_lambda_function.settlement_engine.function_name
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
      TRANSACTION_TABLE = var.transaction_table
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "payment-processor-${var.environment}"
    Component = "payment-processor"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "risk_scoring" {
  filename = "../../lambda/risk-scoring.zip"
  function_name = "risk-scoring-${var.environment}"
  role = aws_iam_role.antifraud_lambda_role.arn
  handler = "com.payments.risk.Handler"
  source_code_hash = filebase64sha256("../../lambda/risk-scoring.zip")
  runtime = "java17"
  timeout = 45
  memory_size = 512
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.fraud_detection_table
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
      RISK_THRESHOLD = "0.75"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "risk-scoring-${var.environment}"
    Component = "risk-scoring"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_permission" "allow_alb_invoke_antifraud" {
  statement_id = "AllowExecutionFromALB"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.antifraud_engine.function_name
  principal = "elasticloadbalancing.amazonaws.com"
  source_arn = "arn:aws:elasticloadbalancing:${var.aws_region}:${var.account_id}:targetgroup/*/*"
}

resource "aws_lambda_permission" "allow_api_gateway_invoke_processor" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payment_processor.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:*/*"
}

resource "aws_lambda_event_source_mapping" "settlement_queue_mapping" {
  event_source_arn = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.environment}-settlement-queue"
  function_name = aws_lambda_function.settlement_engine.function_name
  batch_size = 10
  maximum_record_age_in_seconds = 300
  bisect_batch_on_function_error = true
  destination_config {
    on_failure {
      destination_arn = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.environment}-settlement-dlq"
    }
  }
}

resource "aws_lambda_alias" "antifraud_production" {
  name = "production"
  function_name = aws_lambda_function.antifraud_engine.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_alias" "settlement_production" {
  name = "production"
  function_name = aws_lambda_function.settlement_engine.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_provisioned_concurrency_config" "antifraud_provisioned" {
  function_name = aws_lambda_function.antifraud_engine.function_name
  qualifier = aws_lambda_alias.antifraud_production.name
  provisioned_concurrent_executions = 5
}

resource "aws_cloudwatch_log_group" "antifraud_logs" {
  name = "/aws/lambda/${aws_lambda_function.antifraud_engine.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "antifraud-logs-${var.environment}" })
}

resource "aws_cloudwatch_log_group" "settlement_logs" {
  name = "/aws/lambda/${aws_lambda_function.settlement_engine.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "settlement-logs-${var.environment}" })
}

resource "aws_cloudwatch_log_group" "payment_processor_logs" {
  name = "/aws/lambda/${aws_lambda_function.payment_processor.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "payment-processor-logs-${var.environment}" })
}