# Agent Instructions

## Project Overview

VibePilot is a toolkit for vibe engineering - helping developers stay in control while using AI to build software.

## Working on This Project

### Context Files (The WHAT)
- Read `architecture.md` for technical structure
- Read `product.md` for requirements and user stories
- These define what we're building and why

### This File (The HOW)
- Principles and patterns for working on VibePilot itself

## Development Principles

### Context Discipline
- Keep ALL documentation files lean and minimal
- Every token counts - we practice what we preach
- No chatty explanations - be technical and concise
- If adding >50 tokens to any .md file, justify it

### Feature Workspace Usage
- We eat our own dog food - use `features/` for all work
- Active features live in `features/<name>/`
- Use planning/ during work, decisions/ for ADRs, context/ for summaries

### Code Style
- Prefer clarity over cleverness
- Document the "why" not the "what"
- No premature abstractions

### Testing Approach
- Manual testing in real workflows first
- Document test scenarios in feature planning/
- Real-world usage drives design

## File Organization

```
/
  architecture.md       # Technical design (keep lean)
  product.md           # Requirements (keep lean)
  agents.md            # This file (keep lean)
  skills/              # Skill definitions
    vibepilot.md       # Main skill prompt
  features/            # Active work
    <feature-name>/
      planning/        # Work in progress
      decisions/       # ADRs (persist)
      context/         # Summaries (persist)
```

## When Making Changes

1. **Read context first**: Check architecture.md and product.md
2. **Work in features**: Use appropriate feature workspace
3. **Update context**: If code diverges from docs, update docs
4. **Be minimal**: Every doc update must justify its token cost
5. **Close the loop**: Generate ADR on feature completion

## Common Tasks

### Adding a new skill
- Create in `skills/`
- Update `skills/README.md` with usage
- Document in `architecture.md` if it changes structure
- Add to `product.md` if it's a new user-facing feature

### Extending vibepilot skill
- Work in `features/vibepilot-skill/`
- Update `skills/vibepilot.md` with changes
- Update tests and examples

### Updating context files
- Make surgical edits - replace, don't append
- Remove outdated info when adding new info
- Keep total file size in check

## Anti-Patterns

❌ Don't create files in root - use features/
❌ Don't write verbose documentation - be concise
❌ Don't skip ADRs on feature completion
❌ Don't let context files drift from code
❌ Don't auto-close or auto-start sessions (user control)
