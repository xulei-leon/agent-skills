# /swd-fix

## Goal
Apply a minimal, verified fix for a confirmed root cause using TDD — write a failing test first, then implement the fix.

## Skill
`.opencode/skills/fixer/SKILL.md`

## Steps

### Step 1: Understand Root Cause
- Accept root cause report (from `/swd-debug` or user description)
- Confirm: what is the bug, where is it (file:line), what is the correct behavior

### Step 2: Write Failing Test (Red)
- Write a test that reproduces the bug in isolation
- Run it — must fail (proving the test detects the bug)
- Place in `test/unit/` following project naming conventions

### Step 3: Implement Fix (Green)
- Apply the minimal code change to fix the bug
- Do NOT fix anything beyond the root cause
- Do NOT refactor, rename, or clean up adjacent code

### Step 4: Verify (Green)
- Run the new test — must pass
- Run full existing test suite — no regressions

### Step 5: Report
- Summary: root cause, fix applied, test added
- Verification: test output showing green

## Constraints
- Fix must be surgical — touch only the lines that need changing
- Always write the failing test BEFORE the fix (TDD for bugs)
- If the fix causes existing tests to fail, revert and reconsider approach
- Do NOT add new features or scope-creep during a fix
