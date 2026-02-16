# VibePilot

A toolkit for vibe engineering - tools and skills for developers who want to stay in the driver's seat while leveraging AI to build software.

## What is Vibe Engineering?

You're an experienced developer. You get the power of AI coding, but you know the problems: context windows fill up, planning tools force waterfall thinking when you want to stay agile, and it's easy to lose track of decisions during flow state.

Vibe engineering is the art of staying productive with AI without losing control. It's structured enough to prevent context chaos, but flexible enough to let you explore and iterate.

## What's in this toolkit?

### Skills

**[managing-vibe-sessions](skills/managing-vibe-sessions/)** - Managed vibe sessions with feature workspaces, planning files, and clean closeouts

Commands: `/vibe start`, `/vibe close`, `/vibe status`

### Future Tools (Planned)

- **Context sync detection** - Detect drift between code and architecture/product docs
- **Vibe patterns library** - Documentation on effective vibe engineering practices

## Quick Start

**Installation**: See [skills/managing-vibe-sessions/reference/installation.md](skills/managing-vibe-sessions/reference/installation.md) for setup instructions.

**Usage**:
```bash
# Start a vibe session
/vibe start

# Check status
/vibe status

# When you're done
/vibe close
```

The automation handles context injection via hooks - you just focus on building.

## Philosophy

- **Stay in control**: AI assists, you decide
- **Structure without rigidity**: Framework for vibing, not a straitjacket
- **Context is precious**: Keep docs lean, minimize bloat
- **Close the loop**: Capture decisions, update context, leave a clean trail

## How It Works

VibePilot skills combine three components:

1. **Skill file (SKILL.md)**: Instructions that guide Claude's behavior
2. **Hooks**: Automation scripts that run at lifecycle events (SessionStart, PreToolUse, PostToolUse, PreCompact)
3. **CLI utilities**: Scripts for workspace management

The hooks automatically inject feature context, remind you of progress, and preserve state across context compression. You stay in control, but never lose track of what you're building.

## Project Structure

```
vibepilot/                    # Toolkit repository
├── skills/                   # Individual skills
│   └── managing-vibe-sessions/
│       ├── SKILL.md          # Main skill file
│       ├── hooks/            # Automation hooks
│       ├── bin/              # CLI utilities
│       ├── reference/        # Additional docs
│       └── evaluations/      # Test cases
│
├── features/                 # Our own dogfooding workspace
│   └── initial-development/
│
├── docs/                     # Development documentation
│   └── development/
│       ├── ARCHITECTURE.md
│       ├── PRODUCT.md
│       └── AGENTS.md
│
└── templates/                # Templates for new work
```

## Development

Want to contribute or build your own skills?

- **Architecture**: [docs/development/ARCHITECTURE.md](docs/development/ARCHITECTURE.md) - How VibePilot works
- **Product Vision**: [docs/development/PRODUCT.md](docs/development/PRODUCT.md) - Requirements and roadmap
- **Development Guidelines**: [docs/development/AGENTS.md](docs/development/AGENTS.md) - How to work on VibePilot
- **Contributing**: [docs/development/CONTRIBUTING.md](docs/development/CONTRIBUTING.md) - How to contribute

## Credits

Inspired by [planning-with-files](https://github.com/OthmanAdi/planning-with-files) by [OthmanAdi](https://github.com/OthmanAdi). See [CREDITS.md](CREDITS.md) for details.

## License

GNU General Public License v3.0 (GPL-3.0) - See [LICENSE](LICENSE) file.
