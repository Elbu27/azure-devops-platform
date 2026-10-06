# Example postmortem: incompatible container port

**Status:** Example only  
**Severity:** SEV-2  
**Duration:** 18 minutes

## Summary

A deployment changed the API container from port 80 to 8080 without updating the Container Apps ingress target. Health requests returned gateway errors until ingress was corrected.

## Impact

The learning API was unavailable for 18 minutes. No data was lost and no secrets were exposed.

## Timeline (UTC)

- 10:02 — Deployment completed.
- 10:07 — Error alert fired.
- 10:10 — On-call confirmed the container was healthy internally but ingress failed.
- 10:16 — Target port updated to 8080.
- 10:20 — Health checks recovered.

## Root cause

The pipeline updated the image but the deployment contract did not test the expected listening port before promotion.

## Corrective actions

- Add a container health check in CI before deployment. **Owner:** DevOps, **Due:** next sprint.
- Keep ingress port configuration in reviewed IaC. **Owner:** Platform, **Due:** next sprint.
- Add a post-deployment smoke test and rollback step. **Owner:** DevOps, **Due:** next sprint.

The purpose of this postmortem is learning and system improvement, not assigning blame.
