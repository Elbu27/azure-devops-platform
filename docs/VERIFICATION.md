# Verification record

I used these commands to validate the project before publishing it:

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

## My local results

- Python lint, format, four unit tests, and a live Gunicorn health smoke test: passed.
- Both Terraform configurations: initialized and validated with pinned provider locks.
- Workbook JSON, local Markdown links, and GitHub workflows: checked; Actionlint passed.
- Dependency audit: no known vulnerabilities after upgrading Flask to 3.1.3.
- Secret scan: no findings outside ignored local tool caches.
- Container build: Dockerfile is present and CI-ready; local execution requires the Docker daemon to be running.
- Live Azure plan/apply and smoke test: intentionally pending my subscription configuration, cost approval, OIDC setup, and deployment approval.

After I complete the Azure deployment, I will add screenshots and measured results such as pipeline duration, recovery time, and lab cost. Until then, this record clearly separates what I validated locally from what remains to be tested in Azure.
