# FR Document Template

Create active FR documents under `FR_DIR`. Use `FR_BACKLOG_DIR` for unscheduled backlog FRs and `FR_DONE_DIR` only for completed FRs. Resolve these variables from the project instructions first; fallback values are defined in `SKILL.md`.

Name files as `FR-<id>-<kebab-slug>.md`, for example `FR-218-search-sdk-web-search-and-hotspot-discovery.md`.

# FR-<id> <标题>

- `FR-ID`: `FR-<id>`
- `标题`: <中文标题>
- `所属阶段`: 阶段 <n> - <阶段名称>
- `开发顺序`: <number>
- `优先级`: P0 | P1 | P2 | P3
- `前置依赖`: <FR/doc links or `无`>
- `涉及包`: <packages/modules/directories or `无`>
- `是否属于原型阶段`: 是 | 否
- `来源类型`: 新需求 | 需求变更 | 设计补强 | 缺陷修复 | 技术债治理
- `原始 SRS 章节`: <requirement index/SRS section or `无`>
- `相关 FR`: <optional related FR list>

## 目标

Describe the business or product outcome. Keep it aligned with the active project's requirement source of truth.

## 背景与问题

Explain why this FR exists now, current limitations, and any conflicts with previous FRs or implementation.

## 影响范围

List affected packages, docs, runtime files, prompts, config files, tests, and user-visible behavior.

## 需求描述

Write concrete, testable requirements. Prefer stable bullets and explicit boundaries over vague prose.

## 高层要求

State architecture and behavior constraints that implementation must preserve, especially module, package, runtime-data, and dependency boundaries from the active project's instructions.

## 输入

Define user input, config, runtime data, prompt input, CLI flags, API payloads, or state fields if relevant.

## 输出

Define generated article data, artifacts, runtime files, DTOs, events, UI state, or diagnostics if relevant.

## 失败与降级

Define error handling, fallback, timeout, retry, resume, manual review, and diagnostics behavior.

## 不纳入范围

List explicit non-goals. Do not add compatibility paths, workflow branches, or migration scope unless the active project requires them.

## 最小验证方式

List the minimum unit/system/regression tests or commands needed before implementation can be considered complete.

## 验收要点

Use observable acceptance bullets. Each core behavior must be testable or have a named manual verification.

## 备注

Record open decisions, follow-up FRs, review notes, and migration notes.
