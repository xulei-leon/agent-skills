# test_gen

## Purpose
Generate unit test and system test cases from requirements and milestone specs.

## Interface
- **unitTests**(milestoneSpec, acceptanceCriteria): `file[]` — generate UT files
  - Output: `test/ut/m{n}-us{yy}.test.*`
  - Cover all acceptance criteria for each US
- **systemTests**(srs, frList): `file[]` — generate ST files
  - Output: `test/st/st-cases.test.*`
  - Format: Given-When-Then with Traceability ID to FR

## Constraints
- UTs must pass before implementation (TDD)
- Each UT maps to exactly one acceptance criterion
- Each ST maps to exactly one FR
- Cover normal path, error path, and boundary conditions
