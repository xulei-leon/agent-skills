# Requirement Phase Workflow

Complete Phase 1: produce SRS and System Test cases.

## Steps

### Step 1: Create SRS
- Use the `requirements-analysis` skill
- Input: user's project requirements (and Charter from Phase 0 if Concept is enabled)
- Output: `docs/1-Requirement/SRS.md`
- Use `Version: 1.0.0` (bump on subsequent edits)
- Functional requirements numbered as `FR-001`, `FR-002`, etc.
- Non-functional requirements numbered as `NFR-001`, `NFR-002`, etc.

### Step 2: Create System Test Cases
- Use the `testcase-designer` skill
- Input: SRS functional requirements
- Output: `test/system/st-cases.test.*`
- Follow template: `test/system/st-case-template.md`
- Each ST must have Traceability ID pointing to a FR
- Cover normal path, error path, and boundary conditions

### Step 3: Bump Versions and Output Review Signal
- Use the `version-manager` skill to bump document versions
- Bump `docs/1-Requirement/SRS.md` if modified
- Print `[Phase 1 Exit Check]` with checklist
- User confirms with: `/npd-decision SRS.md approved` then `/npd-decision phase1 go`

## Exit Criteria
- SRS and ST cases all created
- Every FR is testable and traceable
- User confirms with `/npd-decision phase1 go`
