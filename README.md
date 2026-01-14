# Claude Code Configuration

Custom skills, hooks, and continuity system for terraform workflows.

Inspired by [Continuous-Claude-v3](https://github.com/parcadei/Continuous-Claude-v3).

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| `/tf-plan` | `terraform plan` | Run plan with formatted output |
| `/tf-apply` | `terraform apply` | Apply with safety checks |
| `/tf-validate` | `validate terraform` | Format + validate |
| `/tf-pr` | `create terraform pr` | PR with plan summary |
| `/tf-import` | `terraform import` | Import existing resources |

## Hooks

### PostToolUse
- **tf-validate.sh**: Auto-format and validate after .tf file edits

### PreCommit
- **tf-check.sh**: Block commits with invalid terraform

## Setup

### Option 1: Symlink to ~/.claude
```bash
ln -s $(pwd)/skills ~/.claude/skills
ln -s $(pwd)/hooks ~/.claude/hooks
ln -s $(pwd)/settings.json ~/.claude/settings.json
```

### Option 2: Copy to project
```bash
cp -r skills/ your-project/.claude/skills/
cp -r hooks/ your-project/.claude/hooks/
```

## Continuity System

### Ledgers
Track within-session progress in `thoughts/ledgers/CONTINUITY_*.md`:

```markdown
## Goal
Implement VPC module with proper subnets

## Completed
- [x] Created VPC resource
- [x] Added public subnets

## In Progress
- [ ] Add private subnets
- [ ] Configure NAT gateway
```

### Handoffs
Transfer knowledge between sessions in `thoughts/shared/handoffs/<date>.yaml`:

```yaml
session_id: 2025-01-14-terraform-vpc
completed:
  - VPC module scaffolding
  - Public subnet configuration
next_steps:
  - Add private subnets
  - Configure route tables
decisions:
  - Using 3 AZs for high availability
  - CIDR: 10.0.0.0/16
blockers: []
```

## Directory Structure

```
claude-code-config/
├── skills/
│   ├── tf-plan/SKILL.md
│   ├── tf-apply/SKILL.md
│   ├── tf-validate/SKILL.md
│   ├── tf-pr/SKILL.md
│   └── tf-import/SKILL.md
├── hooks/
│   ├── post-tool-use/tf-validate.sh
│   └── pre-commit/tf-check.sh
├── thoughts/
│   ├── ledgers/
│   └── shared/handoffs/
├── settings.json
└── README.md
```
