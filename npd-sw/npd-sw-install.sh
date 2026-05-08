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
    "$target/agents/commands"
    "$target/agents/skills"
    "$target/agents/workflows"
    "$target/docs/01-Concept"
    "$target/docs/02-Requirement"
    "$target/sprint/done"
    "$target/docs/03-Design"
    "$target/docs/04-Develop"
    "$target/docs/05-Test"
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
  for cmd_file in "$SCRIPT_DIR"/agents/commands/*.md; do
    if [ -f "$cmd_file" ]; then
      cp "$cmd_file" "$target/agents/commands/"
      echo "  ✓ Copied: agents/commands/$(basename "$cmd_file")"
    fi
  done

  # Copy skills (each in its own subdirectory with SKILL.md)
  for skill_dir in "$SCRIPT_DIR"/agents/skills/*/; do
    if [ -d "$skill_dir" ]; then
      cp -r "$skill_dir" "$target/agents/skills/"
      echo "  ✓ Copied: agents/skills/$(basename "$skill_dir")/SKILL.md"
    fi
  done

  # Copy workflows
  for wf_file in "$SCRIPT_DIR"/agents/workflows/*.md; do
    if [ -f "$wf_file" ]; then
      cp "$wf_file" "$target/agents/workflows/"
      echo "  ✓ Copied: agents/workflows/$(basename "$wf_file")"
    fi
  done

  # Copy sprint
  for sprint_file in "$SCRIPT_DIR"/sprint/*.md; do
    if [ -f "$sprint_file" ]; then
      cp "$sprint_file" "$target/sprint/"
      echo "  ✓ Copied: sprint/$(basename "$sprint_file")"
    fi
  done

  # Copy doc lifecycle templates (force override)
  cp -r "$SCRIPT_DIR/docs/"* "$target/docs/"
  echo "  ✓ Copied: doc lifecycle templates"
  mkdir -p "$target/test/st"
  for st_file in "$SCRIPT_DIR"/test/st/*.md; do
    if [ -f "$st_file" ]; then
      cp "$st_file" "$target/test/st/"
      echo "  ✓ Copied: test/st/$(basename "$st_file")"
    fi
  done
  echo "  ✓ Created: test/results/"

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
    "agents/commands/npd-concept.md"
    "agents/commands/npd-requirement.md"
    "agents/commands/npd-design.md"
    "agents/commands/npd-develop.md"
    "agents/commands/npd-launch.md"
    "agents/commands/npd-test.md"
    "agents/commands/npd-decision.md"
    "agents/commands/npd-status.md"
    "agents/workflows/phase0-concept.md"
    "agents/workflows/phase1-requirement.md"
    "agents/workflows/phase2-design.md"
    "agents/workflows/phase3-develop.md"
    "agents/workflows/phase4-test.md"
    "agents/workflows/phase5-launch.md"
    "agents/workflows/gate-decision.md"
    "agents/workflows/status-check.md"
    "agents/workflows/git-ops.md"
    "agents/skills/state-manager/SKILL.md"
    "agents/skills/test-reporter/SKILL.md"
    "agents/skills/review-tracker/SKILL.md"
    "agents/skills/market-analysis/SKILL.md"
    "agents/skills/requirements-analysis/SKILL.md"
    "agents/skills/software-architecture-design/SKILL.md"
    "agents/skills/testcase-designer/SKILL.md"
    "agents/skills/git-ops/SKILL.md"
    "agents/skills/milestone-planner/SKILL.md"
    "agents/skills/programmer/SKILL.md"
    "agents/skills/code-reviewer/SKILL.md"
    "agents/skills/rtm-builder/SKILL.md"
    "agents/skills/backlog-builder/SKILL.md"
    "agents/skills/version-manager/SKILL.md"
    "test/st/st-case-template.md"
    "docs/01-Concept/Charter-template.md"
    "docs/01-Concept/Market_Research-template.md"
    "docs/01-Concept/User_Research-template.md"
    "docs/02-Requirement/SRS-template.md"
    ".npd-status.json"
    "sprint/backlog-template.md"
    "sprint/sprint-template.md"
    "docs/03-Design/SAD-template.md"
    "docs/03-Design/milestones-template.md"
    "docs/03-Design/RTM-template.md"
    "docs/05-Test/test-strategy-template.md"
    "docs/05-Test/test-design-template.md"
    "agents/workflows"
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
