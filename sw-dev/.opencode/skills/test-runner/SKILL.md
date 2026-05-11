---
name: test-runner
description: Run test suites, report pass/fail metrics, diagnose failures, and track coverage trends.
license: MIT
---

# test-runner

## Role
Test Runner

## Interface
- **run**(scope): `TestReport`
  - Input: test scope (full / module / file)
  - Output: pass/fail summary + failure diagnostics + coverage metrics

## Failure Classification

| Type | Indication | Action |
|------|-----------|--------|
| Assertion Error | `expect(a).toBe(b)` failed | Check expected vs actual values |
| Runtime Exception | Uncaught error in test or code | Check stack trace for source location |
| Timeout | Async test exceeded limit | Check for unfulfilled promises / infinite loops |
| Infrastructure | DB/API not reachable | Check test environment setup |
| Compile/Parse Error | Syntax error or type error | Check test file for import/syntax issues |

## Coverage Tracking

| Metric | Target | Trend |
|--------|--------|-------|
| Line coverage | ≥ 80% | Track increase/decrease per run |
| Branch coverage | ≥ 70% | Identify uncovered branches |
| Function coverage | ≥ 90% | Find untested functions |

## Constraints
- Report every failure with file:line and full error message
- Do NOT truncate stack traces — they are essential for debugging
- Do NOT modify tests or implementation
- If no test runner is detected, ask the user for the run command
