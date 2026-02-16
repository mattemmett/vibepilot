# Features

This directory contains feature workspaces created during vibe sessions.

## Structure

Each feature workspace follows this pattern:

```
features/
  feature-name/
    planning/          # Active planning files (cleaned on close)
      OVERVIEW.md      # Feature scope, goals, questions
      PLAN.md          # Implementation plan
      PROGRESS.md      # Current status, blockers
      DECISIONS.md     # Quick decision capture
    decisions/         # ADRs (persist after close)
      ADR-YYYY-MM-DD-feature-name.md
    context/           # Session summaries (persist after close)
      SUMMARY-YYYY-MM-DD.md
```

## Lifecycle

1. **Create**: `/vibe start` creates workspace + planning files
2. **Work**: Update planning/ files as you iterate
3. **Close**: `/vibe close` generates ADR, cleans planning/, persists decisions/context/

## Active Features

(None - all features completed)

## Completed Features

- [initial-development](initial-development/) - Initial VibePilot skill implementation ✅ CLOSED 2026-02-16
  - See [ADR-2026-02-16-initial-development.md](initial-development/decisions/ADR-2026-02-16-initial-development.md)

## This is Dogfooding

These features show VibePilot being used to build VibePilot. They serve as:
- **Examples**: Real usage of the vibe session pattern
- **Testing**: Practical validation of our tools
- **Documentation**: Historical record of decisions

## Tips

- Use descriptive feature names (auth-middleware, not task-1)
- Keep planning files updated during work
- Close features when done - don't let them linger
- Review decisions/ directory for historical context
