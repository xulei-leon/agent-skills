---
name: git-ops
description: Standardized git operations with conventional commits, annotated tags, and changelog generation.
license: MIT
---

# git-ops

## Role
Git Operator

## Interface
- **commit**(type, scope?, message): `string` — make standardized commit
- **tag**(version, message?): `string` — create annotated tag
- **changelog**(version, entries): `string` — generate/update changelog

## Commit Types
| Type | Scope | Message Format |
|------|-------|----------------|
| docs | filename | `docs: update {name} v{x.y.z}` |
| feat | M{n} | `feat(M{n}): complete {milestone}` |
| release | — | `Release v{x.y.z}` |

## Constraints
- Commit after each atomic operation
- Tag only at Phase 5 (release)
- Never amend pushed commits
