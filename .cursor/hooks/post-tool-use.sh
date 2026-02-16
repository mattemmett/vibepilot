#!/usr/bin/env bash
# VibePilot PostToolUse Hook
# Captures tool outputs and prompts for progress updates

set -euo pipefail

# Read hook input
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "."')

cd "$CWD"

# Check for active feature
if [[ ! -f .vibe/active-feature ]]; then
  exit 0
fi

ACTIVE_FEATURE=$(cat .vibe/active-feature)

# Track significant operations
case "$TOOL" in
  Write|Edit)
    # File was modified - suggest updating progress
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown"')

    # Don't nag about planning file updates
    if [[ "$FILE_PATH" == *"/planning/"* ]]; then
      exit 0
    fi

    # Log the change
    echo "📝 Modified: $FILE_PATH"
    echo ""
    echo "💡 Consider updating features/$ACTIVE_FEATURE/planning/PROGRESS.md if this completes a milestone."
    ;;

  Bash)
    # Command execution - check for test runs, builds, etc
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

    # Log significant commands
    if echo "$COMMAND" | grep -qE "test|build|npm|yarn|make"; then
      echo "⚙️ Ran: $(echo "$COMMAND" | cut -c1-60)..."
      echo ""
      echo "💡 Log results in features/$ACTIVE_FEATURE/planning/PROGRESS.md if relevant."
    fi
    ;;
esac

exit 0
