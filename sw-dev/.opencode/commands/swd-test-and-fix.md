# /swd-test-and-fix

## Goal
Run the test suite, diagnose any failures, fix them, and repeat until all tests pass.

## Skills
- `.opencode/skills/swd-test-runner/SKILL.md`
- `.opencode/skills/swd-fixer/SKILL.md`

## Inputs
- Test scope: full suite, module, directory, or file (default: full suite)
- Project test command, or enough repo context to detect one

## Steps

### Step 1: Run Tests
- Execute the test suite at the requested scope
- Capture full output: pass/fail counts, stack traces, coverage

### Step 2: Check Result
- If all pass → report success, exit
- If failures found → proceed to Step 3

### Step 3: Diagnose and Fix (per failure)
For each failing test:
- Classify the failure (assertion error, runtime exception, timeout, infrastructure)
- Locate the root cause (file:line)
- Apply the minimal surgical fix (TDD: write failing test, implement fix, verify)
- Move to next failure

### Step 4: Re-run Tests
- Run the same test scope again
- If all pass → report summary (fixed N tests)
- If still failing → loop back to Step 3 (max 3 iterations)

### Step 5: Report
- Summary: tests passed / failed / fixed
- For each fix: root cause, change applied, verification
- If iterations exhausted: list remaining failures and escalate

## Constraints
- Fix one failure at a time — do not batch fixes
- Each fix requires a reproduction test before patching (TDD)
- Max 3 fix iterations per session to avoid infinite loops
- Do NOT modify tests to make them pass — fix the implementation
