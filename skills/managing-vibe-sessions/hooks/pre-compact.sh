#!/usr/bin/env bash
# VibePilot PreCompact Hook
# Re-injects feature context before context window compaction

set -euo pipefail

# Read hook input
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // "."')

cd "$CWD"

# Check for active feature
if [[ ! -f .vibe/active-feature ]]; then
  exit 0
fi

ACTIVE_FEATURE=$(cat .vibe/active-feature)

if [[ ! -d "features/$ACTIVE_FEATURE" ]]; then
  exit 0
fi

# Re-inject critical context before compaction
echo "═══════════════════════════════════════════════════════════════"
echo "🔄 Context compaction detected - re-injecting vibe session context"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "Active Feature: $ACTIVE_FEATURE"
echo ""

# Re-inject OVERVIEW (critical context)
if [[ -f "features/$ACTIVE_FEATURE/planning/OVERVIEW.md" ]]; then
  echo "## Feature Overview"
  echo ""
  cat "features/$ACTIVE_FEATURE/planning/OVERVIEW.md"
  echo ""
fi

# Re-inject current PROGRESS (what's been done)
if [[ -f "features/$ACTIVE_FEATURE/planning/PROGRESS.md" ]]; then
  echo "## Recent Progress"
  echo ""
  tail -20 "features/$ACTIVE_FEATURE/planning/PROGRESS.md"
  echo ""
fi

# Re-inject DECISIONS (critical choices made)
if [[ -f "features/$ACTIVE_FEATURE/planning/DECISIONS.md" ]]; then
  echo "## Key Decisions"
  echo ""
  cat "features/$ACTIVE_FEATURE/planning/DECISIONS.md"
  echo ""
fi

echo "═══════════════════════════════════════════════════════════════"

exit 0
