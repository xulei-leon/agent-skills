# /phase2-design

## Goal
Complete Phase 2 (Design) — plan milestones, write User Stories, and build RTM.

## Instructions

### Step 1: Milestone Planning
- Use the `milestone_planner` skill
- Input: `docs/02-Requirement/SRS.md` (extract all FR/NFR)
- Group FRs into 2-5 milestones (M1-M4) by coupling and priority
- Output: milestone plan

### Step 2: Create M0 Architecture Spec
- Use the `doc_gen` skill with template `docs/templates/spec-template.md`
- Output: `docs/02-Requirement/User-Story/M0-architecture.md`
- Define directory structure, module dependencies, public interfaces, data models

### Step 3: Create M1-M4 Specs
- For each milestone, use `doc_gen` skill with template `docs/templates/spec-template.md`
- Output: `docs/02-Requirement/User-Story/M{n}-{name}.md`
- Format: `US-M{n}-{yy}: description` with traceable FR/NFR IDs
- Include acceptance criteria and complexity estimate (S/M/L/XL)

### Step 4: Build RTM
- Use the `rtm_builder` skill
- Output: `docs/03-Design/RTM.md`
- Table: FR ID | Description | US | ST | Status

### Step 5: Update State
- Use the `state_manager` skill to mark Phase 2 docs completed

### Step 6: Output Review Signal
- Print `[Phase 2 出口检查]` with checklist
- Wait for user to reply `Phase 2 Approved`

## Constraints
- M0 defines ARCHITECTURE ONLY — no business logic
- Each US must reference at least one FR/NFR
- Do NOT proceed without `Phase 2 Approved`
