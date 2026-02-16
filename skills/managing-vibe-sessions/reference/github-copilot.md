# GitHub Copilot Setup

How to use VibePilot managing-vibe-sessions with GitHub Copilot.

---

## Installation

### Prerequisites

- GitHub Copilot subscription (Individual, Business, or Enterprise)
- `jq` command-line JSON processor
- Bash shell (macOS/Linux) or Git Bash (Windows)
- Repository with GitHub Copilot enabled

### Step 1: Copy GitHub Configuration

Copy the `.github` directory to your project root:

```bash
# From the VibePilot repo
cp -r /path/to/vibepilot/.github ~/your-project/.github
```

This installs:
- `.github/hooks/hooks.json` - Hook configuration
- `.github/hooks/*.sh` - Hook scripts
- `.github/skills/managing-vibe-sessions/SKILL.md` - Skill file

### Step 2: Commit to Default Branch

**CRITICAL**: GitHub Copilot only loads hooks from the **default branch** (usually `main` or `master`).

```bash
cd ~/your-project
git add .github/
git commit -m "Add VibePilot for GitHub Copilot"
git push origin main  # or master, depending on your default branch
```

### Step 3: Add CLI Utilities to PATH (Optional)

If you want to use vibe CLI commands:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:/path/to/vibepilot/skills/managing-vibe-sessions/bin"

# Reload shell
source ~/.zshrc  # or ~/.bashrc
```

### Step 4: Verify Installation

```bash
# In your project directory
cd ~/your-project

# Check hooks config exists
cat .github/hooks/hooks.json

# Start a vibe session
vibe-start test-feature
```

---

## Hooks Support

GitHub Copilot supports these VibePilot hooks via `.github/hooks/hooks.json`:

| Hook | Purpose | Copilot Feature |
|------|---------|-----------------|
| `sessionStart` | Injects feature context on session start | Context on startup |
| `preToolUse` | Re-reads progress before tool operations | Keeps goals in context |
| `postToolUse` | Reminds to update progress after edits | Prevents forgetting updates |

### GitHub Copilot Hook Configuration

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "bash": ".github/hooks/session-start.sh",
        "cwd": ".",
        "timeoutSec": 5
      }
    ],
    "preToolUse": [
      {
        "type": "command",
        "bash": ".github/hooks/pre-tool-use.sh",
        "cwd": ".",
        "timeoutSec": 3
      }
    ],
    "postToolUse": [
      {
        "type": "command",
        "bash": ".github/hooks/post-tool-use.sh",
        "cwd": ".",
        "timeoutSec": 2
      }
    ]
  }
}
```

### What Each Hook Does

**SessionStart Hook**

**Triggers:** When a new Copilot coding agent session begins or resumes

**What it does:**
- Checks for active vibe session in `.vibe/active-feature`
- Reads and displays OVERVIEW.md
- Reads and displays first 20 lines of PLAN.md
- Shows last 10 lines of PROGRESS.md
- Injects context automatically on session start

This is **unique to GitHub Copilot** - Cursor doesn't have this hook!

**PreToolUse Hook**

**Triggers:** Before Write, Edit, or Bash operations

**What it does:**
- Checks for active vibe session
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

## Differences from Claude Code and Cursor

| Feature | Claude Code | Cursor | GitHub Copilot |
|---------|-------------|--------|----------------|
| Hook config location | `~/.claude/settings.json` | `.cursor/hooks.json` | `.github/hooks/hooks.json` |
| Skills location | `~/.claude/skills/` | `.cursor/skills/` | `.github/skills/` |
| Hook name format | PascalCase (`PreToolUse`) | camelCase (`preToolUse`) | camelCase (`preToolUse`) |
| Timeout units | milliseconds | seconds | seconds |
| SessionStart hook | ✅ Supported | ❌ Not available | ✅ Supported |
| PreCompact hook | ✅ Supported | ❌ Not available | ❌ Not available |
| Stop hook | ❌ Not available | ✅ Supported | ❌ Not available |
| Config scope | User-global | Project-local | **Repository (default branch)** |
| Environment variable | `$CLAUDE_PLUGIN_DIR` | Relative paths | Relative paths |

