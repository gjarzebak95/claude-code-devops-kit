---
name: tf-apply
description: Apply terraform changes with safety checks
triggers:
  - /tf-apply
  - terraform apply
  - apply changes
---

# Terraform Apply

Apply terraform changes with safety checks.

## Workflow

1. Confirm plan exists or run fresh plan
2. Show summary of what will change
3. Request confirmation for destructive changes
4. Apply with `terraform apply tfplan`

## Safety Checks

- Warns if destroying resources
- Confirms before applying to production
- Validates state is not stale

## Usage

```
/tf-apply                     # Apply existing plan
/tf-apply --auto-approve      # Skip confirmation (use carefully)
```
