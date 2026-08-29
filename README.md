# Claude Code DevOps Kit

Skills, hooks, and MCP patterns for DevOps workflows with Claude Code. Terraform, Kubernetes, IAM, incident response, and CI/CD — with safety guardrails built in.

## Quick Start

```bash
# Option 1: Symlink into your Claude Code config
ln -s $(pwd)/skills ~/.claude/skills
ln -s $(pwd)/hooks ~/.claude/hooks

# Option 2: Copy into a project
cp -r skills/ your-project/.claude/skills/
cp -r hooks/ your-project/.claude/hooks/
```

## Skills

| Skill | Trigger | What it does |
|-------|---------|-------------|
| `tf-plan` | `/tf-plan` | Run terraform plan with formatted change summary |
| `tf-apply` | `/tf-apply` | Apply with safety checks and confirmation |
| `tf-validate` | `/tf-validate` | Format + validate terraform configuration |
| `tf-pr` | `/tf-pr` | Generate PR description from terraform changes |
| `tf-import` | `/tf-import` | Import existing resources into state |
| `k8s-manifest-review` | `/k8s-review` | Review K8s manifests against production baseline |
| `iam-least-privilege` | `/iam-audit` | Audit IAM policies for overly broad permissions |
| `incident-runbook` | `/incident` | Generate structured incident response from alert |
| `pr-description` | `/pr-desc` | Generate PR description from diff |

## Hooks

| Hook | Type | What it does |
|------|------|-------------|
| `dangerous-apply-guard` | PreToolUse | Blocks `terraform apply`/`kubectl apply` on production contexts |
| `secret-scanner` | PreCommit | Scans staged files for AWS keys, tokens, private keys |
| `conventional-commits` | PreCommit | Enforces `type(scope): description` commit format |
| `tf-validate` | PostToolUse | Auto-formats and validates `.tf` files after edits |
| `tf-check` | PreCommit | Blocks commits with invalid terraform |

## MCP Integration

See `mcp/mcp-config-example.json` for GitHub + AWS tool integration setup.

## Structure

```
skills/           9 DevOps skills (5 Terraform + 4 general)
hooks/            5 safety hooks (pre-commit, pre-tool-use, post-tool-use)
mcp/              MCP server configuration examples
docs/             Architecture diagram and decision records
```

## Documentation

- [Architecture](docs/architecture.md) — how skills, hooks, and MCP compose
- [Decisions](docs/DECISIONS.md) — why these specific tools and patterns

## License

Apache-2.0
