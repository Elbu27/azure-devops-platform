# Architecture

## Delivery flow

```mermaid
sequenceDiagram
  participant Dev as Developer
  participant GH as GitHubActions
  participant Azure as AzureOIDC
  participant ACR as ContainerRegistry
  participant ACA as ContainerApp
  participant LAW as LogAnalytics

  Dev->>GH: Push reviewed change
  GH->>GH: Lint test scan validate
  GH->>Azure: Exchange OIDC token
  GH->>ACR: Build immutable SHA image
  GH->>ACA: Deploy new revision
  GH->>ACA: Smoke test health endpoint
  ACA->>LAW: Stream console logs
```

## Boundaries

- GitHub CI runs without Azure credentials; CD receives a short-lived token only after environment approval and OIDC claim validation.
- Azure Container Registry has admin access disabled. The application managed identity receives only `AcrPull` on the registry and `Key Vault Secrets User` on the vault.
- The API stores no state. This keeps rollback and scale-out simple for a junior portfolio while leaving room to discuss stateful design.
- Azure Monitor consumes Container Apps console logs. Queries, alert logic, SLOs, and the response process are version-controlled.

## Repository relationship

The projects are independently reviewable but intentionally connected: platform outputs configure delivery; delivery creates revisions and telemetry; observability turns telemetry into action.
