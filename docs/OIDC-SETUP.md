# GitHub Actions OIDC setup

This is a one-time owner task after creating the GitHub repository. Commands are templates; replace placeholders and review every scope before execution.

1. Create a Microsoft Entra application and service principal.
2. Add a federated credential whose subject is `repo:OWNER/REPOSITORY:environment:dev`.
3. Assign only the permissions needed to build in ACR and update the target Container App. Avoid subscription-wide `Owner`.
4. Create a protected GitHub environment named `dev` with required reviewer approval.
5. Add these non-secret repository/environment variables: `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AZURE_RESOURCE_GROUP`, `AZURE_CONTAINER_APP`, `AZURE_ACR_NAME`, and `AZURE_MANAGED_IDENTITY_ID`.

Example federated credential body:

```json
{
  "name": "github-dev",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:OWNER/REPOSITORY:environment:dev",
  "description": "Deploy approved revisions from GitHub Actions",
  "audiences": ["api://AzureADTokenExchange"]
}
```

The deployment workflow requests `id-token: write`, exchanges the signed GitHub token during `azure/login`, and receives a short-lived Azure token. There is no client secret to rotate or leak.
