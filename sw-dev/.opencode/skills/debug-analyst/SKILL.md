---
name: debug-analyst
description: "Use when diagnosing a bug, regression, flaky behavior, or production failure. Applies hypothesis-driven debugging, minimal reproduction, and discriminating checks to isolate root cause."
license: MIT
---

# debug-analyst

## Purpose
Diagnose the most likely root cause of a bug before implementation changes begin.

## Required Inputs
- Observed behavior and expected behavior
- Reproduction steps, failing input, logs, stack trace, or a concrete symptom
- Approximate scope: subsystem, file, endpoint, job, or recent change window

## Optional Inputs
- Screenshots, metrics, traces, recent commits, or environment details
- Existing failing tests or known good behavior baselines

## Clarify Before Proceeding
- If expected behavior is unclear, ask what the system should do instead.
- If there is no reproduction path, ask for the smallest repeatable symptom or artifact.
- If the scope is broad, ask for the first failing boundary: endpoint, file, job, or input set.

## Execution Rules
1. Reproduce the problem when feasible, or define the closest observable failure signal.
2. Form ranked hypotheses and state what evidence would confirm or disprove each one.
3. Choose the cheapest discriminating check before broad exploration.
4. Isolate the controlling code path and identify the most specific plausible root cause.
5. Do not start implementing a fix until the current leading hypothesis is supported by evidence.

## Output Template

```markdown
## Root Cause Report

### 1. Observation
{what happens vs what should happen}

### 2. Assumptions
- {assumption 1}

### 3. Hypotheses
- H1: {candidate cause} — {evidence for/against}
- H2: {candidate cause} — {evidence for/against}

### 4. Experiment
{steps taken to isolate, e.g. write test, add assertion, binary search commits}

### 5. Root Cause
{file:line} — {one-sentence explanation}

### 6. Fix Direction
{minimal change to fix}

### 7. Verification
{test / assertion that proves the fix}
```

## Constraints
- Do NOT fix random code — drive by hypotheses
- Do NOT fix symptoms, fix root cause
- Do NOT change unrelated code during debug
- Verify the proposed root cause with a concrete check whenever possible.

## Fallbacks
- If the bug cannot be reproduced, return the highest-value next experiment instead of overstating confidence.
- If multiple hypotheses remain plausible, say what one additional check would discriminate between them.
- If no code path can yet be isolated, stop at the boundary where evidence runs out and ask for the missing artifact.
