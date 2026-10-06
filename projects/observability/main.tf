resource "azurerm_monitor_action_group" "portfolio" {
  name                = "ag-cloud-portfolio"
  resource_group_name = var.resource_group_name
  short_name          = "cloudops"
  tags                = var.tags

  email_receiver {
    name          = "portfolio-owner"
    email_address = var.alert_email
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "api_errors" {
  name                 = "alert-container-api-errors"
  resource_group_name  = var.resource_group_name
  location             = var.location
  scopes               = [var.log_analytics_workspace_id]
  description          = "More than five error log entries from the container API in five minutes."
  severity             = 2
  enabled              = true
  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"
  tags                 = var.tags

  criteria {
    query                   = <<-KQL
      ContainerAppConsoleLogs_CL
      | where TimeGenerated > ago(5m)
      | where Log_s has_any ("ERROR", "Exception", "status=500")
    KQL
    time_aggregation_method = "Count"
    threshold               = 5
    operator                = "GreaterThan"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.portfolio.id]
  }
}
