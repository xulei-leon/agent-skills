# /phase4-launch

## Goal
Complete Phase 4 (Launch) — build verification, changelog, and Git tag.

## Instructions

### Step 1: Build Verification
- Run `npm run build` (or language-appropriate build command)
- If build fails: fix → rebuild until success
- Use the `report_gen` skill to create `docs/06-Launch/build-report.md`

### Step 2: Update Changelog
- Use the `changelog_gen` skill
- Create/update `CHANGELOG.md` with release notes
- Follow semantic versioning from SRS

### Step 3: Git Tag
- Use the `git_ops` skill to create tag: `git tag -a v{x.y.z} -m "Release v{x.y.z}"`

### Step 4: Update State
- Use the `state_manager` skill to mark Phase 4 complete

### Step 5: Output Final Report
- Print `[Phase 4 出口检查]` with full checklist
- Confirm project is ready for production deployment

## Constraints
- All milestones must have `Review Passed` before launching
- Build must succeed before tagging
- Do NOT skip any checklist item
