---
name: test-reporter
description: Generate milestone test reports and build verification reports with pass rates.
license: MIT
---

# test-reporter

## Role
Test Reporter

## Interface
- **testReport**(data): `string` — generate milestone test report markdown
  - Input: utTotal, utPassed, stTotal, stPassed, coverage?, knownIssues[]
  - Output: formatted markdown with pass rates
- **buildReport**(data): `string` — generate build verification report
