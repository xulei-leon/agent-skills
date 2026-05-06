# CMMV Command + Skills

**CMM V-Model & Agile Hybrid — Command + Skills 模式模板项目**

一套基于 Command + Skills 模式的流程驱动型开发框架，遵循 CMM V-Model 的 6 阶段生命周期（概念→需求→设计→开发→测试→发布），融合敏捷迭代和 TDD 实践。

---

## 特性

- **Command 驱动** — 每个阶段对应一个 `commands/` 中的 MD 命令，聚焦单一目标
- **Skills 复用** — 共享能力抽象为 `skills/`，命令通过引用技能组合完成工作
- **6 阶段全流程覆盖** — 概念论证 → 需求分析 → 架构设计 → 迭代开发 → 系统测试 → 部署发布
- **评审门控机制** — 每阶段/里程碑强制评审，通过后才能进入下一步
- **TDD 强制** — 先写测试用例，再写实现代码
- **状态持久化** — `state.json` 追踪工作流进度，断点续做

---

## 生命周期

| Phase | 阶段 | 文档产出 | 出口条件 |
|-------|------|---------|---------|
| 0 | **概念 (Concept)** | Charter, Market Research | `Phase 0 Approved` |
| 1 | **需求 (Requirement)** | SRS, user-stories, ST Cases | `Phase 1 Approved` |
| 2 | **设计 (Design)** | SAD, RTM, User-Story/M0-M4 | `Phase 2 Approved` |
| 3 | **开发 (Develop)** | src/, UT, milestone 循环 | `Review Passed: M{n}` |
| 4 | **测试 (Test)** | 测试报告 (System-Test/results/) | 所有 milestone 通过 |
| 5 | **发布 (Launch)** | build-report, CHANGELOG, Git Tag | 构建成功 |

---

## 目录结构

```
npd-sw/
├── opencode/                           # ★ Command + Skill 定义
│   ├── commands/                       #   命令定义
│   │   ├── phase0-concept.md
│   │   ├── phase1-requirement.md
│   │   ├── phase2-design.md
│   │   ├── phase3-develop.md
│   │   ├── phase4-launch.md
│   │   ├── review-gate.md
│   │   └── status.md
│   └── skills/                         #   Skill 定义
│       ├── state-manager.md
│       ├── version-manager.md
│       ├── report-gen.md
│       ├── review-tracker.md
│       ├── doc-gen.md
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
│
├── opencode/workflows/                 # 工作流定义
├── state.json                          # 工作流状态文件
├── init-cmmv.sh                        # 脚手架脚本
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
chmod +x init-cmmv.sh

# 初始化新项目
./init-cmmv.sh init /path/to/my-project
```

---

## 使用方式

通过命令名调用相应流程：

| 命令 | 用途 |
|------|------|
| `/phase0-concept` | 启动概念阶段 |
| `/phase1-requirement` | 启动需求分析阶段 |
| `/phase2-design` | 启动设计阶段 |
| `/phase3-develop` | 启动迭代开发 |
| `/phase4-launch` | 启动部署发布 |
| `/review-gate` | 处理评审结果 |
| `/status` | 查看项目状态 |

### 命令格式

每个命令包含：
- **Goal** — 目标描述
- **Instructions** — 步骤化指引，引用 Skills
- **Constraints** — 约束条件

### 示例流程

```
用户: /phase0-concept 开发一个图书管理系统
  → 执行 Step 1: doc_gen skill 创建 Charter
  → 执行 Step 2: doc_gen skill 创建 Market Research
  → 执行 Step 3: state_manager skill 更新状态
  → 输出评审信号，等待用户确认

用户: Phase 0 Approved
  → /review-gate 处理推进信号
  → 建议下一步: /phase1-requirement
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
