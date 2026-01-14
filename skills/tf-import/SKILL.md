---
name: tf-import
description: Import existing AWS resources into terraform state
triggers:
  - /tf-import
  - terraform import
  - import resource
  - import existing
---

# Terraform Import

Import existing AWS resources into terraform state.

## Workflow

1. Identify resource to import (type + ID)
2. Create terraform resource block
3. Run `terraform import <address> <id>`
4. Run `terraform plan` to verify
5. Adjust configuration to match actual state

## Common Import Commands

```bash
# EC2 Instance
terraform import aws_instance.example i-1234567890abcdef0

# S3 Bucket
terraform import aws_s3_bucket.example bucket-name

# IAM Role
terraform import aws_iam_role.example role-name

# Security Group
terraform import aws_security_group.example sg-1234567890abcdef0
```

## Usage

```
/tf-import aws_s3_bucket.logs my-logs-bucket
/tf-import                    # Interactive mode
```
