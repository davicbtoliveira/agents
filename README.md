# agents

Personal rules and skills for coding agents.

- `CLAUDE.md` — global instructions. `~/.claude/CLAUDE.md` is a symlink to this file.
- `settings.json` — Claude Code user settings. `~/.claude/settings.json` is a symlink to this file.
- `output-styles/` — custom output styles. `~/.claude/output-styles` is a symlink to this folder. `ste.md` makes replies concise and in Simplified Technical English.
- `skills/` — skills in use. Empty for now.

## Setup

```sh
ln -sf ~/dev/github.com/agents/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dev/github.com/agents/settings.json ~/.claude/settings.json
ln -sfn ~/dev/github.com/agents/output-styles ~/.claude/output-styles
```
