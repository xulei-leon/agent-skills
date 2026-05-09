# NPD-SW Status Check Workflow

Display current project status by scanning files and state.

## Steps

### Step 1: Scan Project Files
- Read `.npd-status.json` to check which phases are enabled
- Check existence of:
  - `.npd-status.json` — project status overview
  - `sprint/sprint.md` — sprint plan
  - `docs/0-Concept/Charter.md` — project charter (skip if Concept phase `enable: false`)
  - `docs/0-Concept/Market_Research.md` — market research (skip if Concept phase `enable: false`)
  - `docs/0-Concept/User_Research.md` — user research (skip if Concept phase `enable: false`)
  - `docs/1-Requirement/SRS.md` — SRS
  - `sprint/backlog.md` — backlog items
  - `docs/2-Design/SAD.md` — SAD
  - `docs/2-Design/RTM.md` — RTM
  - `test/st/*.test.*` — system test cases (skip if Test phase `enable: false`)
  - `test/ut/*.test.*` — unit test cases (skip if Develop phase `enable: false`)
  - `src/` — source code (skip if Develop phase `enable: false`)

### Step 2: Print Report
- Format:
  ```
  ## NPD-SW Workflow Status
  - **Current Phase**: {phase} - {phase_name}
  - **Current Milestone**: {milestone}
  - **Review Status**: {review_status}
  - **Completed Documents**: {list}
  - **Next Action**: {next_action}
  ```

### Step 3: Suggest Next Command
- Based on current state, recommend the next command to run
- Example: if Phase 0 just completed, suggest `/npd-requirement`

## Constraints
- Read-only — do NOT modify any files
- Report must be clear enough for user to decide next action
