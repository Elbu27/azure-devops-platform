# Azure DevOps Portfolio Projects

Three connected, junior-level cloud and DevOps projects that demonstrate the path from infrastructure provisioning to application delivery and production operations.

> This repository is designed as a learning portfolio. It is deployable, but Azure resources may incur charges. Review [cost controls](docs/COSTS.md) and always run `terraform destroy` after a lab.

## What this demonstrates

- Azure infrastructure as code with Terraform
- Linux containers, health probes, non-root execution, and local Compose
- GitHub Actions CI/CD with Azure OIDC instead of long-lived credentials
- Managed identities and least-privilege Azure RBAC
- Azure Monitor, Log Analytics, KQL, alerting, SLOs, runbooks, and postmortems
- Automated tests, linting, secret scanning, image scanning, and documentation

## Projects

| Project | Evidence | Key technologies |
|---|---|---|
| [1. Azure platform](projects/azure-platform) | Reproducible resources, identity, RBAC, networking, outputs, teardown | Terraform, Azure Container Apps, ACR, Key Vault, VNet, Log Analytics |
| [2. Container API and CI/CD](projects/container-api) | Tested API, hardened image, CI and OIDC deployment | Python, Flask, Docker, GitHub Actions, Trivy |
| [3. Observability and operations](projects/observability) | KQL, alert-as-code, workbook, SLO, runbook, postmortem | Azure Monitor, KQL, Terraform, incident response |

## Architecture

```mermaid
flowchart LR
  Developer[Developer] --> GitHub[GitHubRepository]
  GitHub --> CI[CIQualityAndSecurity]
  CI --> OIDC[GitHubOIDC]
  OIDC --> ACR[AzureContainerRegistry]
  OIDC --> App[AzureContainerApp]
  App --> Identity[ManagedIdentity]
  Identity --> ACR
  Identity --> KV[KeyVault]
  App --> Logs[LogAnalytics]
  Logs --> Alert[AzureMonitorAlert]
  Alert --> Operator[OperatorRunbook]
```

See [the detailed architecture](docs/ARCHITECTURE.md) and [security decisions](docs/SECURITY.md).

## Local quick start

Requirements: Python 3.12+, Docker (optional), Terraform 1.5+ for infrastructure validation.

```bash
make setup
make lint
make test

docker compose -f projects/container-api/compose.yaml up --build
curl http://localhost:8080/healthz
```

Run all available checks with `make check`. Terraform deployment is optional; each project README provides focused instructions.

## Azure deployment order

1. Deploy `projects/azure-platform` with a copied, untracked `terraform.tfvars`.
2. Configure GitHub-to-Azure OIDC using [docs/OIDC-SETUP.md](docs/OIDC-SETUP.md).
3. Run the deployment workflow to build and release the API.
4. Deploy `projects/observability` using the platform workspace output.
5. Exercise an incident with the runbook, then destroy both Terraform stacks.

No real credentials, subscription IDs, email addresses, or secrets belong in Git. Placeholder values are deliberately used throughout.

## Recruiter summary

This portfolio shows practical junior cloud/DevOps skills: converting requirements into tagged Azure resources, building a secure delivery pipeline, troubleshooting from logs and metrics, and documenting both normal operation and failure recovery. See [interview talking points](docs/INTERVIEW.md) for concise explanations and résumé bullets.

## Status and limitations

Local checks are automated. Live Azure deployment is not performed automatically because it requires the owner's subscription, budget approval, OIDC trust, and contact details. The repository documents those steps explicitly so they can be reproduced safely.
