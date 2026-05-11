# /swd-review

## Goal
Perform a structured code review with security, performance, and maintainability checks.

## Skill
`.opencode/skills/code-reviewer/SKILL.md`

## Inputs
- Diff, pull request, or changed files
- Intended behavior, requirement, or change summary

## Steps

### Step 1: Understand Context
- Read the PR/changeset description and linked requirements
- Identify which files are new vs modified vs deleted

### Step 2: Run Review Checklist
- Correctness: edge cases, error handling, input validation
- Security: injection, auth, secrets exposure
- Performance: algorithmic complexity, N+1 queries, hot path allocations
- Concurrency: shared state, async error handling
- Architecture: module boundaries, coupling
- Maintainability: readability, over-engineering, dead code

### Step 3: Report Results
- Format by severity: **blocker** / **warning** / **nit**
- For each issue: file:line + explanation + suggestion
- Summarize: X blockers, Y warnings, Z nits

### Step 4: Follow Up
- Resolve blockers before merge
- Re-review if significant changes are made

## Constraints
- Do NOT review style that matches project conventions
- Do NOT request changes for personal preference
- Blockers only for correctness, security, or severe performance issues
