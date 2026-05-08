# Design Phase Workflow

Complete Phase 2: create SAD, plan milestones, build backlog, and build RTM.

## Steps

### Step 1: Create SAD (Architecture Design)
- Use the `software-architecture-design` skill
- Input: `docs/02-Requirement/SRS.md`
- Output: `docs/03-Design/SAD.md`
- Trace each architecture decision to FR/NFR
- Include: tech stack rationale, module partitioning, interface definitions, data flow

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
- Output: `sprint/backlog.md` — populate `M0 — Architecture Scaffolding` section
- Table columns: ID | Type | Title | SRS Trace | US ID | Priority | Complexity | Status
- M0 items use type `TECH` (technical task), IDs `BL-001` onward, US IDs `US-M0-{yy}`
- Define: directory structure, module dependencies, public interfaces, data models
- M0 is architecture scaffolding only — no business logic

### Step 5: Create Feature Backlog (User Stories)
- Use the `backlog-builder` skill
- Input: milestone plan + SRS
- Output: `sprint/backlog.md` — populate `M1` ~ `M4` sections
- Table columns: ID | Type | Title | SRS Trace | US ID | Priority | Complexity | Status
- Format: `US-M{n}-{yy}` US IDs, type `US`, traceable FR/NFR IDs
- Include acceptance criteria, complexity estimate (S/M/L/XL), and dependencies

### Step 6: Update RTM (Full Traceability)
- Use the `rtm-builder` skill
- Input: initial RTM + backlog
- Output: `docs/03-Design/RTM.md` (full)
- Every FR must trace to at least one architecture module, one US, and one ST

### Step 7: Bump Versions and Output Review Signal
- Use the `version-manager` skill to bump document versions
- Bump `docs/03-Design/SAD.md`, `docs/03-Design/RTM.md`, `docs/03-Design/milestones.md` if modified
- Print `[Phase 2 Exit Check]` with checklist
- User confirms with: `/npd-decision SAD.md approved`, `/npd-decision RTM.md approved`, then `/npd-decision phase2 go`

## Exit Criteria
- SAD created and consistent with SRS
- Initial RTM built with FR→Architecture mapping
- Milestone plan completed (`docs/03-Design/milestones.md`)
- Backlog populated in `sprint/backlog.md`
- RTM has full traceability (FR → Module → US → ST)
- User confirms with `/npd-decision phase2 go`
