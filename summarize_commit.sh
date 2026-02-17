#!/bin/bash
set -euo pipefail
COMMIT_HASH="${1:-HEAD}"
if ! git rev-parse --verify "$COMMIT_HASH" >/dev/null 2>&1; then
	echo "Error: Invalid commit hash: $COMMIT_HASH" >&2
	exit 1
fi
echo "Analyzing commit: $COMMIT_HASH"
echo "Getting diff..."
DIFF=$(git show --no-color "$COMMIT_HASH")
response=$(opencode run "You are a senior software engineer.
Analyze this git commit and explain the changes.
COMMIT INFO:
$(git log -1 --oneline "$COMMIT_HASH")
DIFF:
$DIFF
Summarize:
- High level purpose
- Key logic changes
Keep it concise and technical.")
echo ""
echo "---- AI Explanation ----"
echo "$response"
echo "$response" >>~/dairy.txt
