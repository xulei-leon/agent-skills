# Design Phase Workflow

Complete Phase 2: plan milestones, build backlog, and create RTM.

## Steps

### Step 1: Create SAD
- Use the `software_architecture_design` skill
- Output: `docs/03-Design/SAD.md`
- Trace each architecture decision to FR/NFR
- Include: tech stack rationale, module划分, interface definitions, data flow

### Step 2: Milestone Planning
- Use the `milestone_planner` skill
- Input: `docs/02-Requirement/SRS.md` (extract all FR/NFR)
- Group FRs into 2-5 milestones (M1-M4) by functional coupling and priority
- Output: milestone plan with assigned FR IDs

### Step 3: Create M0 Architecture Backlog
- Use the `software_architecture_design` skill
- Record M0 items in `sprint/backlog.md` under `M0 — 架构搭建`
- Define: directory structure, module dependencies, public interfaces, data models
- M0 is architecture scaffolding only — no business logic

### Step 4: Create M1-M4 Backlog Items
- For each milestone, use the `software_architecture_design` skill
- Append to `sprint/backlog.md` under corresponding milestone section
- Format: `US-M{n}-{yy}: description` with traceable FR/NFR IDs
- Include acceptance criteria, complexity estimate (S/M/L/XL), and dependencies

### Step 5: Build RTM
- Use the `rtm_builder` skill
- Output: `docs/03-Design/RTM.md`
- Table: FR ID | Description | US | ST | Status
- Every FR must trace to at least one US and one ST

### Step 6: Output Review Signal
- Print `[Phase 2 出口检查]` with checklist
- Wait for user reply: `Phase 2 Approved` to advance

## Exit Criteria
- SAD created and consistent with SRS
- Milestone plan completed
- Backlog populated in sprint/backlog.md
- RTM built with full traceability
- User confirms with `Phase 2 Approved`
