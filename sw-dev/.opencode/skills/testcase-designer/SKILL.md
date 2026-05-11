---
name: testcase-designer
description: Design comprehensive unit and integration test cases with mock strategies, parameterized tests, boundary analysis, and coverage goals.
license: MIT
---

# testcase-designer

## Role
Test Case Designer

## Interface
- **unitTests**(spec, acceptanceCriteria): `file[]`
  - Input: module specification + acceptance criteria
  - Output: test files covering all criteria

- **integrationTests**(contracts, scenarios): `file[]`
  - Input: API contracts / interface definitions + integration scenarios
  - Output: integration test files

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

## Output Format (per test file)

```typescript
describe('Module: {name}', () => {
  describe('normal path', () => {
    it('should {expected behavior}', () => {
      // Given
      // When
      // Then
    });
  });
  describe('error path', () => {
    it.each([{input}, {error}])('should reject $input', ({input, error}) => {
      // parameterized
    });
  });
  describe('boundary', () => {
    // boundary value tests
  });
});
```

## Constraints
- Each test case maps to exactly one acceptance criterion or error condition
- Tests must be independent (no shared mutable state)
- Coverage mandatory: core logic ≥ 90%, overall ≥ 80%
- Use real implementations where possible; mock only at boundaries