**Key Differences:**

- **Must be on default branch**: Unlike Cursor (project-local) or Claude Code (user config), GitHub Copilot loads hooks from the committed repository
- **Has SessionStart**: Unlike Cursor, GitHub Copilot supports automatic context injection on session start
- **Repository-scoped**: Configuration is per-repository and committed to version control

---

## File Structure

When using VibePilot with GitHub Copilot, your project looks like:

```
your-project/
├── .github/
│   ├── README.md                                ← Setup guide
│   ├── hooks/
│   │   ├── hooks.json                          ← Hook configuration
│   │   ├── session-start.sh                    ← Session start hook
│   │   ├── pre-tool-use.sh                     ← Context refresh hook
│   │   └── post-tool-use.sh                    ← Progress reminder hook
│   └── skills/
│       └── managing-vibe-sessions/
│           └── SKILL.md                         ← Copilot skill file
├── .vibe/
│   ├── active-feature                           ← Current feature name
│   └── session.json                             ← Session metadata
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

## Usage with GitHub Copilot

### Starting a Session

```bash
# From terminal in your project directory
vibe-start my-feature
```

Or if not in PATH:

```bash
/path/to/vibepilot/skills/managing-vibe-sessions/bin/vibe-start my-feature
```

**On next Copilot session start**, the `sessionStart` hook will automatically inject your feature context!

### Checking Status

```bash
vibe-status
```

### Closing a Session

```bash
vibe-close
```

### Using Skills with Copilot

GitHub Copilot automatically discovers skills in `.github/skills/` and loads them when relevant to your task. The skill description helps Copilot decide when to use VibePilot patterns.

---

## Tips for GitHub Copilot Users

1. **Commit .github/ to default branch**: Hooks won't work until committed and pushed

2. **Check hook output**: Monitor Copilot's output for hook execution logs

3. **Keep planning files updated**: Since hooks inject context automatically, keep them current

4. **SessionStart advantage**: Unlike Cursor, Copilot injects context on every session start - no manual file reading needed

5. **Works with Copilot CLI**: Hooks also work with `gh copilot` CLI commands

6. **Team collaboration**: Since config is in git, your whole team can use VibePilot patterns

---

## Compatibility with Claude Code and Cursor

Your vibe session files are fully compatible across all three tools:

- `.vibe/` directory works for all
- Planning files have identical format
- Same CLI utilities work everywhere
- ADRs and context files are tool-agnostic

**However**: Each tool requires its own configuration directory (`.claude/`, `.cursor/`, `.github/`). You can have multiple configs in one repo to support different team members using different tools!

---

## Troubleshooting

### Hooks not firing

1. **Check default branch**: Hooks must be committed to default branch (usually `main`)
   ```bash
   git branch --show-current  # Should show your default branch
   git log --oneline -1 .github/hooks/  # Verify hooks are committed
   ```

2. **Verify scripts are executable**:
   ```bash
   ls -l .github/hooks/*.sh
   ```

3. **Make scripts executable if needed**:
   ```bash
   chmod +x .github/hooks/*.sh
   git add .github/hooks/
   git commit -m "Make hook scripts executable"
   git push
   ```

4. **Check Copilot output** for hook execution logs or errors

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

### Hooks work locally but not in Copilot

Ensure `.github/` is committed to the **default branch**:

```bash
git log origin/main -- .github/hooks/hooks.json
```

If empty, hooks aren't on the default branch yet.

---

## Security Note

Since `.github/hooks/` is committed to version control and executed by GitHub Copilot, **only commit trusted hook scripts**. Review hook scripts before committing to ensure they don't contain malicious code.

---

## Need Help?

- Check [troubleshooting.md](troubleshooting.md) for common issues
- Open an issue at [github.com/yourusername/vibepilot/issues](https://github.com/yourusername/vibepilot/issues)
- See [GitHub Copilot hooks documentation](https://docs.github.com/en/copilot/reference/hooks-configuration)
