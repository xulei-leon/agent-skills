# /swd-refactor

## Goal
Identify code smells and safely refactor without changing external behavior.

## Skill
`.opencode/skills/refactoring-analyst/SKILL.md`

## Inputs
- Target file, module, or subsystem
- Refactoring goal, smell, or maintenance concern
- Behavior baseline or validation path

## Steps

### Step 1: Analyze
- Scan target code for smells (god class, duplication, long function, etc.)
- Run existing tests to establish baseline (all pass)

### Step 2: Plan
- Prioritize smells by risk (P0 bug-prone → P1 maintenance → P2 readability)
- For each smell: identify refactoring technique
- If tests are missing for the area, write characterization tests first

### Step 3: Refactor (one smell at a time)
1. Apply the smallest refactoring that addresses the smell
2. Run tests — all must pass
3. Commit with message format: `refactor: {technique} - {smell}`

### Step 4: Verify
- Final test run — all tests pass
- Confirm no behavior change (same inputs → same outputs)

## Constraints
- One smell at a time — do NOT batch unrelated refactorings
- Do NOT add features or fix bugs during refactoring
- If validation fails, reduce the step size or re-baseline before continuing
- Max 3 smells per session
