output "resource_group_name" {
  description = "Resource group containing the portfolio platform."
  value       = azurerm_resource_group.main.name
}

output "container_registry_name" {
  description = "Azure Container Registry name."
  value       = azurerm_container_registry.main.name
}

output "container_app_name" {
  description = "Azure Container App name."
  value       = azurerm_container_app.api.name
}

output "container_app_url" {
  description = "Public API URL."
  value       = "https://${azurerm_container_app.api.latest_revision_fqdn}"
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID for the observability project."
  value       = azurerm_log_analytics_workspace.main.id
}

output "key_vault_name" {
  description = "Key Vault name; no secrets are created by this example."
  value       = azurerm_key_vault.main.name
}

output "estimated_budget_guardrail" {
  description = "User-defined monthly spending guardrail; configure a real Azure budget separately."
  value       = var.monthly_budget_amount
}
