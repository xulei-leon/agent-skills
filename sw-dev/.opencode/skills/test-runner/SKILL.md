---
name: test-runner
description: "Use when running tests, reporting failures, or diagnosing broken suites. Detects project test commands, reports actionable results, and classifies failures."
license: MIT
---

# test-runner

## Purpose
Run the requested test scope and return a report that is actionable for debugging or release decisions.

## Required Inputs
- Requested scope: full suite, package, module, directory, or individual test file
- Test command, or enough project context to detect one safely

## Optional Inputs
- Environment setup requirements, coverage preference, retries, or prior failing output

## Clarify Before Proceeding
- If scope is ambiguous, ask whether to run the full suite or a narrower target.
- If no runner can be detected confidently, ask for the exact command instead of guessing.
- If environment prerequisites are unclear, ask before starting a run that is likely to fail for setup reasons.

## Execution Rules
1. Prefer the project's existing test command or documented runner.
2. Run the narrowest requested scope first unless the user asked for full coverage.
3. Preserve actionable error output, including the first relevant stack frames.
4. Report coverage only when the runner actually produces it.
5. Classify failures by likely cause before suggesting next steps.

## Failure Classification

| Type | Indication | Action |
|------|-----------|--------|
| Assertion Error | `expect(a).toBe(b)` failed | Check expected vs actual values |
| Runtime Exception | Uncaught error in test or code | Check stack trace for source location |
| Timeout | Async test exceeded limit | Check for unfulfilled promises / infinite loops |
| Infrastructure | DB/API not reachable | Check test environment setup |
| Compile/Parse Error | Syntax error or type error | Check test file for import/syntax issues |

## Output Template

```markdown
## Test Report

### 1. Scope
{what was run}

### 2. Command
{runner and command used}

### 3. Summary
{passed / failed / skipped / duration}

### 4. Failures
- {test or file} — {classification} — {key error message and likely cause}

### 5. Coverage
{coverage details if available, otherwise "not reported"}

### 6. Next Action
{best next debugging or rerun step}
```

## Constraints
- Report every failure with file:line and full error message
- Do NOT truncate stack traces — they are essential for debugging
- Do NOT modify tests or implementation
- If no test runner is detected, ask the user for the run command

## Fallbacks
- If the project has multiple plausible test commands, ask which one is authoritative.
- If coverage is unavailable, omit target judgments and report only what the tool produced.
- If the suite fails for infrastructure reasons, separate setup failure from test failure.
