---
name: incident-runbook
description: Generate structured incident response from alert description
triggers:
  - /incident
  - incident response
  - we have an alert
  - pagerduty
  - something is down
---

# Incident Runbook Generator

Generate a structured incident response plan from an alert or problem description.

## Workflow

1. Parse the alert: service name, error type, metrics (latency, error rate, saturation).
2. Classify severity:
   - **P1**: customer-facing outage, data loss risk, security breach
   - **P2**: degraded service, partial outage, elevated error rate
   - **P3**: non-customer-facing, internal tooling, performance degradation
   - **P4**: cosmetic, monitoring gap, tech debt surfaced

3. Generate response plan:

```markdown
## Incident: [title]
**Severity:** P[1-4]
**Blast radius:** [which users/services affected]
**Detection:** [how discovered — alert, customer report, deploy correlation]

### Immediate (first 15 min)
1. [Mitigation step — rollback, scale, circuit break, failover]
2. [Verification — how to confirm mitigation worked]
3. [Communication — who to notify, what channel]

### Investigation
1. [Where to look — logs, metrics, traces, recent deploys]
2. [Key queries — CloudWatch Insights, kubectl, SQL]
3. [Likely root causes ranked by probability]

### Resolution
1. [Fix path — patch, config change, data repair]
2. [Verification — how to confirm resolution]
3. [All-clear criteria — metrics back to baseline for N minutes]

### Post-incident
- [ ] Timeline written
- [ ] Root cause identified
- [ ] Action items logged
- [ ] Monitoring gap closed
```

## Output

Filled-in runbook template. Severity-appropriate urgency — P1 gets "do this NOW", P4 gets "schedule this."
