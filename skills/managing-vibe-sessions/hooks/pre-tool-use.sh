#!/usr/bin/env bash
# VibePilot PreToolUse Hook
# Re-reads planning files before significant tool operations

set -euo pipefail

# Read hook input
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "."')

cd "$CWD"

# Only act on tools that make significant changes
case "$TOOL" in
  Write|Edit|Bash)
    # Check for active feature
    if [[ -f .vibe/active-feature ]]; then
      ACTIVE_FEATURE=$(cat .vibe/active-feature)

      if [[ -d "features/$ACTIVE_FEATURE/planning" ]]; then
        # Inject a reminder about current plan and progress
        echo "⚡ Quick context refresh for $ACTIVE_FEATURE:"

        # Show current progress if exists
        if [[ -f "features/$ACTIVE_FEATURE/planning/PROGRESS.md" ]]; then
          echo ""
          echo "Current Progress:"
          tail -10 "features/$ACTIVE_FEATURE/planning/PROGRESS.md"
        fi

        # Show recent decisions if exists
        if [[ -f "features/$ACTIVE_FEATURE/planning/DECISIONS.md" ]]; then
          echo ""
          echo "Recent Decisions:"
          tail -5 "features/$ACTIVE_FEATURE/planning/DECISIONS.md"
        fi
      fi
    fi
    ;;
  *)
    # Other tools don't need context refresh
    ;;
esac

# Always allow the tool to proceed
exit 0
