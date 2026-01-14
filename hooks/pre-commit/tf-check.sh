#!/bin/bash
# Hook: Pre-commit validation for terraform files
# Blocks commit if terraform validation fails

# Find all staged .tf files
STAGED_TF=$(git diff --cached --name-only --diff-filter=ACM | grep '\.tf$')

if [[ -z "$STAGED_TF" ]]; then
  exit 0
fi

echo "🔍 Checking staged terraform files..."

ERRORS=0

for FILE in $STAGED_TF; do
  DIR=$(dirname "$FILE")

  # Format check
  if ! terraform fmt -check "$FILE" 2>/dev/null; then
    echo "❌ Format error: $FILE"
    ERRORS=$((ERRORS + 1))
  fi
done

# Validate each unique directory
DIRS=$(echo "$STAGED_TF" | xargs -n1 dirname | sort -u)

for DIR in $DIRS; do
  if [[ -d "$DIR/.terraform" ]]; then
    if ! terraform -chdir="$DIR" validate -no-color 2>/dev/null; then
      echo "❌ Validation failed in: $DIR"
      ERRORS=$((ERRORS + 1))
    fi
  fi
done

if [[ $ERRORS -gt 0 ]]; then
  echo ""
  echo "⛔ Commit blocked: $ERRORS terraform error(s)"
  echo "   Run: terraform fmt -recursive && terraform validate"
  exit 1
fi

echo "✅ Terraform validation passed"
exit 0
