# /swd-debug

## Goal
Analyze and locate the root cause of a difficult bug using structured hypothesis-driven debugging.

## Skill
`.opencode/skills/debug-analyst/SKILL.md`

## Steps

### Step 1: Understand the Bug
- Ask user for: reproduction steps, expected vs actual behavior, environment, frequency
- Collect artifacts: stack trace, logs, input data, screenshots

### Step 2: Build Hypotheses
- Trace the data flow from input to failure point
- List candidate root causes ranked by likelihood
- State each hypothesis with "if X is wrong, we'd see Y" logic

### Step 3: Design Minimal Experiment
- Write a focused test that reproduces the issue in isolation
- Or: add logging/assertions at key decision points
- Or: binary search (git bisect for regressions, input bisect for data bugs)

### Step 4: Isolate Root Cause
- Narrow to specific file:line
- Explain why the code produces wrong behavior

### Step 5: Fix & Verify
- Propose minimal fix (surgical, no scope creep)
- User applies fix, re-runs reproduction test to confirm

## Constraints
- Do NOT start fixing before root cause is confirmed
- If stuck after 3 failed hypotheses, escalate with what was ruled out
- Each experiment must rule in or rule out at least one hypothesis
