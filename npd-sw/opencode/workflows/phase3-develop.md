# Development Loop Workflow

Execute TDD cycle for a milestone: UT → Code → Test → Review.

## Steps

### Step 1: Read Backlog Items
- Read `sprint/backlog.md` to get items for current milestone
- Filter by milestone section (M0 ~ M4)
- Extract all acceptance criteria

### Step 2: Generate Unit Tests (TDD)
- Use the `testcase-designer` skill
- Input: milestone User Stories and acceptance criteria
- Output: `test/ut/m{n}-us{yy}.test.*`
- Cover ALL acceptance criteria for each US
- Each UT must trace to a specific US acceptance criterion

### Step 3: Implement Code
- Use the `programmer` skill
- Input: milestone specs + UT cases
- Output: `src/` implementation files
- Follow SAD architecture and module boundaries
- Do NOT modify UTs (they define the contract)

### Step 4: Run Unit Tests
- Run `npm test` (or language-appropriate test command)
- If any UT case fails: fix implementation → re-run until all pass

### Step 5: Code Review
- Use the `code-reviewer` skill (or manual review)
- Input: implemented source code + UT cases
- Verify: code follows SAD architecture, module boundaries, project conventions
- Verify: all acceptance criteria are covered
- If review fails: fix issues → rerun unit tests (go to Step 3)

### Step 6: Git Commit
- Use the `git-ops` skill
- Commit message: `feat(M{n}): complete {milestone name}`

### Step 7: Output Review Signal
- Print `[Review Gate]` with test results summary
- Wait for user reply: `Review Passed: M{n}` or `Review Failed: ...`

### Step 8 (on Failure)
- If user replies `Review Failed: {reason}`:
  - Analyze the issue
  - Fix code → rerun unit tests (go to Step 3)
  - Max 3 retries per milestone
  - After 3 failures: log unresolved issues, proceed

### Step 9: Proceed to System Test
- After milestone review passes, proceed to Phase 4 (System Test)

## Constraints
- TDD is mandatory: write tests BEFORE implementation
- Do NOT enter M{n+1} until `Review Passed: M{n}`
