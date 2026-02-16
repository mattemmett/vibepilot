---
name: managing-vibe-sessions
description: Manages structured vibe engineering sessions with feature workspaces, planning files, and automatic context injection via hooks. Use when starting extended coding sessions, need to track decisions across context windows, or want structured closeout with ADRs. Commands are /vibe start, /vibe close, /vibe status.
---

# Managing Vibe Sessions

Provides structured vibe engineering workflows with automatic context management through hooks.

**Important**: This skill uses automation hooks that inject feature context automatically. When you see feature context at session start or after compaction, that's the hooks working - you don't need to manually read planning files unless you need specific details.

## Commands

### /vibe start

Creates a new vibe session with feature workspace and planning files.

**Usage**: `/vibe start [feature-name]`

**What happens**:

1. Call the automation script:
   ```bash
   "$CLAUDE_PROJECT_DIR"/skills/managing-vibe-sessions/bin/vibe-start [feature-name]
   ```

   The script will:
   - Prompt for feature description if not provided
   - Suggest a feature name
   - Create feature workspace at `features/<feature-name>/`
   - Initialize planning files (OVERVIEW, PLAN, PROGRESS, DECISIONS)
   - Set as active feature in `.vibe/active-feature`

2. After script completes:
   - Confirm workspace created
   - Remind user that hooks will inject context automatically on next session
   - Help them fill out OVERVIEW.md and PLAN.md if needed
   - Start working on their task

**Note**: The next session start will automatically inject the feature context via SessionStart hook.

### /vibe close

Closes the current vibe session and generates an ADR.

**Usage**: `/vibe close`

**What happens**:

1. Call the automation script:
   ```bash
   "$CLAUDE_PROJECT_DIR"/skills/managing-vibe-sessions/bin/vibe-close
   ```

   The script will:
   - Read all planning files
   - Generate ADR in `decisions/ADR-<timestamp>-<feature-name>.md`
   - Create session summary in `context/SUMMARY-<timestamp>.md`
   - Archive planning files to `context/planning-archive-<timestamp>.tar.gz`
   - Clean up `.vibe/active-feature`
   - Flag potential context file updates

2. After script completes:
   - Review the generated ADR
   - **CRITICAL**: Check for flagged context file updates
   - If architecture.md, product.md, or agents.md need updates:
     - Make minimal, precise updates
     - Every token must justify its cost
     - Surgical edits, not verbose additions
   - Confirm closeout to user

### /vibe status

Shows the current vibe session status.

**Usage**: `/vibe status`

**What happens**:

```bash
"$CLAUDE_PROJECT_DIR"/skills/managing-vibe-sessions/bin/vibe-status
```

Shows:
- Active feature (if any)
- Session start time and description
- Recent progress
- Plan completion status
- Workspace location

## Context Management (Automatic via Hooks)

**You don't need to manually manage context** - the hooks do it:

- **SessionStart hook**: Injects feature context at session start/resume
- **PreToolUse hook**: Reminds you of current progress before major operations
- **PostToolUse hook**: Suggests updating progress after file changes
- **PreCompact hook**: Re-injects feature context before context compression

**When hooks inject context**:
- Trust the context provided - it's fresh from planning files
- You don't need to read planning files unless you need specific details
- Update planning files when you make progress or decisions
- The hooks ensure you never lose track of what you're working on

## Context Escalation (Suggest When Appropriate)

If the conversation is getting complex and NO vibe session is active, suggest:

"💡 This is getting substantial. Want to start a vibe session with `/vibe start`? It'll help capture decisions and manage context automatically."

**Only suggest once per conversation** - respect if user declines.

## Core Principles

### Context Discipline
- Every update to `agents.md`, `architecture.md`, `product.md` must be **minimal**
- One clear fact per line/paragraph
- No chatty explanations - be technical and concise
- If adding >50 tokens, ask yourself: "Is this truly necessary?"

### User Control
- Never auto-start or auto-close sessions
- Never decide the user is "done" - they tell you
- Suggestions only, never assumptions

### Save-Our-Ass Mode
- Escalation exists to prevent context chaos
- Hooks preserve context across sessions and compaction
- Better to start a session early than rebuild later

### Clean Closeout
- Consolidate, don't hoard
- ADRs should be scannable (future you needs to grok this fast)
- Context file changes are MANDATORY verification - don't skip

### Trust the Automation
- Hooks handle context injection and reminders
- Scripts handle workspace management and ADR generation
- Your job: guide the work, update planning files, make decisions
- Don't duplicate what automation does

## File Locations

- Feature workspaces: `features/<feature-name>/`
- Root context: `architecture.md`, `product.md`, `agents.md`
- Subdir context: `<subdir>/agents.md`
- Active session state: `.vibe/active-feature`, `.vibe/session.json`

## Example Session Flow

```
User: /vibe start
You: [runs bin/vibe-start]
Script: "What are you working on?"
User: "Adding user authentication"
Script: [creates features/user-auth/, initializes files]
You: "✅ Vibe session started at features/user-auth/
      Next time you start a session, context will be injected automatically.
      Let's define your plan in planning/PLAN.md..."
[work happens, hooks inject context and reminders]
User: /vibe close
You: [runs bin/vibe-close]
Script: [generates ADR, flags context updates]
You: "✅ Session closed!

      ⚠️  Context updates needed:
      - architecture.md: Add auth middleware pattern
      - src/api/agents.md: Note JWT validation requirement

      Let me make those updates now..."
[makes minimal, precise updates]
You: "Done! ADR saved at features/user-auth/decisions/ADR-2026-02-16-user-auth.md"
```

## Error Handling

- If no active feature workspace: "No active vibe session. Start one with `/vibe start`"
- If feature name conflicts: Suggest alternative or append timestamp
- If context files missing: Warn but don't block (maybe new project)
- If planning files empty on close: Still create ADR, note minimal changes
- If hooks don't fire: Check `.claude/settings.json` has hooks configured

## Installation

See [reference/installation.md](reference/installation.md) for complete setup instructions.

## Troubleshooting

See [reference/troubleshooting.md](reference/troubleshooting.md) for common issues and solutions.

---

Remember: VibePilot exists to keep developers in control while preventing context chaos. Structure without rigidity. Trust the automation. Always save their ass.
