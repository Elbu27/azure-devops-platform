# Project 3: Azure Observability and Incident Response

I created this operations layer with KQL, alert-as-code, an Azure Workbook starter, SLOs, a runbook, and a blameless postmortem.

## Deploy alerts

Deploy the platform project first, copy its workspace output into `terraform.tfvars`, then:

```bash
cd projects/observability
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

`alert_email` is sensitive in Terraform output, but plain `.tfvars` files must still remain uncommitted. For automation, provide it through `TF_VAR_alert_email` from a protected secret.

## Use the queries

Open **Azure Portal > Log Analytics workspace > Logs** and paste a query from `queries/`. Container Apps console logs use `ContainerAppConsoleLogs_CL`. Table availability depends on successful diagnostic ingestion.

Import `workbook-template.json` as a workbook template after replacing its placeholder workspace resource ID. The supplied dashboard is intentionally a starter: a real service should add request duration and distributed traces through OpenTelemetry/Application Insights.

## Operational evidence

- `SLO.md` defines measurable targets and an error budget.
- `RUNBOOK.md` gives repeatable detection, mitigation, verification, and escalation steps.
- `POSTMORTEM-example.md` demonstrates blameless incident learning.
