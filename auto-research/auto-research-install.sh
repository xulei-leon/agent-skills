#!/usr/bin/env bash
# auto-research-install.sh — Install the auto-research template into a target project.
#
# Usage:
#   ./auto-research-install.sh init <target-dir>
#
# Copies .opencode/ (commands, workflows, skills) and research/ into the target.
# Does NOT overwrite existing files. Safe to run multiple times.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"

usage() {
    echo "Usage: $0 init <target-dir>"
    echo ""
    echo "  init <target-dir>  Copy auto-research template files into the target project"
    exit 1
}

init_target() {
    local target="$1"

    if [ ! -d "$target" ]; then
        echo "Error: target directory '$target' does not exist"
        exit 1
    fi

    echo "Installing auto-research template into: $target"

    # Copy .opencode directory
    if [ -d "$TEMPLATE_DIR/.opencode" ]; then
        mkdir -p "$target/.opencode"
        cp -rn "$TEMPLATE_DIR/.opencode/"* "$target/.opencode/" 2>/dev/null || true
        echo "  ✓ .opencode/ (commands, workflows, skills)"
    fi

    # Copy research directory
    if [ -d "$TEMPLATE_DIR/research" ]; then
        mkdir -p "$target/research"
        cp -rn "$TEMPLATE_DIR/research/"* "$target/research/" 2>/dev/null || true
        echo "  ✓ research/ (target.md template)"
    fi

    # Copy status file if not present
    if [ -f "$TEMPLATE_DIR/.auto-research-status.json" ] && [ ! -f "$target/.auto-research-status.json" ]; then
        cp "$TEMPLATE_DIR/.auto-research-status.json" "$target/.auto-research-status.json"
        echo "  ✓ .auto-research-status.json"
    fi

    echo ""
    echo "Installation complete."
    echo ""
    echo "Next steps:"
    echo "  1. Edit research/target.md to define your research goal"
    echo "  2. Verify your environment (dependencies, hardware, data)"
    echo "  3. Run the command: /auto-research"
}

# Main
case "${1:-}" in
    init)
        if [ -z "${2:-}" ]; then
            usage
        fi
        init_target "$2"
        ;;
    *)
        usage
        ;;
esac
