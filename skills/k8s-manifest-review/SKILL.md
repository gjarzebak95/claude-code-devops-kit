---
name: k8s-manifest-review
description: Review Kubernetes manifests against production baseline
triggers:
  - /k8s-review
  - review kubernetes
  - check k8s manifest
  - validate deployment
---

# Kubernetes Manifest Review

Review K8s manifests for production readiness gaps.

## Checklist

For each Deployment/StatefulSet/DaemonSet found:

1. **Probes** — readinessProbe AND livenessProbe defined. initialDelaySeconds set. Liveness != readiness (different endpoints or thresholds).
2. **Resources** — requests AND limits set for CPU and memory. Limits >= requests. No unbounded containers.
3. **Security context** — runAsNonRoot: true, readOnlyRootFilesystem: true, allowPrivilegeEscalation: false, drop ALL capabilities.
4. **Replicas** — minReplicas >= 2 for any user-facing service. PodDisruptionBudget exists.
5. **Image** — pinned tag (not :latest), from approved registry if org policy exists.
6. **Labels** — app.kubernetes.io/name, app.kubernetes.io/version, app.kubernetes.io/managed-by present.
7. **NetworkPolicy** — exists for the namespace. Default deny ingress with explicit allowlist.
8. **Topology** — topologySpreadConstraints or pod anti-affinity for multi-replica workloads.
9. **Graceful shutdown** — terminationGracePeriodSeconds > 0, preStop hook if needed.

## Output

Table: resource name | check | status (PASS/WARN/FAIL) | detail.
Summary line: X passed, Y warnings, Z failures.
