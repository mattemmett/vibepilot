# Credits and Inspiration

## Acknowledgments

VibePilot was inspired by and builds upon ideas from the open source community:

### planning-with-files

**Project**: [planning-with-files](https://github.com/OthmanAdi/planning-with-files)
**Author**: [OthmanAdi](https://github.com/OthmanAdi)
**License**: MIT

planning-with-files demonstrated the power of using persistent markdown files and Claude Code hooks to extend AI agent memory beyond context windows. Their 3-file pattern (task_plan.md, findings.md, progress.md) and hooks-based automation showed that filesystem-as-memory is a viable approach for managing long-running AI coding sessions.

**What we learned from them**:
- Hooks system for automatic context injection
- Planning files as persistent state
- SessionStart/PreToolUse/PostToolUse lifecycle management
- The "filesystem as memory" paradigm

**How VibePilot differs**:
- Feature-based workspace organization (not root-level planning files)
- Emphasis on vibe engineering (structured but flexible)
- ADR generation and closeout workflow
- Integration with architecture.md/product.md/agents.md context system
- Focus on user control and manual closeout

## Philosophy

We believe in building on the shoulders of giants while creating something new. planning-with-files proved the concept; VibePilot adapts it for developers who want structure without straitjackets.

## License

VibePilot is licensed under the GNU General Public License v3.0 (GPL-3.0) (see LICENSE file).

We encourage you to:
- Use it
- Modify it
- Share it
- Build upon it

Just as we built upon planning-with-files, we hope others build upon VibePilot.

## Contributing

If you'd like to contribute to VibePilot, check out the issues and pull requests on GitHub. We welcome:
- Bug fixes
- Feature additions
- Documentation improvements
- Use case examples

Always maintain the core philosophy: keep developers in the driver's seat.
