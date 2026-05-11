---
name: testcase-designer
description: "Use when designing unit, integration, or characterization tests. Produces traceable test cases, boundary coverage, and mock strategies that fit existing project conventions."
license: MIT
---

# testcase-designer

## Purpose
Design a test plan or concrete test cases that trace clearly to expected behavior and fit the target project's tooling.

## Required Inputs
- Feature, module, API, or behavior under test
- Expected behavior, acceptance criteria, contract, or observable invariants
- Desired test level: unit, integration, characterization, or mixed

## Optional Inputs
- Existing test conventions, framework, fixture patterns, and dependency boundaries
- Risk areas, past defects, or known edge cases

## Clarify Before Proceeding
- If acceptance criteria are missing, ask for the expected behavior or infer characterization coverage and label it clearly.
- If test level is unclear, ask whether the goal is fast isolated tests, boundary-crossing tests, or regression capture.
- If project conventions are unknown, ask which runner, folder layout, and naming pattern should be followed.

## Execution Rules
1. Map each test case to one behavior, rule, error condition, or transition.
2. Prefer existing project test structure and framework over generic defaults.
3. Mock only at system boundaries and justify each mock.
4. Use parameterization when the same assertion pattern repeats across inputs.
5. If requirements are incomplete, separate inferred cases from explicitly requested cases.

## Coverage Dimensions

| Dimension | Coverage Target | Technique |
|-----------|----------------|-----------|
| Normal path | 100% acceptance criteria | Happy path per AC |
| Error path | All documented errors | Each error code/path |
| Boundary | Input boundaries | Equivalence partitioning + boundary values |
| Edge cases | Empty/null/max inputs | Adversarial input design |
| State transitions | All valid transitions | State transition testing |

## Mock Strategy

| Dependency | Mock Type | Tool |
|------------|-----------|------|
| External HTTP API | Wiremock / MSW handshake | Return canned responses |
| Database | In-memory / Testcontainers | Reset per test case |
| Time | Fake timers | Freeze at known time |
| File system | Temp directory / in-memory FS | Clean up in teardown |
| Message queue | In-memory broker | Verify published messages |

## Output Template

```markdown
## Test Design

### 1. Scope
{feature or module under test}

### 2. Assumptions
- {assumption 1}

### 3. Test Matrix
| ID | Level | Behavior or Rule | Input / Setup | Expected Result | Mocking |
|----|-------|------------------|---------------|-----------------|---------|
| T1 | unit | {behavior} | {input} | {result} | {none or boundary mock} |

### 4. Mock Strategy
- {dependency} — {why it should or should not be mocked}

### 5. File Plan
- {suggested test file or suite placement using project conventions}

### 6. Coverage Gaps
- {important behavior not yet covered}
```

## Constraints
- Each test case maps to exactly one acceptance criterion or error condition
- Tests must be independent (no shared mutable state)
- Use real implementations where possible; mock only at boundaries

## Fallbacks
- If no explicit acceptance criteria exist, design characterization tests around current observable behavior.
- If project conventions are missing, propose a default test layout but mark it as a recommendation.
- If integration boundaries are unclear, stop after listing the external dependencies that need confirmation.
