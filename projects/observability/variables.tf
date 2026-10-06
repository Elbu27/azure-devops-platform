variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group created by the platform project."
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
  default     = "uksouth"
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of the platform Log Analytics workspace."
  type        = string
}

variable "alert_email" {
  description = "Email address for portfolio alerts."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to monitoring resources."
  type        = map(string)
  default = {
    project    = "azure-devops-portfolio"
    managed_by = "terraform"
  }
}
