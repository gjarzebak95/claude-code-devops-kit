#!/bin/bash
# Hook: Enforce conventional commit format
# Format: type(scope): description
# Types: feat, fix, chore, docs, ci, refactor, test, perf

COMMIT_MSG_FILE="$1"
COMMIT_MSG=$(head -1 "$COMMIT_MSG_FILE")

PATTERN='^(feat|fix|chore|docs|ci|refactor|test|perf)(\([a-z0-9_-]+\))?: .{1,72}$'

if ! echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
  echo "BLOCKED: Commit message doesn't follow conventional format"
  echo ""
  echo "Expected: type(scope): description"
  echo "  Types: feat, fix, chore, docs, ci, refactor, test, perf"
  echo "  Max length: 72 characters"
  echo ""
  echo "Examples:"
  echo "  feat(vpc): add private subnet support"
  echo "  fix: resolve EKS node group scaling"
  echo "  docs: update deployment runbook"
  echo ""
  echo "Got: $COMMIT_MSG"
  exit 1
fi

exit 0
