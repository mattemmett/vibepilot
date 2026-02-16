# ADR 1: initial-development

**Date**: 2026-02-16
**Status**: Accepted
**Feature**: initial-development

## Context

Built the initial VibePilot skill for managing vibe engineering sessions. Started with prompt-only approach, pivoted to hooks + automation after discovering limitations. Goal was structured vibe sessions without forcing waterfall planning.

## Decision

Created `managing-vibe-sessions` skill with:
- Hooks for automatic context injection (SessionStart, PreToolUse, PostToolUse, PreCompact)
- CLI utilities for workspace management (vibe-start, vibe-close, vibe-status)
- Feature workspace pattern (planning/, decisions/, context/)
- Progressive disclosure in SKILL.md with reference docs
- Evaluation template for behavioral testing

Followed Claude skill best practices: gerund naming, third-person description, <500 line SKILL.md.

## Rationale

**Automation over prompts**: Prompt-only skills can't reliably inject context or trigger workflows. planning-with-files proved hooks work.

**VibePilot as toolkit**: Multiple tools/skills under one brand. Skill name (`managing-vibe-sessions`) for discovery, short commands (`/vibe`) for UX.

**Feature workspaces**: Organize work in `features/` with hybrid lifecycle - planning cleaned, ADRs/summaries persist.

**Own implementation**: Similar goals to planning-with-files but different approach (feature-based, ADRs, context integration). Full control and customization.

## Consequences

### What was built

**Skill structure** (`skills/managing-vibe-sessions/`):
- SKILL.md with proper YAML frontmatter
- 4 automation hooks (session-start, pre-tool-use, post-tool-use, pre-compact)
- 3 CLI utilities (vibe-start, vibe-close, vibe-status)
- Reference docs (installation, troubleshooting)
- Evaluation template with 10 test scenarios

**Project structure**:
- Toolkit pattern: skills/ for distribution, docs/ for development
- Dogfooding workspace in features/
- Development docs (ARCHITECTURE, PRODUCT, AGENTS, CONTRIBUTING)

**Key files**:
- README.md - Brand overview
- CREDITS.md - Attribution to planning-with-files
- .gitignore - Exclude .vibe/ and planning/ dirs

### Trade-offs

**More complex setup**: Users must configure hooks in settings.json. But provides automatic context management worth the cost.

**Manual testing**: Behavioral skill requires human evaluation. Created template but can't fully automate.

**Bash dependency**: Scripts require bash and jq. Limits Windows support but works on primary platforms.

**GPL-3.0 license**: Copyleft ensures derivatives stay open. May limit some commercial use cases vs MIT.

## Implementation Notes

### Key Changes

- [Extracted from progress log]

### Files Modified

**Core skill**:
- skills/managing-vibe-sessions/SKILL.md
- skills/managing-vibe-sessions/hooks/*.sh
- skills/managing-vibe-sessions/bin/*
- skills/managing-vibe-sessions/reference/*.md

**Project docs**:
- README.md
- CREDITS.md
- docs/development/*.md

**Dogfooding**:
- features/initial-development/* (this feature)

### Patterns Used

**Hooks pattern**: Automation at lifecycle events instead of prompt-based reminders.

**Progressive disclosure**: SKILL.md as overview, reference/ for details. Keeps main file <500 lines.

**State tracking**: File-based session state in `.vibe/` directory.

**Hybrid lifecycle**: Planning files temporary, decisions/summaries permanent.

**Toolkit structure**: Brand (VibePilot) contains multiple skills, each self-contained.

## Follow-up

### Outstanding Work

**Testing**:
- [ ] Run evaluations from EVALUATION_TEMPLATE.md
- [ ] Test with Haiku, Sonnet, and Opus
- [ ] Validate hooks fire correctly in real usage
- [ ] Test installation on fresh system

**Minor script bugs**:
- [ ] Fix grep errors in vibe-close (line 50-52 in output)
- [ ] Fix head command issue in ADR generation

**Nice-to-haves**:
- [ ] Windows compatibility (currently bash/macOS/Linux only)
- [ ] GitHub Actions for automated testing
- [ ] Example evaluation results
- [ ] Video walkthrough of usage

### Future Considerations

**Context sync tool**: Detect drift between code and architecture/product docs. Mentioned in product.md as future feature.

**Additional planning files**: May want FINDINGS.md (like planning-with-files) or other specialized files based on usage.

**Hook refinements**: Adjust timing, verbosity, and content based on real-world use.

**Template library**: Common feature templates (API endpoint, UI component, etc.) to speed up vibe sessions.

**Multi-model optimization**: Tune SKILL.md for Haiku (more guidance) vs Opus (less explanation) if needed.

## References

- Planning files: `features/initial-development/context/`
- Related ADRs: [If any]

