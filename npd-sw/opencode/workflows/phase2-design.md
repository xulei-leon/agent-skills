# Design Phase Workflow

Complete Phase 2: create SAD, plan milestones, build backlog, and build RTM.

## Steps

### Step 1: Create SAD (Architecture Design)
- Use the `software-architecture-design` skill
- Input: `docs/02-Requirement/SRS.md`
- Output: `docs/03-Design/SAD.md`
- Trace each architecture decision to FR/NFR
- Include: tech stack rationale, module划分, interface definitions, data flow

### Step 2: Build Initial RTM (Requirements → Architecture)
- Use the `rtm-builder` skill
- Input: `docs/02-Requirement/SRS.md` + `docs/03-Design/SAD.md`
- Output: `docs/03-Design/RTM.md` (initial)
- Table: FR ID | Description | Architecture Module | ST | Status
- Map each FR to its corresponding architecture module from SAD
- ST and US columns remain pending (filled in later steps)

### Step 3: Milestone Planning (Feature Grouping)
- Use the `milestone-planner` skill
- Input: `docs/02-Requirement/SRS.md` (extract all FR/NFR)
- Output: `docs/03-Design/milestones.md`
- Group FRs into 2-5 milestones (M1-M4) by functional coupling and priority

### Step 4: Create M0 Architecture Backlog
- Use the `software-architecture-design` skill
- Output: `sprint/backlog.md` — populate `M0 — 架构搭建` section
- Table columns: ID | 类型 | 标题 | SRS 追踪 | US ID | 优先级 | 复杂度 | 状态
- M0 items use type `TECH` (技术任务), IDs `BL-001` onward, US IDs `US-M0-{yy}`
- Define: directory structure, module dependencies, public interfaces, data models
- M0 is architecture scaffolding only — no business logic

### Step 5: Create Feature Backlog (User Stories)
- Use the `backlog-builder` skill
- Input: milestone plan + SRS
- Output: `sprint/backlog.md` — populate `M1` ~ `M4` sections
- Table columns: ID | 类型 | 标题 | SRS 追踪 | US ID | 优先级 | 复杂度 | 状态
- Format: `US-M{n}-{yy}` US IDs, type `US`, traceable FR/NFR IDs
- Include acceptance criteria, complexity estimate (S/M/L/XL), and dependencies

### Step 6: Update RTM (Full Traceability)
- Use the `rtm-builder` skill
- Input: initial RTM + backlog
- Output: `docs/03-Design/RTM.md` (full)
- Every FR must trace to at least one architecture module, one US, and one ST

### Step 7: Output Review Signal
- Print `[Phase 2 出口检查]` with checklist
- Wait for user reply: `Phase 2 Approved` to advance

## Exit Criteria
- SAD created and consistent with SRS
- Initial RTM built with FR→Architecture mapping
- Milestone plan completed (`docs/03-Design/milestones.md`)
- Backlog populated in `sprint/backlog.md`
- RTM has full traceability (FR → Module → US → ST)
- User confirms with `Phase 2 Approved`
