# Installation Guide

## Prerequisites

- Claude Code CLI installed
- `jq` command-line JSON processor
- Bash shell (macOS/Linux) or compatible shell

## Installation Steps

### Option 1: Install Single Skill

Copy the managing-vibe-sessions skill to your Claude skills directory:

```bash
# Clone the vibepilot repo
git clone https://github.com/yourusername/vibepilot.git
cd vibepilot

# Copy the skill
cp -r skills/managing-vibe-sessions ~/.claude/skills/

# Make scripts executable
chmod +x ~/.claude/skills/managing-vibe-sessions/bin/*
chmod +x ~/.claude/skills/managing-vibe-sessions/hooks/*.sh
```

### Option 2: Install All VibePilot Skills

```bash
# Install all skills from the toolkit
cp -r skills/* ~/.claude/skills/

# Make all scripts executable
find ~/.claude/skills -type f \( -name "*.sh" -o -path "*/bin/*" \) -exec chmod +x {} \;
```

### Configure Hooks

The skill includes hooks that need to be configured in your Claude settings:

```bash
# Edit your Claude settings
nano ~/.claude/settings.json
```

Add the hooks configuration (or merge with existing hooks):

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/managing-vibe-sessions/hooks/session-start.sh",
            "timeout": 5000
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Write|Edit|Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/managing-vibe-sessions/hooks/pre-tool-use.sh",
            "timeout": 3000
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit|Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/managing-vibe-sessions/hooks/post-tool-use.sh",
            "timeout": 2000
          }
        ]
      }
    ],
    "PreCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/managing-vibe-sessions/hooks/pre-compact.sh",
            "timeout": 5000
          }
        ]
      }
    ]
  }
}
```

### Add bin to PATH (Optional)

If you want to use the CLI utilities directly:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:$HOME/.claude/skills/managing-vibe-sessions/bin"

# Reload shell
source ~/.zshrc  # or ~/.bashrc
```

## Verification

Test that everything is installed:

```bash
# Start a new Claude Code session
claude

# In the session, try:
/vibe status
```

You should see: "No active vibe session"

## Troubleshooting

### Hooks not firing

1. Check hooks are configured in settings.json:
   ```bash
   cat ~/.claude/settings.json | jq '.hooks'
   ```

2. Test with debug mode:
   ```bash
   claude --debug
   ```

3. Verify scripts are executable:
   ```bash
   ls -l ~/.claude/skills/managing-vibe-sessions/hooks/*.sh
   ```

### Scripts not found

1. Check PATH includes bin directory:
   ```bash
   echo $PATH | grep claude
   ```

2. Verify bin scripts exist:
   ```bash
   ls -l ~/.claude/skills/managing-vibe-sessions/bin/
   ```

### jq not found

Install jq:

```bash
# macOS
brew install jq

# Linux (Debian/Ubuntu)
sudo apt-get install jq

# Linux (RHEL/CentOS)
sudo yum install jq
```

## Uninstallation

```bash
# Remove skill
rm -rf ~/.claude/skills/managing-vibe-sessions

# Remove hooks configuration from ~/.claude/settings.json
# (Edit file and remove managing-vibe-sessions hooks)

# Remove from PATH
# (Edit ~/.zshrc or ~/.bashrc and remove PATH addition)
```

## Next Steps

Once installed:
- Try `/vibe start` to create your first session
- Check the main [README](../../README.md) for usage examples
- See [troubleshooting.md](troubleshooting.md) for common issues
