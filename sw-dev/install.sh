#!/usr/bin/env bash
# ============================================================
# SW-DEV — Software Development Command & Skills Installer
# Installs sw-dev commands and skills into an existing project.
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
  echo "Usage: $0 <target-dir>"
  echo ""
  echo "Installs sw-dev commands & skills into <target-dir>'s .opencode/ directory."
  echo "Safe to run on an existing npd-sw project — coexists without overwriting."
}

if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

TARGET="$1"

if [ ! -d "$TARGET/.opencode" ]; then
  echo "Error: $TARGET/.opencode not found. Is this an npd-sw project?"
  exit 1
fi

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     SW-DEV Commands & Skills Installer           ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# Copy commands
mkdir -p "$TARGET/.opencode/commands"
for cmd_file in "$SCRIPT_DIR"/.opencode/commands/*.md; do
  if [ -f "$cmd_file" ]; then
    cp "$cmd_file" "$TARGET/.opencode/commands/"
    echo "  ✓ Command: $(basename "$cmd_file")"
  fi
done

# Copy skills
for skill_dir in "$SCRIPT_DIR"/.opencode/skills/*/; do
  if [ -d "$skill_dir" ]; then
    skill_name="$(basename "$skill_dir")"
    mkdir -p "$TARGET/.opencode/skills/$skill_name"
    cp "$skill_dir"SKILL.md "$TARGET/.opencode/skills/$skill_name/"
    echo "  ✓ Skill: $skill_name"
  fi
done

echo ""
echo -e "Done. ${#cmds[@]} commands, ${#skills[@]} skills installed."
echo ""
echo "Available commands:"
for cmd in "$TARGET"/.opencode/commands/swd-*.md; do
  name="$(basename "$cmd" .md)"
  desc="$(head -3 "$cmd" | tail -1 | sed 's/^#* *//')"
  echo "  /$name"
done
