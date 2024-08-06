output "cloudwatch_alarm_arns" {
  description = "The ARNs of the cloudwatch metric alarms."
  value       = [for alarm in module.alarms : alarm["cloudwatch_metric_alarm_arn"]]
}