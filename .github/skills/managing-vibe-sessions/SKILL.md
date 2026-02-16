---
name: managing-vibe-sessions
description: Structured vibe engineering workflows with feature workspaces, planning files, and automatic context injection via hooks. Use when starting extended coding sessions, tracking decisions across context windows, or closing out features with ADRs. Commands are vibe-start, vibe-close, vibe-status.
---

# Managing Vibe Sessions (GitHub Copilot)

Structured vibe engineering workflows with feature workspaces, planning files, and context management through hooks.

## What This Does

VibePilot helps you manage coding sessions with:
- **Feature workspaces** at `features/<feature-name>/`
- **Planning files** (OVERVIEW, PLAN, PROGRESS, DECISIONS)
- **Automatic context injection** via hooks (configured in `.github/hooks/hooks.json`)
- **ADR generation** when closing features

## CLI Commands

### Start a Vibe Session

```bash
vibe-start [feature-name]
```

Creates:
- Feature workspace at `features/<feature-name>/`
- Planning files: OVERVIEW.md, PLAN.md, PROGRESS.md, DECISIONS.md
- Session tracking in `.vibe/active-feature`

### Check Session Status

```bash
vibe-status
```

Shows:
- Active feature name
- Recent progress
- Plan completion percentage

### Close Vibe Session

```bash
vibe-close
```

Generates:
- ADR (Architecture Decision Record) in `decisions/`
- Session summary in `context/`
- Archives planning files
- Clears active session

## How Hooks Work

The hooks in `.github/hooks/hooks.json` automatically:

**sessionStart** (on session start/resume):
- Injects feature context at session start
- Shows current OVERVIEW, PLAN, and PROGRESS
- Keeps you oriented when returning to work

**preToolUse** (before Write/Edit/Bash):
- Refreshes context with last 10 lines of PROGRESS.md
- Shows last 5 lines of DECISIONS.md
- Keeps goals in mind during work

**postToolUse** (after Write/Edit/Bash):
- Reminds you to update PROGRESS.md after significant changes
- Helps prevent forgetting to log work

## Feature Workspace Structure

```
features/
  your-feature/
    planning/          # Active work (cleaned on close)
      OVERVIEW.md      # Feature scope, goals, questions
      PLAN.md          # Implementation plan with checkboxes
      PROGRESS.md      # Current status, blockers, notes
      DECISIONS.md     # Quick decision capture
    decisions/         # ADRs (persist after close)
      ADR-YYYY-MM-DD-feature-name.md
    context/           # Session summaries (persist after close)
      SUMMARY-YYYY-MM-DD.md
```

## Workflow

1. **Start**: `vibe-start feature-name`
   - Fill out OVERVIEW.md (scope, goals)
   - Create PLAN.md with implementation phases
   - Begin work

2. **Work**: Code and iterate
   - Hooks inject context automatically on session start
   - Update PROGRESS.md as you complete tasks
   - Log decisions in DECISIONS.md

3. **Close**: `vibe-close`
   - Generates ADR from your planning files
   - Archives planning/ directory
   - Preserves decisions/ and context/

## When to Use

**Use this pattern for:**
- Multi-step features (3+ phases)
- Work spanning multiple sessions
- Complex refactoring or architecture changes
- Anything you might forget context on

**Skip for:**
- Single-file edits
- Quick bug fixes
- Trivial changes

## Planning File Guidelines

### OVERVIEW.md

- Describe the feature in 1-2 sentences
- List what's in scope and what's NOT
- Define success criteria
- Track open questions

### PLAN.md

- Break work into phases
- Use checkboxes: `- [ ] Task description`
- Update status as you complete tasks
- Add new tasks as discovered

### PROGRESS.md

- Log session start/end
- Note completed milestones
- Record blockers and how you solved them
- Link to relevant files/resources

### DECISIONS.md

- Quick capture format:
  ```
  ## Decision: [Title]
  Context: [Why?]
  Decision: [What?]
  Rationale: [Why this?]
  ```
- Don't overthink it - capture and move on

## Installation

For full installation instructions, see the main VibePilot README.

**Quick setup:**
1. Copy `.github/` to your repository (must be on default branch)
2. Add VibePilot bin to PATH (optional)
3. Start vibing with `vibe-start`

**Note**: Hooks configuration must be on your default branch to work with GitHub Copilot coding agent.

## Philosophy

- **Stay in control**: AI assists, you decide
- **Context is precious**: Files > memory
- **Close the loop**: Capture decisions, update docs
- **Structure without rigidity**: Framework for vibing, not a straitjacket
