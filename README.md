# agents

My personal configuration for [Claude Code](https://docs.claude.com/en/docs/claude-code): global rules, settings, an output style, and two custom subagents.

## What is in this repo

| Path | What it does |
| --- | --- |
| `CLAUDE.md` | Global instructions for every project. |
| `settings.json` | Claude Code user settings. |
| `output-styles/ste.md` | The `STE` output style. |
| `agents/anvil.md` | The `anvil` subagent. |
| `agents/davi.md` | The `davi` subagent. |
| `install.sh` | Installs the files above into `~/.claude`. |

### `CLAUDE.md`

The rules bias toward caution over speed:

1. **Think before coding.** Ask when a choice changes the result. State assumptions. Push back when the approach seems wrong.
2. **Simplicity first.** Write the minimum code that solves the problem. Nothing speculative.
3. **Surgical changes.** Every changed line traces back to the request. Mention unrelated dead code; do not delete it.
4. **Goal-driven execution.** Turn each task into a check that can pass or fail, then loop until it passes.
5. **Comments.** Let the code explain itself. Comment only when the reason is not clear.
6. **Commits and PRs.** Sign off with `-s`. Use a fixed AI-disclosure line in place of `Co-Authored-By`.
7. **Subagents.** Plan implementation and reviews in the main session, then hand them to a Sonnet subagent. Docs and trivial tasks go to Haiku.

### `settings.json`

- `model: opus` and `outputStyle: STE`.
- `permissions.defaultMode: auto`.
- No commit or PR attribution (`attribution` empty, `includeCoAuthoredBy: false`). The disclosure line in `CLAUDE.md` replaces it.
- The [pstack](https://github.com/michael-denyer/pstack-claude) plugin, enabled from its git marketplace. Claude Code installs it the first time it starts with these settings.

### `output-styles/ste.md`

Replies use [ASD-STE100 Simplified Technical English](https://www.asd-ste100.org/): approved words, short sentences, active voice, one instruction per sentence, and the answer first. Code, commands, logs, commit messages, and docs keep their own conventions.

### Subagents

- **`anvil`**: evidence-first coding and verification. It reproduces a claim before it acts, keeps changes small, attacks its own result, and reports only what a tool proved. The default mode is verify-only; it edits code only when you ask.
- **`davi`**: an engineering and maintainer partner. It challenges scope, prefers boring and reliable code, keeps the public surface small, and gives a direct recommendation.

## Install

The installer overwrites these files in `~/.claude`:

- `CLAUDE.md`
- `settings.json`
- `output-styles/ste.md`
- `agents/anvil.md`
- `agents/davi.md`

Before it writes, it copies each existing file to `~/.claude/backups/agents-<timestamp>/`. Other files in `~/.claude` stay as they are.

### With the script

```sh
curl -fsSL https://raw.githubusercontent.com/davicbtoliveira/agents/main/install.sh | sh
```

Read the script first if you do not trust a pipe to `sh`:

```sh
curl -fsSL https://raw.githubusercontent.com/davicbtoliveira/agents/main/install.sh -o install.sh
less install.sh
sh install.sh
```

Options:

- `AGENTS_REF=<branch or tag>` installs from another ref. The default is `main`.
- `CLAUDE_CONFIG_DIR=<path>` installs into another directory. The default is `~/.claude`.

### Manual

Clone the repo and link the files, so edits in `~/.claude` go straight into the clone:

```sh
git clone https://github.com/davicbtoliveira/agents.git ~/dev/github.com/agents
ln -sf ~/dev/github.com/agents/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dev/github.com/agents/settings.json ~/.claude/settings.json
mkdir -p ~/.claude/output-styles ~/.claude/agents
ln -sf ~/dev/github.com/agents/output-styles/ste.md ~/.claude/output-styles/ste.md
ln -sf ~/dev/github.com/agents/agents/anvil.md ~/.claude/agents/anvil.md
ln -sf ~/dev/github.com/agents/agents/davi.md ~/.claude/agents/davi.md
```

## How to use

Start Claude Code after the install. Then:

- **Output style.** Replies are in STE. Run `/config` to pick another output style for a session.
- **pstack.** On the first start, accept the prompt to trust the `pstack-claude` marketplace. Type `/poteto-help` to see what the plugin does.
- **Subagents.** Ask for one by name, for example "use anvil to verify this fix" or "ask davi if this flag should exist". Claude can also pick them by their description. Run `/agents` to see them.
- **Your own rules.** `CLAUDE.md` holds my rules. Edit it, or keep your own copy and remove `CLAUDE.md` from `FILES` in `install.sh` before you run it.

To undo the install, copy the files back from the backup folder:

```sh
cp -R ~/.claude/backups/agents-<timestamp>/. ~/.claude/
```
