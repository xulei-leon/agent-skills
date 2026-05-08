# Git Operations Workflow

Standardized commit messages and tagging for NPD-SW milestones.

## Commit Templates

| Type | When | Template |
|------|------|----------|
| `docs` | Document changes (SRS/SAD/spec updates) | `docs: update {fileName} v{version}` |
| `feat` | Milestone completion | `feat({milestone}): complete {name}` with body listing US range and test pass rates |
| `release` | Phase 4 release | `Release v{version}` |

### Milestone Commit Body Format

```
Completed User Stories: US-M1-01 ~ US-M1-03
Passed UT: 12/12, ST: 5/5
```

## Steps

### Step 1: Document Change
- Stage changed files: `git add <files>`
- Commit: `git commit -m "docs: update SRS.md v1.1.0"`

### Step 2: Milestone Completion
- Stage all: `git add .`
- Commit with full details:
  - `feat(M{n}): complete {milestone name}`
  - Body: completed User Story range
  - Body: UT/ST pass counts

### Step 3: Release Tag
- Ensure all milestones passed
- `git tag -a v{x.y.z} -m "Release v{x.y.z}"`
- Version matches SRS main version

## Constraints
- Commit after each atomic operation
- Tag only at Phase 4
- Never amend pushed commits
