SHELL := /bin/bash
PYTHON ?= python3
VENV ?= .venv
PIP := $(VENV)/bin/pip
PYTEST := $(VENV)/bin/pytest
RUFF := $(VENV)/bin/ruff

.PHONY: setup test lint format-check terraform-check check
setup:
	$(PYTHON) -m venv $(VENV)
	$(PIP) install -r projects/container-api/requirements-dev.txt

test:
	PYTHONPATH=projects/container-api $(PYTEST) -q projects/container-api/tests

lint:
	$(RUFF) check projects/container-api

format-check:
	$(RUFF) format --check projects/container-api

terraform-check:
	terraform -chdir=projects/azure-platform fmt -check -recursive
	terraform -chdir=projects/azure-platform init -backend=false
	terraform -chdir=projects/azure-platform validate
	terraform -chdir=projects/observability fmt -check -recursive
	terraform -chdir=projects/observability init -backend=false
	terraform -chdir=projects/observability validate

check: lint format-check test terraform-check
