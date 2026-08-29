#!/bin/bash
# Hook: Block terraform apply / kubectl apply on production without confirmation
# Type: PreToolUse (fires before Bash commands)

COMMAND="$1"

# Check for dangerous apply commands targeting production
if echo "$COMMAND" | grep -qiE '(terraform\s+apply|kubectl\s+apply|kubectl\s+delete)'; then
  # Check for production context indicators
  if echo "$COMMAND" | grep -qiE '(prod|production|live|main-cluster)'; then
    echo "BLOCKED: Production apply detected"
    echo "Command: $COMMAND"
    echo ""
    echo "To proceed, explicitly confirm by running the command with --auto-approve (terraform)"
    echo "or re-run with the production context explicitly named."
    exit 2
  fi
fi

# Check for destructive terraform commands
if echo "$COMMAND" | grep -qiE 'terraform\s+destroy'; then
  echo "BLOCKED: terraform destroy requires explicit confirmation"
  echo "Command: $COMMAND"
  exit 2
fi

exit 0
