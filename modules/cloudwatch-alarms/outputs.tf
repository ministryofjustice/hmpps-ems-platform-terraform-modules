output "cloudwatch_alarm_arns" {
  description = "The ARNs of the cloudwatch metric alarms."
  value       = module.alarms[*].cloudwatch_metric_alarm_arn
}