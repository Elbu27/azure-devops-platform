# Azure cost controls

This project is cost-aware, not guaranteed free. Azure prices vary by region and account.

- Container Apps scales to zero and caps at two replicas.
- Azure Container Registry uses the Basic tier.
- Log Analytics retention is 30 days, with a 0.5 GB daily ingestion cap.
- Key Vault uses Standard tier; networking remains public for a cheaper learning deployment.
- Resource tags make the lab easy to identify.

Before deploying, check the Azure Pricing Calculator and set a real subscription or resource-group budget in Azure Cost Management. The Terraform `monthly_budget_amount` output is only a visible guardrail, not an enforced budget, because Azure budget scope and contact configuration are account-specific.

Destroy in reverse order:

```bash
terraform -chdir=projects/observability destroy
terraform -chdir=projects/azure-platform destroy
```

Then verify the resource group is gone and check Cost Management for residual storage, registry, or log charges. Key Vault purge protection can retain the deleted vault name without continuing normal vault usage charges.
