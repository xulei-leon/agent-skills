# /phase3-develop

## Goal
Execute iterative development for a milestone (M{n}) — TDD loop: UT → Code → Test → Review.

## Instructions

### Step 1: Read Milestone Spec
- Use the `state_manager` skill to determine current milestone M{n}
- Read `docs/02-Requirement/User-Story/M{n}-*.md`

### Step 2: Generate Unit Tests (TDD)
- Use the `test_gen` skill
- Input: milestone User Stories and acceptance criteria
- Output: `test/ut/m{n}-us{yy}.test.*`
- Cover ALL acceptance criteria for each US

### Step 3: Implement Code
- Use the `code_impl` skill
- Input: milestone specs + UT cases
- Output: `src/` implementation files
- Make all UTs pass

### Step 4: Run Tests
- Run `npm test` (or language-appropriate test command)
- If any UT fails: fix implementation → rerun until all pass
- Then run `npm run test:st` (system tests)
- If ST fails: fix → rerun until all pass

### Step 5: Generate Test Report
- Use the `report_gen` skill
- Output: `test/results/M{n}-test-report.md`

### Step 6: Git Commit
- Use the `git_ops` skill
- Commit message: `feat(M{n}): complete {milestone name}`

### Step 7: Output Review Signal
- Print `[评审门]` with test results summary
- Wait for user to reply `Review Passed: M{n}` or `Review Failed: ...`

### Step 8 (on Failure): If user replies `Review Failed`
- Analyze the issue → fix code → go to Step 4
- Max 3 retries, then proceed regardless (log unresolved issues)

## Constraints
- TDD MANDATORY: write tests BEFORE implementation
- Do NOT enter M{n+1} until `Review Passed: M{n}`
- Each UT must trace to a specific US acceptance criterion
