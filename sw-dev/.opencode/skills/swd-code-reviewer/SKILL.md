---
name: swd-code-reviewer
description: "Use when performing code review on a diff, pull request, or changed files. Focus on correctness, security, performance, maintainability, and project conventions."
license: MIT
---

# code-reviewer

## Purpose
Produce a concise, evidence-based review of implementation changes with findings ranked by severity.

## Required Inputs
- Diff, pull request, or list of changed files
- Intended behavior, requirement, or problem being solved

## Optional Inputs
- Architecture notes, API contracts, issue links, or acceptance criteria
- Threat model, performance budget, or test results

## Clarify Before Proceeding
- If no review scope is provided, ask which files or diff to review.
- If the intended behavior is unclear, ask what the change is supposed to achieve.
- If review context is incomplete, continue with a local code review and label any assumption-driven findings.

## Execution Rules
1. Review the changed slice before expanding to nearby code.
2. Prioritize correctness, security, data integrity, performance, concurrency, and maintainability.
3. Only raise findings you can justify from code, behavior, or a clear engineering principle.
4. Separate confirmed issues from open questions.
5. Respect existing project conventions; do not request style-only churn.

## Output Template

```markdown
## Review Findings

### Blockers
- {file:line or area} — {problem, impact, and concrete fix direction}

### Warnings
- {file:line or area} — {risk, scenario, and recommended change}

### Nits
- {optional improvement with low risk and low urgency}

### Open Questions
- {missing context that affects confidence}

### Residual Risks
- {what was not verified or remains uncertain}
```

## Constraints
- Blockers are reserved for correctness, security, data loss, severe performance, or severe operability risks.
- Do not block on personal preference or repo-consistent style.
- If a concern is plausible but unproven, label it as a question or warning rather than a blocker.

## Fallbacks
- If requirements are missing, review against observable invariants and clearly state assumptions.
- If only a partial diff is available, review the touched slice and call out what could not be verified.
- If test or runtime evidence is unavailable, avoid claiming behavior regressions as facts.
