# Project Validation Workflow

Verify NPD-SW project directory structure completeness.

## Steps

### Step 1: Check Required Directories
- Verify each required directory exists:
  - `docs/requirement`
  - `docs/design`
  - `docs/spec`
  - `docs/reports`
  - `test/st`
  - `test/ut`
  - `opencode/commands`
- Output: list of existing and missing directories
- Overall: `valid = (missing.length === 0)`

### Step 2: Get Project Status Summary
- Aggregate:
  - Project structure validation result
- Output: `{ structure: { valid, missing, existing } }`

## Usage

```markdown
1. Validate: `validateProjectStructure(".")` → `{ valid: true, missing: [], existing: [...] }`
2. Summary: returns combined status object
```
