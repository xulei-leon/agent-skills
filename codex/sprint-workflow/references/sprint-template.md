# Sprint Document Template

Create active Sprint documents under `SPRINT_DIR`. Move completed Sprint documents to `SPRINT_DONE_DIR`. Resolve these variables from the project instructions first; fallback values are defined in `SKILL.md`.

Name files as `sprint-m<major>-<nn>.md`, for example `sprint-m4-05.md`.

# Sprint M<major>-<nn>

## 1. Sprint 目标

State the FR(s) covered and the concrete delivery outcome. Link source FR documents under `FR_DIR`.

核心目标：

- <objective>

## 2. 前置依赖

- <FR/design/code/test dependency>

协同说明：

- <cross-FR or architecture note>

## 3. 纳入范围

本 Sprint 纳入以下 FR：

- `FR-<id>` <title>

涉及包和目录：

- <package/module/directory>
- <package/module/directory>
- `docs/...`

## 4. 暂不纳入范围

- <explicit out-of-scope item>

原因：

- <why it is deferred>

## 5. 工作范围

### 5.1 工作包：<name>

目标：

- <goal>

实现任务清单：

- [ ] <task>

测试要求：

- [ ] <unit/system/regression test requirement>

### 5.2 工作包：<name>

目标：

- <goal>

实现任务清单：

- [ ] <task>

测试要求：

- [ ] <unit/system/regression test requirement>

## 6. 验收标准

- <observable acceptance criterion>

## 7. 验证要求

Run the verification commands declared by the active project instructions, usually in `AGENTS.md` or equivalent. If no commands are declared, infer the smallest credible command set from the package manager, build files, and touched areas, then record that inference.

项目声明的验证命令：

- `<command from project instructions>`

推断的验证命令（仅在项目未声明时使用）：

- `<inferred command and why>`

专项验证：

- <manual or targeted automated check>

## 8. 实施顺序

1. <step>
2. <step>
3. <step>

## 9. 风险控制

- <risk and mitigation>

## 10. 交付结论

Leave this section empty or marked pending before implementation. Fill it only after coding, review confirmation, and verification are complete.
