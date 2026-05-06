# Requirement Phase Workflow

Complete Phase 1: produce SRS, SAD, and System Test cases.

## Steps

### Step 1: Create SRS
- Use the `requirements_analysis` skill
- Input: user's project requirements
- Output: `docs/02-Requirement/SRS.md`
- Use `Version: 1.0.0` (bump on subsequent edits)
- Functional requirements numbered as `FR-001`, `FR-002`, etc.
- Non-functional requirements numbered as `NFR-001`, `NFR-002`, etc.

### Step 2: Create SAD
- Use the `software_architecture_design` skill
- Output: `docs/03-Design/SAD.md`
- Trace each architecture decision to FR/NFR
- Include: tech stack rationale, module划分, interface definitions, data flow

### Step 3: Create System Test Cases
- Use the `test_design` skill with template `docs/templates/st-template.md`
- Output: `test/st/st-cases.test.*`
- Each ST must have Traceability ID pointing to a FR
- Cover normal path, error path, and boundary conditions
- Format: Given-When-Then

### Step 4: Output Review Signal
- Print `[Phase 1 出口检查]` with checklist
- Wait for user reply: `Phase 1 Approved` to advance

## Exit Criteria
- SRS, SAD, and ST cases all created
- Every FR is testable and traceable
- SRS and SAD versions aligned
- User confirms with `Phase 1 Approved`
