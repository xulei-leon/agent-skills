# Requirement Phase Workflow

Complete Phase 1: produce SRS and System Test cases.

## Steps

### Step 1: Create SRS
- Use the `requirements-analysis` skill
- Input: user's project requirements
- Output: `docs/02-Requirement/SRS.md`
- Use `Version: 1.0.0` (bump on subsequent edits)
- Functional requirements numbered as `FR-001`, `FR-002`, etc.
- Non-functional requirements numbered as `NFR-001`, `NFR-002`, etc.

### Step 2: Create System Test Cases
- Use the `testcase-designer` skill
- Input: SRS functional requirements
- Output: `test/st/st-cases.test.*`
- Follow template: `test/st/st-case.md`
- Each ST must have Traceability ID pointing to a FR
- Cover normal path, error path, and boundary conditions

### Step 3: Output Review Signal
- Print `[Phase 1 Exit Check]` with checklist
- Wait for user reply: `Phase 1 Approved` to advance

## Exit Criteria
- SRS and ST cases all created
- Every FR is testable and traceable
- User confirms with `Phase 1 Approved`
