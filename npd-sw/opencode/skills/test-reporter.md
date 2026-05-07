# test-reporter

## Role
Test Reporter

## Interface
- **testReport**(data): `string` — generate milestone test report markdown
  - Input: utTotal, utPassed, stTotal, stPassed, coverage?, knownIssues[]
  - Output: formatted markdown with pass rates
- **buildReport**(data): `string` — generate build verification report

