# /phase1-requirement

## Goal
Complete Phase 1 (Requirement) — produce SRS, SAD, and System Test cases.

## Instructions

### Step 1: Create SRS
- Use the `doc_gen` skill with template `docs/templates/srs-template.md`
- Input: user's project requirements
- Output: `docs/02-Requirement/SRS.md`
- Use `Version: 1.0.0` (bump on subsequent edits)
- Requirements numbered as `FR-001`, `FR-002`, etc.

### Step 2: Create SAD
- Use the `doc_gen` skill with template `docs/templates/sad-template.md`
- Output: `docs/03-Design/SAD.md`
- Trace each architecture decision to FR/NFR

### Step 3: Create System Test Cases
- Use the `test_design` skill with template `docs/templates/st-template.md`
- Output: `test/st/st-cases.test.*`
- Each ST must have Traceability ID pointing to a FR
- Cover normal path, error path, and boundary conditions

### Step 4: Update State
- Use the `state_manager` skill to mark Phase 1 completed docs

### Step 5: Output Review Signal
- Print `[Phase 1 出口检查]` with checklist
- Wait for user to reply `Phase 1 Approved`

## Constraints
- Every FR must be testable and traceable
- Do NOT proceed without `Phase 1 Approved`
- SRS and SAD versions must align
