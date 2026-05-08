# /npd-launch

## Goal
Complete Phase 5 (Launch) — build verification, changelog, and Git tag.

## Workflow
`.opencode/workflows/phase5-launch.md`

## Constraints
- All milestones must have gate `Go` before launching
- Build must succeed before tagging
- Do NOT skip any checklist item
- If `.npd-status.json` has `Launch.enable = false`, this command is skipped automatically
