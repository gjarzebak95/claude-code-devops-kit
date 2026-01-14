---
name: tf-plan
description: Run terraform plan with formatted output
triggers:
  - /tf-plan
  - terraform plan
  - plan changes
  - what will terraform do
---

# Terraform Plan

Run terraform plan and summarize the changes.

## Workflow

1. Validate configuration first
2. Run `terraform plan -out=tfplan`
3. Summarize changes (add/change/destroy)
4. Show key resources affected

## Usage

```
/tf-plan                      # Plan current directory
/tf-plan environments/prod    # Plan specific path
```

## Output

Provides:
- Change summary table (add/change/destroy counts)
- Key resources being modified
- Warnings or errors
- Full plan in collapsible details
