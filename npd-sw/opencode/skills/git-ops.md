# git_ops

## Purpose
Standardized Git operations for CMM V-Model workflow — commits, tags, and changelog.

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
- Tag only at Phase 4 (release)
- Never amend pushed commits
