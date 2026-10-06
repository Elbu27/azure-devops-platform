# Interview talking points

## Two-minute walkthrough

“I built one end-to-end Azure DevOps platform with three connected parts. I wrote Terraform for a tagged platform with networking, Container Registry, Container Apps, Key Vault, managed identity, RBAC, and Log Analytics. I developed and tested a non-root Python container and created GitHub Actions workflows for linting, tests, IaC validation, security scans, and an OIDC-based deployment. I also wrote Azure Monitor KQL, an alert, an SLO, a runbook, and a postmortem to demonstrate how I would operate the service, not only deploy it. I validated the project locally; the live Azure deployment is the next step.”

## Trade-offs to explain

- Public endpoints keep the learning lab affordable; production would use private endpoints and VNet integration.
- Scale-to-zero saves cost but introduces cold-start latency.
- Multiple revisions enable rollback but should be cleaned up through retention policy/operations.
- Local Terraform state is approachable for a solo lab; teams need encrypted remote state with RBAC and locking.
- A simple stateless API focuses the project on cloud operations rather than application complexity.

## Résumé-ready bullets

- Developed and locally validated Terraform for a repeatable Azure platform using Container Apps, ACR, Key Vault, Log Analytics, networking, managed identity, and least-privilege RBAC.
- Built a GitHub Actions pipeline that lints, tests, validates, and scans a containerized Python API and is ready to deploy through secretless Azure OIDC authentication.
- Created KQL queries and alert-as-code plus an SLO, incident runbook, rollback workflow, and blameless postmortem to demonstrate operational readiness.

Replace these with measured results after a real deployment, such as pipeline duration, recovery time, or monthly lab cost. Never invent metrics.
