#!/usr/bin/env bash
# thesis-research-install.sh — Install the thesis-research template into a target project.
#
# Usage:
#   ./thesis-research-install.sh init <target-dir>
#
# Copies .opencode/ (commands, workflows, skills) and thesis/ (templates, target.md)
# into the target. Does NOT overwrite existing files. Safe to run multiple times.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"

usage() {
    echo "Usage: $0 init <target-dir>"
    echo ""
    echo "  init <target-dir>  Copy thesis-research template files into the target project"
    exit 1
}

init_target() {
    local target="$1"

    if [ ! -d "$target" ]; then
        echo "Error: target directory '$target' does not exist"
        exit 1
    fi

    echo "Installing thesis-research template into: $target"

    # Copy .opencode directory
    if [ -d "$TEMPLATE_DIR/.opencode" ]; then
        mkdir -p "$target/.opencode"
        cp -rn "$TEMPLATE_DIR/.opencode/"* "$target/.opencode/" 2>/dev/null || true
        echo "  ✓ .opencode/ (commands, workflows, skills)"
    fi

    # Copy thesis directory
    if [ -d "$TEMPLATE_DIR/thesis" ]; then
        mkdir -p "$target/thesis"
        cp -rn "$TEMPLATE_DIR/thesis/"* "$target/thesis/" 2>/dev/null || true
        echo "  ✓ thesis/ (target.md, templates)"
    fi

    # Copy status file if not present
    if [ -f "$TEMPLATE_DIR/.thesis-status.json" ] && [ ! -f "$target/.thesis-status.json" ]; then
        cp "$TEMPLATE_DIR/.thesis-status.json" "$target/.thesis-status.json"
        echo "  ✓ .thesis-status.json"
    fi

    echo ""
    echo "Installation complete."
    echo ""
    echo "Next steps:"
    echo "  1. Run /thesis-init <research direction> to start a new paper"
    echo "  2. Or run /thesis-continue to resume an existing project"
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
