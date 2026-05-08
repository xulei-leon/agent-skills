# System Test Phase Workflow

Complete Phase 4: run full system test suite and generate test report.

## Prerequisites
- All milestones have gate `Go`
- Each milestone UT passed in Phase 3

## Steps

### Step 1: Run System Test Suite
- Run `npm run test:st` (or language-appropriate ST command)
- Cover all ST cases in `test/st/`
- Each ST traces to a FR from SRS

### Step 2: Handle Failures
- If any ST fails:
  - Identify the failing milestone/module
  - Fix code in `src/`
  - Rerun both UT and ST for affected module
  - Repeat until all ST pass

### Step 3: Generate System Test Report
- Use the `test-reporter` skill
- Output: `test/results/system-test-report-V<version>.md`
- Include:
  - ST pass rate (passed/total)
  - Coverage metrics
  - Known issues
  - Per-milestone summary

### Step 4: Output Completion Signal
- Print `[Phase 4 Complete]` with test summary
- All milestones pass confirmation
- Check `.npd-status.json`: if the next enabled phase (Launch or other) is `enable: true`, recommend proceeding to it
- If no next enabled phase exists, mark project as complete

## Exit Criteria
- All system tests pass
- Test report generated
- Known issues documented
