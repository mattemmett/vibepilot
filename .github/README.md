# GitHub Copilot Setup for VibePilot

This directory contains GitHub Copilot-specific configuration for VibePilot hooks and skills.

## Quick Setup

If you're using GitHub Copilot in your project, copy this directory to your repository:

```bash
cp -r /path/to/vibepilot/.github ~/your-project/.github
```

**Important**: The hooks configuration must be present on your repository's **default branch** (usually `main` or `master`) to be used by GitHub Copilot coding agent.

Then commit and push:

```bash
git add .github/
git commit -m "Add VibePilot for GitHub Copilot"
git push origin main
```

## What's Included

- **hooks/hooks.json** - GitHub Copilot hook configuration
- **hooks/*.sh** - Hook scripts (copies from `skills/managing-vibe-sessions/hooks/`)
- **skills/managing-vibe-sessions/SKILL.md** - Copilot-compatible skill file

**Note**: These are copies, not symlinks, so the directory is self-contained and portable.

## Hooks Supported

GitHub Copilot supports these VibePilot hooks:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `sessionStart` | On session start/resume | Injects feature context at session start |
| `preToolUse` | Before Write/Edit/Bash | Refreshes context with current progress |
| `postToolUse` | After Write/Edit/Bash | Reminds to update progress files |

## Differences from Claude Code and Cursor

| Feature | Claude Code | Cursor | GitHub Copilot |
|---------|-------------|--------|----------------|
| Hook config location | `~/.claude/settings.json` | `.cursor/hooks.json` | `.github/hooks/hooks.json` |
| Skill location | `~/.claude/skills/` | `.cursor/skills/` | `.github/skills/` |
| Hook name format | PascalCase | camelCase | camelCase |
| Timeout units | milliseconds | seconds | seconds |
| SessionStart hook | ✅ | ❌ | ✅ |
| PreCompact hook | ✅ | ❌ | ❌ |
| Must be on default branch | ❌ | ❌ | ✅ |

**Key Difference**: GitHub Copilot requires hooks configuration to be **committed to your repository's default branch**. This is different from Claude Code (user-level config) and Cursor (project-local, not necessarily committed).

## Testing

To verify hooks are working:

1. Copy `.github/` to your project
2. Commit and push to default branch
3. Start a vibe session: `vibe-start test-feature`
4. Watch for hook output when Copilot starts or uses tools

## Need Help?

See [skills/managing-vibe-sessions/reference/github-copilot.md](../skills/managing-vibe-sessions/reference/github-copilot.md) for complete setup instructions.
