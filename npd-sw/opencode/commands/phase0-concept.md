# /phase0-concept

## Goal
Complete Phase 0 (Concept) — produce Charter and Market Research documents to define project scope.

## Instructions

### Step 1: Create Charter
- Use the `doc_gen` skill with template `docs/templates/charter-template.md`
- Input: user's project description
- Output: `docs/01-Concept/Charter.md`
- Set `Version: 1.0.0` in header

### Step 2: Create Market Research
- Use the `doc_gen` skill with template `docs/templates/market-research-template.md`
- Output: `docs/01-Concept/Market_Research.md`

### Step 3: Update State
- Use the `state_manager` skill to mark phase as Phase0 completed
- Set `completed_docs: ["docs/01-Concept/Charter.md", "docs/01-Concept/Market_Research.md"]`

### Step 4: Output Review Signal
- Print: `[Phase 0 出口检查]` with checklist of produced documents
- Wait for user to reply `Phase 0 Approved` before advancing

## Constraints
- Do NOT proceed to Phase 1 without `Phase 0 Approved`
- Each document must have `Version: x.y.z` header
