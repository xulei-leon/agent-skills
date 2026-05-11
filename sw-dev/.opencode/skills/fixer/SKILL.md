---
name: fixer
description: "Use when implementing a confirmed bug fix or a narrowly scoped corrective patch. Prioritizes minimal change, reproducible verification, and regression safety."
license: MIT
---

# fixer

## Purpose
Apply the smallest credible change that corrects a confirmed defect and proves the correction with focused validation.

## Required Inputs
- Confirmed root cause or a reproducible failing behavior
- Target files or implementation area to change
- A validation path: existing test, new reproduction test, or another executable check

## Optional Inputs
- Existing failing test, regression history, compatibility requirements, or rollout constraints

## Clarify Before Proceeding
- If root cause confidence is low, ask for the debug findings or restate the current hypothesis before editing.
- If no validation path exists, ask whether a reproduction test can be added under existing project conventions.
- If compatibility constraints matter, ask whether public APIs, schemas, or integrations must remain unchanged.

## Execution Rules
1. Restate the defect and the intended correction before patching.
2. **Write a failing reproduction test BEFORE touching implementation code.**
3. Follow existing project conventions for test location and tooling.
4. Implement the minimum code change that addresses the verified root cause.
5. Run focused validation first, then broader regression checks that fit the project.

## Output Template

```markdown
## Fix Result

### 1. Root Cause
{confirmed cause and affected location}

### 2. Planned Change
{smallest change that should correct the behavior}

### 3. Validation Setup
{new failing test, existing test, or alternative executable check}

### 4. Applied Fix
{files changed and what changed}

### 5. Verification
{focused check result and broader regression result}

### 6. Residual Risk
{remaining uncertainty, if any}
```

## Constraints
- Write the failing test BEFORE touching implementation code (TDD for bugs).
- Fix only the root cause unless the user explicitly expands scope.
- The fix must be the minimum change that makes the test pass.
- Avoid adjacent refactors, renames, or formatting-only churn.
- Every changed line should trace directly to the root cause.
- If the fix touches a public API, verify backward compatibility.

## Fallbacks
- If no automated test path exists, define the narrowest executable validation available and state the added risk.
- If validation fails in a way that questions the root cause, stop and return to debugging rather than broadening the patch.
- If the fix would require a large refactor, stop and explain why the change is no longer a minimal corrective patch.
