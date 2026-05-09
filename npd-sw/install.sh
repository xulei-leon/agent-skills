#!/usr/bin/env bash
# ============================================================
# NPD-SW Command + Skills - Project Initialization Script
# Deploy NPD-SW Command + Skills architecture to target project
# ============================================================

set -euo pipefail

# ─── Colors ───────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ─── Get script directory (template root) ─────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Functions ───────────────────────────────────────────
print_banner() {
  echo -e "${BLUE}"
  echo "╔══════════════════════════════════════════════════╗"
  echo "║     NPD-SW Model & Agile Hybrid                  ║"
  echo "║     Command + Skills Init Tool v2.0               ║"
  echo "╚══════════════════════════════════════════════════╝"
  echo -e "${NC}"
}

print_usage() {
  echo "Usage:"
  echo "  $0 init [target-dir]      Initialize new project (copy templates to target)"
  echo "  $0 status                 Check current project status"
  echo ""
  echo "Examples:"
  echo "  $0 init /path/to/my-proj   # Initialize NPD-SW workflow for my-proj"
  echo "  $0 init .                  # Initialize in current directory"
}

# ─── Template Copy Helper ──────────────────────────────
# Copies a -template file to target. If the non-template version exists,
# copies as -template (reference only). Otherwise strips -template suffix.
copy_template() {
  local src="$1"
  local dst_dir="$2"
  local basename="$(basename "$src")"

  # Strip -template suffix: file-template.ext → file.ext
  local base="${basename%-template*}"
  local ext="${basename##*.}"
  local target_name="${base}.${ext}"

  if [ -f "$dst_dir/$target_name" ]; then
    cp "$src" "$dst_dir/$basename"
    echo "  ✓ Template: $basename ($target_name exists)"
  else
    cp "$src" "$dst_dir/$target_name"
    echo "  ✓ Copied: $target_name"
  fi
}

