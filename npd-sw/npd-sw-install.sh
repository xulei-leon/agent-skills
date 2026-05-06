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
    "$target/opencode/commands"
    "$target/opencode/skills"
    "$target/opencode/workflows"
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
  for cmd_file in "$SCRIPT_DIR"/opencode/commands/*.md; do
    if [ -f "$cmd_file" ]; then
      cp "$cmd_file" "$target/opencode/commands/"
      echo "  ✓ Copied: opencode/commands/$(basename "$cmd_file")"
    fi
  done

  # Copy skills
  for skill_file in "$SCRIPT_DIR"/opencode/skills/*.md; do
    if [ -f "$skill_file" ]; then
      cp "$skill_file" "$target/opencode/skills/"
      echo "  ✓ Copied: opencode/skills/$(basename "$skill_file")"
    fi
  done

  # Copy workflows
  for wf_file in "$SCRIPT_DIR"/opencode/workflows/*.md; do
    if [ -f "$wf_file" ]; then
      cp "$wf_file" "$target/opencode/workflows/"
      echo "  ✓ Copied: opencode/workflows/$(basename "$wf_file")"
    fi
  done

  # Copy sprint
  for sprint_file in "$SCRIPT_DIR"/sprint/*.md; do
    if [ -f "$sprint_file" ]; then
      cp "$sprint_file" "$target/sprint/"
      echo "  ✓ Copied: sprint/$(basename "$sprint_file")"
    fi
  done

  # Copy doc lifecycle templates (skip if any doc already exists to avoid overwrite)
  if [ ! -f "$target/docs/01-Concept/Charter.md" ]; then
    cp -r "$SCRIPT_DIR/docs/"* "$target/docs/"
    echo "  ✓ Copied: doc lifecycle templates"
  else
    echo "  ○ docs already exist, skipping copy"
  fi
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
    "opencode/commands/npd-concept.md"
    "opencode/commands/npd-requirement.md"
    "opencode/commands/npd-design.md"
    "opencode/commands/npd-develop.md"
    "opencode/commands/npd-launch.md"
    "opencode/commands/npd-test.md"
    "opencode/commands/npd-decision.md"
    "opencode/commands/npd-status.md"
    "opencode/workflows/phase0-concept.md"
    "opencode/workflows/phase1-requirement.md"
    "opencode/workflows/phase2-design.md"
    "opencode/workflows/phase3-develop.md"
    "opencode/workflows/phase4-test.md"
    "opencode/workflows/phase5-launch.md"
    "opencode/workflows/gate-decision.md"
    "opencode/workflows/status-check.md"
    "opencode/workflows/git-ops.md"
    "opencode/workflows/project-validation.md"
    "opencode/skills/state-manager.md"
    "opencode/skills/test-reporter.md"
    "opencode/skills/review-tracker.md"
    "opencode/skills/market-analysis.md"
    "opencode/skills/requirements-analysis.md"
    "opencode/skills/software-architecture-design.md"
    "opencode/skills/testcase-designer.md"
    "opencode/skills/git-ops.md"
    "opencode/skills/milestone-planner.md"
    "opencode/skills/programmer.md"
    "opencode/skills/code-reviewer.md"
    "opencode/skills/rtm-builder.md"
    "opencode/skills/backlog-builder.md"
    "test/st/st-case.md"
    "docs/01-Concept/Charter.md"
    "docs/01-Concept/Market_Research.md"
    "docs/01-Concept/User_Research.md"
    "docs/02-Requirement/SRS.md"
    ".npd-status.md"
    "sprint/backlog.md"
    "sprint/sprint.md"
    "docs/03-Design/SAD.md"
    "docs/03-Design/milestones.md"
    "docs/03-Design/RTM.md"
    "docs/05-Test/test-strategy.md"
    "docs/05-Test/test-design.md"
    "opencode/workflows"
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
