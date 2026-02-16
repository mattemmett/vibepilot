# Feature Backlog

Outstanding work from closed features. Reference source ADR for context.

## Purpose

When features are closed, they often have outstanding work that's not critical but still valuable. This file surfaces those items so they're not buried in ADRs.

## How to Use

1. **Review**: Check this file when planning new work
2. **Prioritize**: Organize items by importance (move high-priority items to top)
3. **Start work**: Pick an item, start a vibe session, reference the source ADR
4. **Clean up**: Remove items as they're completed or become obsolete

## Outstanding Items

### From initial-development (ADR-2026-02-16)

**Source**: [ADR-2026-02-16-initial-development.md](initial-development/decisions/ADR-2026-02-16-initial-development.md#outstanding-work)

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

---

## Future Automation

Currently manual, but `vibe-close` could:
1. Detect `[ ]` items in "Outstanding Work" section of ADR
2. Offer to add them to this backlog
3. Auto-link back to source ADR

Phase 2: GitHub Issues integration for full workflow tracking.