# ─── Init Project ────────────────────────────────────
cmd_init() {
  local target="${1:-.}"
  target="$(realpath "$target")"

  # Check if target directory exists
  if [ ! -d "$target" ]; then
    echo -e "${YELLOW}Directory does not exist, creating: $target${NC}"
    mkdir -p "$target"
  fi

  echo -e "${BLUE}→ Initializing NPD-SW project: $target${NC}"

  # Create directory structure
  local dirs=(
    "$target/.opencode/commands"
    "$target/.opencode/skills"
    "$target/.opencode/workflows"
    "$target/docs/0-Concept"
    "$target/docs/1-Requirement"
    "$target/sprint/done"
    "$target/docs/2-Design"
    "$target/docs/3-Develop"
    "$target/docs/4-Test"
    "$target/docs/5-Launch"
    "$target/test/st"
    "$target/test/ut"
    "$target/test/results"
    "$target/src"
  )
  for dir in "${dirs[@]}"; do
    mkdir -p "$dir"
    echo "  ✓ Created: ${dir#$target/}"
  done

  # Copy commands
  for cmd_file in "$SCRIPT_DIR"/.opencode/commands/*.md; do
    if [ -f "$cmd_file" ]; then
      cp "$cmd_file" "$target/.opencode/commands/"
      echo "  ✓ Copied: .opencode/commands/$(basename "$cmd_file")"
    fi
  done

  # Copy skills (each in its own subdirectory with SKILL.md)
  for skill_dir in "$SCRIPT_DIR"/.opencode/skills/*/; do
    if [ -d "$skill_dir" ]; then
      cp -r "$skill_dir" "$target/.opencode/skills/"
      echo "  ✓ Copied: .opencode/skills/$(basename "$skill_dir")/SKILL.md"
    fi
  done

  # Copy workflows
  for wf_file in "$SCRIPT_DIR"/.opencode/workflows/*.md; do
    if [ -f "$wf_file" ]; then
      cp "$wf_file" "$target/.opencode/workflows/"
      echo "  ✓ Copied: .opencode/workflows/$(basename "$wf_file")"
    fi
  done

  # Copy sprint templates
  for sprint_file in "$SCRIPT_DIR"/sprint/*.md; do
    if [ -f "$sprint_file" ]; then
      copy_template "$sprint_file" "$target/sprint/"
    fi
  done

  # Copy doc lifecycle templates (intelligently handle -template suffix)
  for doc_subdir in "$SCRIPT_DIR"/docs/*/; do
    local doc_dir_name="$(basename "$doc_subdir")"
    for doc_file in "$doc_subdir"*.md "$doc_subdir"*.json; do
      if [ -f "$doc_file" ]; then
        mkdir -p "$target/docs/$doc_dir_name"
        copy_template "$doc_file" "$target/docs/$doc_dir_name"
      fi
    done
  done
  mkdir -p "$target/test/st"
  for st_file in "$SCRIPT_DIR"/test/st/*.md; do
    if [ -f "$st_file" ]; then
      copy_template "$st_file" "$target/test/st/"
    fi
  done
  echo "  ✓ Created: test/results/"

  # Copy .npd-status template
  copy_template "$SCRIPT_DIR/.npd-status-template.json" "$target/"

  echo ""
  echo -e "${GREEN}════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}  Initialization complete!${NC}"
  echo ""
  echo "  Usage:"
  echo "    cd $target"
  echo "    /npd-concept        # Start concept phase"
  echo "    /npd-requirement    # Start requirement analysis"
  echo "    /npd-status         # Check project status"
  echo ""
  echo "  See README.md for details"
  echo -e "${GREEN}════════════════════════════════════════════════════${NC}"
}

# ─── Global Registration (no global agent needed for Command+Skills) ──
cmd_global() {
  echo -e "${YELLOW}Command + Skills mode needs no global agent registration.${NC}"
  echo -e "${YELLOW}Use '$0 init /path/to/project' to initialize a project.${NC}"
}

# ─── Status Check ──────────────────────────────────────
cmd_status() {
  echo -e "${BLUE}→ NPD-SW Installation Status Check${NC}"
  echo ""
  echo "Project root: $SCRIPT_DIR"
  echo ""

  local files=(
    ".opencode/commands/npd-concept.md"
    ".opencode/commands/npd-requirement.md"
    ".opencode/commands/npd-design.md"
    ".opencode/commands/npd-develop.md"
    ".opencode/commands/npd-launch.md"
    ".opencode/commands/npd-test.md"
    ".opencode/commands/npd-decision.md"
    ".opencode/commands/npd-status.md"
    ".opencode/workflows/phase0-concept.md"
    ".opencode/workflows/phase1-requirement.md"
    ".opencode/workflows/phase2-design.md"
    ".opencode/workflows/phase3-develop.md"
    ".opencode/workflows/phase4-test.md"
    ".opencode/workflows/phase5-launch.md"
    ".opencode/workflows/gate-decision.md"
    ".opencode/workflows/status-check.md"
    ".opencode/workflows/git-ops.md"
    ".opencode/skills/state-manager/SKILL.md"
    ".opencode/skills/test-reporter/SKILL.md"
    ".opencode/skills/review-tracker/SKILL.md"
    ".opencode/skills/market-analysis/SKILL.md"
    ".opencode/skills/requirements-analysis/SKILL.md"
    ".opencode/skills/software-architecture-design/SKILL.md"
    ".opencode/skills/testcase-designer/SKILL.md"
    ".opencode/skills/git-ops/SKILL.md"
    ".opencode/skills/milestone-planner/SKILL.md"
    ".opencode/skills/programmer/SKILL.md"
    ".opencode/skills/code-reviewer/SKILL.md"
    ".opencode/skills/rtm-builder/SKILL.md"
    ".opencode/skills/backlog-builder/SKILL.md"
    ".opencode/skills/version-manager/SKILL.md"
    "test/st/st-case.md"
    "docs/0-Concept/Charter.md"
    "docs/0-Concept/Market_Research.md"
    "docs/0-Concept/User_Research.md"
    "docs/1-Requirement/SRS.md"
    ".npd-status.json"
    "sprint/backlog.md"
    "sprint/sprint.md"
    "docs/2-Design/SAD.md"
    "docs/2-Design/milestones.md"
    "docs/2-Design/RTM.md"
    "docs/4-Test/test-strategy.md"
    "docs/4-Test/test-design.md"
    ".opencode/workflows"
  )

  for f in "${files[@]}"; do
    if [ -f "$SCRIPT_DIR/$f" ]; then
      echo -e "  ${GREEN}✓${NC} $f"
    else
      echo -e "  ${RED}✗${NC} $f (missing)"
    fi
  done

  echo ""

  # Check opencode availability
  if command -v opencode &>/dev/null; then
    echo -e "${GREEN}OpenCode CLI installed${NC}"
    opencode --version 2>/dev/null || true
  else
    echo -e "${YELLOW}OpenCode CLI not installed${NC}"
    echo "  Install: curl -fsSL https://opencode.ai/install | bash"
  fi

  echo ""
  echo -e "${BLUE}Command + Skills mode ready. Use commands/*.md to drive the workflow.${NC}"
}

# ─── Main Entry ─────────────────────────────────────────
main() {
  print_banner

  case "${1:-}" in
    init)
      cmd_init "${2:-.}"
      ;;
    status)
      cmd_status
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
}

main "$@"
