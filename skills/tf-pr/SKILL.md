---
name: tf-pr
description: Create PR with terraform changes
triggers:
  - /tf-pr
  - create terraform pr
  - pr for terraform
---

# Terraform PR

Create a pull request with terraform changes.

## Workflow

1. Validate all terraform files
2. Run `terraform plan` to capture changes
3. Create branch if not on feature branch
4. Commit changes with descriptive message
5. Push and create PR with plan summary

## PR Template

```markdown
## Terraform Changes

### Summary
[Auto-generated from plan]

### Resources
- X to add
- Y to change
- Z to destroy

### Plan Output
<details>
<summary>Show Plan</summary>
[full plan]
</details>

### Checklist
- [ ] Plan reviewed
- [ ] No secrets in code
- [ ] State file considerations
```

## Usage

```
/tf-pr                        # Create PR for current changes
/tf-pr "Add new VPC module"   # With custom title
```
