# Contributing to VibePilot

Thanks for your interest in contributing! VibePilot is a toolkit for vibe engineering, and we welcome contributions of new skills, improvements to existing tools, and documentation.

## Project Philosophy

Before contributing, understand VibePilot's core principles:

- **User control**: Developers stay in the driver's seat
- **Structure without rigidity**: Framework for vibing, not a straitjacket
- **Context is precious**: Every token must justify its cost
- **Clean closeout**: Capture decisions, don't hoard artifacts
- **Trust automation**: Use hooks and scripts, not just prompts

## Getting Started

### Setup Development Environment

1. Fork and clone:
   ```bash
   git clone https://github.com/yourusername/vibepilot.git
   cd vibepilot
   ```

2. Install the skill locally:
   ```bash
   cp -r skills/managing-vibe-sessions ~/.claude/skills/
   chmod +x ~/.claude/skills/managing-vibe-sessions/bin/*
   chmod +x ~/.claude/skills/managing-vibe-sessions/hooks/*.sh
   ```

3. Configure hooks in `~/.claude/settings.json` (see installation guide)

### Use VibePilot While Developing

We dogfood our own tools:

```bash
# Start a vibe session for your feature
/vibe start your-feature-name

# Work on your changes
# Hooks will manage context automatically

# Close when done
/vibe close
```

Your work will be in `features/your-feature-name/` with planning files and an ADR when you close.

## Types of Contributions

### 1. New Skills

VibePilot is a toolkit - new skills are welcome!

**Skill requirements**:
- Must follow [Claude skill best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- Name in gerund form (`doing-something`)
- Commands can be short (like `/vibe`)
- Include hooks if automation is needed
- Provide reference docs in `reference/`
- Include evaluations in `evaluations/`

**Structure**:
```
skills/your-skill-name/
├── SKILL.md              # Main skill file with YAML frontmatter
├── hooks/                # If automation needed
├── bin/                  # If CLI utilities needed
├── reference/            # Additional documentation
└── evaluations/          # Test cases
```

**Process**:
1. Create feature workspace: `/vibe start new-skill-yourname`
2. Build your skill following the structure above
3. Test thoroughly with Haiku, Sonnet, and Opus
4. Create evaluations (at least 3 test cases)
5. Document in README and add to project structure
6. Close your vibe session: `/vibe close`
7. Submit PR with your ADR

### 2. Improvements to Existing Skills

**Process**:
1. Start vibe session: `/vibe start improve-skillname`
2. Make your changes
3. Update evaluations to cover new behavior
4. Test across models
5. Document changes in your session's DECISIONS.md
6. Close and create ADR: `/vibe close`
7. Submit PR

**What we look for**:
- Follows existing patterns
- Minimal and precise (context is precious)
- Backwards compatible (or has migration guide)
- Includes evaluation updates

### 3. Documentation

Documentation improvements are always welcome:

- Fix typos or unclear explanations
- Add usage examples
- Improve installation guides
- Add troubleshooting steps

**Small fixes**: PR directly
**Large changes**: Start vibe session first

### 4. Bug Fixes

1. Open issue describing the bug (if not already exists)
2. Start vibe session: `/vibe start fix-issue-NNN`
3. Fix the bug and add test case to evaluations
4. Document the fix in DECISIONS.md
5. Close session: `/vibe close`
6. Reference the issue in your PR

## Development Guidelines

### Code Style

**Bash scripts**:
- Use `set -euo pipefail`
- Quote all variables: `"$VAR"`
- Comment non-obvious logic
- Exit codes: 0 = success, 2 = block with error

**Markdown**:
- Keep lines under 80 characters where reasonable
- Use fenced code blocks with language tags
- Be concise - context is precious

**SKILL.md**:
- Follow [skill best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- Keep main body under 500 lines
- Use progressive disclosure (link to reference files)
- Third person in description
- Gerund form for skill name

### Testing

**Before submitting**:
- [ ] Tested with `/vibe start` and `/vibe close`
- [ ] Hooks fire correctly
- [ ] Scripts are executable
- [ ] Works on macOS (Windows support nice-to-have)
- [ ] Tested with Haiku, Sonnet, Opus
- [ ] Evaluations pass
- [ ] No context bloat (check token counts)

### Commit Messages

Use conventional commit format:

```
feat(managing-vibe-sessions): add context threshold detection
fix(hooks): correct path handling for spaces
docs(readme): clarify installation steps
chore(deps): update jq requirement docs
```

## Pull Request Process

1. **Fork and branch**: Create feature branch from `main`
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Do your work**: Use `/vibe start` to manage your session

3. **Close your session**: `/vibe close` generates ADR

4. **Commit**: Include the ADR in your commits
   ```bash
   git add features/your-feature-name/decisions/
   git commit -m "feat: your feature description"
   ```

5. **Push and create PR**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **PR description should include**:
   - What problem does this solve?
   - Link to ADR in your feature workspace
   - Screenshots/examples if applicable
   - Testing done
   - Breaking changes (if any)

7. **Review process**:
   - Maintainer reviews code and ADR
   - May request changes or clarifications
   - Once approved, squash and merge

## Review Criteria

We review for:

- **Philosophy alignment**: Does it keep developers in control?
- **Context discipline**: Is every token justified?
- **Automation**: Are hooks used effectively?
- **Documentation**: Clear and concise?
- **Testing**: Evaluations included and passing?
- **Best practices**: Follows Claude skill guidelines?

## Questions?

- Check [docs/development/](../development/) for technical details
- Open a discussion issue
- Review closed PRs for examples

## License

By contributing, you agree that your contributions will be licensed under GPL-3.0.
