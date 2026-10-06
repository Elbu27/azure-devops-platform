# Runbook: elevated API errors

**Trigger:** `alert-container-api-errors` reports more than five error-like log lines in five minutes.

## Triage

1. Acknowledge the alert and record the UTC start time.
2. Confirm customer impact by calling `/healthz` and `/readyz`.
3. Run `queries/error-rate.kql`, then `queries/revision-health.kql` in Log Analytics.
4. In Azure Container Apps, compare the current revision with the last known good revision.
5. Check Azure Activity Log for deployments or configuration changes near the start time.
6. Do not paste secrets, tokens, or customer data into the incident notes.

## Mitigation

- If a new image caused the issue, direct traffic to the previous healthy revision or redeploy the last known image digest.
- If configuration is missing, restore it from the approved source; do not hot-fix secrets into source code.
- If Azure is degraded, document the platform status and apply the agreed communication cadence.

## Verification

1. `/healthz` and `/readyz` return HTTP 200.
2. Error volume remains below threshold for two evaluation periods.
3. Record the recovery time, image digest, and commands used.
4. Close the alert and schedule a blameless postmortem within two business days.

## Escalation

Escalate after 15 minutes without diagnosis or immediately for suspected credential exposure, data loss, or a broad Azure outage.
