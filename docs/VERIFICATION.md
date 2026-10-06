# Verification record

Run these checks before presenting or publishing the portfolio:

```bash
make lint
make format-check
make test
terraform -chdir=projects/azure-platform fmt -check -recursive
terraform -chdir=projects/azure-platform init -backend=false
terraform -chdir=projects/azure-platform validate
terraform -chdir=projects/observability fmt -check -recursive
terraform -chdir=projects/observability init -backend=false
terraform -chdir=projects/observability validate
docker build -t cloud-status-api:test projects/container-api
```

## Local result

- Python lint, format, four unit tests, and a live Gunicorn health smoke test: passed.
- Both Terraform configurations: initialized and validated with pinned provider locks.
- Workbook JSON, local Markdown links, and GitHub workflows: checked; Actionlint passed.
- Dependency audit: no known vulnerabilities after upgrading Flask to 3.1.3.
- Secret scan: no findings outside ignored local tool caches.
- Container build: Dockerfile is present and CI-ready; local execution requires the Docker daemon to be running.
- Live Azure plan/apply and smoke test: intentionally pending owner subscription, cost approval, OIDC configuration, and deployment approval.

A live deployment is not necessary to review the source, but deployment screenshots and measured results should be added after the owner completes the lab. Never claim Azure resources were deployed when they were not.
