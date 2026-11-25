#!/bin/sh
# Install the Claude Code configs from this repo into ~/.claude.
set -eu

REPO="davicbtoliveira/agents"
REF="${AGENTS_REF:-main}"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
FILES="CLAUDE.md settings.json output-styles/ste.md agents/anvil.md agents/davi.md"
BACKUP="$DEST/backups/agents-$(date +%Y%m%d%H%M%S)"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

for f in $FILES; do
  mkdir -p "$TMP/$(dirname "$f")"
  curl -fsSL -o "$TMP/$f" "https://raw.githubusercontent.com/$REPO/$REF/$f"
done

for f in $FILES; do
  dir="$DEST/$(dirname "$f")"
  if [ -e "$DEST/$f" ]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    cp -L "$DEST/$f" "$BACKUP/$f"
  fi
  # Replace symlinks from an older clone-based setup with plain files.
  [ -L "$dir" ] && rm "$dir"
  mkdir -p "$dir"
  rm -f "$DEST/$f"
  mv "$TMP/$f" "$DEST/$f"
  echo "installed $DEST/$f"
done

[ -d "$BACKUP" ] && echo "previous files saved in $BACKUP"
exit 0
