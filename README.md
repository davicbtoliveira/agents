# agents

Personal rules and skills for coding agents.

- `CLAUDE.md` — global instructions for Claude Code.
- `settings.json` — Claude Code user settings.
- `output-styles/` — custom output styles. `ste.md` makes replies concise and in Simplified Technical English.
- `skills/` — skills in use. Empty for now.
- `install.sh` — installs the files above into `~/.claude`.

## Backup - AVOID OVERWRITING EXISTING CONFIGS

Both setup options below replace `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, and `~/.claude/output-styles`. Copy them first:

```sh
mkdir -p ~/.claude-backup
cp -rL ~/.claude/CLAUDE.md ~/.claude/settings.json ~/.claude/output-styles ~/.claude-backup/
```

`cp` reports the files you don't have; that is fine. To restore, copy them back from `~/.claude-backup`.

## Setup

### With the script

> **Warning:** the script overwrites `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, and `~/.claude/output-styles/ste.md` with no backup. Symlinks there are replaced with plain files. Run the backup above first.

The repo is private, so every request needs a GitHub token. The command uses `gh auth token`; log in with `gh auth login` first.

```sh
curl -fsSL -H "Authorization: Bearer $(gh auth token)" -H "Accept: application/vnd.github.raw" \
  https://api.github.com/repos/davicbtoliveira/agents/contents/install.sh | sh
```

Without `gh`, export `GITHUB_TOKEN` (a token with read access to this repo) and use it in place of `$(gh auth token)`. Set `AGENTS_REF` to install from another branch or tag, and `CLAUDE_CONFIG_DIR` to install somewhere other than `~/.claude`.

### Manual

Clone the repo and link the files, so edits in `~/.claude` go straight into the clone:

```sh
gh repo clone davicbtoliveira/agents ~/dev/github.com/agents
ln -sf ~/dev/github.com/agents/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dev/github.com/agents/settings.json ~/.claude/settings.json
rm -rf ~/.claude/output-styles
ln -s ~/dev/github.com/agents/output-styles ~/.claude/output-styles
```
