---
name: pr-description
description: Generate PR description from diff with what/why/how/testing/rollback
triggers:
  - /pr-desc
  - write pr description
  - describe this pr
  - generate pr
---

# PR Description Generator

Generate a structured pull request description from the current diff.

## Workflow

1. Run `git diff main...HEAD` (or specified base branch)
2. Analyze: files changed, lines added/removed, types of changes
3. Generate:

```markdown
## What
[One sentence: what this PR does]

## Why
[One sentence: the problem or goal this addresses]

## How
[Bullet list of key implementation choices — not a line-by-line diff narration]

## Testing
- [ ] [How to verify this works — specific steps, not "tested locally"]
- [ ] [Edge cases considered]
- [ ] [Regression check if touching shared code]

## Rollback
[How to undo this if it causes problems — revert commit, feature flag, config change]

## Risk
[Low/Medium/High + one line justifying: blast radius, reversibility, dependency changes]
```

## Rules

- Read the actual diff, don't guess from file names
- "How" section: implementation choices, not a restatement of the diff
- "Testing" section: actionable steps someone else can follow
- "Rollback" section: always present, even if it's just "revert this commit"
- Keep the whole description under one screen
