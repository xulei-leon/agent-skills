# System Test Phase Workflow

Complete Phase 4: run full system test suite and generate test report.

## Prerequisites
- All milestones have `Review Passed`
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
- Use the `report_gen` skill
- Output: `test/results/system-test-report.md`
- Include:
  - ST pass rate (passed/total)
  - Coverage metrics
  - Known issues
  - Per-milestone summary

### Step 4: Output Completion Signal
- Print `[Phase 4 完成]` with test summary
- All milestones pass confirmation
- Proceed to Phase 5 (Launch) when ready

## Exit Criteria
- All system tests pass
- Test report generated
- Known issues documented
