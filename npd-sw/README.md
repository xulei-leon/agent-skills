# NPD-SW Command + Skills

**NPD-SW Model & Agile Hybrid — Command + Skills 模式模板项目**

一套基于 Command + Skills 模式的流程驱动型开发框架，遵循 NPD-SW Model 的 6 阶段生命周期（概念→需求→设计→开发→测试→发布），融合敏捷迭代和 TDD 实践。

---

## 特性

- **Command 驱动** — 每个阶段对应一个 `commands/` 中的 MD 命令，聚焦单一目标
- **Skills 复用** — 共享能力抽象为 `skills/`，命令通过引用技能组合完成工作
- **6 阶段全流程覆盖** — 概念论证 → 需求分析 → 架构设计 → 迭代开发 → 系统测试 → 部署发布
- **评审门控机制** — 每阶段/里程碑强制评审，通过后才能进入下一步
- **TDD 强制** — 先写测试用例，再写实现代码
- **Sprint 驱动** — sprint/backlog.md + sprint/sprint.md 管理迭代

---

## 生命周期

| Phase | 阶段 | 文档产出 | 出口条件 |
|-------|------|---------|---------|
| 0 | **概念 (Research → Charter)** | Market Research, User Research → Charter | `Charter Approved` |
| 1 | **需求 (Requirement)** | SRS, SAD, ST Cases | `Phase 1 Approved` |
| 2 | **设计 (Design)** | sprint/backlog.md, sprint/sprint.md, RTM | `Phase 2 Approved` |
| 3 | **开发 (Develop)** | src/, UT | `Review Passed: M{n}` |
| 4 | **测试 (Test)** | System Test Report | 所有 ST 通过 |
| 5 | **发布 (Launch)** | build-report, CHANGELOG, Git Tag | 构建成功 |

---

## 目录结构

```
npd-sw/
├── opencode/                           # ★ Command + Workflow + Skill 定义
│   ├── commands/                       #   命令定义
│   │   ├── npd-concept.md
│   │   ├── npd-requirement.md
│   │   ├── npd-design.md
│   │   ├── npd-develop.md
│   │   ├── npd-test.md
│   │   ├── npd-launch.md
│   │   ├── npd-decision.md
│   │   └── npd-status.md
│   ├── workflows/                      #   工作流定义
│   │   ├── phase0-concept.md
│   │   ├── phase1-requirement.md
│   │   ├── phase2-design.md
│   │   ├── phase3-develop.md
│   │   ├── phase4-test.md
│   │   ├── phase5-launch.md
│   │   ├── gate-decision.md
│   │   ├── status-check.md
│   │   ├── git-ops.md
│   │   ├── project-validation.md
│   │   ├── report-generation.md
│   │   └── version-management.md
│   └── skills/                         #   Skill 定义
│       ├── state-manager.md
│       ├── version-manager.md
│       ├── report-gen.md
│       ├── review-tracker.md
│       ├── market-analysis.md
│       ├── requirements-analysis.md
│       ├── software-architecture-design.md
│       ├── test-gen.md
│       ├── git-ops.md
│       ├── milestone-planner.md
│       └── code-impl.md
│
├── docs/
│   ├── templates/                      # 文档模板
│   │   ├── srs-template.md
│   │   ├── sad-template.md
│   │   ├── st-template.md
│   │   └── spec-template.md
│   ├── 01-Concept/
│   ├── 02-Requirement/
│   ├── 03-Design/
│   ├── 04-Develop/
│   ├── 05-Test/
│   └── 06-Launch/
├── init-npd-sw.sh                        # 脚手架脚本
│
└── test/
    ├── st/
    ├── ut/
    └── results/
```

---

## 快速开始

```bash
git clone <repo-url>
cd npd-sw
chmod +x init-npd-sw.sh

# 初始化新项目
./init-npd-sw.sh init /path/to/my-project
```

---

## 使用方式

通过命令名调用相应流程：

| 命令 | 用途 |
|------|------|
| `/npd-concept` | 启动概念阶段 |
| `/npd-requirement` | 启动需求分析阶段 |
| `/npd-design` | 启动设计阶段 |
| `/npd-develop` | 启动迭代开发 |
| `/npd-test` | 启动系统测试阶段 |
| `/npd-launch` | 启动部署发布 |
| `/npd-decision` | 处理评审结果 |
| `/npd-status` | 查看项目状态 |

### 命令格式

每个命令包含：
- **Goal** — 目标描述
- **Instructions** — 步骤化指引，引用 Skills
- **Constraints** — 约束条件

### 完整流程

```
Phase 0: /npd-concept           → 输出评审 -> Phase 0 Approved
Phase 1: /npd-requirement       → 输出评审 -> Phase 1 Approved
Phase 2: /npd-design            → 输出评审 -> Phase 2 Approved
Phase 3: /npd-develop (per M{n}) → 输出评审 -> Review Passed: M{n}
Phase 4: /npd-test              → 所有 ST 通过
Phase 5: /npd-launch            → 构建成功
```

---

## Command vs Agent 对比

| 维度 | Agent 模式 (旧) | Command + Skills (新) |
|------|----------------|----------------------|
| 复杂度 | 单个超大 prompt (387行) | 多个聚焦命令 + 轻量 skill |
| 可维护性 | 耦合度高, 改一处影响全局 | 低耦合, 每个命令独立 |
| 复用性 | 逻辑内嵌在 prompt 中 | Skills 可跨命令复用 |
| 可测试性 | 依赖完整对话测试 | 单命令可独立验证 |
| 心智负担 | 高 (AI 需理解完整流程) | 低 (每次聚焦一个任务) |

---

## 许可证

MIT
