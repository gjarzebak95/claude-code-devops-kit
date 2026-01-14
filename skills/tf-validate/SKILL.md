---
name: tf-validate
description: Validate terraform (format + validate)
triggers:
  - /tf-validate
  - validate terraform
  - check tf config
  - terraform lint
---

# Terraform Validate

Comprehensive validation: format check, syntax validation.

## Workflow

1. `terraform fmt -check -recursive` (auto-fix if needed)
2. `terraform init -backend=false` (if not initialized)
3. `terraform validate`

## Usage

```
/tf-validate                  # Validate current directory
/tf-validate modules/vpc      # Validate specific module
```
