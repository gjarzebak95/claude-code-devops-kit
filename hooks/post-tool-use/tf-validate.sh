#!/bin/bash
# Hook: Auto-validate terraform after .tf file edits
# Triggered by: PostToolUse on Edit/Write to *.tf files

FILE="$1"

# Only run for .tf files
if [[ "$FILE" != *.tf ]]; then
  exit 0
fi

DIR=$(dirname "$FILE")

# Check if terraform is initialized
if [[ ! -d "$DIR/.terraform" ]]; then
  echo "⚠️  Terraform not initialized in $DIR"
  exit 0
fi

# Run format check
echo "🔍 Checking terraform format..."
if ! terraform -chdir="$DIR" fmt -check "$FILE" 2>/dev/null; then
  echo "📝 Auto-formatting $FILE..."
  terraform -chdir="$DIR" fmt "$FILE"
fi

# Run validate
echo "✅ Validating terraform configuration..."
terraform -chdir="$DIR" validate -no-color 2>&1 | head -5

exit 0
