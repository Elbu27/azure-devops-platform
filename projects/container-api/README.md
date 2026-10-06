# Project 2: Container API and CI/CD

A small production-style Flask API packaged as a non-root container. It demonstrates testing, container hardening, health probes, image scanning, and deployment automation.

## Run locally

```bash
python3 -m venv .venv
.venv/bin/pip install -r projects/container-api/requirements-dev.txt
PYTHONPATH=projects/container-api .venv/bin/pytest projects/container-api/tests

docker compose -f projects/container-api/compose.yaml up --build
curl http://localhost:8080/healthz
```

## Endpoints

- `GET /` — service metadata
- `GET /healthz` — liveness
- `GET /readyz` — readiness

## CI/CD

`ci.yml` runs linting, tests, Terraform validation, secret scanning, and a Trivy filesystem scan. `deploy.yml` uses GitHub OIDC federation, builds an immutable image in Azure Container Registry, and updates Azure Container Apps. No long-lived Azure password is stored in GitHub.

Required GitHub variables after infrastructure deployment: `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AZURE_RESOURCE_GROUP`, `AZURE_CONTAINER_APP`, and `AZURE_ACR_NAME`.
