variable "subscription_id" {
  description = "Azure subscription ID used by the provider."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Short environment name used in resource names and tags."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test, or prod."
  }
}

variable "project_name" {
  description = "Short lowercase project identifier."
  type        = string
  default     = "cloudportfolio"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project_name))
    error_message = "project_name must contain 3-20 lowercase letters, numbers, or hyphens."
  }
}

variable "monthly_budget_amount" {
  description = "Documented monthly cost guardrail in the selected billing currency."
  type        = number
  default     = 25
}

variable "tags" {
  description = "Additional tags merged with the standard project tags."
  type        = map(string)
  default     = {}
}
