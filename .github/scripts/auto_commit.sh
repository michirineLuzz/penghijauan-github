#!/usr/bin/env bash
set -euo pipefail

# Auto-commit script for GitHub Actions
# - stages all changes
# - commits with a timestamp and [skip ci]
# - pushes using existing credentials (GITHUB_TOKEN via actions/checkout)

cd "$(git rev-parse --show-toplevel)"

git add -A

# If there are no staged changes, exit cleanly
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
MSG="chore: auto-commit ${TS} [skip ci]"

git commit -m "$MSG" || true

# Push to the current branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

git push origin "${BRANCH}"

echo "Auto-commit pushed on branch ${BRANCH}"
