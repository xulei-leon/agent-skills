# report_gen

## Purpose
Generate milestone test reports and build reports in Markdown format.

## Interface
- **testReport**(data): `string` — generate milestone test report markdown
  - Input: utTotal, utPassed, stTotal, stPassed, coverage?, knownIssues[]
  - Output: formatted markdown with pass rates
- **buildReport**(data): `string` — generate build verification report

## Implementation
`opencode/workflows/report-generation.md` — report generation workflow
