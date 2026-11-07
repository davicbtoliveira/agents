#!/bin/sh
# Install the Claude Code configs from this repo into ~/.claude.
set -eu

REPO="davicbtoliveira/agents"
REF="${AGENTS_REF:-main}"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
FILES="CLAUDE.md settings.json output-styles/ste.md"

TOKEN="${GITHUB_TOKEN:-$(gh auth token 2>/dev/null || true)}"
if [ -z "$TOKEN" ]; then
  echo "error: set GITHUB_TOKEN or log in with 'gh auth login'" >&2
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

for f in $FILES; do
  mkdir -p "$TMP/$(dirname "$f")"
  curl -fsSL \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github.raw" \
    -o "$TMP/$f" \
    "https://api.github.com/repos/$REPO/contents/$f?ref=$REF"
done

# Replace symlinks from an older clone-based setup with plain files.
for f in $FILES; do
  dir="$DEST/$(dirname "$f")"
  [ -L "$dir" ] && rm "$dir"
  mkdir -p "$dir"
  rm -f "$DEST/$f"
  mv "$TMP/$f" "$DEST/$f"
  echo "installed $DEST/$f"
done
