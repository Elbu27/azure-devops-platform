# Interview talking points

## Two-minute walkthrough

“I built three connected Azure DevOps projects. Terraform creates a tagged platform with networking, Container Registry, Container Apps, Key Vault, managed identity, RBAC, and Log Analytics. A tested non-root Python container moves through GitHub Actions, where linting, tests, IaC validation, and security scans run before an OIDC-based deployment. Azure Monitor KQL, an alert, an SLO, a runbook, and a postmortem demonstrate how I would operate the service, not only deploy it.”

## Trade-offs to explain

- Public endpoints keep the learning lab affordable; production would use private endpoints and VNet integration.
- Scale-to-zero saves cost but introduces cold-start latency.
- Multiple revisions enable rollback but should be cleaned up through retention policy/operations.
- Local Terraform state is approachable for a solo lab; teams need encrypted remote state with RBAC and locking.
- A simple stateless API focuses the project on cloud operations rather than application complexity.

## Résumé-ready bullets

- Provisioned a repeatable Azure platform with Terraform, including Container Apps, ACR, Key Vault, Log Analytics, networking, managed identity, and least-privilege RBAC.
- Built a GitHub Actions pipeline that linted, tested, validated, and scanned a containerized Python API before deploying through secretless Azure OIDC authentication.
- Created KQL dashboards and alert-as-code plus an SLO, incident runbook, rollback workflow, and blameless postmortem to demonstrate operational readiness.

Replace these with measured results after a real deployment, such as pipeline duration, recovery time, or monthly lab cost. Never invent metrics.
