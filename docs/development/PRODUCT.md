# Product Requirements

## Problem Statement

AI coding tools fall into two camps:
1. **Planning tools** (spec-kit, open-spec, plan mode) - Great for scoped work, terrible for exploration
2. **Freeform chat** - Easy to start, but context degrades and decisions get lost

Neither serves the developer who wants to "vibe" - iterate quickly while staying in control.

### Specific Pain Points

- Context window fills up during flow state
- Decisions made but not captured
- Planning tools force waterfall when you want agile
- No organization - files scattered in root
- No closeout - work ends but nothing documented
- Context files drift out of sync with code

## User Persona

**Experienced developer who:**
- Understands AI coding power and limitations
- Wants to stay in the driver's seat
- Values structure but hates rigidity
- Needs to explore and iterate, not just execute specs
- Works on both planned features and emergent work

## Core Features

### 1. Managed Vibe Sessions ✅ IMPLEMENTED

**User Story**: As a developer, I want to start a vibe session so my work stays organized even when I'm iterating rapidly.

**Implementation**: `managing-vibe-sessions` skill

**Acceptance Criteria**:
- ✅ `/vibe start` prompts for work description
- ✅ Suggests feature name (users hate naming things)
- ✅ Creates feature workspace with planning/, decisions/, context/ subdirs
- ✅ Initializes planning files (OVERVIEW, PLAN, PROGRESS, DECISIONS)

### 2. Context-Aware Escalation ✅ IMPLEMENTED

**User Story**: As a developer, I want to be warned before my context explodes so I can formalize my work before it's too late.

**Implementation**: Built into `managing-vibe-sessions` skill

**Acceptance Criteria**:
- ✅ Suggest session when conversation gets complex
- ✅ Polite suggestion, not pushy
- ✅ User confirms manually (no auto-promotion)
- ✅ Only suggest once per conversation
- ⚠️ Context monitoring threshold not automated (requires user judgment)

### 3. Clean Closeout ✅ IMPLEMENTED

**User Story**: As a developer, I want to close a vibe session and have all decisions captured and context updated so nothing gets lost.

**Implementation**: `vibe-close` script + skill guidance

**Acceptance Criteria**:
- ✅ `/vibe close` is manual trigger
- ✅ Consolidate planning/ artifacts into ADR
- ✅ Check for context file changes
- ✅ Flag potential updates needed
- ✅ Archive planning/ directory to context/
- ✅ Persist ADR and session summary
- ⚠️ Context file verification is basic (checks git status, could be smarter)

### 4. Context File Discipline ✅ IMPLEMENTED

**User Story**: As a developer, I want context files to stay lean and relevant so they don't bloat my context window with noise.

**Implementation**: Guidelines in SKILL.md and agents.md

**Acceptance Criteria**:
- ✅ Clear guidelines in SKILL.md for minimal updates
- ✅ "Every token must justify its cost" principle
- ✅ Surgical edits, not verbose additions
- ⚠️ Enforcement relies on Claude following guidelines (no automated checks)

## Implementation Status

### v1.0 - Initial Release ✅
- ✅ managing-vibe-sessions skill
- ✅ Hook-based automation (SessionStart, PreToolUse, PostToolUse, PreCompact)
- ✅ CLI utilities (vibe-start, vibe-close, vibe-status)
- ✅ Feature workspace pattern
- ✅ ADR generation
- ✅ Evaluation framework
- ✅ Installation and troubleshooting docs

**Release Date**: 2026-02-16

### Future Features

#### Context Sync Tool (v2+)

**User Story**: As a developer, I want to know when my documentation drifts from my code so I can keep them in sync.

**Implementation TBD**:
- Separate skill or dedicated agent
- Scans code vs architecture.md/product.md
- Reports out-of-sync items
- May propose updates (merge request workflow TBD)
- On-demand or periodic execution

**Priority**: High - mentioned as key planned feature

#### Automated Evaluations (v2+)

**User Story**: Verify skill behavior consistently across model updates

**Implementation TBD**:
- Convert manual evaluation template to automated tests where possible
- CI/CD integration
- Regression detection

**Priority**: Medium

## Non-Goals

- Not a replacement for proper planning when needed
- Not trying to be fully autonomous (user stays in control)
- Not trying to prevent all context issues (just manage them better)

## Success Metrics

- Can complete multi-hour vibe session without context chaos
- Decisions captured in ADRs
- Context files stay under X tokens (TBD)
- Zero scattered planning artifacts in root after closeout
