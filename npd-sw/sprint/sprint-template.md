# Sprint 计划

> **项目**: {PROJECT_NAME}
> **编制日期**: {DATE}
> **关联 Backlog**: sprint/backlog-template.md

---

## Sprint {N}

### 基本信息

| 属性 | 值 |
|------|-----|
| **Sprint ID** | Sprint {N} |
| **目标** | {Sprint 目标描述} |
| **周期** | {开始日期} — {结束日期} |
| **Velocity** | {N} SP |
| **状态** | Planning / Active / Review / Done |

### 计划条目

| BL ID | 类型 | 标题 | 复杂度 | 负责人 | 状态 |
|-------|------|------|--------|--------|------|
| BL-001 | US | 项目初始化 | S | TBD | Pending |
| BL-002 | US | 配置管理 | M | TBD | Pending |
| BL-003 | US | 日志系统 | M | TBD | Pending |
| BL-016 | TECH | CI/CD 流水线配置 | M | TBD | Pending |
| BL-017 | TECH | 代码规范与 Linter 配置 | S | TBD | Pending |
| BL-018 | TECH | 测试框架搭建 | M | TBD | Pending |

### 容量

| 指标 | 值 |
|------|-----|
| 计划总 SP | {N} |
| 团队容量 | {N} SP |
| 可用工作日 | {N} 天 |
| 缓冲 | {N} SP |

### Sprint Backlog

```json
{
  "sprint": "Sprint {N}",
  "goal": "{Sprint 目标}",
  "backlog_ids": ["BL-001", "BL-002", "BL-003", "BL-016", "BL-017", "BL-018"],
  "total_sp": "{N}",
  "status": "planning"
}
```

---

## Sprint 回顾

| Sprint | 完成 SP | 未完成 | 改进项 |
|--------|---------|--------|--------|
| Sprint 1 | — | — | — |

---

## 路线图

| Sprint | 目标 | 涵盖 Backlog | 预计开始 |
|--------|------|-------------|---------|
| Sprint 1 | 基础架构搭建 | BL-001 ~ BL-003, BL-016 ~ BL-018 | {DATE} |
| Sprint 2 | {核心功能 1} | BL-004 ~ BL-005, BL-019 | {DATE} |
| Sprint 3 | {核心功能 2 + 增强} | BL-006 ~ BL-009, BL-020 | {DATE} |
| Sprint 4 | 质量与运维 | BL-010 ~ BL-015, BL-021 | {DATE} |

---

## 变更历史

| 版本 | 日期 | 作者 | 变更描述 |
|------|------|------|---------|
| 1.0.0 | {DATE} | NPD-SW Agent | 初始版本 |
