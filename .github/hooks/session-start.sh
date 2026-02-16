#!/usr/bin/env bash
# VibePilot SessionStart Hook
# Injects feature context at session start/resume

set -euo pipefail

# Read hook input from stdin
INPUT=$(cat)
SOURCE=$(echo "$INPUT" | jq -r '.source // "unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "."')

cd "$CWD"

# Only inject on startup or resume (not on compact)
if [[ "$SOURCE" != "startup" && "$SOURCE" != "resume" ]]; then
  exit 0
fi

# Check if there's an active vibe session
ACTIVE_FEATURE=""
if [[ -f .vibe/active-feature ]]; then
  ACTIVE_FEATURE=$(cat .vibe/active-feature)
fi

# If no active feature, check for any recent features
if [[ -z "$ACTIVE_FEATURE" ]] && [[ -d features ]]; then
  # Find most recently modified feature (by planning/ directory mtime)
  RECENT_FEATURE=$(find features -mindepth 1 -maxdepth 1 -type d -exec stat -f "%m %N" {} \; 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2- | xargs basename 2>/dev/null || echo "")
  if [[ -n "$RECENT_FEATURE" ]]; then
    ACTIVE_FEATURE="$RECENT_FEATURE"
  fi
fi

# Build context injection
OUTPUT=""

if [[ -n "$ACTIVE_FEATURE" ]] && [[ -d "features/$ACTIVE_FEATURE" ]]; then
  OUTPUT+="═══════════════════════════════════════════════════════════════\n"
  OUTPUT+="🎯 ACTIVE VIBE SESSION: $ACTIVE_FEATURE\n"
  OUTPUT+="═══════════════════════════════════════════════════════════════\n\n"

  # Inject OVERVIEW if exists
  if [[ -f "features/$ACTIVE_FEATURE/planning/OVERVIEW.md" ]]; then
    OUTPUT+="## Feature Overview\n\n"
    OUTPUT+="$(cat "features/$ACTIVE_FEATURE/planning/OVERVIEW.md")\n\n"
  fi

  # Inject current PLAN if exists
  if [[ -f "features/$ACTIVE_FEATURE/planning/PLAN.md" ]]; then
    OUTPUT+="## Current Plan\n\n"
    OUTPUT+="$(cat "features/$ACTIVE_FEATURE/planning/PLAN.md")\n\n"
  fi

  # Inject PROGRESS if exists
  if [[ -f "features/$ACTIVE_FEATURE/planning/PROGRESS.md" ]]; then
    OUTPUT+="## Progress\n\n"
    OUTPUT+="$(cat "features/$ACTIVE_FEATURE/planning/PROGRESS.md")\n\n"
  fi

  # Inject recent DECISIONS if exists
  if [[ -f "features/$ACTIVE_FEATURE/planning/DECISIONS.md" ]]; then
    OUTPUT+="## Recent Decisions\n\n"
    OUTPUT+="$(cat "features/$ACTIVE_FEATURE/planning/DECISIONS.md")\n\n"
  fi

  OUTPUT+="═══════════════════════════════════════════════════════════════\n"
  OUTPUT+="Use /vibepilot close when done to generate ADR and clean up.\n"
  OUTPUT+="═══════════════════════════════════════════════════════════════\n"
else
  OUTPUT+="💡 No active vibe session. Start one with /vibepilot start\n"
fi

# Output to Claude's context
echo -e "$OUTPUT"

exit 0
