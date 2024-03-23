# Create an SNS topic for alarm notifications
resource "aws_sns_topic" "rds_alarms_topic" {
  name = "rds-alarms-topic"
}


# RDS Instance Status Alarm
resource "aws_cloudwatch_metric_alarm" "rds_status_alarm" {
  alarm_name          = "rds-mysql-instance-status"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "DBInstanceStatus"
  namespace           = "AWS/RDS"
  period              = 60 # 1 minute
  statistic           = "Average"
  threshold           = 0 # 0 indicates the instance is down
  alarm_description   = "RDS MySQL Instance Status Alarm"
  alarm_actions       = [aws_sns_topic.rds_alarms_topic.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.myinstance.id
  }
}   

# CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "rds-mysql-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60 # 5 minutes
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "RDS MySQL CPU Utilization High"
  alarm_actions       = [aws_sns_topic.rds_alarms_topic.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.myinstance.id
  }
}

# Memory Usage Alarm
resource "aws_cloudwatch_metric_alarm" "memory_usage_alarm" {
  alarm_name          = "rds-mysql-memory-usage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60 # 5 minutes
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "RDS MySQL Memory Usage High"
  alarm_actions       = [aws_sns_topic.rds_alarms_topic.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.myinstance.id
  }
}

# Database Errors Alarm
resource "aws_cloudwatch_metric_alarm" "db_errors_alarm" {
  alarm_name          = "rds-mysql-database-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DatabaseErrors"
  namespace           = "AWS/RDS"
  period              = 300 # 5 minutes
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "RDS MySQL Database Errors"
  alarm_actions       = [aws_sns_topic.rds_alarms_topic.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.myinstance.id
  }
}

# Create an SNS subscription to Discord Webhook 
resource "aws_sns_topic_subscription" "discord_subscription" {
  topic_arn = aws_sns_topic.rds_alarms_topic.arn
  protocol  = "https"
  endpoint  = var.discord_webhook_url
}
