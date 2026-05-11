# /swd-test-design

## Goal
Design comprehensive test cases with mock strategies, parameterized tests, boundary analysis, and coverage goals.

## Skill
`.opencode/skills/swd-testcase-designer/SKILL.md`

## Inputs
- Feature, module, API, or behavior under test
- Expected behavior, acceptance criteria, contract, or observable invariants
- Desired test level and existing project conventions if known

## Steps

### Step 1: Analyze Target
- Read module specification / API contract / acceptance criteria
- Identify dependencies (external APIs, databases, time, file system)

### Step 2: Design Test Suite
- **Normal path**: one test per acceptance criterion
- **Error path**: one test per documented error code/path
- **Boundary**: equivalence partitioning + boundary value analysis
- **Edge cases**: empty, null, max input; adversarial scenarios
- **State transitions**: if applicable, cover all valid transitions

### Step 3: Plan Mock Strategy
- For each external dependency: choose mock type and tool
- Define mock behavior for each test scenario

### Step 4: Generate Test Files
- Output in project's test framework (Jest / Vitest / Mocha / pytest)
- Use parameterized tests (`it.each`) for repetitive cases
- Place files in `test/unit/` or `test/integration/` as appropriate

### Step 5: Verify Coverage
- Run tests to confirm they fail before implementation (TDD)
- Report: coverage metrics, gaps found

## Constraints
- Each test maps to exactly one acceptance criterion or error condition
- Tests must be independent (no shared mutable state)
- Use real implementations where possible; mock only at boundaries
