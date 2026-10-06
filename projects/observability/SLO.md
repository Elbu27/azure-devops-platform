# Service-level objectives

## User journey

A user calls the public `/healthz` endpoint and receives a successful JSON response.

## Indicators and objectives

- **Availability SLI:** successful health requests / all health requests.
- **Availability SLO:** 99.5% over a rolling 30-day window.
- **Latency SLI:** proportion of API requests completed in under 500 ms.
- **Latency SLO:** 95% under 500 ms over 30 days.
- **Error budget:** 0.5%, approximately 3 hours 39 minutes per 30 days.

This learning environment scales to zero, so cold starts may affect latency. In a production service, measure request duration with Application Insights/OpenTelemetry and tune minimum replicas based on the SLO and cost target.

## Alert strategy

The Terraform example pages on clustered errors rather than individual failures. During an incident, validate impact using the supplied KQL queries before changing the service.
