# /swd-test-run

## Goal
Run tests, report results, and diagnose failures with actionable output.

## Skill
`.opencode/skills/test-runner/SKILL.md`

## Steps

### Step 1: Determine Scope
- Ask: full suite, specific module, or specific test file?
- Default: full test suite

### Step 2: Run Tests
- Execute the appropriate test command (npm test, pytest, etc.)
- Capture full output including stack traces

### Step 3: Report Results
- Summary: passed / failed / skipped / total
- For failures: file:line, actual vs expected, stack trace snippet
- Coverage: line/branch/function metrics if available

### Step 4: Diagnose Failures
- For each failure: classify as assertion error, runtime exception, timeout, or infrastructure issue
- Link to likely root cause (test issue vs implementation issue)

## Constraints
- Do NOT modify tests or code — only run and report
- If no test command is configured, ask the user for one
- Do NOT truncate or summarize stack traces
