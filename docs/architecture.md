# Architecture

## How skills, hooks, and MCP compose

```mermaid
graph TB
    subgraph "Claude Code Agent"
        A[User Request] --> B{Skill Match?}
        B -->|Yes| C[Skill Workflow]
        B -->|No| D[General Response]
    end

    subgraph "Skills Layer"
        C --> TF[Terraform Skills]
        C --> K8S[K8s Manifest Review]
        C --> IAM[IAM Audit]
        C --> INC[Incident Runbook]
        C --> PR[PR Description]
    end

    subgraph "Hooks Layer"
        E[PreToolUse] --> F[dangerous-apply-guard]
        G[PreCommit] --> H[secret-scanner]
        G --> I[conventional-commits]
        G --> J[tf-check]
        K[PostToolUse] --> L[tf-validate]
    end

    subgraph "MCP Tools"
        M[GitHub MCP] --> N[PR review, issues, code search]
        O[AWS MCP] --> P[Resource queries, cost data]
    end

    C -->|"terraform apply"| E
    C -->|"git commit"| G
    C -->|"edit .tf"| K
    C -->|"gh pr"| M
    C -->|"aws describe"| O
```

## Flow

1. **Request arrives** — user asks to deploy, review, or investigate
2. **Skill matches** — agent loads the relevant skill's checklist and workflow
3. **Hooks guard** — before any tool use, hooks validate safety (no prod apply without confirmation, no secrets in commits)
4. **MCP extends** — when the skill needs external data (GitHub PR context, AWS resource state), MCP servers provide it
5. **Output** — structured response following the skill's output format

## Design principles

- **Skills are checklists, not scripts.** They guide judgment, not replace it.
- **Hooks are guardrails, not gates.** They prevent known-bad patterns, not enforce process.
- **MCP is plumbing, not logic.** It provides data access, not decision-making.
