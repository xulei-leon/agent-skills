# 开发阶段指南

> **项目名称**: {PROJECT_NAME}
> **阶段**: Phase 3 — Develop
> **入口条件**: Phase 2 (Design) 审批通过

---

## 开发流程概览

开发阶段按 **里程碑 (Milestone M0~M4)** 依次进行，每个里程碑内执行 **TDD 循环**，通过 **Sprint** 管理迭代节奏。

```
Milestone Plan → Sprint Plan → TDD Loop → Review → Next Milestone
```

---

## TDD 工作流

每个里程碑内的开发遵循 **红-绿-重构** 循环：

### 1. 红 — 编写单元测试

- 根据当前里程碑的 User Story 和验收标准 (AC) 编写 UT
- 每个 UT 用例对应一个 AC
- 测试文件位置：`test/unit/m{n}-us{yy}.test.*`
- 此时测试预期失败（没有实现代码）

### 2. 绿 — 实现代码

- 在 `src/` 中编写实现代码
- 遵循 SAD 架构设计和模块边界
- **不要修改 UT** — 它们定义了合约
- 运行 `npm test`，直到所有 UT 通过

### 3. 重构 — 优化代码

- 在测试通过的前提下清理代码
- 移除重复、简化逻辑、改进命名
- 保持功能不变，测试继续全绿

### 4. 评审门禁

- UT 通过率 100% 方可提交评审
- 通过 `/npd-decision M{n} go` 批准
- 最多 3 次重做机会

---

## Sprint 流程

Sprint 将里程碑分解为可交付的迭代单元。

### Sprint 规划

- 从 `sprint/backlog.md` 选取当前里程碑的条目
- 创建 `sprint/sprint.md` 详细规划 Sprint 内容
- 分配负责人、估算复杂度 (SP)

### Sprint 执行

- 按 TDD 循环完成每个 Backlog 条目
- 每日跟踪进度，更新状态

### Sprint 回顾

- 完成后记录完成 SP、未完成项、改进项
- 计入 `sprint/sprint.md` 回顾区

---

## 目录结构

```
project/
├── sprint/                    # 迭代管理
│   ├── backlog.md            #   Product Backlog (M0~M4)
│   ├── sprint.md             #   当前 Sprint 计划
│   └── done/                 #   ✅ 已完成的 Sprint 回顾归档
│
├── test/
│   ├── ut/                   #   单元测试
│   │   └── m{n}-us{yy}.test.*
│   ├── st/                   #   系统测试
│   │   ├── st-001.test.*
│   │   └── ...
│   ├── fixtures/             #   测试数据与工厂
│   └── results/              #   测试报告
│       ├── M{n}-test-report.md
│       └── system-test-report-V<version>.md
│
└── src/                      # 实现源码
```

---

## sprint/ 目录详解

### sprint/backlog.md

Product Backlog，按里程碑分组 (M0~M4)：

| ID | 类型 | 标题 | SRS 追踪 | US ID | 优先级 | 复杂度 | 状态 |
|----|------|------|----------|-------|--------|--------|------|

- 类型：`US` (User Story) / `TECH` (技术任务) / `BUG` (缺陷) / `IMP` (改进)
- 复杂度：S(1) / M(3) / L(8) / XL(13) SP
- 由 Phase 2 (Design) 生成，开发阶段不修改

### sprint/sprint.md

当前 Sprint 执行计划：

| 属性 | 值 |
|------|-----|
| Sprint ID | Sprint {N} |
| 目标 | {Sprint 目标描述} |
| 周期 | {开始} — {结束} |
| Velocity | {N} SP |

从 backlog 选取条目，标注负责人和状态。

### sprint/done/

已完成的 Sprint 回顾归档目录。每个 Sprint 结束后将 `sprint/sprint.md` 移入此处保存。

---

## test/ 目录详解

### test/unit/ — 单元测试

- 命名规范：`test/unit/m{n}-us{yy}.test.{ext}`
- 示例：`test/unit/m1-us01.test.ts`
- 每个 UT 文件对应一个 User Story
- 覆盖率要求：核心逻辑 ≥ 90%，整体 ≥ 80%

### test/system/ — 系统测试

- 命名规范：`test/system/st-{id}.test.{ext}`
- 示例：`test/system/st-001.test.ts`
- 每个 ST 对应 SRS 中的一个 FR
- 覆盖正常路径、异常路径、边界条件

### test/fixtures/ — 测试数据

- 工厂模式创建测试数据
- 避免硬编码，复用数据构建函数

### test/results/ — 测试报告

| 文件 | 来源 | 说明 |
|------|------|------|
| `M{n}-test-report.md` | Phase 3 | 里程碑 UT 执行报告 |
| `system-test-report-V<version>.md` | Phase 4 | 全量系统测试报告 |

---

## 关键约束

- **TDD 是强制性的**：先写测试，后写实现
- **不要进入 M{n+1}**，直到 M{n} 评审通过
- **不要修改 UT**，它们定义了合约
- 每个里程碑完成后执行 `/npd-decision M{n} go` 门禁

---

## 参考文档

| 文档 | 位置 |
|------|------|
| System Requirements | `docs/1-Requirement/SRS.md` |
| Architecture Design | `docs/2-Design/SAD.md` |
| Milestone Plan | `docs/2-Design/milestones.md` |
| Requirements Traceability | `docs/2-Design/RTM.md` |
| Product Backlog | `sprint/backlog.md` |

---

## 变更历史

| 版本 | 日期 | 作者 | 变更描述 |
|------|------|------|---------|
| 1.0.0 | {DATE} | NPD-SW Agent | 初始版本 |
