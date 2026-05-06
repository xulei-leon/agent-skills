#!/usr/bin/env bash
# ============================================================
# NPD-SW Command + Skills - 项目初始化脚本
# 将 NPD-SW Command + Skills 架构部署到目标项目
# ============================================================

set -euo pipefail

# ─── 颜色 ───────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ─── 获取脚本所在目录 (模板根目录) ─────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── 函数 ───────────────────────────────────────────
print_banner() {
  echo -e "${BLUE}"
  echo "╔══════════════════════════════════════════════════╗"
  echo "║     NPD-SW Model & Agile Hybrid                  ║"
  echo "║     Command + Skills 初始化工具 v2.0              ║"
  echo "╚══════════════════════════════════════════════════╝"
  echo -e "${NC}"
}

print_usage() {
  echo "用法:"
  echo "  $0 init [项目目录]       初始化新项目 (将模板复制到目标目录)"
  echo "  $0 status                检查当前项目状态"
  echo ""
  echo "示例:"
  echo "  $0 init /path/to/my-proj   # 为 my-proj 初始化 NPD-SW 流程"
  echo "  $0 init .                  # 在当前目录初始化"
}

# ─── 初始化项目 ────────────────────────────────────
cmd_init() {
  local target="${1:-.}"
  target="$(realpath "$target")"

  # 检查目标目录是否存在
  if [ ! -d "$target" ]; then
    echo -e "${YELLOW}目录不存在，正在创建: $target${NC}"
    mkdir -p "$target"
  fi

  echo -e "${BLUE}→ 初始化 NPD-SW 项目: $target${NC}"

  # 创建目录结构
  local dirs=(
    "$target/opencode/commands"
    "$target/opencode/skills"
    "$target/opencode/workflows"
    "$target/docs/templates"
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
    echo "  ✓ 创建: ${dir#$target/}"
  done

  # 复制 commands
  for cmd_file in "$SCRIPT_DIR"/opencode/commands/*.md; do
    if [ -f "$cmd_file" ]; then
      cp "$cmd_file" "$target/opencode/commands/"
      echo "  ✓ 复制: opencode/commands/$(basename "$cmd_file")"
    fi
  done

  # 复制 skills
  for skill_file in "$SCRIPT_DIR"/opencode/skills/*.md; do
    if [ -f "$skill_file" ]; then
      cp "$skill_file" "$target/opencode/skills/"
      echo "  ✓ 复制: opencode/skills/$(basename "$skill_file")"
    fi
  done

  # 复制 workflows
  for wf_file in "$SCRIPT_DIR"/opencode/workflows/*.md; do
    if [ -f "$wf_file" ]; then
      cp "$wf_file" "$target/opencode/workflows/"
      echo "  ✓ 复制: opencode/workflows/$(basename "$wf_file")"
    fi
  done

  # 复制 sprint
  for sprint_file in "$SCRIPT_DIR"/sprint/*.md; do
    if [ -f "$sprint_file" ]; then
      cp "$sprint_file" "$target/sprint/"
      echo "  ✓ 复制: sprint/$(basename "$sprint_file")"
    fi
  done

  # 复制模板
  for tmpl_file in "$SCRIPT_DIR"/docs/templates/*.md; do
    if [ -f "$tmpl_file" ]; then
      cp "$tmpl_file" "$target/docs/templates/"
      echo "  ✓ 复制: docs/templates/$(basename "$tmpl_file")"
    fi
  done

  # 复制 docs 生命周期模板
  if [ ! -f "$target/docs/01-Concept/Charter.md" ]; then
    cp "$SCRIPT_DIR/docs/01-Concept/Charter.md" "$target/docs/01-Concept/"
  fi
  if [ ! -f "$target/docs/01-Concept/Market_Research.md" ]; then
    cp "$SCRIPT_DIR/docs/01-Concept/Market_Research.md" "$target/docs/01-Concept/"
  fi
  if [ ! -f "$target/docs/01-Concept/User_Research.md" ]; then
    cp "$SCRIPT_DIR/docs/01-Concept/User_Research.md" "$target/docs/01-Concept/"
  fi
  if [ ! -f "$target/docs/02-Requirement/SRS.md" ]; then
    cp "$SCRIPT_DIR/docs/02-Requirement/SRS.md" "$target/docs/02-Requirement/"
  fi
  if [ ! -f "$target/docs/02-Requirement/user-stories.md" ]; then
    cp "$SCRIPT_DIR/docs/02-Requirement/user-stories.md" "$target/docs/02-Requirement/"
  fi
  if [ ! -f "$target/docs/03-Design/SAD.md" ]; then
    cp "$SCRIPT_DIR/docs/03-Design/SAD.md" "$target/docs/03-Design/"
  fi
  if [ ! -f "$target/docs/03-Design/RTM.md" ]; then
    cp "$SCRIPT_DIR/docs/03-Design/RTM.md" "$target/docs/03-Design/"
  fi
  if [ ! -f "$target/docs/05-Test/test-strategy.md" ]; then
    cp "$SCRIPT_DIR/docs/05-Test/test-strategy.md" "$target/docs/05-Test/"
  fi
  if [ ! -f "$target/docs/05-Test/test-design.md" ]; then
    cp "$SCRIPT_DIR/docs/05-Test/test-design.md" "$target/docs/05-Test/"
  fi
  echo "  ✓ 复制: docs/ 生命周期文档模板"
  echo "  ✓ 创建: test/results/"

  # 复制 workflows
  for wf_file in "$SCRIPT_DIR"/opencode/workflows/*.md; do
    if [ -f "$wf_file" ]; then
      cp "$wf_file" "$target/opencode/workflows/"
      echo "  ✓ 复制: opencode/workflows/$(basename "$wf_file")"
    fi
  done

  echo ""
  echo -e "${GREEN}════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}  初始化完成!${NC}"
  echo ""
  echo "  使用方式:"
  echo "    cd $target"
  echo "    使用 Command + Skills 模式:"
  echo "      /npd-concept        # 启动概念阶段"
  echo "      /npd-requirement    # 启动需求分析"
  echo "      /npd-status         # 查看项目状态"
  echo ""
  echo "  详细说明请参考 README.md"
  echo -e "${GREEN}════════════════════════════════════════════════════${NC}"
}

# ─── 全局注册 (Command+Skills 模式无需全局 Agent) ──
cmd_global() {
  echo -e "${YELLOW}Command + Skills 模式无需全局 Agent 注册。${NC}"
  echo -e "${YELLOW}请使用 '$0 init /path/to/project' 初始化项目。${NC}"
}

# ─── 状态检查 ──────────────────────────────────────
cmd_status() {
  echo -e "${BLUE}→ NPD-SW Agent 状态检查${NC}"
  echo ""

  echo "项目根目录: $SCRIPT_DIR"
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
    "opencode/workflows/report-generation.md"
    "opencode/workflows/version-management.md"
    "opencode/skills/state-manager.md"
    "opencode/skills/version-manager.md"
    "opencode/skills/report-gen.md"
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
    "docs/02-Requirement/user-stories.md"
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
      echo -e "  ${RED}✗${NC} $f (缺失)"
    fi
  done

  echo ""

  # 检查 opencode 是否可用
  if command -v opencode &>/dev/null; then
    echo -e "${GREEN}OpenCode CLI 已安装${NC}"
    opencode --version 2>/dev/null || true
  else
    echo -e "${YELLOW}OpenCode CLI 未安装${NC}"
    echo "  安装: curl -fsSL https://opencode.ai/install | bash"
  fi

  echo ""
  echo -e "${BLUE}Command + Skills 模式已就绪。使用 commands/*.md 驱动流程。${NC}"
}

# ─── 主入口 ─────────────────────────────────────────
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
