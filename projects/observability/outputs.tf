output "action_group_id" {
  value       = azurerm_monitor_action_group.portfolio.id
  description = "Action group receiving operational alerts."
}

output "error_alert_id" {
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.api_errors.id
  description = "Scheduled-query alert resource ID."
}
