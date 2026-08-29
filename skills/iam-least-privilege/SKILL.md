---
name: iam-least-privilege
description: Audit IAM policies for overly broad permissions
triggers:
  - /iam-audit
  - review iam
  - check permissions
  - least privilege
---

# IAM Least Privilege Audit

Audit IAM policy documents for overly broad permissions.

## Workflow

1. Find all IAM policy documents in scope (inline policies, managed policies, role trust policies).
2. For each statement, check:

### Red flags (FAIL)
- `"Action": "*"` or `"Action": "iam:*"` — full admin or IAM admin
- `"Resource": "*"` on destructive actions (Delete*, Terminate*, Put*)
- `"Effect": "Allow"` with no Condition on sensitive services (iam, sts, organizations, s3)
- Trust policy allowing AssumeRole from `"AWS": "*"` (any account)
- PassRole with `"Resource": "*"`

### Warnings (WARN)
- Service-level wildcards (`"Action": "s3:*"`, `"Action": "ec2:*"`)
- `"Resource": "*"` on read-only actions (acceptable but worth narrowing)
- Missing condition keys where they'd help (aws:SourceIp, aws:PrincipalOrgID)
- Inline policies (prefer managed for reuse and audit trail)

### Good patterns (PASS)
- Action-level granularity (`s3:GetObject`, `ec2:DescribeInstances`)
- Resource ARN scoping (`arn:aws:s3:::my-bucket/*`)
- Condition keys (aws:RequestedRegion, ec2:ResourceTag)

## Output

Per-policy: policy name | statement index | severity | finding | suggested fix.
Summary: X policies reviewed, Y findings (Z critical).
