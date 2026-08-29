#!/bin/bash
# Hook: Scan staged files for secrets before commit
# Catches AWS keys, generic tokens, passwords in code

STAGED=$(git diff --cached --name-only --diff-filter=ACM)

if [[ -z "$STAGED" ]]; then
  exit 0
fi

FINDINGS=0

for FILE in $STAGED; do
  # Skip binary files
  if file "$FILE" | grep -q "binary"; then
    continue
  fi

  CONTENT=$(git show ":$FILE" 2>/dev/null)

  # AWS access key (AKIA...)
  if echo "$CONTENT" | grep -qE 'AKIA[0-9A-Z]{16}'; then
    echo "SECRET: AWS access key found in $FILE"
    FINDINGS=$((FINDINGS + 1))
  fi

  # AWS secret key pattern (40-char base64 after common assignments)
  if echo "$CONTENT" | grep -qE '(aws_secret|secret_key|SECRET_KEY)\s*[=:]\s*["\x27]?[A-Za-z0-9/+=]{40}'; then
    echo "SECRET: Possible AWS secret key in $FILE"
    FINDINGS=$((FINDINGS + 1))
  fi

  # Generic high-entropy tokens (API keys, bearer tokens)
  if echo "$CONTENT" | grep -qiE '(api[_-]?key|bearer|token|password|secret)\s*[=:]\s*["\x27][A-Za-z0-9_\-]{20,}'; then
    # Exclude common false positives
    if ! echo "$CONTENT" | grep -qE '(example|placeholder|changeme|your-|TODO|xxx)'; then
      echo "SECRET: Possible token/password in $FILE"
      FINDINGS=$((FINDINGS + 1))
    fi
  fi

  # Private keys
  if echo "$CONTENT" | grep -q 'BEGIN.*PRIVATE KEY'; then
    echo "SECRET: Private key found in $FILE"
    FINDINGS=$((FINDINGS + 1))
  fi
done

if [[ $FINDINGS -gt 0 ]]; then
  echo ""
  echo "BLOCKED: $FINDINGS potential secret(s) found in staged files"
  echo "If these are false positives, commit with --no-verify (not recommended)"
  exit 1
fi

exit 0
