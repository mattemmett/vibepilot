# Architecture

## Overview

VibePilot is a Claude Code plugin combining:
- **Skill**: Instructions that guide Claude's behavior during vibe sessions
- **Hooks**: Automation scripts triggered at lifecycle events (SessionStart, PreToolUse, PostToolUse, Stop, PreCompact)
- **CLI utilities**: Scripts for workspace management and context operations
- **State tracking**: File-based session management

This provides structured vibe engineering workflows without requiring Claude to remember to do things - the automation handles it.

**Inspiration**: [planning-with-files](https://github.com/OthmanAdi/planning-with-files) pattern, but our own implementation.

## Core Components

### 1. Feature Workspace Pattern

```
features/
  feature-name/
    planning/          # Planning files during active work
    decisions/         # ADRs - persist after closeout
    context/           # Session summaries - persist after closeout
```

**Lifecycle**: Hybrid
- Planning artifacts cleaned on closeout
- ADRs and summaries persist as historical record
- Feature name primary, timestamp optional nice-to-have

**Location**: TBD - root vs subdir (avoiding "workspace" term)

### 2. Context File Structure

```
/
  architecture.md      # Technical "what" - system design, patterns
  product.md          # Product "what" - requirements, features
  agents.md           # Root-level "how" - agent instructions
  src/
    module/
      agents.md       # Subdir-level "how" - module-specific instructions
```

**Principles**:
- Keep files minimal - GenAI is chatty, context is precious
- architecture.md + product.md = WHAT
- agents.md (all levels) = HOW
- Updates must be concise and technically viable

### 3. Planning Files Integration

Based on [planning-with-files](https://github.com/OthmanAdi/planning-with-files) pattern:
- Leverage existing framework for context management
- Extend with feature-tying and closeout workflow
- Planning artifacts scoped to feature workspace

## Vibe Session Flow

### Start (Deliberate)
```
/vibepilot start
→ Ask about the work
→ Suggest feature name
→ Create feature workspace
→ Initialize planning files
```

### Escalation (Accidental)
```
Trigger: 50-75% context usage
→ Suggest formalizing session
→ User confirms manually
→ Scaffold workspace from conversation history
→ Extract decisions made so far
```

### Close (Manual)
```
/vibepilot close
→ Consolidate planning artifacts into ADR
→ Verify context file changes
→ Flag conflicts/extensions to agents.md, architecture.md, product.md
→ Clean planning/ directory
→ Persist decisions/ and context/
```

## Context Sync (Future)

Separate tool/agent (not vibepilot v1):
- Detect drift between code and architecture.md/product.md
- Run on-demand or periodically
- Produce list of out-of-sync items
- May suggest merge requests (TBD)

## Design Principles

1. **Manual control points**: User decides when to start/close, not the agent
2. **Save our ass mode**: Escalation captures state before context explodes
3. **Clean closeout**: Consolidate, don't hoard
4. **Context discipline**: Every update must justify its token cost
