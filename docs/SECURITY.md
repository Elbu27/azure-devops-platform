# Security decisions

## Implemented controls

- GitHub Actions uses OIDC and explicit minimal workflow permissions.
- ACR admin credentials are disabled; runtime access uses managed identity and scoped RBAC.
- Key Vault uses Azure RBAC, soft delete, and purge protection. No secrets are provisioned in source.
- The container uses a slim pinned base version, runs as an unprivileged user, and is scanned with Trivy.
- CI runs Gitleaks, dependency installation, static linting, tests, and Terraform validation.
- Example `.tfvars` values are fake and real `.tfvars` files are ignored.
- The API returns basic security headers and avoids logging request bodies or credentials.

## Production improvements

For a production workload, use a private ACR endpoint, VNet-integrated Container Apps, Key Vault references, Azure Policy, Defender for Cloud, signed images/SBOM attestations, remote Terraform state, dependency update automation, and separate Azure subscriptions per environment.

## Reporting

Do not open a public issue containing a credential. Revoke the credential, preserve minimal evidence, and notify the repository owner privately.
