# Cursor IDE Setup

How to use VibePilot managing-vibe-sessions with Cursor IDE.

---

## Installation

### Prerequisites

- Cursor IDE installed
- `jq` command-line JSON processor
- Bash shell (macOS/Linux) or Git Bash (Windows)

### Step 1: Copy Cursor Configuration

Copy the `.cursor` directory to your project root:

```bash
# From the VibePilot repo
cp -r /path/to/vibepilot/.cursor ~/your-project/.cursor
```

This installs:
- `.cursor/hooks.json` - Hook configuration
- `.cursor/hooks/*.sh` - Hook scripts

### Step 2: Add CLI Utilities to PATH (Optional)

If you want to use vibe CLI commands:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:/path/to/vibepilot/skills/managing-vibe-sessions/bin"

# Reload shell
source ~/.zshrc  # or ~/.bashrc
```

### Step 3: Verify Installation

```bash
# In your project directory
cd ~/your-project

# Check hooks config exists
cat .cursor/hooks.json

# Start a vibe session
/path/to/vibepilot/skills/managing-vibe-sessions/bin/vibe-start
```

---

## Hooks Support

Cursor supports these VibePilot hooks via `.cursor/hooks.json`:

| Hook | Purpose | Cursor Feature |
|------|---------|----------------|
| `preToolUse` | Re-reads progress before tool operations | Keeps goals in context |
| `postToolUse` | Reminds to update progress after edits | Prevents forgetting updates |

### Cursor Hook Configuration

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      {
        "command": ".cursor/hooks/pre-tool-use.sh",
        "matcher": "Write|Edit|Bash",
        "timeout": 3
      }
    ],
    "postToolUse": [
      {
        "command": ".cursor/hooks/post-tool-use.sh",
        "matcher": "Write|Edit|Bash",
        "timeout": 2
      }
    ]
  }
}
```

### What Each Hook Does

**PreToolUse Hook**

**Triggers:** Before Write, Edit, or Bash operations

**What it does:**
- Checks for active vibe session in `.vibe/active-feature`
- Reads last 10 lines of PROGRESS.md
- Reads last 5 lines of DECISIONS.md
- Logs to stderr for context

Always returns success - never blocks tools.

**PostToolUse Hook**

**Triggers:** After Write or Edit operations

**What it does:**
- Detects file modifications
- Outputs reminder to update planning files
- Skips if modifying planning files themselves

Helps prevent forgetting to log progress.

---

## Differences from Claude Code

| Feature | Claude Code | Cursor |
|---------|-------------|--------|
| Hook config location | `~/.claude/settings.json` | `.cursor/hooks.json` (project root) |
| Hook name format | PascalCase (`PreToolUse`) | camelCase (`preToolUse`) |
| Timeout units | milliseconds | seconds |
| SessionStart hook | ✅ Supported | ❌ Not available |
| PreCompact hook | ✅ Supported | ❌ Not available |
| Stop hook | ❌ Not available | ✅ Supported (not implemented yet) |
| Environment variable | `$CLAUDE_PLUGIN_DIR` | Relative paths only |

**Missing Hooks in Cursor:**

- **SessionStart**: Cursor doesn't inject context on session start
- **PreCompact**: No context compression hooks in Cursor

These limitations mean you should manually check planning files more frequently in Cursor.

---

## File Structure

When using VibePilot in Cursor, your project looks like:

```
your-project/
├── .cursor/
│   ├── hooks.json              ← Hook configuration
│   └── hooks/
│       ├── pre-tool-use.sh     ← Context refresh script
│       └── post-tool-use.sh    ← Progress reminder script
├── .vibe/
│   ├── active-feature          ← Current feature name
│   └── session.json            ← Session metadata
├── features/
│   └── your-feature/
│       ├── planning/
│       │   ├── OVERVIEW.md
│       │   ├── PLAN.md
│       │   ├── PROGRESS.md
│       │   └── DECISIONS.md
│       ├── decisions/
│       └── context/
└── ...
```

---

## Usage in Cursor

### Starting a Session

```bash
# From terminal in your project directory
vibe-start
```

Or if not in PATH:

```bash
/path/to/vibepilot/skills/managing-vibe-sessions/bin/vibe-start
```

### Checking Status

```bash
vibe-status
```

### Closing a Session

```bash
vibe-close
```

### Using Skills in Cursor

Cursor supports skills, but VibePilot doesn't currently provide a Cursor skill file. You'll use the CLI utilities directly via terminal.

**Future**: We may add `.cursor/skills/managing-vibe-sessions/` for Cursor-native integration.

---

## Tips for Cursor Users

1. **Check hooks are firing**: Monitor Cursor's output panel for hook execution logs

2. **Keep planning files open**: Pin PROGRESS.md in a split view for easy reference

3. **Manual session start**: Since there's no SessionStart hook, review planning files yourself at the beginning of each session

4. **Use composer mode**: Cursor's composer integrates well with the vibe pattern

---

## Compatibility with Claude Code

Your vibe session files are fully compatible between Cursor and Claude Code:

- `.vibe/` directory works for both
- Planning files have identical format
- Same CLI utilities work everywhere
- ADRs and context files are tool-agnostic

You can switch between IDEs mid-session without any changes.

---

## Troubleshooting

### Hooks not firing

1. Check `.cursor/hooks.json` exists in project root:
   ```bash
   cat .cursor/hooks.json
   ```

2. Verify scripts are executable:
   ```bash
   ls -l .cursor/hooks/*.sh
   ```

3. Make scripts executable if needed:
   ```bash
   chmod +x .cursor/hooks/*.sh
   ```

4. Check Cursor's output panel for error messages

### jq not found

Install jq:

```bash
# macOS
brew install jq

# Linux (Debian/Ubuntu)
sudo apt-get install jq

# Windows (Git Bash)
# jq comes with Git for Windows
```

### Session not found

Make sure you're in the project root where `.vibe/` exists:

```bash
ls -la .vibe/
```

---

## Need Help?

- Check [troubleshooting.md](troubleshooting.md) for common issues
- Open an issue at [github.com/yourusername/vibepilot/issues](https://github.com/yourusername/vibepilot/issues)
