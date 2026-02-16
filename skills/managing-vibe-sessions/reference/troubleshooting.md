# Troubleshooting Guide

## Common Issues

### Skill not loading

**Symptom**: `/vibe` commands not recognized

**Solutions**:
1. Verify skill is in skills directory:
   ```bash
   ls ~/.claude/skills/managing-vibe-sessions/SKILL.md
   ```

2. Restart Claude Code:
   ```bash
   # Exit current session and start new one
   claude
   ```

3. Check skill name in SKILL.md frontmatter matches directory name

### Hooks not injecting context

**Symptom**: No feature context shown at session start

**Solutions**:
1. Verify hooks are configured in `~/.claude/settings.json`:
   ```bash
   cat ~/.claude/settings.json | jq '.hooks'
   ```

2. Check hooks are executable:
   ```bash
   ls -l ~/.claude/skills/managing-vibe-sessions/hooks/*.sh
   ```

3. Test hook manually:
   ```bash
   echo '{"source":"startup","cwd":"'$(pwd)'"}' | ~/.claude/skills/managing-vibe-sessions/hooks/session-start.sh
   ```

4. Run Claude with debug mode:
   ```bash
   claude --debug
   ```

### vibe-start fails

**Symptom**: Error when running `/vibe start`

**Solutions**:
1. Check script is executable:
   ```bash
   ls -l ~/.claude/skills/managing-vibe-sessions/bin/vibe-start
   ```

2. Verify jq is installed:
   ```bash
   which jq
   ```

3. Run script manually to see detailed errors:
   ```bash
   ~/.claude/skills/managing-vibe-sessions/bin/vibe-start test-feature
   ```

### Planning files not found

**Symptom**: Hooks show "file not found" errors

**Solutions**:
1. Verify active feature exists:
   ```bash
   cat .vibe/active-feature
   ls features/$(cat .vibe/active-feature)/planning/
   ```

2. Check feature workspace structure:
   ```bash
   find features/$(cat .vibe/active-feature) -type f
   ```

3. If corrupted, start fresh:
   ```bash
   rm -f .vibe/active-feature
   /vibe start
   ```

### Context not updating after changes

**Symptom**: Old context persists after making edits

**Solutions**:
1. Hooks read files directly - no caching involved
2. Check files are actually saved:
   ```bash
   ls -l features/$(cat .vibe/active-feature)/planning/*.md
   ```

3. Manually trigger context injection:
   ```bash
   /vibe status
   ```

### ADR generation fails

**Symptom**: `/vibe close` errors during ADR creation

**Solutions**:
1. Check planning files exist:
   ```bash
   ls features/$(cat .vibe/active-feature)/planning/
   ```

2. Verify decisions directory exists:
   ```bash
   mkdir -p features/$(cat .vibe/active-feature)/decisions
   ```

3. Run close script manually:
   ```bash
   ~/.claude/skills/managing-vibe-sessions/bin/vibe-close
   ```

### Permission errors

**Symptom**: "Permission denied" when running scripts

**Solutions**:
1. Make scripts executable:
   ```bash
   chmod +x ~/.claude/skills/managing-vibe-sessions/bin/*
   chmod +x ~/.claude/skills/managing-vibe-sessions/hooks/*.sh
   ```

2. Check file ownership:
   ```bash
   ls -l ~/.claude/skills/managing-vibe-sessions/
   ```

### Hooks timeout

**Symptom**: "Hook timed out" errors

**Solutions**:
1. Check if filesystem is slow (network drives, etc.)
2. Increase timeout in settings.json:
   ```json
   {
     "hooks": {
       "SessionStart": [{
         "hooks": [{
           "timeout": 10000  // Increase from 5000
         }]
       }]
     }
   }
   ```

3. Simplify hook scripts if reading too many files

## Debug Mode

Run Claude with debug mode to see detailed hook execution:

```bash
claude --debug
```

This shows:
- Which hooks fire
- Hook execution time
- Hook output and errors
- Context injection details

## Getting Help

If issues persist:

1. Check the [GitHub issues](https://github.com/yourusername/vibepilot/issues)
2. Review planning-with-files issues (similar architecture)
3. Open a new issue with:
   - Claude Code version
   - Operating system
   - Error messages (from debug mode)
   - Steps to reproduce

## Known Limitations

- **macOS/Linux only**: Windows support not tested
- **Bash required**: Other shells may have compatibility issues
- **jq dependency**: Must be installed separately
- **Path spaces**: Always quote paths with spaces in custom scripts
