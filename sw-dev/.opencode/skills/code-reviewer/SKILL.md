---
name: code-reviewer
description: Review implementation code against architecture, coding standards, security, performance, and project conventions.
license: MIT
---

# code-reviewer

## Role
Code Reviewer

## Interface
- **review**(sourceCode, context): `ReviewResult`
  - Input: source code changes + context (architecture doc, acceptance criteria)
  - Output: review result with issue list by severity

## Review Checklist

### Correctness
- All acceptance criteria are covered
- Input validation, edge cases, error paths handled
- No logic errors or off-by-one mistakes

### Architecture & Design
- Follows module boundaries and SAD architecture
- No inappropriate coupling or leaky abstractions
- API contracts are consistent and well-defined

### Security
- No injection vulnerabilities (SQL, XSS, command injection)
- Authentication/authorization checks in place
- Secrets never logged or exposed
- Input sanitized at trust boundaries

### Performance
- No obvious O(n²) or worse algorithms where O(n) suffices
- No unnecessary allocations in hot paths
- Database queries indexed and not in loops (N+1)

### Concurrency & Safety
- Shared state properly synchronized
- No deadlock or race condition risks
- Async error handling (unhandled rejections)

### Maintainability
- Code is readable and self-documenting
- No speculative abstractions or dead code
- Only required changes made (no adjacent "improvements")
- Error messages are actionable

## Constraints
- Blocking issues (severity: blocker) must be resolved before merge
- Non-blocking issues (severity: nit) are noted but optional
- One review round; re-review only after fixes

## Guidelines

### Reject Overcomplication
- "Would a senior engineer say this is overcomplicated?"
- If a function is >50 lines, ask if it can be split.

### Surgical Changes
- Every changed line should trace to the user's request.
- If you find unrelated issues, note them — don't block on them.
