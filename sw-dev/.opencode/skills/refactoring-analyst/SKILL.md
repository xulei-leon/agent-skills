---
name: refactoring-analyst
description: "Use when planning or executing safe refactoring. Identifies code smells, ranks refactoring opportunities, and defines behavior-preserving steps with validation."
license: MIT
---

# refactoring-analyst

## Purpose
Identify refactoring opportunities and define the safest next behavior-preserving improvement.

## Required Inputs
- Target code or module to inspect
- Refactoring goal, smell, or maintenance pain point
- Existing validation path such as tests, checks, or reproducible behavior

## Optional Inputs
- Hot paths, ownership concerns, recent defects, or planned adjacent changes

## Clarify Before Proceeding
- If the target slice is too broad, ask which file, module, or smell to prioritize.
- If behavior expectations are unclear, ask what must remain unchanged.
- If no validation path exists, ask whether characterization tests can be added first.

## Execution Rules
1. Establish a behavior baseline before proposing structural changes.
2. Rank smells by risk reduction and maintenance payoff.
3. Prefer one small refactoring step at a time.
4. Follow project validation conventions before and after each step.
5. Treat commit strategy as optional process advice, not a required outcome.

## Smell Catalog

| Smell | Detection | Suggested Refactor |
|-------|-----------|-------------------|
| God Class / Long Function | >200 lines class, >50 lines function | Extract class / Extract method |
| Shotgun Surgery | same change required in many files | Move method, consolidate |
| Duplicate Code | similar blocks in 2+ places | Extract method / Pull up |
| Primitive Obsession | excessive use of string/number for domain concepts | Value object / Enum |
| Feature Envy | method uses more of another class than its own | Move method |
| Speculative Generality | unused params, abstract classes, hooks | Inline / Remove |
| Message Chains | `a.b().c().d()` deep traversal | Hide delegate |
| Long Parameter List | >3 parameters | Parameter object |
| Switch/if-else over Type | type-checking dispatch | Strategy / Polymorphism |

## Constraints
- Every refactoring must be verified: run tests before and after
- One smell at a time
- Do NOT change external behavior — only internal structure
- If tests don't exist, write characterization tests first

## Output Template

```markdown
## Refactoring Plan

### 1. Baseline
{current behavior, validation status, and target slice}

### 2. Ranked Smells
- {smell} — {why it matters now}

### 3. First Safe Step
{smallest refactoring step to take next}

### 4. Validation
{checks to run before and after}

### 5. Stop Conditions
{signals that mean the refactor is getting too broad or risky}
```

## Fallbacks
- If tests do not exist, recommend characterization tests before structural changes.
- If the smallest safe step cannot be identified, stop and narrow the target slice.
- If the refactor is entangled with a bug fix or feature request, split the work before proceeding.
