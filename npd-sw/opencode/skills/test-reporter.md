# test-reporter

## Role
ST Reporter

## Purpose
Generate comprehensive system test reports summarizing test results, coverage, and known issues.
- **buildReport**(data): `string` — generate build verification report
- **testReport**(data): `string` — generate milestone test report markdown
  - Input: utTotal, utPassed, stTotal, stPassed, coverage?, knownIssues[]
  - Output: formatted markdown with pass rates

