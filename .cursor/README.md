# Cursor IDE Setup for VibePilot

This directory contains Cursor-specific configuration for VibePilot hooks.

## Quick Setup

If you're using Cursor IDE in your project, copy this directory to your project root:

```bash
cp -r /path/to/vibepilot/.cursor ~/your-project/.cursor
```

Then install the VibePilot skill (see main installation guide).

## What's Included

- **hooks.json** - Cursor hook configuration
- **hooks/*.sh** - Hook scripts (copies from `skills/managing-vibe-sessions/hooks/`)

**Note**: These are copies, not symlinks, so the directory is self-contained and portable. When you copy `.cursor/` to your project, it will work out of the box.

## Hooks Supported

Cursor supports these VibePilot hooks:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `preToolUse` | Before Write/Edit/Bash | Refreshes context with current progress |
| `postToolUse` | After Write/Edit/Bash | Reminds to update progress files |

**Note**: Cursor does not support `SessionStart` or `PreCompact` hooks (Claude Code only).

## Differences from Claude Code

| Feature | Claude Code | Cursor |
|---------|-------------|--------|
| Hook config location | `settings.json` | `.cursor/hooks.json` |
| Hook name format | PascalCase | camelCase |
| Timeout units | milliseconds | seconds |
| SessionStart hook | ✅ Supported | ❌ Not available |
| PreCompact hook | ✅ Supported | ❌ Not available |
| Stop hook | ❌ Not available | ✅ Supported |

## Testing

To verify hooks are working:

1. Start a vibe session: `/vibe start`
2. Modify a file
3. Check Cursor's output panel for hook execution logs

## Need Help?

See [skills/managing-vibe-sessions/reference/setup-guide.md](../skills/managing-vibe-sessions/reference/setup-guide.md) for complete setup instructions.
