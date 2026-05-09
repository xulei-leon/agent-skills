# Launch Phase Workflow

Complete Phase 5: build verification, changelog, and Git tag.

## Steps

### Step 1: Build Verification
- Run `npm run build` (or language-appropriate build command)
- If build fails: fix → rebuild until success
- Use the `test-reporter` skill to create `docs/5-Launch/build-report.md`
- Include: build status, artifact list, build time

### Step 2: Update Changelog
- Use the `git-ops` skill (changelog interface)
- Create/update `CHANGELOG.md` with release notes
- Follow semantic versioning from SRS
- Include: new features, bug fixes, breaking changes

### Step 3: Generate Release Note
- Output: `docs/5-Launch/release-note.md`
- Content: version number, release date, summary of changes, new features, bug fixes, breaking changes
- Format follows semantic versioning from SRS

### Step 4: Git Tag
- Use the `git-ops` skill to create tag:
- `git tag -a v{x.y.z} -m "Release v{x.y.z}"`
- Version matches SRS main version

### Step 5: Bump Versions and Output Final Report
- Use the `version-manager` skill to bump document versions
- Print `[Phase 5 Exit Check]` with full checklist:
  - All milestone UT/ST passed
  - Build succeeded
  - CHANGELOG.md updated
  - Release note generated
  - Git tag created
- Confirm with `/npd-decision phase5 go` to mark project complete

## Exit Criteria
- All milestones have gate `Go`
- Build succeeds
- CHANGELOG.md updated
- Release note generated (`docs/5-Launch/release-note.md`)
- Git tag created
- User confirms with `/npd-decision phase5 go`
