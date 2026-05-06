# Requirement Phase Workflow

Complete Phase 1: produce SRS and System Test cases.

## Steps

### Step 1: Create SRS
- Use the `requirements_analysis` skill
- Input: user's project requirements
- Output: `docs/02-Requirement/SRS.md`
- Use `Version: 1.0.0` (bump on subsequent edits)
- Functional requirements numbered as `FR-001`, `FR-002`, etc.
- Non-functional requirements numbered as `NFR-001`, `NFR-002`, etc.

### Step 2: Create System Test Cases
- Use the `test_design` skill with template `test/st/st-case.md`
- Output: `test/st/st-cases.test.*`
- Each ST must have Traceability ID pointing to a FR
- Cover normal path, error path, and boundary conditions
- Format: Given-When-Then

### Step 3: Output Review Signal
- Print `[Phase 1 出口检查]` with checklist
- Wait for user reply: `Phase 1 Approved` to advance

## Exit Criteria
- SRS and ST cases all created
- Every FR is testable and traceable
- User confirms with `Phase 1 Approved`
