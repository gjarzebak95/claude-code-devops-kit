# Decisions

## Why skills over scripts

Skills are declarative checklists that guide an AI agent through a workflow. Scripts automate a fixed sequence. The distinction matters because DevOps decisions require context — a skill tells the agent WHAT to check and WHY, letting it adapt to the specific codebase. A script either passes or fails with no judgment.

## Why hook-based guards over CI-only

Hooks fire at the point of action — before a dangerous command runs, before a commit includes a secret. CI catches problems after they're pushed. Both are needed, but hooks are the first line of defence. A secret caught in CI has already been in git history; a secret caught by a pre-commit hook never enters the repo.

## Why these 9 skills

Each maps to a category of mistake that costs real time in production DevOps:

| Skill | Prevents |
|-------|----------|
| tf-plan/apply/validate/import/pr | Unreviewed infrastructure changes |
| k8s-manifest-review | Deploying containers without probes, limits, or security context |
| iam-least-privilege | Overly broad IAM policies that become security incidents |
| incident-runbook | Unstructured incident response that extends MTTR |
| pr-description | PRs merged without context, making future debugging harder |

## Why MCP over custom tool integrations

MCP provides a standard protocol for tool use. Building custom integrations per-tool creates maintenance burden and coupling. MCP servers are composable — add GitHub, AWS, or Slack without changing the agent's code.

## Why conventional commits

Structured commit messages enable automated changelogs, semantic versioning, and readable git history. The hook enforces the format at commit time rather than relying on PR review to catch it.
