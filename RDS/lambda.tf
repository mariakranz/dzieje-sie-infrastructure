resource "aws_lambda_function" "cloudwatch_to_discord" {
  function_name    = "cloudwatch_to_discord"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "webhook.lambda_handler"
  runtime          = "python3.10"
  filename         = "../Scripts/webhook.zip"
  source_code_hash = filebase64sha256("../Scripts/webhook.zip")
}

resource "aws_lambda_permission" "sns_invoke_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_to_discord.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.rds_alarms_topic.arn
}