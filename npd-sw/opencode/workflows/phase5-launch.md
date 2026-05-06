# Launch Phase Workflow

Complete Phase 5: build verification, changelog, and Git tag.

## Steps

### Step 1: Build Verification
- Run `npm run build` (or language-appropriate build command)
- If build fails: fix → rebuild until success
- Use the `report-gen` skill to create `docs/06-Launch/build-report.md`
- Include: build status, artifact list, build time

### Step 2: Update Changelog
- Use the `git-ops` skill (changelog interface)
- Create/update `CHANGELOG.md` with release notes
- Follow semantic versioning from SRS
- Include: new features, bug fixes, breaking changes

### Step 3: Git Tag
- Use the `git-ops` skill to create tag:
- `git tag -a v{x.y.z} -m "Release v{x.y.z}"`
- Version matches SRS main version

### Step 4: Output Final Report
- Print `[Phase 5 出口检查]` with full checklist:
  - All milestone UT/ST passed
  - Build succeeded
  - CHANGELOG.md updated
  - Git tag created
- Confirm project is ready for production deployment

## Exit Criteria
- All milestones have `Review Passed`
- Build succeeds
- CHANGELOG.md updated
- Git tag created
